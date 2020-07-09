// the vampire nosfiraat attacks the player

#include "nw_i0_generic"
#include "hf_in_spawn"
#include "hf_in_xp"

void Attack(object oNPC, object oPC)
{
    SetPlotFlag(oNPC, FALSE);
    SetImmortal(oPC, FALSE);
    ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
    AssignCommand(oNPC, ActionAttack(oPC));
    AssignCommand(oNPC, DetermineCombatRound(oPC));
}

void main()
{
    object oPC = GetPCSpeaker();
    int nVampLevels = SpawnGetPartyCR(oPC, 20);

    // spawn a vampire friend
    object oCoffin1 = GetNearestObjectByTag("am_ar2009_coffn2", oPC);
    SetLocked(oCoffin1, FALSE);
    AssignCommand(oCoffin1, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    object oWP1 = GetWaypointByTag("WP_AR2009_VAMP1");
    object oVamp1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_nosfiraat_sum", GetLocation(oWP1));
    SpawnLevelupCreature(oVamp1, nVampLevels);
    Attack(oVamp1, oPC);

    // spawn another vampire friend
    object oCoffin2 = GetNearestObjectByTag("am_ar2009_coffn3", oPC);
    SetLocked(oCoffin2, FALSE);
    AssignCommand(oCoffin2, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    object oWP2 = GetWaypointByTag("WP_AR2009_VAMP2");
    object oVamp2 = CreateObject(OBJECT_TYPE_CREATURE, "ks_nosfiraat_sum", GetLocation(oWP2));
    SpawnLevelupCreature(oVamp2, nVampLevels);
    Attack(oVamp2, oPC);

    // give XP to player
    GiveScaledXPToCreature(oPC, 250);

// go all hostile
    Attack(OBJECT_SELF, oPC);
}
