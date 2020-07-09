#include "x0_i0_common"
#include "ddf_util"

void main()
{
    object oPC = GetPlaceableLastClickedBy();

    // Get the guard in front of the back door
    object oGuard = GetObjectByTag("FraternityofOrderGuard6");

    int iGuardDistracted = GetLocalInt(oGuard, "distracted");

    // If the guard is distracted then open the door
    if (iGuardDistracted == TRUE)
    {
        // Unlock and open door
        //ActionUnlockObject(OBJECT_SELF);
        //ActionOpenDoor(OBJECT_SELF);

        if(MovePartyToObject(oPC, GetObjectByTag("NW_Guvner_BackDoor")) == TRUE)
        {
            //GiveXPToAll(oPC, XP_SMALL);

            // For now just teleport the player inside the guvenor building
            //object oPlayerWaypoint = GetWaypointByTag("NW_Guvner_BackDoor");
            //location locPWP = GetLocation( oPlayerWaypoint );
            //AssignCommand(oPC, ActionJumpToLocation(locPWP));

            // Remove the blocker
            object oBlocker = GetObjectByTag("RecordsBlocker");
            DestroyObject(oBlocker);
        }
    }
    // Otherwise play the dialog between him and the player
    else
    {
        AssignCommand(oPC, ActionStartConversation(oGuard, "long_001"));
    }
}
