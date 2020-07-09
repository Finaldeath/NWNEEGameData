//::///////////////////////////////////////////////
//:: cut_fireelement
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start the Cutscene with Edgrims elder fire
    elemental avatar.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

const string STRING = "PLACEHOLDER.PLACEHOLDER.PLACEHOLDER.";

void main()
{
    object oWPPCStart1 = GetWaypointByTag("wp_pcstart1");
    object oWPPCStart2 = GetWaypointByTag("wp_pcstart2");
    object oWP_Clone0 = GetWaypointByTag("wp_clone01");
    object oWP_Clone1 = GetWaypointByTag("wp_clone02");
    object oWP_Clone2 = GetWaypointByTag("wp_clone03");
    object oWP_Clone3 = GetWaypointByTag("wp_clone04");

    object oArea = OBJECT_SELF;
    object oTree0 = GetObjectByTag("oWP_PALMTR", 0);
    object oTree1 = GetObjectByTag("oWP_PALMTR", 1);

    object oWPFireSpwn = GetWaypointByTag("wp_Fire00");
    object oWPFirewp01 = GetWaypointByTag("wp_Fire01");
    object oWPFirewp02 = GetWaypointByTag("wp_Fire02");

    object oFireTarg01 = GetObjectByTag("a1_CutTarg01");
    object oFireTarg02 = GetObjectByTag("a1_CutTarg02");

    location lEleSpawn = GetLocation(oWPFireSpwn);
    location lElement1 = GetLocation(oWPFirewp01);
    location lElement2 = GetLocation(oWPFirewp02);
    location lPCCopy1 = GetLocation(oWPPCStart1);
    location lPCCopy2 = GetLocation(oWPPCStart2);

    object oPCCopy0 = cs_CopyPC(lPCCopy1, FALSE, 0);
    object oPCCopy1 = cs_CopyPC(lPCCopy2, FALSE, 1);
    object oPCCopy2 = cs_CopyPC(lPCCopy1, FALSE, 2);
    object oPCCopy3 = cs_CopyPC(lPCCopy2, FALSE, 3);

    object oMonster = CreateObject(OBJECT_TYPE_CREATURE, "act0_fireelement", lEleSpawn);

    effect eJump = EffectDisappearAppear(lElement2);

    SetLocalObject(oArea, "a1_oMonster", oMonster);
    SetLocalObject(oArea, "a1_oPCCopy0", oPCCopy0);
    SetLocalObject(oArea, "a1_oPCCopy1", oPCCopy1);
    SetLocalObject(oArea, "a1_oPCCopy2", oPCCopy2);
    SetLocalObject(oArea, "a1_oPCCopy3", oPCCopy3);

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);
    cs_CameraUseCameraWaypoint(0.5, 10);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    //players run on camera
    cs_ActionMoveToLocation(0.8f, oPCCopy0, GetLocation(oWP_Clone0), TRUE);
    cs_ActionMoveToLocation(1.0f, oPCCopy1, GetLocation(oWP_Clone1), TRUE);
    cs_ActionMoveToLocation(1.2f, oPCCopy2, GetLocation(oWP_Clone2), TRUE);
    cs_ActionMoveToLocation(1.4f, oPCCopy3, GetLocation(oWP_Clone3), TRUE);

    cs_CameraSetFacing(1.0f, 270.0f, 16.0f, 67.0f, CAMERA_TRANSITION_TYPE_SLOW);

    //second frame, the Monster appears in a bloom of light
    //cs_CameraUseCameraWaypoint(4.0, 11);
    cs_ApplyVFXToObject(4.0f, DURATION_TYPE_INSTANT, VFX_FNF_SUMMON_EPIC_UNDEAD, oFireTarg01);

    cs_JumpToLocation(4.5f, oMonster, lElement1);
    cs_PlayAnimation(5.0f, oMonster, ANIMATION_FIREFORGET_VICTORY1, 1.75);
    cs_ApplyVFXToObject(6.0f, DURATION_TYPE_PERMANENT, VFX_DUR_INFERNO, oFireTarg01, 2.0f);

    DelayCommand(5.0f, DayToNight(cs_GetPCObject(0), 4.0f));
    DelayCommand(5.0f, DayToNight(cs_GetPCObject(1), 4.0f));
    DelayCommand(5.0f, DayToNight(cs_GetPCObject(2), 4.0f));
    DelayCommand(5.0f, DayToNight(cs_GetPCObject(3), 4.0f));

    cs_ApplyVFXToObject(6.5f, DURATION_TYPE_TEMPORARY, VFX_FNF_SUNBEAM, oFireTarg01, 3.0);
    cs_ApplyEffectToObject(8.0f, DURATION_TYPE_PERMANENT, eJump, oMonster);

    cs_CameraSetFacing(9.7f, 270.0f, 7.0f, 62.0f, CAMERA_TRANSITION_TYPE_MEDIUM);

    //cs_ApplyVFXToObject(10.0f, DURATION_TYPE_TEMPORARY, VFX_FNF_SCREEN_SHAKE, oFireTarg01, 2.0f, TRUE);

    cs_ApplyVFXToObject(10.0f, DURATION_TYPE_TEMPORARY, VFX_FNF_FIRESTORM, oFireTarg02, 15.0f);
    cs_ApplyVFXToObject(11.5f, DURATION_TYPE_TEMPORARY, VFX_DUR_INFERNO, oFireTarg02, 3.0);
    cs_ApplyVFXToObject(11.5f, DURATION_TYPE_INSTANT, VFX_FNF_FIREBALL, oFireTarg02);
    cs_ApplyVFXToObject(11.7f, DURATION_TYPE_TEMPORARY, VFX_DUR_INFERNO, oTree0, 5.0f);
    cs_ApplyVFXToObject(11.7f, DURATION_TYPE_TEMPORARY, VFX_DUR_INFERNO, oTree1, 5.0f);

    // The player is knocked down for a second as the creature spawns
    // in and the monster cheers

    cs_JumpToLocation(12.0f, oMonster, lElement2);

    cs_ApplyEffectToObject(11.7f, DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPCCopy0, 3.5f);
    cs_ApplyEffectToObject(11.8f, DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPCCopy1, 3.5f);
    cs_ApplyEffectToObject(11.7f, DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPCCopy2, 3.5f);
    cs_ApplyEffectToObject(11.9f, DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPCCopy3, 3.5f);

    //cs_PlayAnimation(11.3f, oMonster, ANIMATION_FIREFORGET_VICTORY1, 1.75);

    cs_ActionStartConversation(13.0f, oMonster, cs_GetPCObject(), "a1_elemental");
    //cs_ActionSetFacingPoint(8.5f, oMonster, GetPosition(oPCCopy));

}

