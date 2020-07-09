// the player has used the rod of "secure shelter"

#include "x0_i0_position"
#include "x2_inc_switches"

location GetAheadNearLocation(object oTarget)
{
    float fDir = GetFacing(oTarget);
    return GenerateNewLocation(oTarget, DISTANCE_SHORT, fDir, fDir);
}

void Activate(object oPC)
{
    // destroy any old doors that might be lying around
    object oOldDoor = GetObjectByTag("ks_pl_shelter");
    if (GetIsObjectValid(oOldDoor))
    {
        DestroyObject(oOldDoor);
    }

    // create a new door facing the player
    location lLoc = GetAheadNearLocation(oPC);
    object oDoor = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_shelter", lLoc, FALSE, "ks_pl_shelter");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE_NO_SOUND), oDoor);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oDoor);
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object oPC = GetItemActivator();
        if (GetIsInCombat(oPC))
        {
            FloatingTextStringOnCreature("... You cannot use this item in combat ...", oPC);
        }
        else
        {
            Activate(GetItemActivator());
        }
    }
}
