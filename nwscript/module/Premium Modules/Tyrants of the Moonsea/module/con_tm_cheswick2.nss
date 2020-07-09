//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cheswick2
// DATE: December 26, 2005
// AUTH: Luke Scull
// NOTE: Appears if player has agreed to help Cheswick
//       and spoken with Ogson.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Inspect local variables
    return ( (GetLocalInt(oPC, "ogsoncaravan") == 1) &&
             (GetLocalInt(oPC, "cheswickhelp") >= 1) );
}
