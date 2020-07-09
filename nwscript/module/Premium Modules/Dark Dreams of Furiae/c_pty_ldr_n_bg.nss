//::///////////////////////////////////////////////
//:: FileName c_pty_ldr_n_bg
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-09-21 2:49:54 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetLastSpeaker();
    object oLeader = GetFactionLeader(oPC);

    if(oPC != oLeader) return FALSE;

    int nBackgroundSetFlag = GetLocalInt(GetModule(), "ddf_background_flag");

    if(nBackgroundSetFlag > 0) return FALSE;

    return TRUE;

}
