// Copyright (c) 2009-2010 Satoshi Nakamoto
// Copyright (c) 2011 Vince Durham
// Copyright (c) 2009-2014 The Bitcoin developers
// Copyright (c) 2014-2017 Daniel Kraft
// Distributed under the MIT/X11 software license, see the accompanying
// file license.txt or http://www.opensource.org/licenses/mit-license.php.

#include "auxpow.h"

#include "compat/endian.h"
#include "consensus/consensus.h"
#include "consensus/merkle.h"
#include "consensus/validation.h"
#include "hash.h"
#include "script/script.h"
#include "txmempool.h"
#include "util.h"
#include "utilstrencodings.h"
#include "validation.h"
#include "chainparams.h"

#include <algorithm>

/* Moved from wallet.cpp.  CMerkleTx is necessary for auxpow, independent
   of an enabled (or disabled) wallet.  Always include the code.  */

const uint256 CMerkleTx::ABANDON_HASH(uint256S("0000000000000000000000000000000000000000000000000000000000000001"));

void CMerkleTx::SetMerkleBranch(const CBlockIndex* pindex, int posInBlock)
{
    // Update the tx's hashBlock
    hashBlock = pindex->GetBlockHash();

    // set the position of the transaction in the block
    nIndex = posInBlock;
}

void CMerkleTx::InitMerkleBranch(const CBlock& block, int posInBlock)
{
    hashBlock = block.GetHash();
    nIndex = posInBlock;
    vMerkleBranch = BlockMerkleBranch (block, nIndex);
}

int CMerkleTx::GetDepthInMainChain(const CBlockIndex* &pindexRet) const
{
    if (hashUnset())
        return 0;

    AssertLockHeld(cs_main);

    // Find the block it claims to be in
    BlockMap::iterator mi = mapBlockIndex.find(hashBlock);
    if (mi == mapBlockIndex.end())
        return 0;
    CBlockIndex* pindex = (*mi).second;
    if (!pindex || !chainActive.Contains(pindex))
        return 0;

    pindexRet = pindex;
    return ((nIndex == -1) ? (-1) : 1) * (chainActive.Height() - pindex->nHeight + 1);
}

int CMerkleTx::GetBlocksToMaturity() const
{
    if (!IsCoinBase())
        return 0;
    return std::max(0, (COINBASE_MATURITY+1) - GetDepthInMainChain());
}

bool CMerkleTx::AcceptToMemoryPool(const CAmount& nAbsurdFee, CValidationState& state)
{
    return ::AcceptToMemoryPool(mempool, state, tx, true, nullptr, nullptr, false, nAbsurdFee);
}

/* ************************************************************************** */

bool
CAuxPow::check (const uint256& hashAuxBlock, const Consensus::Params& params) const
{
    if (vChainMerkleBranch.size() > 30)
        return error("Aux POW chain merkle branch too long");

    // Calculate children hash root using our child block hash
    const uint256 nRootHash = CheckMerkleBranch (hashAuxBlock, vChainMerkleBranch, nChainIndex);

    if (pParentCoinbase) // classic auxpow
    {
        // Coinbase should be the first transaction and thus its merkle branch index should be 0
        if (pParentCoinbase->nIndex != 0)
            return error("AuxPow is not a generate");

        // Check that the coinbase indeed belongs to parent transactions
        if (CheckMerkleBranch(pParentCoinbase->GetHash(), pParentCoinbase->vMerkleBranch, pParentCoinbase->nIndex) != parentBlock.hashMerkleRoot)
            return error("Aux POW merkle root incorrect");

        const CScript script = pParentCoinbase->tx->vin[0].scriptSig;

        // Check that the children hash is in the coinbase
        valtype vchRootHash(nRootHash.begin (), nRootHash.end ());
        std::reverse (vchRootHash.begin (), vchRootHash.end ()); // correct endian
        CScript::const_iterator pc = std::search(script.begin(), script.end(), vchRootHash.begin(), vchRootHash.end());
        if (pc == script.end())
            return error("Aux POW missing chain merkle root in parent coinbase");

        // Check merged mining header in the script
        CScript::const_iterator pcHead = std::search(script.begin(), script.end(), UBEGIN(pchMergedMiningHeader), UEND(pchMergedMiningHeader));
        if (pcHead != script.end())
        {
            // Enforce only one chain merkle root by checking that a single instance of the merged
            // mining header exists just before.
            if (script.end() != std::search(pcHead + 1, script.end(), UBEGIN(pchMergedMiningHeader), UEND(pchMergedMiningHeader)))
                return error("Multiple merged mining headers in coinbase");
            if (pcHead + sizeof(pchMergedMiningHeader) != pc)
                return error("Merged mining header is not just before chain merkle root");
        }
        else
        {
            // For backward compatibility.
            // Enforce only one chain merkle root by checking that it starts early in the coinbase.
            // 8-12 bytes are enough to encode extraNonce and nBits.
            if (pc - script.begin() > 20)
                return error("Aux POW chain merkle root must start in the first 20 bytes of the parent coinbase");
        }
    }
    else    // lean auxpow
    {
        assert(parentBlock.pAuxpowChildrenHash != nullptr);
        if (parentBlock.pAuxpowChildrenHash == nullptr)
            return error("Missing children root hash");

        if (nRootHash != *parentBlock.pAuxpowChildrenHash)
            return error("Aux POW missing chain merkle root in parent block header");
    }

    return true;
}

uint256
CAuxPow::CheckMerkleBranch (uint256 hash,
                            const std::vector<uint256>& vMerkleBranch,
                            int nIndex)
{
  if (nIndex == -1)
    return uint256 ();
  for (std::vector<uint256>::const_iterator it(vMerkleBranch.begin ());
       it != vMerkleBranch.end (); ++it)
  {
    if (nIndex & 1)
      hash = Hash (BEGIN (*it), END (*it), BEGIN (hash), END (hash));
    else
      hash = Hash (BEGIN (hash), END (hash), BEGIN (*it), END (*it));
    nIndex >>= 1;
  }
  return hash;
}

void
CAuxPow::initAuxPow (CBlockHeader& header)
{
  assert (header.nTime >= Params().GetConsensus().nAuxpowActivationTime);

#if 1
  // build a classic auxpow object

  /* Build a minimal coinbase script input for merge-mining.  */
  const uint256 blockHash = header.GetHash ();
  valtype inputData(blockHash.begin (), blockHash.end ());
  std::reverse (inputData.begin (), inputData.end ());

  /* Fake a parent-block coinbase with just the required input
     script and no outputs.  */
  CMutableTransaction coinbase;
  coinbase.vin.resize (1);
  coinbase.vin[0].prevout.SetNull ();
  coinbase.vin[0].scriptSig = (CScript () << inputData);
  assert (coinbase.vout.empty ());
  CTransactionRef coinbaseRef = MakeTransactionRef (coinbase);

  /* Build a fake parent block with the coinbase.  */
  CBlock parent;
  parent.nVersion = 1;
  parent.vtx.resize (1);
  parent.vtx[0] = coinbaseRef;
  parent.hashMerkleRoot = BlockMerkleRoot (parent);

  /* Construct the auxpow object.  */
  header.SetAuxpow (new CAuxPow (coinbaseRef));
  assert (header.auxpow->vChainMerkleBranch.empty ());
  header.auxpow->nChainIndex = 0;
  assert (header.auxpow->pParentCoinbase->vMerkleBranch.empty ());
  header.auxpow->pParentCoinbase->nIndex = 0;
  header.auxpow->parentBlock = parent;

#else
  // build a lean auxpow object

  /* Build a fake parent block that references our (child) block.  */
  CBlock parent;
  parent.nVersion = 1;
  parent.hashMerkleRoot = BlockMerkleRoot (parent);
  parent.pAuxpowChildrenHash.reset(new uint256(header.GetHash()));

  /* Construct the auxpow object.  */
  header.SetAuxpow (new CAuxPow ());
  assert (header.auxpow->vChainMerkleBranch.empty ());
  header.auxpow->nChainIndex = 0;
  header.auxpow->parentBlock = parent;
#endif
}
