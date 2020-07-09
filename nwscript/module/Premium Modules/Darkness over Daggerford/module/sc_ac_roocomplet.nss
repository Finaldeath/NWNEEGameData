int StartingConditional()
{

    if((GetLocalInt(GetPCSpeaker(), "ac_rookill") == 1) ||
       (GetLocalInt(GetPCSpeaker(), "ac_rootake") == 1))
     {

       return TRUE;
    }
    else
    {
        return FALSE;
    }
}
