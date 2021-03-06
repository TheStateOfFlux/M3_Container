/*************************************************************************
 *** FORTE Library Element
 ***
 *** This file was generated using the 4DIAC FORTE Export Filter V1.0.x!
 ***
 *** Name: INSYS_SMS
 *** Description: Service Interface Function Block Type
 *** Version: 
 ***     0.0: 2017-01-31/4DIAC-IDE - 4DIAC-Consortium - 
 *************************************************************************/

#include "INSYS_SMS.h"
#ifdef FORTE_ENABLE_GENERATED_SOURCE_CPP
#include "INSYS_SMS_gen.cpp"
#endif

#include <Messages.h>

DEFINE_FIRMWARE_FB(FORTE_INSYS_SMS, g_nStringIdINSYS_SMS)

const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anDataInputNames[] = {g_nStringIdQI, g_nStringIdRECIPIENT, g_nStringIdMODEM, g_nStringIdTEXT};

const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anDataInputTypeIds[] = {g_nStringIdBOOL, g_nStringIdSTRING, g_nStringIdSTRING, g_nStringIdSTRING};

const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anDataOutputNames[] = {g_nStringIdSUCCESS, g_nStringIdRESPONSE};

const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anDataOutputTypeIds[] = {g_nStringIdBOOL, g_nStringIdSTRING};

const TForteInt16 FORTE_INSYS_SMS::scm_anEIWithIndexes[] = {0, 2};
const TDataIOID FORTE_INSYS_SMS::scm_anEIWith[] = {0, 255, 0, 2, 1, 3, 255};
const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anEventInputNames[] = {g_nStringIdINIT, g_nStringIdREQ};

const TDataIOID FORTE_INSYS_SMS::scm_anEOWith[] = {0, 1, 255, 0, 1, 255};
const TForteInt16 FORTE_INSYS_SMS::scm_anEOWithIndexes[] = {0, 3, -1};
const CStringDictionary::TStringId FORTE_INSYS_SMS::scm_anEventOutputNames[] = {g_nStringIdINITO, g_nStringIdCNF};

const SFBInterfaceSpec FORTE_INSYS_SMS::scm_stFBInterfaceSpec = {
  2,  scm_anEventInputNames,  scm_anEIWith,  scm_anEIWithIndexes,
  2,  scm_anEventOutputNames,  scm_anEOWith, scm_anEOWithIndexes,  4,  scm_anDataInputNames, scm_anDataInputTypeIds,
  2,  scm_anDataOutputNames, scm_anDataOutputTypeIds,
  0, 0
};


void FORTE_INSYS_SMS::executeEvent(int pa_nEIID){
  switch(pa_nEIID){
	case scm_nEventINITID:

		SMSSender = std::make_unique<SMSMessageSenderControl>(factory->getSMSMessageSender());

		if(SMSSender) {
			setInitialised();

			SUCCESS() = SMSSender->isControlStatusOK();
			RESPONSE().fromString(SMSSender->getControlStatusMessage().c_str());
		} else {
			resetInitialised();

			SUCCESS() = false;
			RESPONSE().fromString("ERROR: initialisation failed");
		}

		sendOutputEvent(scm_nEventINITOID);
	  break;
	case scm_nEventREQID:
		SMSMessage sms;

		if(!QI()) {
			SUCCESS() = false;
			RESPONSE().fromString("QI is false");

			return;
		}

		if(!isInitialised()) {
    		SUCCESS() = false;
    		RESPONSE().fromString("ERROR: Not initialised");
    		return;
		}

		sms.recipient = RECIPIENT().getValue();
		sms.text = TEXT().getValue();
		sms.modem = MODEM().getValue();

		SMSSender->setSMSMessage(sms);
		SMSSender->sendSMSMessage();

		SUCCESS() = SMSSender->isControlStatusOK();
		RESPONSE().fromString(SMSSender->getControlStatusMessage().c_str());

		sendOutputEvent(scm_nEventCNFID);
	  break;
  }
}

FORTE_INSYS_SMS::~FORTE_INSYS_SMS() {}
