#include "cu_functions"

void main()
{
    object oLast = GetObjectByTag("WP_TestLast");
    location lLoc = GetLocation(GetWaypointByTag("WP_TestStart"));
    if (GetIsObjectValid(oLast)) DestroyObject(oLast);
    DelayCommand(0.1,ActionCreatePlace("testjumper",GetLocation(GetPCSpeaker()),"WP_TestLast"));
    DelayCommand(0.2,AssignCommand(GetPCSpeaker(),JumpToLocation(lLoc)));
}
