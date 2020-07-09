//::///////////////////////////////////////////////
//:: Include for the Light Barricade puzzle
//:: inc_a3_rgbpzzl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script includes the constants, and
    functions required to remove and apply
    the effects required for the puzzle.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////

const string S_VFXHOLDER = "PLC_VFXHOLDER_";
const string S_SRCCOLOR = "NPC_SOURCECOLOR";
const string S_BOUNCELOC = "NPC_SAFEBOUNCE";

const int S_SRC_RED = 1;
const int S_SRC_GREEN = 2;
const int S_SRC_BLUE = 3;
const int S_SRC_PURPLE = 4;

void ClearSourceEffect(object oTarget);
void ApplySourceEffect(object oTarget, effect eSrcEffect);

// Removed any effect the source applied to the target.
void RemoveEffectsFromObject(object oTarget, object oSource)
{
    // Cycle through the effects on the first of the two henchmen
    effect eSrcEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eSrcEffect) == TRUE)
    {
        //SendMessageToPC(oTarget, "Effect Created By ='"
        //    + GetTag(GetEffectCreator(eSrcEffect)) + "'");

        if (GetEffectCreator(eSrcEffect) == oSource)
        {
            //SendMessageToPC(oTarget, "Found Match, Attempting to remove effect.");
            DelayCommand(0.25f, RemoveEffect(oTarget, eSrcEffect));
        }

        eSrcEffect = GetNextEffect(oTarget);
    }
}

void ClearSourceEffect(object oTarget)
{
    //string sVFXHolder = S_VFXHOLDER + GetPCPublicCDKey(oTarget) + GetName(oTarget);
    object oVFXHolder = GetObjectByTag("a3_tuts_shgnpssge");
    object oCursor = OBJECT_INVALID;
    effect eSrcEffect;

    // Cycle through the effects on the first of the two henchmen
    oCursor = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget, 1);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Second of the two henchmen
    oCursor = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget, 2);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Animal companion
    oCursor = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oTarget, 2);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Familiar
    oCursor = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oTarget, 2);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Familiar
    oCursor = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget, 2);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Familiar
    oCursor = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget, 2);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Dominated Follower
    oCursor = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oTarget, 1);
    RemoveEffectsFromObject(oCursor, oVFXHolder);

    // Cycle through the effects on the Player
    RemoveEffectsFromObject(oTarget, oVFXHolder);
}

void ApplyEffectSpecial(effect eEffect, object oTarget)
{
   //SendMessageToPC(oTarget, "Effect Created By ='"
   //     + GetTag(GetEffectCreator(eEffect)) + "'");

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);
}

void ApplySourceEffect(object oTarget, effect eSrcEffect)
{
    //string sVFXHolder = S_VFXHOLDER + GetPCPublicCDKey(oTarget) + GetName(oTarget);
    object oVFXHolder = GetObjectByTag("a3_tuts_shgnpssge");

    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget, 1)));
    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oTarget, 2)));
    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oTarget, 1)));
    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oTarget, 1)));
    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget, 1)));
    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect,
        GetAssociate(ASSOCIATE_TYPE_DOMINATED, oTarget, 1)));

    AssignCommand(oVFXHolder, ApplyEffectSpecial(eSrcEffect, oTarget));

}
