// BGPHughes
// 18th September 2006
// dla_trigsafety1 - makes sure henchmen move to next area if a quicksave interrupts them

#include "cu_functions"

void main()
{
        if (GetIsDefPC(GetEnteringObject()))
        {
        object oJonas = GetNearestObjectByTag("Jonas");
        object oGodfroy = GetNearestObjectByTag("Godfroy");
        location lLoc = GetLocation(GetWaypointByTag("WP_PCStartFarms"));
        AssignCommand(oJonas,JumpToLocation(lLoc));
        AssignCommand(oGodfroy,JumpToLocation(lLoc));
        DestroyObject(OBJECT_SELF,1.0);
        }
}
