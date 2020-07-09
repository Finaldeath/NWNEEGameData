//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_dazel1
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Option appears if player has a level in Monk,
//       feats in Weapon Focus: Unarmed Strike or
//       Dirty Fighting, or a strength score of 14+.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetLevelByClass(CLASS_TYPE_MONK, oPC) <= 0) return FALSE;

if (!GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE, oPC)) return FALSE;

if (!GetHasFeat(FEAT_DIRTY_FIGHTING, oPC)) return FALSE;

if (GetAbilityScore(oPC, ABILITY_STRENGTH) < 14) return FALSE;

return TRUE;
}

