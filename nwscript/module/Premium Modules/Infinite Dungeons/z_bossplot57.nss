void main()
{
    if (GetLocalInt(GetModule(), "bGzhorbDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bGzhorbDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bGzhorbDead", FALSE);
    }
}
