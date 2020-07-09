int StartingConditional()
{
    // If we talked to diva and she let us pass
    if ((GetLocalInt(OBJECT_SELF, "diva_001_done") == TRUE) && (GetLocalInt(OBJECT_SELF, "diva_001_letpass") == TRUE))
    {
        return TRUE;
    }

    return FALSE;
}
