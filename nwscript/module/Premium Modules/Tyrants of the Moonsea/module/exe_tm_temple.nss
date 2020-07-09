//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_temple
// DATE: September 7, 2005
// AUTH: Luke Scull
// NOTE: Causes Slaadi and Zacharus to attack. Also
//       update journal.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
// Define objects

object oPC = GetFirstPC();

object oSlaad1 = GetObjectByTag("TempleGreenSlaad1");

object oSlaad2 = GetObjectByTag("TempleGreenSlaad2");

object oZacharus = GetObjectByTag("Zacharus");

// Add 1st "Order of the Crippled Fang" journal entry

AddJournalQuestEntry("OrderoftheCrippledFang", 10, oPC);

// Clear actions

AssignCommand(oZacharus, ClearAllActions());

// Buff Zacharus

AssignCommand(oZacharus, ActionCastSpellAtObject(SPELL_STONESKIN, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oZacharus, ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oZacharus, ActionCastSpellAtObject(SPELL_SHIELD, OBJECT_SELF,  METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

// Make slaadi and Zacharus hostile to PC

AssignCommand(oSlaad1, SetIsTemporaryEnemy(oPC));

AssignCommand(oSlaad1, DetermineCombatRound(oPC));

AssignCommand(oSlaad2, SetIsTemporaryEnemy(oPC));

AssignCommand(oSlaad2, DetermineCombatRound(oPC));

DelayCommand(1.0, AssignCommand(oZacharus, SetIsTemporaryEnemy(oPC)));

DelayCommand(1.0, AssignCommand(oZacharus, DetermineCombatRound(oPC)));
}
