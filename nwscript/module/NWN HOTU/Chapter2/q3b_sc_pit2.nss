//::///////////////////////////////////////////////
//:: FileName q3b_sc_pit2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2003 3:09:31 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "q3b_rope"))
		return FALSE;

	return TRUE;
}
