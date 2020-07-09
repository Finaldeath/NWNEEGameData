// Slips player alignment toward evil

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);
}
