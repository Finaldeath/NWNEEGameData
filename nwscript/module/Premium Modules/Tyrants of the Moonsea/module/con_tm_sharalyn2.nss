//Dialog condition for when Hilrad has asked player to find Order base (JNL 36)
int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if(nInt >= 36)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
