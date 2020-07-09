#include "ddf_util"

void main()
{
    object oPC = GetEnteringObject();
    object oTarget = GetObjectByTag(GetName(OBJECT_SELF));

    MovePartyToObject(oPC, oTarget);
}
