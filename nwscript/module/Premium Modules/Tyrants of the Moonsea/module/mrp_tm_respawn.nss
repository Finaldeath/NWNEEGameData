// player pressed the respawn button
// .. take some GP and XP

#include "nw_i0_plot"

// applies an XP and GP penalty to the player respawning
void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = 50 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
    int nGoldToTake = FloatToInt(0.25 * GetGold(oDead));
    // * a cap of 10 000gp taken from you
    if (nGoldToTake > 10000)
    {
        nGoldToTake = 10000;
    }
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(2.0, FloatingTextStringOnCreature("... XP Loss ...", oDead, FALSE)); // 58299
    DelayCommand(3.0, FloatingTextStringOnCreature("... Gold Loss ...", oDead, FALSE)); // 58300
}

// returns true if respawn is possible
int isRespawnPossible(object oDead)
{
    string sAreaTag = GetTag(GetArea(oDead));
    if (sAreaTag == "ZhentilKeepGrandTempleoftheBlack")
    {
        return FALSE;
    }
    return TRUE;
}

void main()
{
    object oRespawner = GetLastRespawnButtonPresser();
    if (isRespawnPossible(oRespawner))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oRespawner);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
        RemoveEffects(oRespawner);
        ApplyPenalty(oRespawner);
    }
    else
    {
        FloatingTextStringOnCreature("... Cannot respawn here ...", oRespawner, FALSE);
    }
}
