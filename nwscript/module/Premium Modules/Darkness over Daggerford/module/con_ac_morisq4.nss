//::///////////////////////////////////////////////
//:: FileName con_ac_morisq4
//:: Player kills Elveronne with turn undead
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////

void main()
{
object oPC = GetPCSpeaker();
object oE = OBJECT_SELF;
effect eF = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
effect eD = EffectDeath(TRUE);
SetLocalInt(oPC, "moris_quest", 4);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eF, oE);
ActionMoveAwayFromObject(oPC);
DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eD, oE));
}
