//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_zalazar1
// DATE: April 1, 2006
// AUTH: Luke Scull
// NOTE: Zalazar casts a fake spell and teleports away
//       during brief conversation pause.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

//Moved to cut_tm_zalazar
//TODO:DELETE

/*
void main()
{
object oZalazar = GetObjectByTag("ZalazarTheHellspellOram");

ActionPauseConversation();

AssignCommand(oZalazar, ActionCastFakeSpellAtObject(VFX_FNF_SUMMON_MONSTER_1, OBJECT_SELF));

DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oZalazar));

DestroyObject(oZalazar, 1.5);

DelayCommand(2.5, ActionResumeConversation());
}
*/
