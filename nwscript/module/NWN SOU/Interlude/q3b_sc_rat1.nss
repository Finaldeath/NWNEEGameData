//::///////////////////////////////////////////////
//:: FileName q3b_sc_rat1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/13/2003 5:32:12 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "NW_IT_MSMLMISC11"))
		return FALSE;

	return TRUE;
}