// burak and crew go hostile

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();

    PlotLevelSet("BuraktheMongrel", 2);

    // burak goes hostile and teleports (?) away
    GoHostile(OBJECT_SELF);
    effect eSmoke = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, GetLocation(OBJECT_SELF));
    location lFlee = GetLocation(GetWaypointByTag("WP_RA_BRAK_FLEE"));
    AssignCommand(OBJECT_SELF, JumpToLocation(lFlee));

    // burak's first mate goes hostile
    object oMate = GetNearestObjectByTag("BurakMate", oPC, 1);
    GoHostile(oMate);

    // burak's crew goes hostile
    int n = 1;
    object oCrew = GetNearestObjectByTag("BurakCrew", oPC, n);
    while (GetIsObjectValid(oCrew))
    {
        GoHostile(oCrew);
        oCrew = GetNearestObjectByTag("BurakCrew", oPC, ++n);
    }

    // release the beasts
    object oWP = GetWaypointByTag("WP_RA_BRAK_BEAST");
    location lLoc = GetLocation(oWP);
    object oBeast1 = CreateObject(OBJECT_TYPE_CREATURE, "burakbeast1", lLoc, FALSE, "BurakBeast");
    ChangeToStandardFaction(oBeast1, STANDARD_FACTION_HOSTILE);
    object oBeast2 = CreateObject(OBJECT_TYPE_CREATURE, "burakbeast2", lLoc, FALSE, "BurakBeast");
    ChangeToStandardFaction(oBeast2, STANDARD_FACTION_HOSTILE);
    object oBeast3 = CreateObject(OBJECT_TYPE_CREATURE, "burakbeast3", lLoc, FALSE, "BurakBeast");
    ChangeToStandardFaction(oBeast3, STANDARD_FACTION_HOSTILE);
    object oBeast4 = CreateObject(OBJECT_TYPE_CREATURE, "burakbeast4", lLoc, FALSE, "BurakBeast");
    ChangeToStandardFaction(oBeast4, STANDARD_FACTION_HOSTILE);
}
