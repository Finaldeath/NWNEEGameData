//::///////////////////////////////////////////////
//:: Red Source Area Of Effect
//:: exe_a3_redsrc
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

    if ((GetIsPC(oEntering) == TRUE) && (iCurColor != S_SRC_RED))
    {
        SetLocalInt(oEntering, S_SRCCOLOR, S_SRC_RED);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oEntering);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oSource);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oEntering, 1.0f);

        SetLocalLocation(oEntering, S_BOUNCELOC, GetLocation(oEntering));
        AssignCommand(oArea, ChangeColor(oEntering));
    }
}

void ChangeColor (object oTarget)
{
    effect eVFXRed = EffectVisualEffect(VFX_DUR_GLOW_RED);
    effect eAttkUp = EffectAttackIncrease(5);
    effect eDmgkUp = EffectDamageIncrease(5);

    eVFXRed = EffectLinkEffects(eAttkUp, eVFXRed);
    eVFXRed = EffectLinkEffects(eDmgkUp, eVFXRed);

    // K2 - 2005_05_09
    // Set the VFX to Supernatural so they aren't removed on rest.
    eVFXRed = SupernaturalEffect(eVFXRed);

    SetLocalInt(oTarget, S_SRCCOLOR, S_SRC_RED);
    ClearSourceEffect(oTarget);
    DelayCommand(0.5f, ApplySourceEffect(oTarget, eVFXRed));
}
