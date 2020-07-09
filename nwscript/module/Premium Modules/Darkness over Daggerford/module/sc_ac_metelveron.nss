//::///////////////////////////////////////////////
//:: FileName sc_ac_metelveron
//:: See whether player has encountered Elveronne
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetObjectByTag("ac_elveronne"), "has_met_pc") == 1))
        return FALSE;

    return TRUE;
}
