int StartingConditional()
{
    if(GetItemPossessedBy(GetPCSpeaker(), "pm_custom_tunic") != OBJECT_INVALID ||
       GetItemPossessedBy(GetPCSpeaker(), "pm_custom_dress") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
