//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cfang17
// DATE: November 21, 2005
// AUTH: Luke Scull
// NOTE: Has the player spoken to the Zhents on the Shind
//       Road East?
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt >= 17)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
