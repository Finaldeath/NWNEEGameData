//::///////////////////////////////////////////////
//:: cut_a0_tasthug
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC has entered the second level of the
    Golden apple and become witnewss to the
    thugs assailing Tasina's room.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string STRING = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";

void main()
{
    object oWPClone1 = GetWaypointByTag("A0_TSNTHG_PCCPY1");
    object oWPClone2 = GetWaypointByTag("A0_TSNTHG_PCCPY2");
    object oWPClone3 = GetWaypointByTag("A0_TSNTHG_PCCPY3");
    object oWPClone4 = GetWaypointByTag("A0_TSNTHG_PCCPY4");

    object oWPSpawn = GetWaypointByTag("A0_TSNTHG_PCCPYSPWN");
    object oWPEnter = GetWaypointByTag("A0_TSNTHG_PCCPYNTR");

    object oDoor = GetObjectByTag("M1Q4P_M1Q4O");
    object oThug1 = GetObjectByTag("a0_corridor_thug");

    location lPCCopy = GetLocation(oWPSpawn);

    object oPCCopy0 = cs_CopyPC(lPCCopy, FALSE, 0);
    object oPCCopy1 = cs_CopyPC(lPCCopy, FALSE, 1);
    object oPCCopy2 = cs_CopyPC(lPCCopy, FALSE, 2);
    object oPCCopy3 = cs_CopyPC(lPCCopy, FALSE, 3);

    //Start scene from black
    cs_CameraUseCameraWaypoint(0.5f, 10);
    cs_CameraSetHeight(1.0f, 2.0f);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    //door opens and players walk on camera
    cs_ActionOpenDoor(2.0f, oDoor, oDoor);

    cs_ActionJumpToLocation(2.5f, oPCCopy0, GetLocation(oWPEnter));
    cs_ActionMoveToObject(3.0f, oPCCopy0, oWPClone1, FALSE, 0.0f);
    cs_ActionJumpToLocation(3.5f, oPCCopy1, GetLocation(oWPEnter));
    cs_ActionMoveToObject(4.0f, oPCCopy1, oWPClone2, FALSE, 0.0f);
    cs_ActionJumpToLocation(4.5f, oPCCopy2, GetLocation(oWPEnter));
    cs_ActionMoveToObject(5.0f, oPCCopy2, oWPClone3, FALSE, 0.0f);
    cs_ActionJumpToLocation(5.5f, oPCCopy3, GetLocation(oWPEnter));
    cs_ActionMoveToObject(6.0f, oPCCopy3, oWPClone4, FALSE, 0.0f);

    cs_ActionSetFacingPoint(2.2f, oThug1, GetPosition(oPCCopy0));
    cs_ActionMoveToObject(5.0f, oThug1, oWPClone1, FALSE, 1.0f);

    cs_ClearAllActions(8.0, oThug1);
    cs_ActionStartConversation(8.1f, oThug1, cs_GetPCObject());
    cs_CameraSetFacing(8.0f, 200.0f, 15.0f, 60.0f, CAMERA_TRANSITION_TYPE_SLOW);
}



