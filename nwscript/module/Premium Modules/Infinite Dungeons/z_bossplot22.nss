void main()
{
    if (GetLocalInt(GetModule(), "bHagathaSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaSurrender2", FALSE);
    }
}
