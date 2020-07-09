// Slips player alignment toward chaotic

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
}
