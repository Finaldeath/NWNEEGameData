// Slips player alignment toward lawful/evil

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_LAWFUL, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);
}
