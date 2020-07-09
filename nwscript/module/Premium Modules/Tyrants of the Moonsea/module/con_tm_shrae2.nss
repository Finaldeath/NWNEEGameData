//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_shrae2
// DATE: September 30, 2005
// AUTH: Luke Scull
// NOTE: Appears when "The Crippled Fang" journal entry
//       is 16+
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt >= 16)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
