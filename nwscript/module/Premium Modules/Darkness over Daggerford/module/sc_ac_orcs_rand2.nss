//::///////////////////////////////////////////////
//:: FileName sc_ac_orcs_rand2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/20/2005 10:50:10 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetModule(), "fieldsquest") == 1))
        return FALSE;

    // Add the randomness
    if(Random(4) >= 1)
        return FALSE;

    return TRUE;
}
