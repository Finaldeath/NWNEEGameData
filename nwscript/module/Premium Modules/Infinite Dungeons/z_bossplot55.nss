void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbCompleted", FALSE);
    }
}
