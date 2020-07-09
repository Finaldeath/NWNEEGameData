int StartingConditional()
{
    // Is he dead?
    int iDead = GetLocalInt(GetModule(), "ddf_ulan_dead");
    if(iDead == TRUE) return TRUE;
    return FALSE;
}
