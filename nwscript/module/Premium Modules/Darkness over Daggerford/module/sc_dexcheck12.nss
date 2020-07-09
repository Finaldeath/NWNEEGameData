int StartingConditional()
{
    object oPC=GetPCSpeaker();
    int nDex=GetAbilityModifier(ABILITY_DEXTERITY,oPC);
    if(d20()+nDex>=12)
    return TRUE;
    return FALSE;
}
