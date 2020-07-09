// Slips player alignment (both axes) toward neutral

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_NEUTRAL, ALIGNMENT_SLIP, TRUE);
}
