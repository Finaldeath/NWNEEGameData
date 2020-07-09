#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHenchman = GetObjectByTag("pm_raegen");
    if(HenchmanIsMine(oHenchman, oPC) == TRUE && GetLocalInt(oHenchman, "ac_raegen_influence") >= 5)
    return TRUE;
    return FALSE;
}
