// Slips player alignment toward chaotic/evil

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);
}
