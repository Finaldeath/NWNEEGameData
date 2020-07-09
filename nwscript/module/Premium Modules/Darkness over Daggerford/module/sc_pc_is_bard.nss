int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(!GetLevelByClass(CLASS_TYPE_BARD,oPC)==0)
    return TRUE;
    return FALSE;
}
