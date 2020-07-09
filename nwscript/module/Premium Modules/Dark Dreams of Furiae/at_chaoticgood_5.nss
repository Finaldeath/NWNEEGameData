// Slips player alignment toward chaotic/good

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIP, TRUE);
}
