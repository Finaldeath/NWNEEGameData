//::///////////////////////////////////////////////
//:: FileName con_ac_mquest4
//:: NPC speaker attacks and set appropriate variable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/02/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
object oPC = GetPCSpeaker();

ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
ActionAttack(oPC);
DetermineCombatRound(oPC);
}
