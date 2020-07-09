//::///////////////////////////////////////////////
//:: cut_a3_sgintro
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player sails away from the island of
    the dead towards the Midnight rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 7, 2005
//:://////////////////////////////////////////////
#include "inc_global"
#include "inc_undead"

// oVO1: "Cursed by the bony hand o' fate,"
// oVO2: "the crew o' the Skull and Bones resumed their quest"
// oVO3: "to find the Midnight Rose."
// oVO4: "While the ship creaked atop a glassy sea,"
// oVO5: "her new captain went below,"
// oVO6: "weary bones in need o' death-like rest..."
const float f_VO_LENGTH_1 = 2.8;  // pp1_allendry043
const float f_VO_LENGTH_2 = 3.83;  // 3.9 minus a bit -- pp1_allendry044
const float f_VO_LENGTH_3 = 2.67; // pp1_allendry045
const float f_VO_LENGTH_4 = 3.12; // pp1_allendry046
const float f_VO_LENGTH_5 = 2.48; // pp1_allendry047
const float f_VO_LENGTH_6 = 4.12; // pp1_allendry048

void main()
{
    //Sound
    object oVO1 = GetObjectByTagInArea("pp1_allendry043");
    object oVO2 = GetObjectByTagInArea("pp1_allendry044");
    object oVO3 = GetObjectByTagInArea("pp1_allendry045");
    object oVO4 = GetObjectByTagInArea("pp1_allendry046");
    object oVO5 = GetObjectByTagInArea("pp1_allendry047");
    object oVO6 = GetObjectByTagInArea("pp1_allendry048");

    //waypoints
    object oWP_PC1_1 = GetObjectByTagInArea("cs_wp_pc1_1");
    object oWP_PC1_2 = GetObjectByTagInArea("cs_wp_pc1_2");
    object oWP_PC2_1 = GetObjectByTagInArea("cs_wp_pc2_1");
    object oWP_PC3_1 = GetObjectByTagInArea("cs_wp_pc3_1");
    object oWP_PC4_1 = GetObjectByTagInArea("cs_wp_pc4_1");

    object oWP_Crew1 = GetObjectByTag("A3_Topdeck_SPWN_01");
    object oWP_Crew2 = GetObjectByTag("A3_Topdeck_SPWN_02");
    object oWP_Crew3 = GetObjectByTag("A3_Topdeck_SPWN_03");
    object oWP_Crew4 = GetObjectByTag("A3_Topdeck_SPWN_04");
    object oWP_Crew5 = GetObjectByTag("A3_Topdeck_SPWN_05");

    //creatures
    effect eCutGhost = EffectCutsceneGhost();
    object oCrew1 = GetObjectArray(OBJECT_SELF, "oaCrew", 1);
    object oCrew2 = GetObjectArray(OBJECT_SELF, "oaCrew", 2);
    object oCrew3 = GetObjectArray(OBJECT_SELF, "oaCrew", 3);
    object oCrew4 = GetObjectArray(OBJECT_SELF, "oaCrew", 4);
    object oCrew5 = GetObjectArray(OBJECT_SELF, "oaCrew", 5);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCrew1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCrew2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCrew3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCrew4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCrew5);

    object oPC1 = cs_CopyPC(GetLocation(oWP_PC1_1), FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC1);
    object oPC2 = cs_CopyPC(GetLocation(oWP_PC2_1), FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC2);
    object oPC3 = cs_CopyPC(GetLocation(oWP_PC3_1), FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC3);
    object oPC4 = cs_CopyPC(GetLocation(oWP_PC4_1), FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC4);
    ApplyVFXEyes (oPC1);
    ApplyVFXEyes (oPC2);
    ApplyVFXEyes (oPC3);
    ApplyVFXEyes (oPC4);

    // unequip weapons
    AssignCommand(oPC1, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC1)));
    AssignCommand(oPC1, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC1)));
    AssignCommand(oPC2, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC2)));
    AssignCommand(oPC2, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC2)));
    AssignCommand(oPC3, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC3)));
    AssignCommand(oPC3, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC3)));
    AssignCommand(oPC4, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC4)));
    AssignCommand(oPC4, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC4)));

    object oDoor = GetObjectByTagInArea("a3_skullbones");

//------------------------------------------------------------------------------
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_PlayAnimation(0.0, oPC2, ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0);
    cs_ActionJumpToObject(0.0, oCrew1, oWP_Crew1);
    cs_ActionJumpToObject(0.0, oCrew2, oWP_Crew2);
    cs_ActionJumpToObject(0.0, oCrew3, oWP_Crew3);
    cs_ActionJumpToObject(0.0, oCrew4, oWP_Crew4);
    cs_ActionJumpToObject(0.0, oCrew5, oWP_Crew5);

    cs_CameraUseCameraWaypoint(0.2, 1);
    cs_CameraUseCameraWaypoint(0.4, 2);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_FROM_BLACK);

    float fDelay = cs_GetDelay();
    cs_ActionMoveToObject(15.6, oPC1, oWP_PC1_2, FALSE, 0.0);
    cs_ActionPlayAnimation(0.1, oPC1, ANIMATION_LOOPING_GET_LOW, 1.0, 2.0);
    cs_ActionPlayAnimation(4.2, oDoor, ANIMATION_PLACEABLE_OPEN);
    cs_ResetDelay(-1.0, fDelay);

    cs_SoundObjectPlay(2.0, oVO1);
    cs_SoundObjectPlay(f_VO_LENGTH_1, oVO2);
    cs_SoundObjectPlay(f_VO_LENGTH_2, oVO3);
    cs_SoundObjectPlay(f_VO_LENGTH_3, oVO4);
    cs_SoundObjectPlay(f_VO_LENGTH_4, oVO5);
    cs_SoundObjectPlay(f_VO_LENGTH_5, oVO6);

    cs_CameraDoFade(f_VO_LENGTH_6 - 1.2, CS_FADE_TYPE_TO_BLACK);
    cs_SoundObjectStop(2.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_DestroyObject(0.0, oPC1);
    cs_DestroyObject(0.0, oCrew1);
    cs_DestroyObject(0.0, oCrew2);
    cs_DestroyObject(0.0, oCrew3);
    cs_DestroyObject(0.0, oCrew4);
    cs_DestroyObject(0.0, oCrew5);
    cs_EndCutscene(0.1, FALSE, TRUE, FADE_SPEED_SLOW);
}


// I need to rework this cutscene, and I think it's easiest if I just
// start from scratch. For the moment I'll leave the old script here,
// just in case we need it at some point.

//::///////////////////////////////////////////////
//:: cut_a3_sgintro
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player sails away from the island of
    the dead towards the Midnight rose, just to
    be ambushed by sahaugin.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
/*
#include "_inc_cutscene"

void main()
{
    effect eGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    object oArea = OBJECT_SELF;
    object oModule = GetModule();

    object oWPFish1_0 = GetObjectByTag("A3_SGI_FISH1_0");
    object oWPFish2_0 = GetObjectByTag("A3_SGI_FISH2_0");
    object oWPFish3_0 = GetObjectByTag("A3_SGI_FISH3_0");
    object oWPFish4_0 = GetObjectByTag("A3_SGI_FISH4_0");
    object oWPFish5_0 = GetObjectByTag("A3_SGI_FISH5_0");
    object oWPFish6_0 = GetObjectByTag("A3_SGI_FISH6_0");

    object oWPFish1_1 = GetObjectByTag("A3_SGI_FISH1_1");
    object oWPFish2_1 = GetObjectByTag("A3_SGI_FISH2_1");
    object oWPFish3_1 = GetObjectByTag("A3_SGI_FISH3_1");
    object oWPFish4_1 = GetObjectByTag("A3_SGI_FISH4_1");
    object oWPFish5_1 = GetObjectByTag("A3_SGI_FISH5_1");
    object oWPFish6_1 = GetObjectByTag("A3_SGI_FISH6_1");

    object oWayPoint0 = GetObjectByTagInArea("cs_camera_pos_1");
    object oWayPoint1 = GetObjectByTagInArea("cs_camera_pos_2");
    object oWayPoint2 = GetObjectByTagInArea("cs_camera_pos_3");

    object oTom = GetObjectByTag("a3_sgi_oldtom");
    object oFish1 = GetObjectByTag("a3_sgi_fish2",0);
    object oFish2 = GetObjectByTag("a3_sgi_fish1",0);
    object oFish3 = GetObjectByTag("a3_sgi_fish2", 1);
    object oFish4 = GetObjectByTag("a3_sgi_fish1", 1);
    object oFish5 = GetObjectByTag("a3_sgi_fish2", 2);
    object oFishLeader = GetObjectByTag("a3_sgi_fish3", 0);

    effect eDisappear1 = EffectDisappearAppear(GetLocation(oWPFish1_1));
    effect eDisappear2 = EffectDisappearAppear(GetLocation(oWPFish2_1));
    effect eDisappear3 = EffectDisappearAppear(GetLocation(oWPFish3_1));
    effect eDisappear4 = EffectDisappearAppear(GetLocation(oWPFish4_1));
    effect eDisappear5 = EffectDisappearAppear(GetLocation(oWPFish5_1));
    effect eDisappear6 = EffectDisappearAppear(GetLocation(oWPFish6_1));

    //Start scene from black
    cs_CameraDoFade(0.0f, CS_FADE_TYPE_BLACK);

    cs_CameraUseCameraWaypoint(0.5f, 1);
    cs_CameraSetMovementRate(0.5f, 0.4f);
    cs_CameraDoFade(2.5f, CS_FADE_TYPE_FROM_BLACK, 0.01f);
    cs_CameraSetFacing(2.5f, 20.0f, 15.0f, 70.0f, CAMERA_TRANSITION_TYPE_SLOW);

    //pan to the Skull and bones
    cs_CameraActionMoveToObject(2.0f, oWayPoint1, TRUE);

    //Sahaugin seige the ship
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear1, oFish1, 4.0f);
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear2, oFish2, 4.2f);
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear3, oFish3, 4.4f);
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear4, oFish4, 4.6f);
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear5, oFish5, 4.8f);
    cs_ApplyEffectToObject(30.0f, DURATION_TYPE_TEMPORARY, eDisappear6, oFishLeader, 5.0f);

    //sahaugin invade the ship
    cs_CameraSetMovementRate(25.0f, 0.3f);
    cs_CameraSetFacing(26.0f, 320.0f, 27.0f, 80.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraActionMoveToObject(26.0f, oWayPoint2, TRUE);

    cs_ActionSetFacingPoint(35.5f, oFishLeader, GetPosition(oTom));
    cs_ActionSetFacingPoint(35.4f, oFish5, GetPosition(oTom));
    cs_ActionSetFacingPoint(35.7f, oFish4, GetPosition(oTom));
    cs_ActionSetFacingPoint(35.8f, oFish3, GetPosition(oTom));
    cs_ActionSetFacingPoint(35.9f, oFish2, GetPosition(oTom));
    cs_ActionSetFacingPoint(35.8f, oFish1, GetPosition(oTom));

    cs_ActionPlayAnimation(36.0f, oTom, ANIMATION_FIREFORGET_VICTORY1);
    cs_PlaySound(36.2f, cs_GetPCObject(0), "c_dragnold_bat1");

    cs_ActionPlayAnimation(39.0f, oFishLeader, ANIMATION_FIREFORGET_VICTORY2);
    cs_ActionPlayAnimation(39.0f, oFish5, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(39.2f, oFish4, ANIMATION_FIREFORGET_VICTORY2);
    cs_ActionPlayAnimation(39.4f, oFish3, ANIMATION_FIREFORGET_VICTORY3);
    cs_ActionPlayAnimation(39.5f, oFish2, ANIMATION_FIREFORGET_VICTORY1);
    cs_ActionPlayAnimation(39.7f, oFish1, ANIMATION_FIREFORGET_VICTORY3);

    cs_CameraDoFade(41.0f, CS_FADE_TYPE_TO_BLACK, 0.01f);
    cs_EndCutscene(44.0f, TRUE, TRUE, FADE_SPEED_MEDIUM);
}
*/
