int StartingConditional()
{
    //true if player has charisma of 17 or more (including enhancement)
    object oPC = GetPCSpeaker();
    int nDex=GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
    if(nDex >=17)
    return TRUE;
    return FALSE;
}
