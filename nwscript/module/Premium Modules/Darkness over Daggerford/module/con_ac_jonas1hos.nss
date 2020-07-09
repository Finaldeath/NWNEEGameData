//::///////////////////////////////////////////////
//:: FileName con_ac_hostile
//:: NPC speaker attacks
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/20/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
object oPC = GetPCSpeaker();
effect eP = EffectVisualEffect(VFX_IMP_POLYMORPH);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, OBJECT_SELF);
DelayCommand(1.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_WEREWOLF));
ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
ActionAttack(oPC);
DetermineCombatRound(oPC);
}
