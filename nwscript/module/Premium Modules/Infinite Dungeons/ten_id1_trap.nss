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
//#include "inc_id_traps"
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
    int nModifiedDamage;

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

        // do a reflex saving throw
        nModifiedDamage = GetReflexAdjustedDamage(nDamage, oPC, nDamageDC, SAVING_THROW_TYPE_TRAP);
        DebugMessage("Modified damage " + IntToString(nModifiedDamage) + " to PC");

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nModifiedDamage, nDamageType), oPC);
    } else
    {
        DebugMessage("Trap radius");

        object oCreature = GetFirstObjectInShape(SHAPE_CUBE, fTrapRadius, GetLocation(OBJECT_SELF), TRUE);

        while (oCreature != OBJECT_INVALID)
        {
            DebugMessage("Damaging creature " + GetTag(oCreature));

            nDamage = Random(nDamageMax) + nDamageMin;
            DebugMessage("Doing " + IntToString(nDamage) + " to PC");

            // do a reflex saving throw
            nModifiedDamage = GetReflexAdjustedDamage(nDamage, oCreature, nDamageDC, SAVING_THROW_TYPE_TRAP);
            DebugMessage("Modified damage " + IntToString(nModifiedDamage) + " to PC");

            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nModifiedDamage, nDamageType), oCreature);

            oCreature = GetNextObjectInShape(SHAPE_CUBE, fTrapRadius, GetLocation(OBJECT_SELF), TRUE);
        }
    }
}

