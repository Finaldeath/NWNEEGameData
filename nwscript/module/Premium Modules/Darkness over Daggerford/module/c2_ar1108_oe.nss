// player has entered AR1108 (Edalseye's Bedroom)

#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // skully always follows the player around in the tower
        object oSkully = GetObjectInArea("ks_skully", OBJECT_SELF);
        if (!GetIsObjectValid(oSkully))
        {
            DestroyObject(oSkully);
            object oWP = GetWaypointByTag("WP_AR1108_SKULLY");
            oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
        }

        // chest of the wise is plot so it can't be destroyed
        object oChest = GetObjectInArea("ks_wise_chest", OBJECT_SELF);
        if (!GetIsObjectValid(oChest))
        {
            object oWP = GetWaypointByTag("WP_AR1108_CHEST");
            CreateObject(OBJECT_TYPE_CREATURE, "ks_wise_chest", GetLocation(oWP));
        }

        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);

            // create the portal that the player just came from
            object oWP = GetWaypointByTag("WP_AR1108_PORTAL");
            object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
            SetLocalString(oPortal, "DESTINATION_DOWN", "WP_AR1107_PORTAL2_EXIT");

            // update the journal
            AddJournalQuestEntry("j83", 7, oPC);
        }
    }
}
