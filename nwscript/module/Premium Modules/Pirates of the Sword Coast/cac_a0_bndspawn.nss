//::///////////////////////////////////////////////
//:: cac_a0_bndspawn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pauses the Conversation and Spawns in thugs
    To the fight on the Blood River Side.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oAttacker = OBJECT_INVALID;
    object oArea = GetArea(OBJECT_SELF);
    object oSpawn1 = GetWaypointByTag("wp_brb_spawn1");
    object oSpawn2 = GetWaypointByTag("wp_brb_spawn2");

    object oBlackRiver1 = GetObjectByTag("a0_bradleyblkr");
    object oBlackRiver2 = GetObjectByTag("a0_honeypea");
    object oDoor = GetObjectByTag("M1Q4A_M1Q4F");

    object oEscape1 = GetObjectByTag("WP_BNDESC_1");
    object oEscape2 = GetObjectByTag("WP_BNDESC_2");

    object oDest1a = GetWaypointByTag("wp_brb_dest1a");
    object oDest1b = GetWaypointByTag("wp_brb_dest1b");
    object oDest2a = GetWaypointByTag("wp_brb_dest2a");
    object oDest2b = GetWaypointByTag("wp_brb_dest2b");

    location lSpawn1 = GetLocation(oSpawn1);
    location lSpawn2 = GetLocation(oSpawn2);

    int iBRBAllies = GetLocalInt(GetModule(), "A0_BLACKRIVER_ALLY");

    ActionPauseConversation();

    cs_CameraSetFacing(0.7, 110.0f, 9.0f, 70.0f, CAMERA_TRANSITION_TYPE_MEDIUM, oArea);

    //Create some thugs, move them out into the open, and have them attack
    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "a0_brbmale", lSpawn1, FALSE, "A0_TEMP");
    DelayCommand(0.5f, AssignCommand(oAttacker, ActionMoveToObject(oDest1a, TRUE, 0.0f)));
    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "a0_brbfemale", lSpawn1, FALSE, "A0_TEMP");
    DelayCommand(1.5f, AssignCommand(oAttacker, ActionMoveToObject(oDest1b, TRUE, 0.0f)));

    //Create some thugs, move them out into the open, and have them attack
    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "a0_brbmale", lSpawn2, FALSE, "A0_TEMP");
    DelayCommand(0.5f, AssignCommand(oAttacker, ActionMoveToObject(oDest2a, TRUE, 0.0f)));
    oAttacker = CreateObject(OBJECT_TYPE_CREATURE, "a0_brbfemale", lSpawn2, FALSE, "A0_TEMP");
    DelayCommand(1.5f, AssignCommand(oAttacker, ActionMoveToObject(oDest2b, TRUE, 0.0f)));

    if(iBRBAllies == TRUE)
    {
        AssignCommand(oDoor, ActionOpenDoor(oDoor));
        AssignCommand(oBlackRiver1, ActionForceMoveToObject(oDoor, TRUE, 0.0f, 4.0f));
        AssignCommand(oBlackRiver2, ActionForceMoveToObject(oDoor, TRUE, 0.0f, 4.0f));
        AssignCommand(oBlackRiver1, ActionJumpToObject(oEscape1, FALSE));
        AssignCommand(oBlackRiver2, ActionJumpToObject(oEscape2, FALSE));
    }

    DelayCommand(3.5f, ActionResumeConversation());
}
