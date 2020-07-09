//::///////////////////////////////////////////////
//:: FileName sc_ac_vladscav1
//:: See whether player on Vlad's scavenger hunt quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 2:25:08 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_vlad_scav_quest") == 1))
        return FALSE;

    return TRUE;
}
