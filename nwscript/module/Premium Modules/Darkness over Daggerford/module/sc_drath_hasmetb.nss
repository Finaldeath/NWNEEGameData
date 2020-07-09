int StartingConditional()
{
    if(GetLocalInt(GetObjectByTag("pm_capt_drath"),"has_met_pc")==1)
    return TRUE;
    return FALSE;
}
