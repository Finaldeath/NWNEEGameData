#include "inc_id1_utility"

void main()
{
    // get current dungeon
    object oDungeon = GetCurrentDungeon();

    // get waypoint variable in area
    string sLevel = GetLocalString(OBJECT_SELF, "sVariable");
    DebugMessage("  Waypoint variable is " + sLevel);

    // set the door as having been triggered
    DebugMessage("  Door marked as triggered.");
    SetLocalInt(oDungeon, "b" + sLevel + "Triggered", TRUE);

    int nDamageDC = GetLocalInt(OBJECT_SELF, "nDamageDC");
    int nDamageType = GetLocalInt(OBJECT_SELF, "nDamageType");
    int nDamageMin = GetLocalInt(OBJECT_SELF, "nDamageMin");
    int nDamageMax = GetLocalInt(OBJECT_SELF, "nDamageMax");
    float fTrapRadius = GetLocalFloat(OBJECT_SELF, "fRadius");

    int nDamage;
    int nModifiedDamage;

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
