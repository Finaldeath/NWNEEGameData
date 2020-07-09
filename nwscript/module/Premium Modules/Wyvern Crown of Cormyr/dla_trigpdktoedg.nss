// March 2006
// B W-Husey
// Any remaining soldiers should be sent to Edgar so they don't interfere
#include "cu_functions"

void main()
{
    object oEdgar = GetObjectByTag("Edgar");
    object oSoldier = GetEnteringObject();

    if (GetStringLeft(GetTag(oSoldier),6)=="Purple")
    {
    location lLoc = GetLocation(GetWaypointByTag("WP_HFBCExit2"));
    AssignCommand(oSoldier,ClearAllActions());
    AssignCommand(oSoldier,DelayCommand(0.1,JumpToLocation(lLoc)));
    PartyGotEntry("Dud",GetFirstPC(),100,"Soldier rescued");
    DestroyObject(oSoldier,5.0);
    }
}
