void main()
{
    if (GetLocalInt(GetModule(), "bHaratSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratSurrender", FALSE);
    }
}
