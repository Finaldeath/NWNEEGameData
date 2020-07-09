int StartingConditional()
{
    //player has met astriel in the stronghold
    if(GetLocalInt(GetModule(), "astriel_lh_plot") ==1)
    return TRUE;
    return FALSE;
}
