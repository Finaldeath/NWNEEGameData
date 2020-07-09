int StartingConditional()
{
    object oPC = GetPCSpeaker();

    int iStrength = GetAbilityScore(oPC, ABILITY_STRENGTH);

    if(d20() < iStrength)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
