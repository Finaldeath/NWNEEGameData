// March 2004
// B W-Husey
// Conversation starts only if not in combat.
#include "nw_i0_tool"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(OBJECT_SELF, "Rope"))
        return FALSE;
    if(GetIsInCombat(GetPCSpeaker())==TRUE)
        return FALSE;

    return TRUE;
}
