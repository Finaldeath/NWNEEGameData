void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusDead", FALSE);
    }
}
