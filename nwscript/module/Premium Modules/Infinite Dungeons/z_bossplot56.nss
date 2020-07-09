void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbHostile", FALSE);
    }
}
