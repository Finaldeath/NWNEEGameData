// the water mephit opens the portal to upstairs

#include "hf_in_plot"

void SpawnPortal(location lLoc, string sDir, string sDest)
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", lLoc);
    SetLocalString(oPortal, sDir, sDest);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    object oSnd = GetNearestObjectByTag("MagicCrystalSourcestone", OBJECT_SELF);
    SoundObjectPlay(oSnd);
    PlaySound("sim_shwngodd1");
}

void main()
{
    // flag that the area should clean up on the next enter event
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    SetLocalInt(oArea, "nState", 2);

    // spawn the exit portal
    object oWP = GetWaypointByTag("WP_AR1106_PORTAL2_SPAWN");
    SpawnPortal(GetLocation(oWP), "DESTINATION_UP", "WP_AR1107_PORTAL_EXIT");

    // advance my dialog level
    PlotLevelSet(GetTag(OBJECT_SELF), 1);
    AddJournalQuestEntry("j83", 4, oPC);
}
