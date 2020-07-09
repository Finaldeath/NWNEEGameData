//Henchman dialog for arrival in Elventree
int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYTheElvenHamlet");

    if (nInt >= 20)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
