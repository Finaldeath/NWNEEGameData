int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int nSpell=SPELL_DISPEL_MAGIC;
    if(GetHasSpell(nSpell,oPC))
    return TRUE;
    return FALSE;
}
