//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_drizzle7
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Appears when player has defeated magic golem.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return ( (GetLocalInt(oPC, "innovator") == 5) ||
             (GetLocalInt(oPC, "magicgolem_defeated")>= 1) ); // set in ndt_tm_magicglm
}
