// (If you've asked Forvor at least one question and have not yet finished Conversation 1)

int StartingConditional()
{
    object oModule = GetModule();

    if (GetLocalInt(oModule, "ddf_forv_asked") < 1) return FALSE;
    if (GetLocalInt(oModule, "forvor_story_index") >= 1) return FALSE;

    return TRUE;
}
