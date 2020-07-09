void main()
{
    //the pc has met astriel for the first time in the stronghold
    if(GetLocalInt(GetModule(), "astriel_lh_plot") ==0)
    {
        SetLocalInt(GetModule(), "astriel_lh_plot", 1);
    }
}
