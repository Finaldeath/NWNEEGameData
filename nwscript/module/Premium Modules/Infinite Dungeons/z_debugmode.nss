void main()
{
    if (GetLocalInt(GetModule(), "bDebugMode") == FALSE)
    {
        SetLocalInt(GetModule(), "bDebugMode", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bDebugMode", FALSE);
    }
}
