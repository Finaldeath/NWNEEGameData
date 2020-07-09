//::///////////////////////////////////////////////
//:: FileName sc_ac_vugubook
//:: Check if PC has Vugu's Journal and has only heard this once.
//:://////////////////////////////////////////////
//:: Created By: Alan Tarrant
//:: Created On: 4/30/2006 7:31:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"
int StartingConditional()
{
    // Check for Vugu's Journal in PC inventory
    if(!(HasItem(GetPCSpeaker(), "ac_vugubook")))
        return FALSE;
    // Inspect local variables
    if(!(GetLocalInt(OBJECT_SELF, "do_once") != 1))
        return FALSE;

    return TRUE;
}
