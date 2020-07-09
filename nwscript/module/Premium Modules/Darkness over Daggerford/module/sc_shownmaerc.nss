//Shown note, not told about Xatuum
int StartingConditional()
{
    if((GetLocalInt(GetModule(), "iShownMaerovynaNote") == 1) &&
       GetLocalInt(GetModule(), "iToldMaerXatuum") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
