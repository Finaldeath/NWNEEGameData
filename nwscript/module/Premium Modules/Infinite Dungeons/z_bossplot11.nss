void main()
{
    if (GetLocalInt(GetModule(), "bBacchaSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaSurrender", FALSE);
    }
}
