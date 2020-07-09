// October 2005
// PC has two shards
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())==2)
        return TRUE;

    return FALSE;
}
