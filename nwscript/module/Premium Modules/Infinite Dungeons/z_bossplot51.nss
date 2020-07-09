void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbSurrender", FALSE);
    }
}
