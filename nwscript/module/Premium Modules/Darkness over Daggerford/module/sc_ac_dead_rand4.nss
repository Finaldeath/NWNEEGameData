//::///////////////////////////////////////////////
//:: FileName sc_ac_dead_rand4
//:: See whether sisters are dead and add randommess
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/22/2005 8:15:27 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
object oE = GetObjectByTag("ac_elveronne");
int iD = GetLocalInt(oE,"sisters_dead");
    // Inspect local variables
    if(!(iD == 2))
        return FALSE;

    // Add the randomness
    if(Random(4) >= 1)
        return FALSE;

    return TRUE;
}
