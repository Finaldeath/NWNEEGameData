// B W-Husey
// September 2005
// Move Londro to the pub so he can get drunk, if the Londro sidequest is under way.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"LondroSide")==2)
    {
        AssignCommand(GetNearestObjectByTag("Londro"),JumpToLocation(GetLocation(GetWaypointByTag("JP_Londro1"))));
    }
}


