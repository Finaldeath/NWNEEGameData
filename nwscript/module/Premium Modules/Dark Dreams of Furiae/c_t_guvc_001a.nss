// if you haven't gained "official" enterance, he doesn't talk to you

int StartingConditional()
{
    int iResult = GetLocalInt(GetModule(), "ddf_guvner_gain_entrance");

    if(iResult != TRUE) return TRUE;
    return FALSE;
}
