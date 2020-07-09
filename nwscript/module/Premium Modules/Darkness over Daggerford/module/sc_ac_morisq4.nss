//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq4
//:: Check whether Elveronne is permanently dead
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") == 4))
        return FALSE;

    return TRUE;
}
