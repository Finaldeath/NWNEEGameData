int StartingConditional()
{
    if(GetItemPossessedBy(GetPCSpeaker(), "db_holdfastkey") == OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
