// Returns true if you HAVE ever spoken to Divala (and haven't finished your conversation)

int StartingConditional()
{
    if (GetLocalInt(GetModule(), "ddf_diva_met") && (GetLocalInt(OBJECT_SELF, "diva_001_done") == FALSE))
        return TRUE;

    return FALSE;
}
