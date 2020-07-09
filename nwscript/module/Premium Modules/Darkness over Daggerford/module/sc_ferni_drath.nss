int StartingConditional()
{
    object oDrath = GetObjectByTag("pm_capt_drath");
    if(GetLocalInt(oDrath, "has_met_pc") ==1)
    return TRUE;
    return FALSE;
}
