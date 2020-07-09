//Not shown note, not killed Xatuum
int StartingConditional()
{
    if((GetLocalInt(GetModule(), "iShownMaerovynaNote") == 0) &&
       GetLocalInt(GetModule(), "nXatuumKilled") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
