//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Ensures the door to the thayan enclave stays open
//::////////////////////////////////////////////////////


#include "hf_in_plot"


const string DOOR_TAG_ENCLAVE_EXIT = "RedWizEnclaveOUT";
const string DOOR_TAG_ENCLAVE_ENTRANCE = "RedWizEnclaveIN";


void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC))
        return;

    if (PlotLevelGet("thayanam_status") >= 3)
    {
        object oDoorA = GetObjectByTag(DOOR_TAG_ENCLAVE_EXIT);
        SetLocked(oDoorA, FALSE);
        object oDoorB = GetObjectByTag(DOOR_TAG_ENCLAVE_ENTRANCE);
        SetLocked(oDoorB, FALSE);
    }
}
