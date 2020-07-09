int StartingConditional()
{
    if(GetLocalInt(GetModule(), "pm_iic_lich") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
