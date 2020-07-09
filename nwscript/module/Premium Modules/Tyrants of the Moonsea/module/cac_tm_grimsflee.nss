#include "x0_i0_walkway"

void main()
{
    object oGrimswold = OBJECT_SELF;
    ClearAllActions();
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);
    ExecuteScript("hf_cs_exit", oGrimswold);
}
