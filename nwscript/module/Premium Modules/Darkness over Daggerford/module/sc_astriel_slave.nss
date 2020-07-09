int StartingConditional()
{
    //drop off cave quest active and not solved but
    //the cave has been previously mentioned to astriel
    if(GetLocalInt(GetModule(), "hevesar_plot")== 5 &&
       GetLocalInt(GetModule(), "drop_off_empty")== 2 &&
       !GetLocalInt(GetModule(), "dropoffquest")== 1)
    return TRUE;
    return FALSE;
}
