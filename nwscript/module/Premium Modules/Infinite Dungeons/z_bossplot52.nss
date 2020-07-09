void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender2", FALSE);
    }
}
