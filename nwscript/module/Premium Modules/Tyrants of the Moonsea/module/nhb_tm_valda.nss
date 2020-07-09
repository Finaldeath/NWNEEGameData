//Valda heartbeat script to move to compass points on Scarred Lands map

#include "x0_i0_anims"

void main()
{
    string sDest = GetLocalString(OBJECT_SELF, "VALDA_DEST");

    if(sDest != "" && !GetIsInCombat() && !IsInConversation(OBJECT_SELF) &&
       !GetIsDead(OBJECT_SELF))
    {
        object oWaypoint = GetWaypointByTag(sDest);

        if(GetDistanceToObject(oWaypoint) < 2.0)
        {
            DeleteLocalString(OBJECT_SELF, "VALDA_DEST");
        }
        else
        {
            ClearAllActions(TRUE);
            ActionMoveToObject(GetWaypointByTag(sDest));
        }
    }
}
