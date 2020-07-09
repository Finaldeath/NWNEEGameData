// don't let the player ask to wield beirmoura if that is not possible

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nHasMartialFeat = GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oPC);
    return (nHasMartialFeat > 0);
}
