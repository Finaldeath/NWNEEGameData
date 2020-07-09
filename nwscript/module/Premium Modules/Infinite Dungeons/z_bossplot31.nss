void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender", FALSE);
    }
}
