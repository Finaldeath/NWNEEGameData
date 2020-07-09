//::///////////////////////////////////////////////
//:: sc_ac_bard
//::
//:: Checks to see whether PC has a level of bard
//:: Created By: Anya Clancy (based on Damian's script)
//:: Created On: Feb. 4, 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iBard = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    if(iBard > 0)
    return TRUE;//pc has a level of bard
    return FALSE;
}
