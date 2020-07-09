void main()
{
    if (GetLocalInt(GetModule(), "bHaratSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratSurrender2", FALSE);
    }
}
