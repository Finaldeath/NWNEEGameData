//::///////////////////////////////////////////////
//:: cut_mrseige3
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PC has been cast into the water.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

#include "_inc_cutscene"

void main()
{
    /* Moved the creation of water PC's to cut_mrseige2.nss
    object oWP_PCwtr1 = GetWaypointByTag("cut_wp_pcW1");
    object oWP_PCwtr2 = GetWaypointByTag("cut_wp_pcW2");
    object oWP_PCwtr3 = GetWaypointByTag("cut_wp_pcW3");
    object oWP_PCwtr4 = GetWaypointByTag("cut_wp_pcW4");

    object oWaterPC1 = cs_CopyPC(GetLocation(oWP_PCwtr1), FALSE, 0);
    object oWaterPC2 = cs_CopyPC(GetLocation(oWP_PCwtr2), FALSE, 1);
    object oWaterPC3 = cs_CopyPC(GetLocation(oWP_PCwtr3), FALSE, 2);
    object oWaterPC4 = cs_CopyPC(GetLocation(oWP_PCwtr4), FALSE, 3);
    */
    object oWaterPC1 = GetObjectByTag("pc_inwater_0");
    object oWaterPC2 = GetObjectByTag("pc_inwater_1");
    object oWaterPC3 = GetObjectByTag("pc_inwater_2");
    object oWaterPC4 = GetObjectByTag("pc_inwater_3");

    object oSplash = GetObjectByTag("a0_mrseige2_splash");

    // fades to the player floating out at sea
    cs_CameraDoFade(2.0f, CS_FADE_TYPE_TO_BLACK);

    // removes invisibility from pc copies in water
    cs_RemoveVFXFromObject(3.0, oWaterPC1, TRUE);
    cs_RemoveVFXFromObject(3.0, oWaterPC2, TRUE);
    cs_RemoveVFXFromObject(3.0, oWaterPC3, TRUE);
    cs_RemoveVFXFromObject(3.0, oWaterPC4, TRUE);

    // water tile vfx - I can have it slightly higher than normal, so
    // it looks like the bodies are in the water and not just on top
    vector vBaseLoc = GetPosition(GetObjectByTagInArea("cs_camera_pos_2"));
    vBaseLoc.x -= 20.0;
    vBaseLoc.y -= 20.0;
    vector vLoc;
    vLoc.z = vBaseLoc.z + 0.3;
    location lLoc;
    int x,y;
    effect eWater = EffectVisualEffect(530);
    for(x=0; x<6; x++)
    {
        vLoc.x = vBaseLoc.x + x*10;
        for(y=0; y<6; y++)
        {
            vLoc.y = vBaseLoc.y + y*10;
            lLoc = Location(OBJECT_SELF, vLoc, 0.0);
            //cs_ApplyEffectAtLocation(3.0, DURATION_TYPE_PERMANENT, eWater, lLoc, 0.0, TRUE);
            DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eWater, lLoc));
        }
    }

    cs_CameraUseCameraWaypoint(4.0, 2);
    /* moved to cut_mrseige2.nss
    cs_PlayAnimation(4.0f, oWaterPC1, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 45.0f);
    cs_PlayAnimation(4.1f, oWaterPC2, ANIMATION_LOOPING_DEAD_BACK, 1.0f, 45.0f);
    cs_PlayAnimation(4.2f, oWaterPC3, ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 45.0f);
    cs_PlayAnimation(4.3f, oWaterPC4, ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 45.0f);
    */
    cs_CameraSetFacing(4.5f, 35.0f, 18.0f, 30.0f, CAMERA_TRANSITION_TYPE_VERY_SLOW);
    cs_SoundObjectPlay(4.5f, oSplash);
    cs_CameraDoFade(4.5f, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_SLOW);

    // INSERT ALLENDRY DIALOG HERE
    // JE: Actually, moved it to when you're washed up on the island, I thought
    // it made more sense there.

    cs_SoundObjectStop(10.0f, oSplash);
    cs_CameraDoFade(10.0f, CS_FADE_TYPE_TO_BLACK);
    cs_EndCutscene(12.0f, FALSE);
}
