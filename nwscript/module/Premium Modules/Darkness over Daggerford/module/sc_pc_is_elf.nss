//is PC an elf?
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetRacialType(oPC)==RACIAL_TYPE_ELF)
    return TRUE;
    return FALSE;
}
