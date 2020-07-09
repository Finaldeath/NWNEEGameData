void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusCompleted", FALSE);
    }
}
