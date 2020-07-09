int StartingConditional()
{
    //the player has not yet told Astriel about Drelia
    //and they did not ignore that plot loop
    if  (GetLocalInt(GetModule(), "astriel_knows_about_drelia") !=1
        && GetLocalInt(GetModule(),"teygan_start")==4)
    return TRUE;
    return FALSE;
}
