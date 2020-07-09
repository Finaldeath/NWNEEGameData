void main()
{
    if (GetLocalInt(GetModule(), "bBacchaCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaCompleted", FALSE);
    }
}
