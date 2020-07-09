void main()
{
    if (GetLocalInt(GetModule(), "bHaratDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bHaratDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bHaratDead", FALSE);
    }
}
