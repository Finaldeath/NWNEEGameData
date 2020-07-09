int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_guarded_warehouse_knowledge") == TRUE) return TRUE;
    return FALSE;
}
