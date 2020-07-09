//::///////////////////////////////////////////////
//:: FileName con_ac_killmaz
//:: Kill the werewolves in the maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
void ahcAttack(object o1, object oPC, effect eP)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, o1);
DelayCommand(1.0, SetCreatureAppearanceType(o1, APPEARANCE_TYPE_WEREWOLF));
DelayCommand(1.0, ChangeToStandardFaction(o1,STANDARD_FACTION_HOSTILE));
DelayCommand(1.1, SetIsTemporaryEnemy(oPC, o1));
DelayCommand(1.1, SetIsTemporaryEnemy(o1, oPC));
DelayCommand(1.3, AssignCommand(o1, DetermineCombatRound(oPC)));
}
void main()
{
    // Set the variables
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "ac_kill_maze", 1);
effect eP = EffectVisualEffect(VFX_IMP_POLYMORPH);
ahcAttack(OBJECT_SELF, oPC, eP);
ahcAttack(GetObjectByTag("ac_jonas2"), oPC, eP);
}
