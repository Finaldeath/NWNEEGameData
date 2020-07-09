int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int nSpell=SPELL_CURE_MINOR_WOUNDS;
    if(GetHasSpell(nSpell,oPC))
    return TRUE;
    return FALSE;
}
