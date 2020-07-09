// October 2005
// B W-Husey
// PC has at least 2 shard on them.
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())>1)
        return TRUE;

    return FALSE;
}
