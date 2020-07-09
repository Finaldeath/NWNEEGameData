// Slips player alignment toward lawful/good

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_LAWFUL, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIP, TRUE);
}
