//::///////////////////////////////////////////////
//:: FileName con_tm_astardead
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 30/06/2006 15:31:51
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "elventreeattacked") == 3))
		return FALSE;

	return TRUE;
}