// October 2005
// PC has four shards
#include "cu_functions"
int StartingConditional()
{

    if(GetShards(GetPCSpeaker())==4)
        return TRUE;

    return FALSE;
}
