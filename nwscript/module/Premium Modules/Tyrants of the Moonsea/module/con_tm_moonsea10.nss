int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheMoonsea");

    if (!(nInt >= 10))

    return FALSE;

    return TRUE;
}

