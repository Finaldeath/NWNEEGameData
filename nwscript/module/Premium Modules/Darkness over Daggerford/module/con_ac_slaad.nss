//::///////////////////////////////////////////////
//:: FileName con_ac_slaad
//:: NPC speaker turns into slaad form and attacks
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/30/2005 12:43:18 AM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
effect eP = EffectVisualEffect(VFX_IMP_POLYMORPH);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, OBJECT_SELF);
DelayCommand(1.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_SLAAD_GRAY));
DelayCommand(1.1, SetPortraitId(OBJECT_SELF, 720));
object oPC = GetPCSpeaker();
SetLocalInt(oPC,"ac_kill_loru",1);
ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
ActionAttack(oPC);
DetermineCombatRound(oPC);
}
