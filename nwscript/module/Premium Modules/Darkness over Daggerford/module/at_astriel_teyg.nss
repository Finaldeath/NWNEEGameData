void main()
{
    //Create Teygan
    //Set relevant Int for Teygan's forced convo
    location lTeygan = GetLocation(GetWaypointByTag("teygan_spwn_lh"));
    if(GetLocalInt(OBJECT_SELF, "create_teygan")!=1)
    {
        SetLocalInt(GetModule(), "teygan_start", 1);
        SetLocalInt(OBJECT_SELF,"create_teygan", 1);
        //flag for astriel's conv tree
        SetLocalInt(GetModule(), "astriel_lh_plot", 2);
    }
}
