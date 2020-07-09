//::///////////////////////////////////////////////
//:: cut_a1_escapec
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC has killed Edgrim and the troglodytes
    and is left to build the raft alone.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// oVO1: "To be marooned on an island"
// oVO2: "be a fate worse than death itself."
const float f_VO_LENGTH_1 = 2.7;  // pp1_allendry022
const float f_VO_LENGTH_2 = 2.87; // pp1_allendry024

void DestroySacredWood();

void main()
{
    object oVO1 = GetObjectByTag("pp1_allendry022");
    object oVO2 = GetObjectByTag("pp1_allendry024");

    object oPC = GetLocalObject(OBJECT_SELF, "A1_ECSPC");

    object oCamera = GetObjectByTag("cuta1_escape");

    object oWPPC1 = GetWaypointByTag("A1CUT_PC1");
    object oWPPC1_2 = GetWaypointByTag("A1CUT_PC1_2");
    object oWPPC1_3 = GetWaypointByTag("A1CUT_PC1_3");
    object oWPPC2 = GetWaypointByTag("A1CUT_PC2");
    object oWPPC2_2 = GetWaypointByTag("A1CUT_PC2_2");
    object oWPPC3 = GetWaypointByTag("A1CUT_PC3");
    object oWPPC3_2 = GetWaypointByTag("A1CUT_PC3_2");
    object oWPPC4 = GetWaypointByTag("A1CUT_PC4");
    object oWPPC4_2 = GetWaypointByTag("A1CUT_PC4_2");

    object oWPGarm = GetObjectByTag("A1CUT_NPC1");
    object oWPGarm2 = GetWaypointByTag("A1CUT_NPC1_2");
    object oWPEmpty = GetWaypointByTag("A1CUT_NPC2");

    location lPC1 = GetLocation(oWPPC1);
    location lPC2 = GetLocation(oWPPC2);
    location lPC3 = GetLocation(oWPPC3);
    location lPC4 = GetLocation(oWPPC4);

    location lGarm = GetLocation(oWPGarm);

    object oPCClone1 = cs_CopyPC(lPC1, FALSE, cs_GetPCNumber(oPC));
    object oPCClone2, oPCClone3, oPCClone4;

    if (cs_GetPCNumber(oPC) != 2)
        oPCClone2 = cs_CopyPC(lPC2, FALSE, 2);
    else
        oPCClone2 = cs_CopyPC(lPC2, FALSE, 1);

    if (cs_GetPCNumber(oPC) != 3)
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 3);
    else
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 2);

    if (cs_GetPCNumber(oPC) != 4)
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 4);
    else
        oPCClone3 = cs_CopyPC(lPC2, FALSE, 3);

    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutgarm", lGarm);
    object oVFXTarg5 = GetObjectByTag("a1_cut_vfxtarg5");

    effect eCutGhost = EffectCutsceneGhost();

//------------------------------------------------------------------------------
    float fDelay;

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_SoundObjectPlay(5.0, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);

    cs_ResetDelay();

    cs_CameraUseCameraWaypoint(0.5, 10);
    cs_CameraSetFacing(0.25, 110.0f, 6.0f, 60.0f, CAMERA_TRANSITION_TYPE_SNAP);
    cs_CameraSetFacing(0.25, 110.0f, 10.0f, 70.0f, CAMERA_TRANSITION_TYPE_MEDIUM);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK);

    cs_ActionPlayAnimation(0.0, oGarm, ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0f, 4.0f);
    cs_ActionSetFacingPoint(3.0, oPCClone1, GetPosition(oWPGarm));
    cs_ActionSetFacingPoint(1.0, oPCClone1, GetPosition(oWPEmpty));
    cs_ActionSetFacingPoint(1.0, oPCClone1, GetPosition(oVFXTarg5));

    cs_ActionPlayAnimation(0.5, oPCClone1, ANIMATION_LOOPING_PAUSE_TIRED, 1.0f, 3.0f);

    cs_ActionMoveToObject(3.5, oPCClone1, oWPPC1_3, TRUE, 0.0f);
    cs_ActionPlayAnimation(1.0, oPCClone1, ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f);

    cs_CameraDoFade(1.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);
    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_chiseling1");
    cs_PlaySound(0.0, cs_GetPCObject(), "as_cv_sawing1");
    cs_PlaySound(1.0, cs_GetPCObject(), "as_cv_woodbreak1");

    cs_CameraUseCameraWaypoint(1.0, 30);
    DelayCommand(cs_GetDelay(), DestroySacredWood());

    cs_ApplyEffectToObject(0.1, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone1);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone2);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone3);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oPCClone4);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eCutGhost, oGarm);

    cs_JumpToLocation(0.1, oPCClone1, GetLocation(oWPPC1_2));
    cs_JumpToLocation(0.0, oPCClone2, GetLocation(oWPPC2_2));
    cs_JumpToLocation(0.0, oPCClone3, GetLocation(oWPPC3_2));
    cs_JumpToLocation(0.0, oPCClone4, GetLocation(oWPPC4_2));
    cs_JumpToLocation(0.0, oGarm, GetLocation(oWPGarm2));

    cs_CameraUseCameraWaypoint(0.4, 31);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

// end, on raft

    cs_CameraDoFade(4.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    cs_SoundObjectStop(2.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);

    cs_EndCutscene(0.1, FALSE);
}

void DestroySacredWood()
{
    object oWood;

    oWood = GetObjectByTag("a1plc_sacwood", 0);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 1);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 2);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 3);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 4);
    DestroyObject(oWood);
    oWood = GetObjectByTag("a1plc_sacwood", 5);
    DestroyObject(oWood);
}
