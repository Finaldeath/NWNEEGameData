// October 2005
// B W-Husey
// PC has at least one shard on them, know about crafting
#include "nw_i0_tool"
int StartingConditional()
{
    //don't care if we know about crafting
    if(GetLocalInt(GetPCSpeaker(), "XCraft") == 1)
    {

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "Shard1")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard4")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard2")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard3")) return TRUE;
    }
    return FALSE;
}
