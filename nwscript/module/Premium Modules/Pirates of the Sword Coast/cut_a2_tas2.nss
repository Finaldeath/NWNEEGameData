//::///////////////////////////////////////////////
//:: cut_a2_tas2
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 2 cutscene where Tasina portals out
    peacefully.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    int nPriestessCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_PRIESTESS_COUNT);
    int nSahClericCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_SAHCLERIC_COUNT);
    int nSahGuardCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_SAHGUARD_COUNT);
    int nAllCount = GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_ALL_COUNT);
    int nIndex = 0;

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // waypoints
    object oWP_Portal = GetWaypointByTag(a2w_BeneathTemple_Portal);
    object oWP_BeforePortal = GetWaypointByTag(a2w_BeneathTemple_Flee2);
    object oWP_Priestess1 = GetObjectByTagInArea("cs_wp_priestess1");
    object oWP_Priestess2 = GetObjectByTagInArea("cs_wp_priestess2");
    object oWP_Priestess1_Vector = GetObjectByTagInArea("cs_wp_priestess1_vector");
    object oWP_Priestess2_Vector = GetObjectByTagInArea("cs_wp_priestess2_vector");
    object oWP_origin, oWP_vector;

    object oWP_PC1_3 = GetObjectByTagInArea("cs_wp_pc1_3");
    object oWP_PC2_3 = GetObjectByTagInArea("cs_wp_pc2_3");
    object oWP_PC3_3 = GetObjectByTagInArea("cs_wp_pc3_3");
    object oWP_PC4_3 = GetObjectByTagInArea("cs_wp_pc4_3");

    // creatures
    object oGarm = GetObjectByTagInArea("garm_copy");
    object oNisar = GetObjectByTagInArea("nisar_copy");

    object oTasina = GetObjectByTagInArea(a2c_tag_Tasina);

    effect eCutGhost = EffectCutsceneGhost();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oTasina);
    object oCreature;
    for(nIndex=0 ; nIndex < nAllCount ; nIndex++)
    {
        oCreature = GetObjectArray(OBJECT_SELF, l_oa_A2_TEMPLE_ALL_ARRAY, nIndex);
        AssignCommand(oCreature, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCreature);
    }

    object oPC1 = cs_CopyPC(GetLocation(oWP_PC1_3), FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC1);
    object oPC2 = cs_CopyPC(GetLocation(oWP_PC2_3), FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC2);
    object oPC3 = cs_CopyPC(GetLocation(oWP_PC3_3), FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC3);
    object oPC4 = cs_CopyPC(GetLocation(oWP_PC4_3), FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oPC4);

    // create portal
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, a2p_temple_portal_spawn, GetLocation(oWP_Portal));
    effect eVFX1 = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    cs_ApplyEffectToObject(0.0, DURATION_TYPE_PERMANENT, eVFX1, oPortal);

    // initial camera, fade-in
    cs_CameraUseCameraWaypoint(0.1, 10);

    location lLoc;
    vector vOrigin, vVector, vLoc;
    float fDistance, fMagnitude;
    for(nIndex=0; nIndex < nAllCount; nIndex++)
    {
        // get a creature to jump
        oCreature = GetObjectArray(OBJECT_SELF, l_oa_A2_TEMPLE_ALL_ARRAY, nIndex);

        // figure out which row to put them in (alternates)
        if(nIndex & 1)
        {
            oWP_origin = oWP_Priestess2;
            vVector = GetPosition(oWP_Priestess2_Vector);
        }
        else
        {
            oWP_origin = oWP_Priestess1;
            vVector = GetPosition(oWP_Priestess1_Vector);
        }

        // calculate a start position, based on two waypoints
        fDistance = (nIndex>>1) * 2.0;
        vOrigin = GetPosition(oWP_origin);
        vVector.x = (vVector.x - vOrigin.x);
        vVector.y = (vVector.y - vOrigin.y);
        fMagnitude = VectorMagnitude(vVector);
        vVector.x /= fMagnitude;
        vVector.y /= fMagnitude;
        vLoc.x = vVector.x * fDistance + vOrigin.x;
        vLoc.y = vVector.y * fDistance + vOrigin.y;

        lLoc = Location(OBJECT_SELF, vLoc, 0.0);

        // jumpy jumpy
        cs_ActionJumpToLocation(0.0, oCreature, lLoc);
    }

    // hack - I need to add a cs_Wait() function...
    cs_ClearAllActions(0.1, OBJECT_INVALID);

    // move you bastards
    for(nIndex=0; nIndex < nAllCount; nIndex++)
    {
        oCreature = GetObjectArray(OBJECT_SELF, l_oa_A2_TEMPLE_ALL_ARRAY, nIndex);
        cs_ActionMoveToObject(0.0, oCreature, oWP_BeforePortal, FALSE, 0.5);
    }

    // hack - I need to add a cs_Wait() function...
    cs_ClearAllActions(0.1, OBJECT_INVALID);

    for(nIndex=0; nIndex < (nAllCount); nIndex++)
    {
        oCreature = GetObjectArray(OBJECT_SELF, l_oa_A2_TEMPLE_ALL_ARRAY, nIndex);
        cs_ActionMoveToObject(0.0, oCreature, oWP_Portal, FALSE, 0.0);
    }

    cs_CameraDoFade(0.4, CS_FADE_TYPE_FROM_BLACK);
    //

    cs_SetFacingPoint(2.0, oTasina, GetPosition(oWP_BeforePortal));
    cs_ActionMoveToObject(4.0, oTasina, oWP_BeforePortal);

    cs_CameraUseCameraWaypoint(0.3, 11);
    //cs_CameraUseCameraWaypoint(2.5, 12);
    cs_CameraUseCameraWaypoint(2.8, 12);

    //cs_CameraUseCameraWaypoint(3.0, 2, TRUE);
    //cs_PlayAnimation(2.2, oTasina, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
    cs_PlayAnimation(4.7, oTasina, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);
    cs_ActionMoveToObject(1.0, oTasina, oWP_Portal, FALSE, 0.0);

    // end
    cs_CameraDoFade(3.0, CS_FADE_TYPE_TO_BLACK);

    //cs_DestroyObject(2.0, oPortal);
    cs_DestroyObject(1.0, oTasina);

    for(nIndex=0 ; nIndex < nAllCount ; nIndex++)
    {
        cs_DestroyObject(0.0, GetObjectArray(OBJECT_SELF, l_oa_A2_TEMPLE_ALL_ARRAY, nIndex));
    }

    cs_EndCutscene(0.5, FALSE, TRUE);
}
