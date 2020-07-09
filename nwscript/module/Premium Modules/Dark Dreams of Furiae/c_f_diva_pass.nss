int StartingConditional()
{
    // If we talked to diva and she did not let us pass
    if ((GetLocalInt(OBJECT_SELF, "diva_001_done") == TRUE) && (GetLocalInt(OBJECT_SELF, "diva_001_letpass") == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
