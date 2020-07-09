//::///////////////////////////////////////////////
//:: FileName sc_ac_wildelves1
//:: Check to see if player is on wild elves quest
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/17/2005 4:47:28 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "ac_wildelves_quest") == 1))
        return FALSE;

    return TRUE;
}
