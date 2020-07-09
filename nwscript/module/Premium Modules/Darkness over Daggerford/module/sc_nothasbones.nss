int StartingConditional()
{
    if(GetItemPossessedBy(GetPCSpeaker(), "ac_perebones") == OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
