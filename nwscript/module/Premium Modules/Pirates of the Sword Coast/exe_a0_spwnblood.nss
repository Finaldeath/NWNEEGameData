//::///////////////////////////////////////////////
//:: exe_a0_spwnblood
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move the Bloodsailors up towards the cutscene
    in progress.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    object oWP_Blood1 = GetWaypointByTag("wp_brb_bloodsailor1");
    object oWP_Blood2 = GetWaypointByTag("wp_brb_bloodsailor2");
    object oWP_Blood3 = GetWaypointByTag("wp_brb_bloodsailor3");
    object oWP_Blood4 = GetWaypointByTag("wp_brb_bloodsailor4");

    object oWP2_Blood1 = GetWaypointByTag("wp_brb_blood2_1");
    object oWP2_Blood2 = GetWaypointByTag("wp_brb_blood2_2");
    object oWP2_Blood3 = GetWaypointByTag("wp_brb_blood2_3");
    object oWP2_Blood4 = GetWaypointByTag("wp_brb_blood2_4");

    object oSailor1 = GetObjectByTag("a0_bloodcut1");
    SetLocalInt(oSailor1, "A0_CUTSCENE", TRUE);
    object oSailor2 = GetObjectByTag("a0_bloodcut2");
    SetLocalInt(oSailor2, "A0_CUTSCENE", TRUE);
    object oSailor3 = GetObjectByTag("a0_bloodcut3");
    SetLocalInt(oSailor3, "A0_CUTSCENE", TRUE);
    object oSailor4 = GetObjectByTag("a0_bloodcut4");
    SetLocalInt(oSailor4, "A0_CUTSCENE", TRUE);

    location lBlood1 = GetLocation(oWP_Blood1);
    location lBlood2 = GetLocation(oWP_Blood2);
    location lBlood3 = GetLocation(oWP_Blood3);
    location lBlood4 = GetLocation(oWP_Blood4);

    AssignCommand(oPC, ActionPauseConversation());

    AssignCommand(oSailor1, JumpToLocation(lBlood1));
    AssignCommand(oSailor2, JumpToLocation(lBlood2));
    AssignCommand(oSailor3, JumpToLocation(lBlood3));
    AssignCommand(oSailor4, JumpToLocation(lBlood4));

    cs_ActionMoveToObject(0.2, oSailor1, oWP2_Blood1, TRUE, 0.0f, oArea);
    cs_ActionMoveToObject(0.2, oSailor2, oWP2_Blood2, TRUE, 0.0f, oArea);
    cs_ActionMoveToObject(0.2, oSailor3, oWP2_Blood3, TRUE, 0.0f, oArea);
    cs_ActionMoveToObject(0.2, oSailor4, oWP2_Blood4, TRUE, 0.0f, oArea);

    cs_CameraSetFacing(0.7, 213.0f, 11.0f, 50.0f, CAMERA_TRANSITION_TYPE_MEDIUM, oArea);

    DelayCommand(4.5f, AssignCommand(oPC, ActionResumeConversation()));
}
