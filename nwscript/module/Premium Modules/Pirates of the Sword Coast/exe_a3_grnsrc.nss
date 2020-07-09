//::///////////////////////////////////////////////
//:: Green Source Area Of Effect
//:: exe_a3_grnsrc
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

    if ((GetIsPC(oEntering) == TRUE) && (iCurColor != S_SRC_GREEN))
    {
        SetLocalInt(oEntering, S_SRCCOLOR, S_SRC_GREEN);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oEntering);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oSource);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oEntering, 1.0f);

        SetLocalLocation(oEntering, S_BOUNCELOC, GetLocation(oEntering));
        AssignCommand(oArea, ChangeColor(oEntering));
    }
}

void ChangeColor (object oTarget)
{
    effect eVFXGreen = EffectVisualEffect(VFX_DUR_GLOW_GREEN);
    effect eSpeed = EffectHaste();
    effect eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, 10);

    eVFXGreen = EffectLinkEffects(eReflex, eVFXGreen);
    eVFXGreen = EffectLinkEffects(eSpeed, eVFXGreen);

    // K2 - 2005_05_09
    // Set the VFX to Supernatural so they aren't removed on rest.
    eVFXGreen = SupernaturalEffect(eVFXGreen);

    SetLocalInt(oTarget, S_SRCCOLOR, S_SRC_GREEN);
    ClearSourceEffect(oTarget);
    DelayCommand(0.5f, ApplySourceEffect(oTarget, eVFXGreen));
}
