QT += core gui dbus network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = paiup
TEMPLATE = app

DEFINES += \
    HAVE_CONFIG_H \
    __x86_64__ \
    USE_ASM \
    VARIANT_LITE

INCLUDEPATH += \
    ../src \
    ../src/config \
    ../src/qt \
    ../src/qt/forms \
    ../src/wallet \
    ../src/leveldb/include \
    ../src/leveldb/helpers/memenv \
    ../src/univalue/include \
    ../src/secp256k1/include

LIBS += \
    -L../src/secp256k1/.libs \
    -L../src/univalue/.libs \
    -L../src/leveldb \
    -L../src \
    -lsecp256k1 \
    -lunivalue \
    -lleveldb \
    -lleveldb_sse42 \
    -lmemenv \
    -lboost_chrono \
    -lboost_filesystem \
    -lboost_program_options \
    -lboost_system \
    -lboost_thread \
    -lcrypto \
    -lssl \
    -lminiupnpc \
    -levent \
    -lpaicoin_common \
    -lpaicoin_server \
    -lpaicoin_wallet \
    -lpaicoin_util \
    -lpaicoin_cli \
    -lpaicoin_zmq \
    -lpaicoin_consensus \
    -lpaicoinconsensus \
    -ldb_cxx-4.8 \
    -levent_pthreads \
    -levent \
    -lprotobuf \
    -pthread \
    -lpthread \
    -lzmq \
    -lqrencode

SOURCES += \
    ../src/addrdb.cpp \
    ../src/addrman.cpp \
    ../src/arith_uint256.cpp \
    ../src/base58.cpp \
    ../src/blockencodings.cpp \
    ../src/bloom.cpp \
    ../src/chain.cpp \
    ../src/chainparamsbase.cpp \
    ../src/chainparams.cpp \
    ../src/checkpoints.cpp \
    ../src/clientversion.cpp \
    ../src/coins.cpp \
    ../src/compressor.cpp \
    ../src/core_read.cpp \
    ../src/core_write.cpp \
    ../src/dbwrapper.cpp \
    ../src/fs.cpp \
    ../src/hash.cpp \
    ../src/httprpc.cpp \
    ../src/httpserver.cpp \
    ../src/init.cpp \
    ../src/key.cpp \
    ../src/keystore.cpp \
    ../src/merkleblock.cpp \
    ../src/netaddress.cpp \
    ../src/netbase.cpp \
    ../src/net.cpp \
    ../src/net_processing.cpp \
    ../src/pow.cpp \
    ../src/pubkey.cpp \
    ../src/random.cpp \
    ../src/rest.cpp \
    ../src/scheduler.cpp \
    ../src/sync.cpp \
    ../src/threadinterrupt.cpp \
    ../src/timedata.cpp \
    ../src/torcontrol.cpp \
    ../src/txdb.cpp \
    ../src/txmempool.cpp \
    ../src/ui_interface.cpp \
    ../src/uint256.cpp \
    ../src/util.cpp \
    ../src/utilmoneystr.cpp \
    ../src/utilstrencodings.cpp \
    ../src/utiltime.cpp \
    ../src/validation.cpp \
    ../src/validationinterface.cpp \
    ../src/versionbits.cpp \
    ../src/warnings.cpp \
    ../src/consensus/merkle.cpp \
    ../src/crypto/aes.cpp \
    ../src/crypto/chacha20.cpp \
    ../src/crypto/hmac_sha256.cpp \
    ../src/crypto/hmac_sha512.cpp \
    ../src/crypto/ripemd160.cpp \
    ../src/crypto/sha256.cpp \
    ../src/crypto/sha512.cpp \
    ../src/primitives/block.cpp \
    ../src/primitives/transaction.cpp \
    ../src/rpc/blockchain.cpp \
    ../src/rpc/client.cpp \
    ../src/rpc/mining.cpp \
    ../src/rpc/misc.cpp \
#    ../src/rpc/net.cpp \
    ../src/rpc/protocol.cpp \
    ../src/rpc/rawtransaction.cpp \
    ../src/rpc/safemode.cpp \
    ../src/rpc/server.cpp \
    ../src/script/interpreter.cpp \
    ../src/script/ismine.cpp \
    ../src/script/script.cpp \
    ../src/script/standard.cpp \
    ../src/script/sign.cpp \
    ../src/support/cleanse.cpp \
    ../src/support/lockedpool.cpp \
    ../src/wallet/crypter.cpp \
    ../src/wallet/db.cpp \
#   ../src/wallet/init.cpp \
    ../src/wallet/wallet.cpp \
    ../src/wallet/walletdb.cpp \
    ../src/wallet/investor.cpp \
    ../src/wallet/bip39words.cpp \
    ../src/wallet/bip39mnemonic.cpp \
    ../src/qt/addressbookpage.cpp \
    ../src/qt/addresstablemodel.cpp \
    ../src/qt/askpassphrasedialog.cpp \
    ../src/qt/authmanager.cpp \
    ../src/qt/settingshelper.cpp \
    ../src/qt/bantablemodel.cpp \
    ../src/qt/clientmodel.cpp \
    ../src/qt/coincontroldialog.cpp \
    ../src/qt/coincontroltreewidget.cpp \
    ../src/qt/confirmationdialog.cpp \
    ../src/qt/csvmodelwriter.cpp \
    ../src/qt/editaddressdialog.cpp \
    ../src/qt/guiutil.cpp \
    ../src/qt/intro.cpp \
    ../src/qt/modaloverlay.cpp \
    ../src/qt/networkstyle.cpp \
    ../src/qt/notificator.cpp \
    ../src/qt/openuridialog.cpp \
    ../src/qt/optionsdialog.cpp \
    ../src/qt/optionsmodel.cpp \
    ../src/qt/overviewpage.cpp \
    ../src/qt/paicoinaddressvalidator.cpp \
    ../src/qt/paicoinamountfield.cpp \
    ../src/qt/paicoin.cpp \
    ../src/qt/paicoingui.cpp \
    ../src/qt/paicoinstrings.cpp \
    ../src/qt/paicoinunits.cpp \
    ../src/qt/paymentrequestplus.cpp \
    ../src/qt/paymentserver.cpp \
    ../src/qt/peertablemodel.cpp \
    ../src/qt/platformstyle.cpp \
    ../src/qt/qrimagewidget.cpp \
    ../src/qt/qvalidatedlineedit.cpp \
    ../src/qt/qvaluecombobox.cpp \
    ../src/qt/qrc_paicoin_locale.cpp \
    ../src/qt/receiverequestdialog.cpp \
    ../src/qt/recentrequeststablemodel.cpp \
    ../src/qt/rpcconsole.cpp \
    ../src/qt/sendcoinsentry.cpp \
    ../src/qt/signverifymessagedialog.cpp \
    ../src/qt/splashscreen.cpp \
    ../src/qt/trafficgraphwidget.cpp \
    ../src/qt/transactiondesc.cpp \
    ../src/qt/transactiondescdialog.cpp \
    ../src/qt/transactionfilterproxy.cpp \
    ../src/qt/transactionrecord.cpp \
    ../src/qt/transactiontablemodel.cpp \
    ../src/qt/transactionview.cpp \
    ../src/qt/utilitydialog.cpp \
    ../src/qt/walletframe.cpp \
    ../src/qt/walletmodel.cpp \
    ../src/qt/walletmodeltransaction.cpp \
    ../src/qt/walletview.cpp \
    ../src/qt/winshutdownmonitor.cpp \
    ../src/qt/paymentrequest.pb.cc \
    ../src/qt/fundsinholdingdialog.cpp \
    ../src/qt/walletselectionpage.cpp \
    ../src/qt/welcomepage.cpp \
    ../src/qt/setpinpage.cpp \
    ../src/qt/paperkeyintropage.cpp \
    ../src/qt/paperkeywritedownpage.cpp \
    ../src/qt/paperkeycompletionpage.cpp \
    ../src/qt/restorewalletpage.cpp \
    ../src/qt/viewinvestorkeydialog.cpp \
    ../src/qt/holdingperiodcompletedialog.cpp \
    ../src/qt/versioncheckutil.cpp \
    ../src/qt/updateavailabledialog.cpp \
    ../src/qt/reviewpaperkeydialog.cpp \
    ../src/qt/paicoindialog.cpp
    ../src/qt/sendcoinspage.cpp \
    ../src/qt/receivecoinspage.cpp

HEADERS += \
    ../src/qt/authmanager.h \
    ../src/qt/settingshelper.h \
    ../src/qt/addressbookpage.h \
    ../src/qt/addresstablemodel.h \
    ../src/qt/askpassphrasedialog.h \
    ../src/qt/bantablemodel.h \
    ../src/qt/callback.h \
    ../src/qt/clientmodel.h \
    ../src/qt/coincontroldialog.h \
    ../src/qt/coincontroltreewidget.h \
    ../src/qt/confirmationdialog.h \
    ../src/qt/csvmodelwriter.h \
    ../src/qt/editaddressdialog.h \
    ../src/qt/guiconstants.h \
    ../src/qt/guiutil.h \
    ../src/qt/intro.h \
    ../src/qt/modaloverlay.h \
    ../src/qt/networkstyle.h \
    ../src/qt/notificator.h \
    ../src/qt/openuridialog.h \
    ../src/qt/optionsdialog.h \
    ../src/qt/optionsmodel.h \
    ../src/qt/overviewpage.h \
    ../src/qt/paicoinaddressvalidator.h \
    ../src/qt/paicoinamountfield.h \
    ../src/qt/paicoingui.h \
    ../src/qt/paicoinunits.h \
    ../src/qt/paymentrequest.pb.h \
    ../src/qt/paymentrequestplus.h \
    ../src/qt/paymentserver.h \
    ../src/qt/peertablemodel.h \
    ../src/qt/platformstyle.h \
    ../src/qt/qrimagewidget.h \
    ../src/qt/qvalidatedlineedit.h \
    ../src/qt/qvaluecombobox.h \
    ../src/qt/receiverequestdialog.h \
    ../src/qt/recentrequeststablemodel.h \
    ../src/qt/rpcconsole.h \
    ../src/qt/sendcoinsentry.h \
    ../src/qt/signverifymessagedialog.h \
    ../src/qt/splashscreen.h \
    ../src/qt/trafficgraphwidget.h \
    ../src/qt/transactiondescdialog.h \
    ../src/qt/transactiondesc.h \
    ../src/qt/transactionfilterproxy.h \
    ../src/qt/transactionrecord.h \
    ../src/qt/transactiontablemodel.h \
    ../src/qt/transactionview.h \
    ../src/qt/utilitydialog.h \
    ../src/qt/walletframe.h \
    ../src/qt/walletmodel.h \
    ../src/qt/walletmodeltransaction.h \
    ../src/qt/walletview.h \
    ../src/qt/winshutdownmonitor.h \
    ../src/qt/fundsinholdingdialog.h \
    ../src/qt/walletselectionpage.h \
    ../src/qt/welcomepage.h \
    ../src/qt/setpinpage.h \
    ../src/qt/paperkeyintropage.h \
    ../src/qt/paperkeywritedownpage.h \
    ../src/qt/paperkeycompletionpage.h \
    ../src/qt/restorewalletpage.h \
    ../src/qt/viewinvestorkeydialog.h \
    ../src/qt/holdingperiodcompletedialog.h \
    ../src/coinbase_addresses.h \
    ../src/qt/versioncheckutil.h \
    ../src/qt/updateavailabledialog.h \
    ../src/qt/reviewpaperkeydialog.h \
    ../src/qt/paicoindialog.h
    ../src/qt/sendcoinspage.h \
    ../src/qt/receivecoinspage.h

UI_DIR = ../src/qt/forms

FORMS += \
    ../src/qt/forms/addressbookpage.ui \
    ../src/qt/forms/askpassphrasedialog.ui \
    ../src/qt/forms/coincontroldialog.ui \
    ../src/qt/forms/editaddressdialog.ui \
    ../src/qt/forms/helpmessagedialog.ui \
    ../src/qt/forms/intro.ui \
    ../src/qt/forms/openuridialog.ui \
    ../src/qt/forms/optionsdialog.ui \
    ../src/qt/forms/overviewpage.ui \
    ../src/qt/forms/modaloverlay.ui \
    ../src/qt/forms/receiverequestdialog.ui \
    ../src/qt/forms/debugwindow.ui \
    ../src/qt/forms/sendcoinsentry.ui \
    ../src/qt/forms/signverifymessagedialog.ui \
    ../src/qt/forms/transactiondescdialog.ui \
    ../src/qt/forms/fundsinholdingdialog.ui \
    ../src/qt/forms/walletselectionpage.ui \
    ../src/qt/forms/welcomepage.ui \
    ../src/qt/forms/setpinpage.ui \
    ../src/qt/forms/paperkeyintropage.ui \
    ../src/qt/forms/paperkeywritedownpage.ui \
    ../src/qt/forms/paperkeycompletionpage.ui \
    ../src/qt/forms/restorewalletpage.ui \
    ../src/qt/forms/viewinvestorkeydialog.ui \
    ../src/qt/forms/holdingperiodcompletedialog.ui \
    ../src/qt/forms/confirmationdialog.ui \
    ../src/qt/forms/updateavailabledialog.ui \
    ../src/qt/forms/reviewpaperkeydialog.ui \
    ../src/qt/forms/sendcoinspage.ui \
    ../src/qt/forms/receivecoinspage.ui

RESOURCES += \
    ../src/qt/paicoin.qrc

TRANSLATIONS += \
    ../src/qt/locale/paicoin_af.ts \
    ../src/qt/locale/paicoin_af_ZA.ts \
    ../src/qt/locale/paicoin_ar.ts \
    ../src/qt/locale/paicoin_be_BY.ts \
    ../src/qt/locale/paicoin_bg_BG.ts \
    ../src/qt/locale/paicoin_bg.ts \
    ../src/qt/locale/paicoin_ca_ES.ts \
    ../src/qt/locale/paicoin_ca.ts \
    ../src/qt/locale/paicoin_ca@valencia.ts \
    ../src/qt/locale/paicoin_cs.ts \
    ../src/qt/locale/paicoin_cy.ts \
    ../src/qt/locale/paicoin_da.ts \
    ../src/qt/locale/paicoin_de.ts \
    ../src/qt/locale/paicoin_el_GR.ts \
    ../src/qt/locale/paicoin_el.ts \
    ../src/qt/locale/paicoin_en_GB.ts \
    ../src/qt/locale/paicoin_en.ts \
    ../src/qt/locale/paicoin_eo.ts \
    ../src/qt/locale/paicoin_es_AR.ts \
    ../src/qt/locale/paicoin_es_CL.ts \
    ../src/qt/locale/paicoin_es_CO.ts \
    ../src/qt/locale/paicoin_es_DO.ts \
    ../src/qt/locale/paicoin_es_ES.ts \
    ../src/qt/locale/paicoin_es_MX.ts \
    ../src/qt/locale/paicoin_es.ts \
    ../src/qt/locale/paicoin_es_UY.ts \
    ../src/qt/locale/paicoin_es_VE.ts \
    ../src/qt/locale/paicoin_et_EE.ts \
    ../src/qt/locale/paicoin_et.ts \
    ../src/qt/locale/paicoin_eu_ES.ts \
    ../src/qt/locale/paicoin_fa_IR.ts \
    ../src/qt/locale/paicoin_fa.ts \
    ../src/qt/locale/paicoin_fi.ts \
    ../src/qt/locale/paicoin_fr_CA.ts \
    ../src/qt/locale/paicoin_fr_FR.ts \
    ../src/qt/locale/paicoin_fr.ts \
    ../src/qt/locale/paicoin_gl.ts \
    ../src/qt/locale/paicoin_he.ts \
    ../src/qt/locale/paicoin_hi_IN.ts \
    ../src/qt/locale/paicoin_hr.ts \
    ../src/qt/locale/paicoin_hu.ts \
    ../src/qt/locale/paicoin_id_ID.ts \
    ../src/qt/locale/paicoin_it_IT.ts \
    ../src/qt/locale/paicoin_it.ts \
    ../src/qt/locale/paicoin_ja.ts \
    ../src/qt/locale/paicoin_ka.ts \
    ../src/qt/locale/paicoin_kk_KZ.ts \
    ../src/qt/locale/paicoin_ko_KR.ts \
    ../src/qt/locale/paicoin_ku_IQ.ts \
    ../src/qt/locale/paicoin_ky.ts \
    ../src/qt/locale/paicoin_la.ts \
    ../src/qt/locale/paicoin_lt.ts \
    ../src/qt/locale/paicoin_lv_LV.ts \
    ../src/qt/locale/paicoin_mk_MK.ts \
    ../src/qt/locale/paicoin_mn.ts \
    ../src/qt/locale/paicoin_ms_MY.ts \
    ../src/qt/locale/paicoin_nb.ts \
    ../src/qt/locale/paicoin_ne.ts \
    ../src/qt/locale/paicoin_nl.ts \
    ../src/qt/locale/paicoin_pam.ts \
    ../src/qt/locale/paicoin_pl.ts \
    ../src/qt/locale/paicoin_pt_BR.ts \
    ../src/qt/locale/paicoin_pt_PT.ts \
    ../src/qt/locale/paicoin_ro_RO.ts \
    ../src/qt/locale/paicoin_ro.ts \
    ../src/qt/locale/paicoin_ru_RU.ts \
    ../src/qt/locale/paicoin_ru.ts \
    ../src/qt/locale/paicoin_sk.ts \
    ../src/qt/locale/paicoin_sl_SI.ts \
    ../src/qt/locale/paicoin_sq.ts \
    ../src/qt/locale/paicoin_sr@latin.ts \
    ../src/qt/locale/paicoin_sr.ts \
    ../src/qt/locale/paicoin_sv.ts \
    ../src/qt/locale/paicoin_ta.ts \
    ../src/qt/locale/paicoin_th_TH.ts \
    ../src/qt/locale/paicoin_tr_TR.ts \
    ../src/qt/locale/paicoin_tr.ts \
    ../src/qt/locale/paicoin_uk.ts \
    ../src/qt/locale/paicoin_ur_PK.ts \
    ../src/qt/locale/paicoin_uz@Cyrl.ts \
    ../src/qt/locale/paicoin_vi.ts \
    ../src/qt/locale/paicoin_vi_VN.ts \
    ../src/qt/locale/paicoin_zh_CN.ts \
    ../src/qt/locale/paicoin_zh_HK.ts \
    ../src/qt/locale/paicoin_zh.ts \
    ../src/qt/locale/paicoin_zh_TW.ts
