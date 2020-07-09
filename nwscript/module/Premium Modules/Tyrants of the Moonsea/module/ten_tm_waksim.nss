//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_waksim
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: See below for specific details.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
#include "hf_in_npc"

// force the given NPC to attack the given player
void AttackPlayer(object oNPC, object oPC)
{
    UnfreezeCreature(oPC);
    SetPlotFlag(oNPC, FALSE);
    AssignCommand(oNPC, SetIsTemporaryEnemy(oPC));
    AssignCommand(oNPC, DetermineCombatRound());
}

void main()
{

// Define objects

object oPC = GetEnteringObject();

object oWaypoint = GetObjectByTag("WP_Simulacrum_Flee");

object oWak = GetObjectByTag("WakRatharSimulacrum");

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

// Freeze the player so that they can't run and talk to wak
FreezeCreature(oPC);

// Wak's simulacrum taunts the player and buffs himself

AssignCommand(oWak, SpeakString("Fool! You'll never made it out of here alive!"));

AssignCommand(oWak, ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oWak, ActionCastSpellAtObject(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oWak, ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

// Move Wak then remove his plot flag before making him hostile

DelayCommand(2.0, AssignCommand(oWak, ActionMoveToObject(oWaypoint, TRUE, 1.0)));

DelayCommand(6.0, AttackPlayer(oWak, oPC));

}
