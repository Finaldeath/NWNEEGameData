//is PC a gnome or halfling?
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetRacialType(oPC)==RACIAL_TYPE_GNOME||GetRacialType(oPC)==RACIAL_TYPE_HALFLING)
    return TRUE;
    return FALSE;
}
