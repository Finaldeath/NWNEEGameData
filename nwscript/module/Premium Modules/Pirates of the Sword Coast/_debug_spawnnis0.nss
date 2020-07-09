/*
    A debug script to spawn in Nisar (Act 0) and add him as a henchman. This script
    can be safely deleted before ship, if we feel it necessary.
*/
#include "x0_i0_henchman"

void main()
{
    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a0_hench_nisar", GetLocation(GetFirstPC()));
    //HireHenchman(GetFirstPC(), oGarm, FALSE);
    AddHenchman(GetFirstPC(), oGarm);
}
