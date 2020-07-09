//::///////////////////////////////////////////////
//:: Witch Wake: WW_Abil_Base
//:: WW_Abil_BaseDC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Always returns TRUE. This script just sets
    the Base ability DC to the standard formula.

    iHitDice + 13 + iAutoDCModifier
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: April 13, 2005
//:://////////////////////////////////////////////
#include "ww_inc"

int StartingConditional()
{
    object oCreature = GetPCSpeaker();
    string sCheckType = "WW_CHECK_TYPE_ALL";
    int iAutoDCModifier = WW_GetAutoDCModifier(sCheckType);
    int iLevel = GetHitDice(oCreature);
    int iBaseAbilityDC = 13+iLevel+iAutoDCModifier;

    WW_SetBaseAbilityDC(iBaseAbilityDC, oCreature, sCheckType);

    //Return TRUE.
    return TRUE;
}
