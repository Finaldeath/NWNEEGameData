void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisCompleted") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisCompleted", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisCompleted", FALSE);
    }
}
