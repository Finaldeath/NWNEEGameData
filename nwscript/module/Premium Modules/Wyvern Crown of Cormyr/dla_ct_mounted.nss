//////////////////////////////////////////////////////////////////
// dla_ct_mounted - Is the PC mounted?
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. Winblood  5/3/2006
/////////////////////////////////////////////////////////////////
#include "dla_i0_horse"


int StartingConditional()
{
    return DLA_GetIsMounted(GetPCSpeaker());
}
