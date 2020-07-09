//::///////////////////////////////////////////////
//:: Cutscene entering warehouse for first time
//:: cut_a2_wareh.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Cutscene that fires the first the player
    enters the warehouse, where they meet Redtip.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Mar 10/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // NPC's
    object oRedtip = GetObjectByTagInArea(a2c_tag_Redtip);
    // modify redtips attacks for the cutscene fight
    effect e = EffectModifyAttacks(2);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_TEMPORARY, e, oRedtip, 60.0, TRUE);

    object oRedtipFighter = GetObjectByTagInArea(a2c_tag_Redtip_Fighter);
    //object oSpec1 = GetObjectByTagInArea(a2c_tag_Redtip_Spectator, OBJECT_SELF, 0);
    //object oSpec2 = GetObjectByTagInArea(a2c_tag_Redtip_Spectator, OBJECT_SELF, 1);
    //object oSpec3 = GetObjectByTagInArea(a2c_tag_Redtip_Spectator, OBJECT_SELF, 2);
    //object oSpec4 = GetObjectByTagInArea(a2c_tag_Redtip_Spectator, OBJECT_SELF, 3);

    // waypoints
    object oWP1 = GetObjectByTagInArea("cs_wp1");
    object oWP2 = GetObjectByTagInArea("cs_wp2");
    object oWP3 = GetObjectByTagInArea("cs_wp3");
    object oWP_Garm = GetObjectByTagInArea("cs_wp_garm");
    object oWP_Nisar = GetObjectByTagInArea("cs_wp_nisar");

    effect eCutGhost = EffectCutsceneGhost();

    // PC copy
    object oPCCopy = cs_CopyPC(GetLocation(oWP1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPCCopy);

    // henchmen
    object oRealGarm = GetObjectByTagInArea(a1c_tag_Garm);
    object oRealNisar = GetObjectByTagInArea(a2c_tag_Nisar);
    object oFakeGarm = CopyObject(oRealGarm, GetLocation(oWP_Garm), OBJECT_INVALID, "warehouse_fakegarm");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oFakeGarm);
    object oFakeNisar = CopyObject(oRealNisar, GetLocation(oWP_Nisar), OBJECT_INVALID, "warehouse_fakenisar");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oFakeNisar);
    AssignCommand(oFakeGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oFakeNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oFakeGarm,ChangeToStandardFaction(oFakeGarm,STANDARD_FACTION_COMMONER));
    AssignCommand(oFakeNisar,ChangeToStandardFaction(oFakeNisar,STANDARD_FACTION_COMMONER));

//------------------------------------------------------------------------------
    // setup camera
    cs_CameraUseCameraWaypoint(0.8, 1);

    // start fight
    cs_ActionAttack(0.0, oRedtip, oRedtipFighter, FALSE);
    cs_PlayAnimation(0.0, oRedtipFighter, ANIMATION_LOOPING_PAUSE_DRUNK, 1.1, 60.0);

    // make sure spectators are facing the right way
    vector vWP2 = GetPosition(oWP2);
    //cs_SetFacingPoint(0.0, oSpec1, vWP2);
    //cs_SetFacingPoint(0.0, oSpec2, vWP2);
    //cs_SetFacingPoint(0.0, oSpec3, vWP2);
    //cs_SetFacingPoint(0.0, oSpec4, vWP2);

    // spectators start cheering
    //cs_UsedDefinedEvent(0.5, oSpec1, UD_EVENT_REDTIP_CS_CHEERING_START);
    //cs_UsedDefinedEvent(0.0, oSpec2, UD_EVENT_REDTIP_CS_CHEERING_START);
    //cs_UsedDefinedEvent(0.0, oSpec3, UD_EVENT_REDTIP_CS_CHEERING_START);
    //cs_UsedDefinedEvent(0.0, oSpec4, UD_EVENT_REDTIP_CS_CHEERING_START);

    // start camera movement
    cs_CameraUseCameraWaypoint(0.7, 2);
    // fade in
    cs_CameraDoFade(0.3, CS_FADE_TYPE_FROM_BLACK);


    // switch to camera 3, Redtip turns to player, spectators stop cheering
    cs_CameraUseCameraWaypoint(4.0, 6);
    cs_ClearAllActions(0.0, oRedtip);
    cs_ActionSetFacingPoint(0.7, oRedtip, GetPosition(oWP1));
    //cs_UsedDefinedEvent(0.0, oSpec1, UD_EVENT_REDTIP_CS_CHEERING_STOP);
    //cs_UsedDefinedEvent(0.0, oSpec2, UD_EVENT_REDTIP_CS_CHEERING_STOP);
    //cs_UsedDefinedEvent(0.0, oSpec3, UD_EVENT_REDTIP_CS_CHEERING_STOP);
    //cs_UsedDefinedEvent(0.0, oSpec4, UD_EVENT_REDTIP_CS_CHEERING_STOP);

    // switch to camera 4, guy falls down
    cs_CameraUseCameraWaypoint(2.5, 4);
    cs_PlayAnimation(0.2, oRedtipFighter, ANIMATION_LOOPING_DEAD_BACK, 0.6, 30.0, TRUE);

    // switch to camera 5, Redtip turns back and plays taunt animation
    cs_ActionSetFacingPoint(0.8, oRedtip, GetPosition(oRedtipFighter));
    cs_PlayAnimation(0.1, oRedtip, ANIMATION_FIREFORGET_TAUNT);
    cs_CameraUseCameraWaypoint(0.1, 5);

    cs_CameraUseCameraWaypoint(2.8, 6);
    cs_CameraUseCameraWaypoint(0.0, 7);
    // zoom in on Redtip a bit
    //cs_CameraSetFacing(0.5, cs_GetCameraWaypointFacing(6), 1.0, -1.0, 4);

    cs_ActionSetFacingPoint(2.0, oRedtip, GetPosition(oWP1));
    cs_ActionMoveToObject(0.3, oRedtip, oWP3);

    cs_CameraDoFade(5.0, CS_FADE_TYPE_TO_BLACK);

    cs_ClearAllActions(1.5, oRealGarm);
    cs_ClearAllActions(0.0, oRealNisar);
    cs_DestroyObject(0.0, oFakeGarm);
    cs_DestroyObject(0.0, oFakeNisar);
    cs_DestroyObject(0.0, oPCCopy);
    cs_CameraJumpToObject(0.1, oWP1);
    cs_ActionJumpToObject(0.0, oRealGarm, oWP_Garm);
    cs_ActionJumpToObject(0.0, oRealNisar, oWP_Nisar);
    cs_EndCutscene(2.0, FALSE, TRUE);
}
