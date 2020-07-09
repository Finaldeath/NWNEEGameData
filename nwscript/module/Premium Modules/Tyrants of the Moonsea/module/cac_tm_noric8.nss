//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_noric8
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Noric flees to gate and is destroyed.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

void main()
{
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);

    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
