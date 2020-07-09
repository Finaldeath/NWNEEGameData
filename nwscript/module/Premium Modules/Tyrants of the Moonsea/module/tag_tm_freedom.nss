// item event script for "scroll of freedom" that releases entombed creatures

#include "x2_inc_switches"
#include "x0_i0_position"
#include "NW_I0_GENERIC"

void vfx(object oPC, object oTomb)
{
    location lLoc = GetLocation(oTomb);
    effect eSmoke = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lLoc);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
    AssignCommand(oPC, PlaySound("sff_expldisp"));
}

void freedom(object oPC, object oTomb)
{
    location lLoc = GetLocation(oTomb);
    string sWP = GetLocalString(oTomb, "HF_FREEDOM_WP");
    object oWP = GetWaypointByTag(sWP);
    if (GetIsObjectValid(oWP))
    {
        lLoc = GetLocation(oWP);
    }
    string sResRef = GetLocalString(oTomb, "HF_FREEDOM_SPAWN");
    object oSpawn = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc);
    TurnToFaceObject(oPC, oSpawn);
    AssignCommand(oSpawn, DetermineCombatRound(oPC));
    DestroyObject(oTomb);

    object oPin = GetWaypointByTag("WP_TH_SCL_SOLAR");
    if (GetIsObjectValid(oPin))
    {
        SetMapPinEnabled(oPin, FALSE);
    }
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
    }

    if (GetIsPC(oPC))
    {
        object oTomb = GetNearestObjectByTag("pl_marker_freedom", oPC);
        if (GetIsObjectValid(oTomb))
        {
            vfx(oPC, oTomb);
            freedom(oPC, oTomb);
            return;
        }

        FloatingTextStringOnCreature("** Nothing Happens **", oPC);
    }
}
