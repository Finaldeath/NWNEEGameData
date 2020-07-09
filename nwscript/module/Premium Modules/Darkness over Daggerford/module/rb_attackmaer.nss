#include "NW_I0_GENERIC"

void main()
{
    SetPlotFlag(OBJECT_SELF, FALSE);
    SetImmortal(OBJECT_SELF, FALSE);
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, 20);
    DetermineCombatRound();
    CreateObject(OBJECT_TYPE_CREATURE, "nw_bearkodiak",
                 GetLocation(GetWaypointByTag("WP_CHAUNTEA_ALLY1")));
    CreateObject(OBJECT_TYPE_CREATURE, "nw_jaguar",
                 GetLocation(GetWaypointByTag("WP_CHAUNTEA_ALLY2")));
    CreateObject(OBJECT_TYPE_CREATURE, "rb_pixie",
                 GetLocation(GetWaypointByTag("WP_CHAUNTEA_ALLY3")));
    CreateObject(OBJECT_TYPE_CREATURE, "rb_pixie",
                 GetLocation(GetWaypointByTag("WP_CHAUNTEA_ALLY4")));
}
