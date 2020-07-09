void main()
{
    if (GetLocalInt(GetModule(), "bDebugModeT") == FALSE)
    {
        SetLocalInt(GetModule(), "bDebugMode", TRUE);
        SetLocalInt(GetModule(), "bDebugModeT", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bDebugMode", FALSE);
        SetLocalInt(GetModule(), "bDebugModeT", FALSE);
    }
}
