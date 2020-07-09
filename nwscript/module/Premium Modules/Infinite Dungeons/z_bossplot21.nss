void main()
{
    if (GetLocalInt(GetModule(), "bHagathaSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaSurrender", FALSE);
    }
}
