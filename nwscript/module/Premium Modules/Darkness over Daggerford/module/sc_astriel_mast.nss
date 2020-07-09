int StartingConditional()
{
    //hevesar's critical path plots are complete, and player has met astriel in
    //the stronghold already
    if(GetLocalInt(GetModule(), "hevesar_plot")==6 &&
       GetLocalInt(GetModule(), "astriel_lh_plot") >0)
    return TRUE;
    return FALSE;
}
