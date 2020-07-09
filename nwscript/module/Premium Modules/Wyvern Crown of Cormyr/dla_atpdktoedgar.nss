// Send soldier to Edgar
#include "cu_functions"

void main()
{
    object oEdgar = GetNearestObjectByTag("Edgar");
    SetIsDestroyable(TRUE,FALSE,FALSE);
    SetPlotFlag(OBJECT_SELF,FALSE);

    if (GetIsObjectValid(oEdgar))
    {
    ClearAllActions();
    ActionForceMoveToObject(oEdgar,TRUE,3.0,8.0);
    }
    else
    {
    location lLoc = GetLocation(GetWaypointByTag("WP_HFBCExit"));
    ClearAllActions();
    ActionForceMoveToLocation(lLoc,TRUE,10.0);
    DestroyObject(OBJECT_SELF,6.0);
    }
    PartyGotEntry("Dud",GetPCSpeaker(),100,"Soldier rescued");
    SetLocalInt(OBJECT_SELF,"nSent",1);
}
