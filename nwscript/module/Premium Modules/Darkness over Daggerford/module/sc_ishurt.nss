// is the player badly hurt?

#include "nw_i0_generic"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nCurHP = GetCurrentHitPoints(oPC);
    int nMaxHP = GetMaxHitPoints(oPC);

    if (nCurHP < nMaxHP)
    {
        return TRUE;
    }
    if (GetHasEffect(EFFECT_TYPE_POISON, oPC) ||
        GetHasEffect(EFFECT_TYPE_NEGATIVELEVEL, oPC) ||
        GetHasEffect(EFFECT_TYPE_CURSE, oPC) ||
        GetHasEffect(EFFECT_TYPE_BLINDNESS, oPC) ||
        GetHasEffect(EFFECT_TYPE_DEAF, oPC) ||
        GetHasEffect(EFFECT_TYPE_DISEASE, oPC) ||
        GetHasEffect(EFFECT_TYPE_ABILITY_DECREASE, oPC))
    {
        return TRUE;
    }

    return FALSE;
}

