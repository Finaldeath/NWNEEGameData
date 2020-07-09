int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_number_of_rings_found") > 0) return TRUE;
    return FALSE;
}
