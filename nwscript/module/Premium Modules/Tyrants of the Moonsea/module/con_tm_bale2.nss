// returns true when the player has arcane training

int HasArcaneTraining(object oPC)
{
    int nWizard = GetLevelByClass(CLASS_TYPE_WIZARD, oPC);
    int nBard = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    int nSorc = GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    return (nWizard > 0 || nBard > 0 || nSorc > 0);
}

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (HasArcaneTraining(oPC))
        return TRUE;
    return FALSE;
}
