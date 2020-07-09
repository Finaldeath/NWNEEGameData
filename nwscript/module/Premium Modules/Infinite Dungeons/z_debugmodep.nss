void main()
{
    if (GetLocalInt(GetModule(), "bDebugModeP") == FALSE)
    {
        SetLocalInt(GetModule(), "bDebugMode", TRUE);
        SetLocalInt(GetModule(), "bDebugModeP", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bDebugMode", FALSE);
        SetLocalInt(GetModule(), "bDebugModeP", FALSE);
    }
}
