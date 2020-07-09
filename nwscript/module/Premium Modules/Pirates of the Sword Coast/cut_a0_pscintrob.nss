//::///////////////////////////////////////////////
//:: cut_a0_pscintrob
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allendry is waiting on the deck of the rose
    and interacts with the PC as they spawn.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string STRING = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";

void main()
{
    object oWPClone1 = GetWaypointByTag("a0_pscintrob_PC1");
    object oWPClone2 = GetWaypointByTag("a0_pscintrob_PC2");
    object oWPClone3 = GetWaypointByTag("a0_pscintrob_PC3");
    object oWPClone4 = GetWaypointByTag("a0_pscintrob_PC4");

    object oWPSpawn = GetWaypointByTag("a0_pscintrob_spwn");
    object oWPEnter = GetWaypointByTag("a0_PCboat1");

    object oDoor = GetObjectByTag("M1Q4A_A0MRLL1");
    object oAllendry = GetObjectByTag("a0_Allendry");
    object oNisar = GetObjectByTag("a0_hench_nisar");

    location lPCCopy1 = GetLocation(oWPSpawn);

    object oPCCopy0 = cs_CopyPC(lPCCopy1, FALSE, 0);
    object oPCCopy1 = cs_CopyPC(lPCCopy1, FALSE, 1);
    object oPCCopy2 = cs_CopyPC(lPCCopy1, FALSE, 2);
    object oPCCopy3 = cs_CopyPC(lPCCopy1, FALSE, 3);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 10);
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

    cs_ActionSetFacingPoint(2.2f, oAllendry, GetPosition(oPCCopy0));
    cs_ActionMoveToObject(5.0f, oAllendry, oWPClone1, FALSE, 1.0f);
    cs_ClearAllActions(7.0f, oAllendry);
    cs_ActionStartConversation(7.1f, oAllendry, cs_GetPCObject());
}

