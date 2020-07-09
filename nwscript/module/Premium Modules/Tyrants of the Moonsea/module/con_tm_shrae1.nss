//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_shrae1
// DATE: September 29, 2005
// AUTH: Luke Scull
// NOTE: "The Crippled Fang" journal entry equals 15.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt == 15)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

