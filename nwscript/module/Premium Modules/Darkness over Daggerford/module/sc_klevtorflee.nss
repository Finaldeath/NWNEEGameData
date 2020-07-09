int StartingConditional()
{
    if((GetLocalInt(GetPCSpeaker(), "pm_fernigoldmet") > 0) &&
       GetLocalInt(GetPCSpeaker(), "pm_fernigolddead") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
