//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_sharalyn1
// DATE: September 29, 2005
// AUTH: Luke Scull
// NOTE: Appears when "Crippled Fang" journal entry is
//       15+
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt >= 15)
    {
        return TRUE;
    }
    else
    {
       return FALSE;
    }
}
