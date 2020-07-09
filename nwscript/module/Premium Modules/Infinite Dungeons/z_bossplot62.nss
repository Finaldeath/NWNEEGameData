void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusSurrender2") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender2", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusSurrender2", FALSE);
    }
}
