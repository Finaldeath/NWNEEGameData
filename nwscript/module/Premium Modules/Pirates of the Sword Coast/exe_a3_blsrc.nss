//::///////////////////////////////////////////////
//:: Blue Source Area Of Effect
//:: exe_a3_blsrc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will apply a "fear" effect if the
    creatures enter the Area of Effect object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_a3_rgbpzzl"

void ChangeColor (object oTarget);

void main()
{
    object oEntering = GetEnteringObject();
    object oSource = GetAreaOfEffectCreator();
    object oArea = GetObjectByTag("a3_tuts_shgnpssge");
    effect eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oSource, BODY_NODE_CHEST);
    effect eSpark = EffectVisualEffect(VFX_IMP_BREACH);
    int iCurColor = GetLocalInt(oEntering, S_SRCCOLOR);

    if ((GetIsPC(oEntering) == TRUE) && (iCurColor != S_SRC_BLUE))
    {
        SetLocalInt(oEntering, S_SRCCOLOR, S_SRC_BLUE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oEntering);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oSource);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oEntering, 1.0f);

        SetLocalLocation(oEntering, S_BOUNCELOC, GetLocation(oEntering));
        AssignCommand(oArea, ChangeColor(oEntering));
    }
}

void ChangeColor (object oTarget)
{
    effect eVFXBlue = EffectVisualEffect(VFX_DUR_GLOW_BLUE);
    effect eDefence = EffectACIncrease(5, AC_SHIELD_ENCHANTMENT_BONUS);
    effect eSoak = EffectDamageReduction(10, DAMAGE_POWER_PLUS_TWENTY);

    eVFXBlue = EffectLinkEffects(eDefence, eVFXBlue);
    eVFXBlue = EffectLinkEffects(eSoak, eVFXBlue);

    // K2 - 2005_05_09
    // Set the VFX to Supernatural so they aren't removed on rest.
    eVFXBlue = SupernaturalEffect(eVFXBlue);

    SetLocalInt(oTarget, S_SRCCOLOR, S_SRC_BLUE);
    ClearSourceEffect(oTarget);
    DelayCommand(0.5f, ApplySourceEffect(oTarget, eVFXBlue));
}
