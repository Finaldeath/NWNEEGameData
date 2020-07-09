// October 2005
// B W-Husey
// PC has at least 4 shard on them.
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())>3)
        return TRUE;

    return FALSE;
}
