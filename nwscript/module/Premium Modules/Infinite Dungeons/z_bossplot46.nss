void main()
{
    if (GetLocalInt(GetModule(), "bHaratHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratHostile", FALSE);
    }
}
