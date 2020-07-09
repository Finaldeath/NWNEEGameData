int StartingConditional()
{
    //check is greater than 1 because conceivable that pc plays until teygan
    //plots are resolved before returning to astriel
    if(GetLocalInt(GetModule(),"teygan_start") >1)
    return TRUE;
    return FALSE;
}
