void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusSurrender") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender", FALSE);
    }
}
