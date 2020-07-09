int StartingConditional()
{
    //has astriel told the player to try and find teygan?
    if(GetLocalInt(GetModule(), "astriel_lh_plot") ==2)
    return TRUE;
    return FALSE;
}
