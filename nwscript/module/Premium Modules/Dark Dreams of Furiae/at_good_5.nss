// Slips player alignment toward good

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIP, TRUE);
}
