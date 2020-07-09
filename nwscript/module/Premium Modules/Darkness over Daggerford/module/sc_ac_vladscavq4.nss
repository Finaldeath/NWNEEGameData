//::///////////////////////////////////////////////
//:: FileName sc_ac_vladscavq4
//:: Post Vlad scavenger quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/16/2005 2:02:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_vlad_scav_quest") == 4))
        return FALSE;

    return TRUE;
}
