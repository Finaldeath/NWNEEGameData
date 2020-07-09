int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_sti_mercenary_dead") == TRUE && GetLocalInt(GetModule(), "ddf_fed_merc_chat") == FALSE)
    {
        SetLocalInt(OBJECT_SELF, "spokeonce", TRUE);
        SetLocalInt(GetModule(), "ddf_fed_merc_chat", TRUE);
        return TRUE;
    }
    return FALSE;
}
