//::///////////////////////////////////////////////
//:: FileName sc_ac_wildelves1
//:: Check to see if player is on wild elves quest
//:: and the town gates are open
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    // are the town gates open?
    if (GetLocalInt(GetModule(), "pm_Daggerford_open") == 0)
        return FALSE;

    // does the player have the wild elf quest?
    if(!(GetLocalInt(GetPCSpeaker(), "ac_wildelves_quest") >= 1))
        return FALSE;

    return TRUE;
}
