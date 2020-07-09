//::///////////////////////////////////////////////
//:: Act 2: Pegleg Drink DC Recalculation
//:: ww_pglg_basedc.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Recalculate Peglegs drinking game DC based on
    his current level of alcohol consumption.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: April 13, 2005
//:://////////////////////////////////////////////
#include "ww_inc"

void main()
{
    object oCreature = GetPCSpeaker();
    string sCheckType = "WW_CHECK_TYPE_ALL";
    int iAdjust = GetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK");
    int iLevel = GetHitDice(oCreature);
    int iBaseAbilityDC = (13 + iLevel) + (17 - iAdjust);

    WW_SetBaseAbilityDC(iBaseAbilityDC, oCreature, sCheckType);
}
