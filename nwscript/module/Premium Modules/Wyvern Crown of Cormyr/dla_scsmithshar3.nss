// October 2005
// B W-Husey
// PC has at least 3 shard on them.

#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())>2)
        return TRUE;

    return FALSE;
}
