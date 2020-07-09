//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_sharalyn6
// DATE: September 29, 2005
// AUTH: Luke Scull
// NOTE: Appears when "The Crippled Fang" quest has not
//       been started.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nInt = GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt < 15)
    {
        return TRUE;
    }
    else
    {
       return FALSE;
    }
}
