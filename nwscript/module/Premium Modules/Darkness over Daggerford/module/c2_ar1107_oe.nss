// onEnter event for AR1107 (chamber of delights)

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
            object oWP = GetWaypointByTag("WP_AR1107_SKULLY");
            oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
        }

        // do the "one-off" actions for this area
        if (GetLocalInt(OBJECT_SELF, "nPlayerEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPlayerEntered", 1);

            // spawn julap
            object oWP = GetWaypointByTag("WP_AR1107_JULAP");
            object oJulap = CreateObject(OBJECT_TYPE_CREATURE, "ks_julap", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_PURPLE_5), oJulap);

            // destroy the useless tent door
            object oDoor = GetObjectByTag("dt_ar1107_exit");
            DestroyObject(oDoor);

            // spawn the portal that we just came thru
            oWP = GetWaypointByTag("WP_AR1107_PORTAL");
            object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
            SetLocalString(oPortal, "DESTINATION_DOWN", "WP_AR1106_PORTAL2_EXIT");

            // give a journal
            AddJournalQuestEntry("j83", 5, oPC);
        }
    }
}
