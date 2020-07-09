//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_order
// DATE: February 27, 2005
// AUTH: Luke Scull
// NOTE: Order members in ambush go hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
object oPC = GetFirstPC();

object oDracolich = GetObjectByTag("Dracolich");

object oWarrior = GetObjectByTag("AmbushOrderWarrior");

object oMage = GetObjectByTag("AmbushOrderWizard");

object oPriest = GetObjectByTag("AmbushOrderPriest");

ChangeToStandardFaction(oDracolich, STANDARD_FACTION_HOSTILE);

AssignCommand(oDracolich, DetermineCombatRound());

AssignCommand(oDracolich, ActionAttack(oPC));

ChangeToStandardFaction(oWarrior, STANDARD_FACTION_HOSTILE);

AssignCommand(oWarrior, DetermineCombatRound());

AssignCommand(oWarrior, ActionAttack(oPC));

ChangeToStandardFaction(oMage, STANDARD_FACTION_HOSTILE);

AssignCommand(oMage, DetermineCombatRound());

AssignCommand(oMage, ActionAttack(oPC));

ChangeToStandardFaction(oPriest, STANDARD_FACTION_HOSTILE);

AssignCommand(oPriest, DetermineCombatRound());

AssignCommand(oPriest, ActionAttack(oPC));

}
