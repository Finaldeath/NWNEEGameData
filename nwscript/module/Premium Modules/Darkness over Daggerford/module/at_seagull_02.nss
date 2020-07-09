// tatham has told the player to find the other 2 missing druids

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oWP;

    // update journal
    AddJournalQuestEntry("j86", 2, oPC);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);

    // spawn nagnorm and penguin in a cage
    oWP = GetWaypointByTag("WP_AR1003_PENGUIN");
    object oPenguin = CreateObject(OBJECT_TYPE_CREATURE, "ks_druid_peng", GetLocation(oWP));
    SetLocalInt(oPenguin, "HF_DISABLE_AM", 1);
    oWP = GetWaypointByTag("WP_AR1003_NAGNORM");
    object oNagnorm = CreateObject(OBJECT_TYPE_CREATURE, "ks_nagnorm", GetLocation(oWP));
    object oNagnormDoor = GetObjectByTag("C1AR1000_C1AR1003_EXIT");
    SetLocked(oNagnormDoor, FALSE);

    // spawn parrot and hester
    oWP = GetWaypointByTag("WP_AR1309_PARROT");
    object oParrot = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_druid_parrot2", GetLocation(oWP));
    oWP = GetWaypointByTag("WP_AR1309_HESTER");
    object oHester = CreateObject(OBJECT_TYPE_CREATURE, "ks_hester", GetLocation(oWP));
    object oHesterDoor = GetObjectByTag("AR1300_AR1309_EXIT");
    SetLocked(oHesterDoor, FALSE);

    // chicken can now walk around again
    object oChicken = GetNearestObjectByTag("ks_druid_chick", oPC);
    DeleteLocalInt(oChicken, "HF_DISABLE_AM");
}
