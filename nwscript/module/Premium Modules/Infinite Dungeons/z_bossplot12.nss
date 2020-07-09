void main()
{
    if (GetLocalInt(GetModule(), "bBacchaSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaSurrender2", FALSE);
    }
}
