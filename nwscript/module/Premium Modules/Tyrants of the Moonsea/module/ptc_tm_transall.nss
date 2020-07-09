//Door transition click to ensure entire party are teleported on transitions
//within the same area
//console drive mode didn't agree with the following code so it was removed
//float fAngleOpposite = GetOppositeDirection(fDir);
//location lTarget = GenerateNewLocation(oTarget, 1.0, fAngleOpposite, fAngleOpposite);

#include "hf_in_npc"

void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);

    if (GetIsPC(oClicker))
    {
        float fDir = GetFacing(oTarget);
        location lTarget = GetLocation(oTarget);

        string sDoor = GetLocalString(OBJECT_SELF, "HF_TRANSITION_DOOR");
        if (sDoor != "")
        {
            object oDoor = GetNearestObjectByTag(sDoor, OBJECT_SELF, 1);
            if (GetIsObjectValid(oDoor))
            {
                SetLocked(oDoor, FALSE);
                AssignCommand(oDoor, ActionOpenDoor(oDoor));
            }
            else
            {
                SendMessageToPC(oClicker, "Error: could not open door: " + sDoor);
            }
        }

        // move the player
        TeleportToMapLocation(oClicker, lTarget);
    }
    else
    {
        //Only allow non-PCs to transition if HF_TRANSITION_ALL set on door
        if(GetLocalInt(OBJECT_SELF, "HF_TRANSITION_ALL") == 0)
        {
            AssignCommand(oClicker, ClearAllActions());
            AssignCommand(oClicker, ActionMoveAwayFromObject(OBJECT_SELF, FALSE, 10.0));
        }
        else
        {
            AssignCommand(oClicker, JumpToObject(oTarget));
        }
    }
}
