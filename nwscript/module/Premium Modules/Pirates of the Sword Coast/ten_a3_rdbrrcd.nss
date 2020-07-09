//::///////////////////////////////////////////////
//:: REd Barricade Trigger
//:: ten_a3_rdbrrcd
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
    object oAssociate = OBJECT_INVALID;
    effect ePass = EffectVisualEffect(VFX_IMP_DISPEL);
    effect eFail = EffectVisualEffect(VFX_IMP_DEATH_L);
    location lEnter = GetLocation(oEnter);
    location lSafe = GetLocalLocation(oEnter, S_BOUNCELOC);
    int iColor = GetLocalInt(oEnter, S_SRCCOLOR);

    if (GetObjectType(oEnter) == OBJECT_TYPE_CREATURE)
    {
        if ((iColor == S_SRC_RED) || (iColor == S_SRC_PURPLE))
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePass, lEnter);
        }
        else
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFail, lEnter);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFail, lSafe);

            // Warp the PC and their associates back to the last safe
            // location marked (Where they acuired their most resent color).
            AssignCommand(oEnter, ClearAllActions(TRUE));
            AssignCommand(oEnter, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oEnter, 1);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oEnter, 2);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oEnter, 1);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oEnter, 1);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oEnter, 1);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));

            oAssociate = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oEnter, 1);
            AssignCommand(oAssociate, ClearAllActions(TRUE));
            AssignCommand(oAssociate, JumpToLocation(lSafe));
        }
    }
}
