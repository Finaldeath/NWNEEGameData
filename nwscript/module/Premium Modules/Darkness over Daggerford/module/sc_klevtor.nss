//::///////////////////////////////////////////////
//:: FileName sc_klevtor
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/11/2005 22:47:00
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "pm_klevtormet") == 1))
		return FALSE;

	return TRUE;
}
