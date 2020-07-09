int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return (GetAbilityScore(oPC, ABILITY_WISDOM) >= 10);
}
