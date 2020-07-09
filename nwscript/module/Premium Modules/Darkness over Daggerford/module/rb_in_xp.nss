// scales an integer value by a percentage
int ScaleIntValue(int n, float fPercentage)
{
    float f = IntToFloat(n) * (fPercentage/100);
    return (FloatToInt(f));
}

// give experience to player, scaling to module defaults
void GiveScaledXPToCreature(object oPC, int nXP, float fScale=100.0)
{
    object oMod = GetModule();

    // scale the XP by the player's level
    int nTargetLevel = GetLocalInt(oMod, "HF_XP_LEVEL");
    float fXP = IntToFloat(nXP);

    if (nTargetLevel > 0)
    {
        int nHD = GetHitDice(oPC);
        fXP = fXP * (IntToFloat(nHD) / IntToFloat(nTargetLevel));
    }

    // scale the XP by the global slider
    // .. this could go up or down, but default is "no change"
    float fSlider = GetLocalFloat(oMod, "HF_XP_SLIDER");
    if (fSlider <= 0.0)
    {
        fSlider = 100.0;
    }

    nXP = FloatToInt(fXP);
    nXP = ScaleIntValue(nXP, fSlider);
    // scale the XP by the value passed-in
    nXP = ScaleIntValue(nXP, fScale);
    //Round down to nearest 5xp
    nXP = nXP - (nXP % 5);
    // give the adjusted XP to the player
    GiveXPToCreature(oPC, nXP);
}

// give quest experience to player
// .. first scale by target level (high level chars need more XP)
// .. next scale by global slider (global scale value)
// .. finally scale based on scale parameter (useful for giving "half" XP)
void GiveQuestXPToCreature(object oPC, string sId, float fScale=100.0)
{
    int nXP = GetJournalQuestExperience(sId);

    // give the adjusted XP to the player
    if (nXP > 0)
    {
        GiveScaledXPToCreature(oPC, nXP, fScale);
    }
}
