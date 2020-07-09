void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisSurrender2", FALSE);
    }
}
