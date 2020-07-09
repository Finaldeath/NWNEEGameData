//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_cfang30
// DATE: November 21, 2005
// AUTH: Luke Scull
// NOTE: Has the player defeated Gloomfang
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt >= 30)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
