// October 2005
// B W-Husey
// PC has at least one shard on them.
#include "nw_i0_tool"
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF,"ShardTalk")==1)     return FALSE;

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "Shard1")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard4")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard2")) return TRUE;
    else if(HasItem(GetPCSpeaker(), "Shard3")) return TRUE;

    return FALSE;
}
