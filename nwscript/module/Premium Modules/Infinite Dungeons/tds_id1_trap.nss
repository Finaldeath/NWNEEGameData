//::///////////////////////////////////////////////
//:: ID Trap Triggered
//:: ten_id_trap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This trap must first setup using the IDSetUpScaledTrap function in the
"inc_id_traps" inorder to function.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Sept 08, 2005
//:://////////////////////////////////////////////
#include "inc_id1_debug"
#include "inc_id_traps"
#include "inc_id1_utility"

void main()
{
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable");
    int nDamageDC = GetLocalInt(OBJECT_SELF, "nDamageDC");
    int nDamageType = GetLocalInt(OBJECT_SELF, "nDamageType");
    int nDamageMin = GetLocalInt(OBJECT_SELF, "nDamageMin");
    int nDamageMax = GetLocalInt(OBJECT_SELF, "nDamageMax");
    float fTrapRadius = GetLocalFloat(OBJECT_SELF, "fRadius");

    int nDamage;

    DebugMessage("Triggering trap.");
    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "b" + sVariable + "Triggered", TRUE);

    if (fTrapRadius == 0.0)
    {
        DebugMessage("No trap radius");

        object oPC = GetClickingObject();
        if (oPC == OBJECT_INVALID)
        {
            DebugMessage("No clicking PC");
        }

        SendMessageToPC(oPC, "trap got you");

        nDamage = Random(nDamageMax) + nDamageMin;
        DebugMessage("Doing " + IntToString(nDamage) + " to PC");

        // EDIT: do a saving throw
        // EDIT: modify to add poison traps
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, nDamageType), oPC);
    } else
    {
        DebugMessage("Trap radius");

        object oCreature = GetFirstObjectInShape(SHAPE_CUBE, fTrapRadius, GetLocation(OBJECT_SELF), TRUE);

        while (oCreature != OBJECT_INVALID)
        {
            DebugMessage("Damaging creature " + GetTag(oCreature));

            nDamage = Random(nDamageMax) + nDamageMin;

            // EDIT: do a saving throw
            // EDIT: modify to add poison traps
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, nDamageType), oCreature);

            oCreature = GetNextObjectInShape(SHAPE_CUBE, fTrapRadius, GetLocation(OBJECT_SELF), TRUE);
        }
    }

    // EDIT: remove self
}



/*
    // Apply Trap Effect.
    effect eDamage;
    int nDamage,nPoison;
    object oTarget = oEnter;
    location lCenter = GetLocation(oEnter);
    effect eVis = GetVisualEffect(nAOE,nDamType);
    if (nAOE) // Area of Effect Traps
    {
        if (nDamType == DAMAGE_TYPE_ELECTRICAL)
        {
            // Start Special Lightning Trap VFX
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oEnter,3.0);
        }
        else
        {
            // Other visual effects
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis,lCenter,6.0);
        }

        oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_HUGE,lCenter,TRUE);
        if (nDamType == DAMAGE_TYPE_POISON) // Poison Traps
        {
            nPoison = GetPoisonType(nDice);
            eDamage = EffectPoison(nPoison);
            while(GetIsObjectValid(oTarget))
            {
                // Chose to make all the poison traps a gas preventing rogue evasion. Call it the great equalizer.
                // May get over ridden later. If so put the saving throw here.
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDamage,oTarget);
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_HUGE,lCenter,TRUE);
            }
        }
        else //Non Poison Traps
        {
            while(GetIsObjectValid(oTarget))
            {
                nDamage = GetTrapDamageAmount(nDice,nDamageDie);
                nDamage = GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_TRAP,oTrap);
                eDamage = EffectDamage(nDamage,nDamType);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                if (nDamType == DAMAGE_TYPE_ELECTRICAL)
                {   // Continue special lightning trap VFX.
                    AssignCommand(oEnter, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,2.0));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_HUGE,lCenter,FALSE);
            }
        }
    }
    else  // Point Target Traps
    {
        if (nDamType == DAMAGE_TYPE_POISON)
        {
            nPoison = GetPoisonType(nDice);
            eDamage = EffectPoison(nPoison);
            // Chose to make all the poison traps a gas preventing rogue evasion. Call it the great equalizer.
            // May get over ridden later. If so put the saving throw here.

        }
        else
        {
            nDamage = GetTrapDamageAmount(nDice,nDamageDie);
            nDamage = GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_TRAP,oTrap);
            eDamage = EffectDamage(nDamage,nDamType);
        }
        if (GetApplyTrapVFXToObject(nDamType))
        {
            // Link effects to apply the VFX and damage at same time to oTarget
            eDamage = EffectLinkEffects(eDamage,eVis);
        }
        else
        {
            // Apply VFX to location
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis,lCenter,6.0);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    }*/

