//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_hilrad2
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Appears when The Crippled Fang journal entry
//       is on 40.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if (nInt == 40)
    {
        return TRUE;
    }
    else
    {
       return FALSE;
    }
}
