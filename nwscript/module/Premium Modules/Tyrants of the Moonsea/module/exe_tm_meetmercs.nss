//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_meetmercs
// DATE: September 26, 2005
// AUTH: Luke Scull
// NOTE: Causes Shields' Meet killers to buff
//       and attack.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{

// Define objects

object oRaest = GetObjectByTag("Raest");

object oZain = GetObjectByTag("Zain");

object oThorne = GetObjectByTag("Thorne");

object oPC = GetFirstPC();

// Clear actions

AssignCommand(oRaest, ClearAllActions());

AssignCommand(oZain, ClearAllActions());

AssignCommand(oThorne, ClearAllActions());


// Buff up Raest

AssignCommand(oRaest, ActionCastSpellAtObject(SPELL_BARKSKIN, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oRaest, ActionCastSpellAtObject(SPELL_RESIST_ELEMENTS, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oRaest, ActionCastSpellAtObject(SPELL_GREATER_STONESKIN, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oRaest, ActionCastSpellAtObject(SPELL_REGENERATE, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

// Buff up Zain

AssignCommand(oZain, ActionCastSpellAtObject(SPELL_INVISIBILITY, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

// Get them all to attack PC

DelayCommand(1.0, AssignCommand(oRaest, SetIsTemporaryEnemy(oPC)));

DelayCommand(1.1, AssignCommand(oRaest, DetermineCombatRound()));

DelayCommand(1.2, AssignCommand(oRaest, ActionAttack(oPC)));

DelayCommand(1.0, AssignCommand(oZain, SetIsTemporaryEnemy(oPC)));

DelayCommand(1.1, AssignCommand(oZain, DetermineCombatRound()));

DelayCommand(1.2, AssignCommand(oZain, ActionAttack(oPC)));

DelayCommand(1.0, AssignCommand(oThorne, SetIsTemporaryEnemy(oPC)));

DelayCommand(1.1, AssignCommand(oThorne, DetermineCombatRound()));

DelayCommand(1.2, AssignCommand(oThorne, ActionAttack(oPC)));
}
