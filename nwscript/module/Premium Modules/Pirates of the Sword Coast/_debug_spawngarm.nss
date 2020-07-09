/*
    A debug script to spawn in Garm and add him as a henchman. This script
    can be safely deleted before ship, if we feel it necessary.
*/
#include "x0_i0_henchman"

void main()
{
    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a1_hench_garm", GetLocation(GetFirstPC()));
    //HireHenchman(GetFirstPC(), oGarm, FALSE);
    AddHenchman(GetFirstPC(), oGarm);
}
