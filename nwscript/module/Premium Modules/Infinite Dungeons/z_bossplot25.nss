void main()
{
    if (GetLocalInt(GetModule(), "bHagathaCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaCompleted", FALSE);
    }
}
