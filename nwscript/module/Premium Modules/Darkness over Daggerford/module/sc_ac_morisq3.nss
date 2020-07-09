//::///////////////////////////////////////////////
//:: FileName sc_ac_morisq3
//:: Check whether necklace returned to Elveronne
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/7/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "moris_quest") == 3))
        return FALSE;

    return TRUE;
}
