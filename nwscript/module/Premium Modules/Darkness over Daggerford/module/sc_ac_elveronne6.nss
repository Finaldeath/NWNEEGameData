//::///////////////////////////////////////////////
//:: FileName sc_ac_elveronne6
//:: See if player agreed to poison sisters
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/14/2005 9:32:07 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "elveronne_quest") == 6))
        return FALSE;

    return TRUE;
}
