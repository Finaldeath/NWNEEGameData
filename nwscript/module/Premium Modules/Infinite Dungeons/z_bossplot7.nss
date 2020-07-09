void main()
{
    if (GetLocalInt(GetModule(), "bBacchaDead") == FALSE)
    {
        SetLocalInt(GetModule(), "bBacchaDead", TRUE);
    } else
    {
        SetLocalInt(GetModule(), "bBacchaDead", FALSE);
    }
}
