void main()
{
    if (GetLocalInt(GetModule(), "bHagathaHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaHostile", FALSE);
    }
}
