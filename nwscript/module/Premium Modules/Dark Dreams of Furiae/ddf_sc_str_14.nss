//::///////////////////////////////////////////////
//:: FileName ddf_sc_str_14
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2018-10-22 3:47:40 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
	if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_STRENGTH) > 13))
		return FALSE;

	return TRUE;
}