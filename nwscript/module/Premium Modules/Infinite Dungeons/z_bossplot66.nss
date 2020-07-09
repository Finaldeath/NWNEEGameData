void main()
{
    if (GetLocalInt(GetModule(), "bMasteriusHostile") == FALSE)
    {
        SetLocalInt(GetModule(), "bMasteriusHostile", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bMasteriusHostile", FALSE);
    }
}
