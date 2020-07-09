//dla_scpchashorse
//The PC has a horse (mounted or not)

#include "dla_i0_horse"

int StartingConditional()
{

    // Inspect local variables
    if(DLA_GetNumHorsesOwned(GetPCSpeaker())>0)
        return TRUE;

    return FALSE;
}
