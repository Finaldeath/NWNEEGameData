#include "x0_i0_spells"

// This file contains functions used to polymorph the player
// ... into a lizardman for AR1800 and AR1900.

// lizardfolk appearance
const int nLizardAppearanceType = 502;

// check if a player is polymorphed into a lizardman
int IsPolymorphed(object oPC)
{
    return(GetAppearanceType(oPC) == nLizardAppearanceType);
}

// remove the lizard polymorph effect and tail
void DePolymorph(object oPC, int nVfx=TRUE)
{
    int nAppearanceType = GetAppearanceType(oPC);

    if (nAppearanceType == nLizardAppearanceType || GetLocalInt(oPC, "iPolymorphed") == 1)
    {
        if (nVfx)
        {
            effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        }

        int nOldTailType = GetLocalInt(oPC, "nLizardPolyTail");
        SetCreatureTailType(nOldTailType, oPC);
        DeleteLocalInt(oPC, "nLizardPolyTail");

        int nOldSkin = GetLocalInt(oPC, "nLizardPolySkin");
        SetCreatureAppearanceType(oPC, nOldSkin);
        DeleteLocalInt(oPC, "nLizardPolySkin");
    }
}

// depolymorph the player and all henchies
void DePolymorphAll(object oPC, int nVfx=TRUE)
{
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        DePolymorph(oHench, nVfx);
        oHench = GetHenchman(oPC, ++i);
    }
    DePolymorph(oPC, nVfx);
}

// polymorph a creature into a lizard
void DoPolymorph(object oPC, int nVfx=TRUE)
{
    // apply the polymorph (index is line in appearance.2da)
    int nOldSkinType = GetRacialType(oPC);// GetAppearanceType(oPC);
    SetLocalInt(oPC, "nLizardPolySkin", nOldSkinType);
    if (nVfx)
    {
        effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    }
    SetCreatureAppearanceType(oPC, nLizardAppearanceType);

    // apply the lizardfolk tail
    int nOldTailType = 0;// GetCreatureTailType(oPC);
    SetLocalInt(oPC, "nLizardPolyTail", nOldTailType);
    SetCreatureTailType(4, oPC);
}

// polymorph the player and all henchies
// .. we don't polymorph familiars / animals / summons / etc.
// .. because that would be just weird.
void DoPolymorphParty(object oPC, int nVfx=TRUE)
{
    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        DoPolymorph(oHench, nVfx);
        oHench = GetHenchman(oPC, ++i);
    }
    DoPolymorph(oPC, nVfx);
}

// exit a swamp area; must depoly and set flag to repoly
void PolymorphAreaExit(object oPC)
{
    int i = 1;
    int iPolymorphed = 0;

    object oHench = GetHenchman(oPC, i);
    while(GetIsObjectValid(oHench))
    {
        if(IsPolymorphed(oHench))
        {
            iPolymorphed = 1;
            break;
        }
        oHench = GetHenchman(oPC, ++i);
    }

    if (IsPolymorphed(oPC) || iPolymorphed == 1)
    {
        SetLocalInt(oPC, "nIsSwampPolymorphed", 1);
        DePolymorphAll(oPC, FALSE);
    }
}

// enter a swamp area; must check flag to repoly
void PolymorphAreaEnter(object oPC, int nPolymorph)
{
    if (GetLocalInt(oPC, "nIsSwampPolymorphed") == 1)
    {
        if (nPolymorph)
        {
            DoPolymorphParty(oPC, FALSE);
        }
    }
    SetLocalInt(oPC, "nIsSwampPolymorphed", 0);
}
