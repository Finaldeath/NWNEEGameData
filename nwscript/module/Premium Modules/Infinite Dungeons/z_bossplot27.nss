void main()
{
    if (GetLocalInt(GetModule(), "bHagathaDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bHagathaDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHagathaDead", FALSE);
    }
}
