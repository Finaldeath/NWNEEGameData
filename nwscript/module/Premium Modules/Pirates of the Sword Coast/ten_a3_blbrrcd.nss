//::///////////////////////////////////////////////
//:: Blue Barricade Trigger
//:: ten_a3_blbrrcd
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

void main()
{
    object oEnter = GetEnteringObject();
    effect ePass = EffectVisualEffect(VFX_IMP_DISPEL);
    effect eFail = EffectVisualEffect(VFX_IMP_DEATH_L);
    location lEnter = GetLocation(oEnter);
    location lSafe = GetLocalLocation(oEnter, S_BOUNCELOC);
    int iColor = GetLocalInt(oEnter, S_SRCCOLOR);

    if (GetObjectType(oEnter) == OBJECT_TYPE_CREATURE)
    {
        if ((iColor == S_SRC_BLUE) || (iColor == S_SRC_PURPLE))
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePass, lEnter);
        }
        else
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFail, lEnter);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFail, lSafe);

            AssignCommand(oEnter, ClearAllActions(TRUE));
            AssignCommand(oEnter, JumpToLocation(lSafe));
        }
    }
}
