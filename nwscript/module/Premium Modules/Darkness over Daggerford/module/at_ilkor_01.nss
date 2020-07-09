// ilkor goes hostile

#include "hf_in_spawn"

void main()
{
    object oPC = GetPCSpeaker();

    // summon a skeleton
    object oWP = GetWaypointByTag("WP_AR0505_CUT1_SKEL");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(oWP));
    object oSkel = CreateObject(OBJECT_TYPE_CREATURE, "nw_skelwarr01", GetLocation(oWP));
    ChangeToStandardFaction(oSkel, STANDARD_FACTION_HOSTILE);
    SpawnLevelupCreature(oSkel, SpawnGetPartyCR(oPC, 50));
    AssignCommand(oSkel, ActionAttack(oPC));

    // ilkor goes hostile
    ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    AssignCommand(OBJECT_SELF, ActionAttack(oPC));

    // creech goes hostile
    object oCreech = GetNearestObjectByTag("ac_creech", OBJECT_SELF);
    ChangeToStandardFaction(oCreech, STANDARD_FACTION_HOSTILE);
    AssignCommand(oCreech, ActionAttack(oPC));
}
