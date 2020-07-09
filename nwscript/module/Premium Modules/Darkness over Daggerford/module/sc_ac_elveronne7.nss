//::///////////////////////////////////////////////
//:: FileName sc_ac_elveronne7
//:: See whether Elveronne has returned to his crypt
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb. 26, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "elveronne_quest") == 7))
        return FALSE;

    return TRUE;
}
