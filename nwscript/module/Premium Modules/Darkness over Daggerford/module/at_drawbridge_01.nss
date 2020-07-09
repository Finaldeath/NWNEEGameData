// feldran offers to meet griswald at midnight

#include "hf_in_plot"

void main()
{
    // olree appears as an alternate entrance to the castle
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_AR2000_ORLEE");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_olree", GetLocation(oWP));
    oWP = GetWaypointByTag("WP_AR2000_BOAT");
    CreateObject(OBJECT_TYPE_PLACEABLE, "pdag_tno_boat1", GetLocation(oWP));

    // assume the player will agree to the meet
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 2);
    AddJournalQuestEntry("j85", 3, oPC);

    // player can tell griswald about the meet
    PlotLevelSet("ks_griswald", 3);
}
