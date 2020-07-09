// October 2005
// PC has one shard
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())==1)
        return TRUE;

    return FALSE;
}
