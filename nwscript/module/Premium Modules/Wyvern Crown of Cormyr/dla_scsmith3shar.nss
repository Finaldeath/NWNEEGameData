// October 2005
// PC has 3 shards
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())==3)
        return TRUE;

    return FALSE;
}
