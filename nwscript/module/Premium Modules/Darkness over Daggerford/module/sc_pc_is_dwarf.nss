//is PC a dwarf?
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetRacialType(oPC)==RACIAL_TYPE_DWARF)
    return TRUE;
    return FALSE;
}
