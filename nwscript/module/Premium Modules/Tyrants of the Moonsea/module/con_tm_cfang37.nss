//Dialog condition for when Crippled Fang base has been found (JNL 37)
int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if(nInt >= 37)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
