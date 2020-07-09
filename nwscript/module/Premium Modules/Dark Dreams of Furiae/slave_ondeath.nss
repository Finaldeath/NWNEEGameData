#include "ddf_util"

void main()
{
    // Slips attacker alignment toward evil
    AdjustAlignment(GetLastAttacker(), ALIGNMENT_EVIL, ALIGNMENT_SLIP, TRUE);

}
