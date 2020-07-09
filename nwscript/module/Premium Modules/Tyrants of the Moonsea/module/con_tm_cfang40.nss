//Henchmen dialog for when Karandas has been slain (JNL 40)

int StartingConditional()
{
    object oPC = GetFirstPC();

    int nInt;
    nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYOrderoftheCrippledFang");

    if(nInt >= 40)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
