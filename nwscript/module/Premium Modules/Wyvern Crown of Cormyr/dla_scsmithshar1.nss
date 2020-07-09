// October 2005
// B W-Husey
// PC has at least one shard on them.
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())>0)
        return TRUE;

    return FALSE;
}
