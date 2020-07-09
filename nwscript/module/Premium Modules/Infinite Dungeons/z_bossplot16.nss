void main()
{
    if (GetLocalInt(GetModule(), "bBacchaHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaHostile", FALSE);
    }
}
