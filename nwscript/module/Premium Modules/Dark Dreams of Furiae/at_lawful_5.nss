// Slips player alignment toward lawful

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_LAWFUL, ALIGNMENT_SLIP, TRUE);
}
