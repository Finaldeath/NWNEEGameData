int StartingConditional()
{
    //has player already talked about Teygan with Astriel?
    if(GetLocalInt(GetModule(), "astriel_lh_plot") ==3)
    return TRUE;
    return FALSE;
}
