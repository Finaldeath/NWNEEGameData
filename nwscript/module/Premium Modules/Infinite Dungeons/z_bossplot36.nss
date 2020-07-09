void main()
{
    if (GetLocalInt(GetModule(), "bMaggrisHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bMaggrisHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMaggrisHostile", FALSE);
    }
}
