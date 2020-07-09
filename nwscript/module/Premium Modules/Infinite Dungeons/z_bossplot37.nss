void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisDead", FALSE);
    }
}
