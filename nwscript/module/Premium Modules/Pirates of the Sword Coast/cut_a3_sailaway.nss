//::///////////////////////////////////////////////
//:: cut_a3_sailaway
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 30, 2005
//:://////////////////////////////////////////////
#include "inc_global"
#include "inc_undead"

// oVO1: "An' thus it was I was betrayed,"
// oVO2: "me spirit cursed to haunt the Midnight Rose"
// oVO3: "while all around me were returned to life,"
// oVO4: "celebratin' what they thought o' as a victory..."
// oVO5: "But little do they know that I still linger,"
// oVO6: "a curse o' blood upon the Rose"
// oVO7: "and on all who dare to sail her..."
const float f_VO_LENGTH_1 = 3.33; // pp1_allendry049
const float f_VO_LENGTH_2 = 3.72; // pp1_allendry050
const float f_VO_LENGTH_3 = 3.2;  // pp1_allendry051
const float f_VO_LENGTH_4 = 3.94; // pp1_allendry052
const float f_VO_LENGTH_5 = 4.7; // 4.08 + delay -- pp1_allendry053
const float f_VO_LENGTH_6 = 2.85; // pp1_allendry054
const float f_VO_LENGTH_7 = 4.22; // pp1_allendry055

// oVO1: "An' thus it was I was avenged,"
// oVO2: "me spirit freed from its haunting o' the Rose."
// oVO3: "But I lingered there amidst the dead"
// oVO4: "an' listened in upon their celebrations..."
// oVO5: "Aye, 'tis true I'll miss the Rose's song,"
// oVO6: "but now she's found another soul to sing it to"
// oVO7: "and another soul to sail her."
const float f_VO_LENGTH_11 = 3.77; // pp1_allendry056
const float f_VO_LENGTH_12 = 3.85; // pp1_allendry057
const float f_VO_LENGTH_13 = 2.87; // pp1_allendry058
const float f_VO_LENGTH_14 = 3.51; // pp1_allendry059
const float f_VO_LENGTH_15 = 4.5; // 4.01 + delay -- pp1_allendry060
const float f_VO_LENGTH_16 = 4.28; // pp1_allendry061
const float f_VO_LENGTH_17 = 3.57; // pp1_allendry062


const string sNisar001 = "Look alive, mates! Cap'n on deck!";

void main()
{
    int bAvenged = (GetLocalInt(GetModule(), "A3_WATER")==100);

    //Sound
    object oVO1, oVO2, oVO3, oVO4, oVO5, oVO6, oVO7;
    float fVOLength1, fVOLength2, fVOLength3, fVOLength4,
          fVOLength5, fVOLength6, fVOLength7, fVOTotalLength;
    if(bAvenged)
    {
        oVO1 = GetObjectByTagInArea("pp1_allendry056");
        oVO2 = GetObjectByTagInArea("pp1_allendry057");
        oVO3 = GetObjectByTagInArea("pp1_allendry058");
        oVO4 = GetObjectByTagInArea("pp1_allendry059");
        oVO5 = GetObjectByTagInArea("pp1_allendry060");
        oVO6 = GetObjectByTagInArea("pp1_allendry061");
        oVO7 = GetObjectByTagInArea("pp1_allendry062");
        fVOLength1 = f_VO_LENGTH_11;
        fVOLength2 = f_VO_LENGTH_12;
        fVOLength3 = f_VO_LENGTH_13;
        fVOLength4 = f_VO_LENGTH_14;
        fVOLength5 = f_VO_LENGTH_15;
        fVOLength6 = f_VO_LENGTH_16;
        fVOLength7 = f_VO_LENGTH_17;
        fVOTotalLength = f_VO_LENGTH_11 +
                         f_VO_LENGTH_12 +
                         f_VO_LENGTH_13 +
                         f_VO_LENGTH_14 +
                         f_VO_LENGTH_15 +
                         f_VO_LENGTH_16 +
                         f_VO_LENGTH_17;
    }
    else
    {
        oVO1 = GetObjectByTagInArea("pp1_allendry049");
        oVO2 = GetObjectByTagInArea("pp1_allendry050");
        oVO3 = GetObjectByTagInArea("pp1_allendry051");
        oVO4 = GetObjectByTagInArea("pp1_allendry052");
        oVO5 = GetObjectByTagInArea("pp1_allendry053");
        oVO6 = GetObjectByTagInArea("pp1_allendry054");
        oVO7 = GetObjectByTagInArea("pp1_allendry055");
        fVOLength1 = f_VO_LENGTH_1;
        fVOLength2 = f_VO_LENGTH_2;
        fVOLength3 = f_VO_LENGTH_3;
        fVOLength4 = f_VO_LENGTH_4;
        fVOLength5 = f_VO_LENGTH_5;
        fVOLength6 = f_VO_LENGTH_6;
        fVOLength7 = f_VO_LENGTH_7;
        fVOTotalLength = f_VO_LENGTH_1 +
                         f_VO_LENGTH_2 +
                         f_VO_LENGTH_3 +
                         f_VO_LENGTH_4 +
                         f_VO_LENGTH_5 +
                         f_VO_LENGTH_6 +
                         f_VO_LENGTH_7;
    }


    effect eGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect eDamage = EffectDamage(1000);

    object oArea = OBJECT_SELF;
    object oModule = GetModule();
    object oConv = GetObjectByTag("a3_convobject");
    object oStart = GetObjectByTag("A3_FNL_DOOR");
    object oDoor = GetObjectByTag("a3_fnldoor");

    //object oNisar = GetObjectByTag("a2_hench_nisar");
    //object oGarm = GetObjectByTag("a1_hench_garm");
    object oWPNisar1 = GetObjectByTag("A3_FNL_NISAR1_0");
    object oWPGarm1 = GetObjectByTag("A3_FNL_GARM1_0");
    object oWPNisar1_1 = GetObjectByTag("A3_FNL_NISAR1");
    object oWPGarm1_1 = GetObjectByTag("A3_FNL_GARM1");
    object oWPPoly = GetObjectByTag("A3_FNL_POLY_0");
    object oWPPoly_1 = GetObjectByTag("A3_FNL_POLY");

    object oWPTasina1 = GetObjectByTag("A3_FNL_TASINA1");
    object oTasina = OBJECT_INVALID;
    if(!bAvenged)
    {
        oTasina = CreateObject(OBJECT_TYPE_CREATURE, "a3_tasina", GetLocation(oStart));
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oTasina);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oTasina);

    object oNisar = CreateObject(OBJECT_TYPE_CREATURE, "a2_cutnisar", GetLocation(oWPNisar1));
    object oGarm = CreateObject(OBJECT_TYPE_CREATURE, "a1_cutgarm", GetLocation(oWPGarm1));
    if(bAvenged)
    {
        ApplyVFXEyes (oNisar);
        ApplyVFXEyes (oGarm);
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oNisar);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oGarm);
    // JE: Stupid factions. The template had a faction set that could potentially
    // be hostile to the player at this point. I don't want to touch the
    // template at this stage, it may need to be that faction for something
    // else, so I'll just fix this with the following function.
    ChangeToStandardFaction(oGarm, STANDARD_FACTION_COMMONER);

    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm, SetIsDestroyable(TRUE, FALSE, FALSE));
    AssignCommand(oGarm,ChangeToStandardFaction(oGarm,STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar,ChangeToStandardFaction(oNisar,STANDARD_FACTION_COMMONER));
    AssignCommand(oNisar, ClearAllActions(TRUE));
    AssignCommand(oGarm, ClearAllActions(TRUE));

    object oWPPlayer1_1 = GetObjectByTag("A3_FNL_PCCOPY1");
    object oWPPlayer2_1 = GetObjectByTag("A3_FNL_PCCOPY2");
    object oWPPlayer3_1 = GetObjectByTag("A3_FNL_PCCOPY3");
    object oWPPlayer4_1 = GetObjectByTag("A3_FNL_PCCOPY4");

    object oWPCrew1 = GetObjectByTag("A3_FNL_FOLLOWER1_0");
    object oWPCrew2 = GetObjectByTag("A3_FNL_FOLLOWER2_0");
    object oWPCrew3 = GetObjectByTag("A3_FNL_FOLLOWER3_0");
    object oWPCrew4 = GetObjectByTag("A3_FNL_FOLLOWER4_0");
    object oWPCrew5 = GetObjectByTag("A3_FNL_FOLLOWER5_0");

    object oWPCrew1_1 = GetObjectByTag("A3_FNL_FOLLOWER1");
    object oWPCrew2_1 = GetObjectByTag("A3_FNL_FOLLOWER2");
    object oWPCrew3_1 = GetObjectByTag("A3_FNL_FOLLOWER3");
    object oWPCrew4_1 = GetObjectByTag("A3_FNL_FOLLOWER4");
    object oWPCrew5_1 = GetObjectByTag("A3_FNL_FOLLOWER5");

    object oPCCopy1 = cs_CopyPC(GetLocation(oStart), FALSE, 0);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPCCopy1);
    object oPCCopy2 = cs_CopyPC(GetLocation(oStart), FALSE, 1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPCCopy2);
    object oPCCopy3 = cs_CopyPC(GetLocation(oStart), FALSE, 2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPCCopy3);
    object oPCCopy4 = cs_CopyPC(GetLocation(oStart), FALSE, 3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPCCopy4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPCCopy4);
    if(bAvenged)
    {
        ApplyVFXEyes (oPCCopy1);
        ApplyVFXEyes (oPCCopy2);
        ApplyVFXEyes (oPCCopy3);
        ApplyVFXEyes (oPCCopy4);
    }

    string sNPCTag1, sNPCTag2, sNPCTag3, sNPCTag4, sNPCTag5;

    if(bAvenged)
    {
        sNPCTag1 = GetLocalString(oModule, "NPC_CREW_DEAD1");
        sNPCTag2 = GetLocalString(oModule, "NPC_CREW_DEAD2");
        sNPCTag3 = GetLocalString(oModule, "NPC_CREW_DEAD3");
        sNPCTag4 = GetLocalString(oModule, "NPC_CREW_DEAD4");
        sNPCTag5 = GetLocalString(oModule, "NPC_CREW_DEAD5");
    }
    else
    {
        sNPCTag1 = GetLocalString(oModule, "NPC_CREW1");
        sNPCTag2 = GetLocalString(oModule, "NPC_CREW2");
        sNPCTag3 = GetLocalString(oModule, "NPC_CREW3");
        sNPCTag4 = GetLocalString(oModule, "NPC_CREW4");
        sNPCTag5 = GetLocalString(oModule, "NPC_CREW5");
    }
    object oCrew1 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag1, GetLocation(oWPCrew1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew1);
    object oCrew2 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag2, GetLocation(oWPCrew2));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew2);
    object oCrew3 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag3, GetLocation(oWPCrew3));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew3);
    object oCrew4 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag4, GetLocation(oWPCrew4));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew4);
    object oCrew5 = CreateObject(OBJECT_TYPE_CREATURE, sNPCTag5, GetLocation(oWPCrew5));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oCrew5);

    object oPoly = CreateObject(OBJECT_TYPE_CREATURE, "cut_poly", GetLocation(oWPPoly));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPoly);

    //object oWayPoint0 = GetObjectByTagInArea("cs_camera_pos_1");
    //object oWayPoint1 = GetObjectByTagInArea("cs_camera_pos_2");
    //object oWayPoint2 = GetObjectByTagInArea("cs_camera_pos_3");
    object oWPOldTom = GetObjectByTag("A3_FNL_OLDTOM");

    object oOldTom;
    if(bAvenged)
    {
        oOldTom = CreateObject(OBJECT_TYPE_CREATURE, "a3_oldtom_b", GetLocation(oWPOldTom));
    }
    else
    {
        oOldTom = CreateObject(OBJECT_TYPE_CREATURE, "a3_oldtom_a", GetLocation(oWPOldTom));
    }

    // Disable braziers if it's the day scene
    if(!bAvenged)
    {
        int i = 0;
        object oBrazier = GetObjectByTagInArea("a3_end_brazier", OBJECT_SELF, 0);
        while(GetIsObjectValid(oBrazier))
        {
            AssignCommand(oBrazier, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            i++;
            oBrazier = GetObjectByTagInArea("a3_end_brazier", OBJECT_SELF, i);
        }
    }

    float fDelay;

//------------------------------------------------------------------------------

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    cs_SoundObjectPlay(6.0, oVO1);
    cs_SoundObjectPlay(fVOLength1, oVO2);
    cs_SoundObjectPlay(fVOLength2, oVO3);
    cs_SoundObjectPlay(fVOLength3, oVO4);
    cs_SoundObjectPlay(fVOLength4, oVO5);
    cs_SoundObjectPlay(fVOLength5, oVO6);
    cs_SoundObjectPlay(fVOLength6, oVO7);

    cs_ResetDelay();

    cs_ActionPlayAnimation(0.0, oNisar, ANIMATION_LOOPING_LOOK_FAR, 0.8f, fVOTotalLength + 7.0);
    cs_ActionPlayAnimation(0.0, oGarm, ANIMATION_LOOPING_TALK_NORMAL, 0.8f, fVOTotalLength + 7.0);

    cs_ActionPlayAnimation_SafeForCrew(0.0, oCrew1, ANIMATION_LOOPING_SIT_CROSS, 0.8f, fVOTotalLength + 7.0);
    cs_ActionPlayAnimation_SafeForCrew(0.0, oCrew2, ANIMATION_LOOPING_LISTEN, 0.8f, fVOTotalLength + 7.0);
    cs_ActionPlayAnimation_SafeForCrew(0.0, oCrew3, ANIMATION_LOOPING_GET_LOW, 0.9f, fVOTotalLength + 7.0);
    cs_ActionPlayAnimation_SafeForCrew(0.0, oCrew4, ANIMATION_LOOPING_TALK_NORMAL, 1.2f, fVOTotalLength + 7.0);
    cs_ActionPlayAnimation_SafeForCrew(0.0, oCrew5, ANIMATION_LOOPING_LOOK_FAR, 0.7f, fVOTotalLength + 7.0);

    //cs_CameraSetMovementRate(0.12, 0.5f);
    cs_CameraUseCameraWaypoint(0.5, 1);

    //cs_CameraActionMoveToObject(0.5, oWayPoint2, TRUE);
    cs_CameraUseCameraWaypoint(0.5, 2);

    cs_CameraDoFade(2.0, CS_FADE_TYPE_FROM_BLACK, 0.01f);
    //cs_CameraSetFacing(0.0, 60.0f, 27.0f, 75.0f, 5);


    // 2nd part (PC comes on deck)
    cs_ResetDelay(-1.0, fVOTotalLength + 2.0);
    cs_CameraDoFade(0.0, CS_FADE_TYPE_TO_BLACK);
    cs_CameraUseCameraWaypoint(2.0, 4);
    cs_CameraDoFade(1.0, CS_FADE_TYPE_FROM_BLACK);
    //cs_CameraSetFacing(0.0, 20.0f, 17.0f, 73.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraUseCameraWaypoint(0.0, 5);

    cs_ActionOpenDoor(2.0, oDoor, oDoor);

    cs_ActionMoveToLocation(0.5, oNisar, GetLocation(oWPNisar1_1), TRUE);
    cs_SpeakString(0.5, oNisar, sNisar001);
    fDelay = cs_GetDelay();

    cs_ActionMoveToObject(0.5, oGarm, oWPGarm1_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oPoly, oWPPoly_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oCrew1, oWPCrew1_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oCrew2, oWPCrew2_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oCrew3, oWPCrew3_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oCrew4, oWPCrew4_1, TRUE, 0.0);
    cs_ActionMoveToObject(0.0, oCrew5, oWPCrew5_1, TRUE, 0.0);
    cs_ActionSetFacing(0.5, oNisar, GetFacing(oWPNisar1_1));
    cs_ActionSetFacing(0.0, oGarm, GetFacing(oWPGarm1_1));
    cs_ActionSetFacing(0.0, oCrew1, GetFacing(oWPCrew1_1));
    cs_ActionSetFacing(0.0, oCrew2, GetFacing(oWPCrew2_1));
    cs_ActionSetFacing(0.0, oCrew3, GetFacing(oWPCrew3_1));
    cs_ActionSetFacing(0.0, oCrew4, GetFacing(oWPCrew4_1));
    cs_ActionSetFacing(0.0, oCrew5, GetFacing(oWPCrew5_1));

    // The PC and Tasina come out and onto the deck
    cs_ResetDelay(-1.0, fDelay);
    cs_RemoveVFXFromObject(0.0, oPCCopy1, TRUE);
    cs_ActionMoveToLocation(0.5, oPCCopy1, GetLocation(oWPPlayer1_1));
    cs_ActionSetFacing(0.5, oPCCopy1, GetFacing(oWPPlayer1_1));
    cs_RemoveVFXFromObject(0.0, oTasina, TRUE);
    cs_ActionMoveToLocation(0.5, oTasina, GetLocation(oWPTasina1));
    cs_ActionSetFacing(0.5, oTasina, GetFacing(oWPTasina1));
    cs_RemoveVFXFromObject(0.0, oPCCopy2, TRUE);
    cs_ActionMoveToLocation(0.5, oPCCopy2, GetLocation(oWPPlayer2_1));
    cs_ActionSetFacing(0.5, oPCCopy2, GetFacing(oWPPlayer2_1));
    cs_RemoveVFXFromObject(0.0, oPCCopy3, TRUE);
    cs_ActionMoveToLocation(0.5, oPCCopy3, GetLocation(oWPPlayer3_1));
    cs_ActionSetFacing(0.5, oPCCopy3, GetFacing(oWPPlayer3_1));
    cs_RemoveVFXFromObject(0.0, oPCCopy4, TRUE);
    cs_ActionMoveToLocation(0.5, oPCCopy4, GetLocation(oWPPlayer4_1));
    cs_ActionSetFacing(0.5, oPCCopy4, GetFacing(oWPPlayer4_1));

    if(bAvenged)
    {
        cs_ActionStartConversation(0.2, cs_GetPCObject(), oConv, "a3_finalb");
    }
    else
    {
        cs_ActionStartConversation(0.2, cs_GetPCObject(), oConv, "a3_finala");
    }

    cs_SoundObjectStop(0.0, oVO1);
    cs_SoundObjectStop(0.0, oVO2);
    cs_SoundObjectStop(0.0, oVO3);
    cs_SoundObjectStop(0.0, oVO4);
    cs_SoundObjectStop(0.0, oVO5);
    cs_SoundObjectStop(0.0, oVO6);
    cs_SoundObjectStop(0.0, oVO7);

//    cs_CameraDoFade(50.0f, CS_FADE_TYPE_TO_BLACK, 0.01f);
//    cs_EndCutscene(53.0f, TRUE, TRUE, FADE_SPEED_MEDIUM);
}
