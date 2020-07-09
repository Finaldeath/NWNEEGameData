//Shown note, has told about Xatuum
int StartingConditional()
{
    if((GetLocalInt(GetModule(), "iShownMaerovynaNote") == 1) &&
       GetLocalInt(GetModule(), "iToldMaerXatuum") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
