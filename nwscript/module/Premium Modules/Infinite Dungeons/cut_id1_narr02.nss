//::///////////////////////////////////////////////
//:: cut_id1_narr02
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Second narrator cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// SPEAKSTRINGS
///////////////

const string S_NARRATION_1 = "Not bad, not bad... So far it's not such a stretch from what one might expect from a dungeon known for its... flexibility.";
const string S_NARRATION_2 = "It is often said that Undermountain has taken on the madness of its creater, Halaster Blackcloak.";
const string S_NARRATION_3 = "Shifting from shape to shape, it lures in its prey with whispers of wealth and prowess, only to betray them in the end.";
const string S_NARRATION_4 = "Listen to it whispering. This is only the beginning.";

const float VO_LENGTH_1 = 10.7; // 9.7, + a little pause so it sounds better
const float VO_LENGTH_2 = 6.25;
const float VO_LENGTH_3 = 9.1; // 8.5, + a little pause
const float VO_LENGTH_4 = 5.08;

const string TAG_AUDIO_VO_1 = "ID1_STATIC_narr2_1";
const string TAG_AUDIO_VO_2 = "ID1_STATIC_narr2_2";
const string TAG_AUDIO_VO_3 = "ID1_STATIC_narr2_3";
const string TAG_AUDIO_VO_4 = "ID1_STATIC_narr2_4";

// CONSTANTS
//////////////

const string WP_HALASTER1 = "ID1_STATIC_CS_HALASTER21";
const string WP_VFX_BR = "ID1_STATIC_WP_VFX_BR";
const string WP_VFX_BL = "ID1_STATIC_WP_VFX_BL";
const string WP_VFX_FR = "ID1_STATIC_WP_VFX_FR";
const string WP_VFX_FL = "ID1_STATIC_WP_VFX_FL";
const string WP_VFX_1_1 = "ID1_STATIC_WP_VFX_1_1";
const string WP_VFX_1_2 = "ID1_STATIC_WP_VFX_1_2";
const string WP_VFX_2_1 = "ID1_STATIC_WP_VFX_2_1";
const string WP_VFX_2_2 = "ID1_STATIC_WP_VFX_2_2";

const string TAG_NARRATOR = "id1_cs_narrator";
const string TAG_HALASTER = "id1_cs_halaster";
const string RESREF_VFX_OBJECT = "plc_invisobj";

int MyRandom(int nMaxInteger, int nNewSeed = 0);
int GetNodeNumber(int nNodeNumber, int nRange);

void main()
{
    //float fTotalVOLength = VO_LENGTH_1 + VO_LENGTH_2 + VO_LENGTH_3 + VO_LENGTH_4;
    float fDelayStart, fDelayEnd, fDelay;

    // seed "random" routine
    MyRandom(1, 44);

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // fog  - store current settings
    int nOriginalFogDay = GetFogColor(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogNight = GetFogColor(FOG_TYPE_MOON, OBJECT_SELF);
    int nOriginalFogAmountDay = GetFogAmount(FOG_TYPE_SUN, OBJECT_SELF);
    int nOriginalFogAmountNight = GetFogAmount(FOG_TYPE_MOON, OBJECT_SELF);

    // Object setup

    // waypoints
    object oWP_Halaster1 = GetObjectByTagInArea(WP_HALASTER1);
    object oWP_VFX_BL = GetObjectByTagInArea(WP_VFX_BL);
    object oWP_VFX_BR = GetObjectByTagInArea(WP_VFX_BR);
    object oWP_VFX_FL = GetObjectByTagInArea(WP_VFX_FL);
    object oWP_VFX_FR = GetObjectByTagInArea(WP_VFX_FR);
    object oWP_VFX_1_1 = GetObjectByTagInArea(WP_VFX_1_1);
    object oWP_VFX_1_2 = GetObjectByTagInArea(WP_VFX_1_2);
    object oWP_VFX_2_1 = GetObjectByTagInArea(WP_VFX_2_1);
    object oWP_VFX_2_2 = GetObjectByTagInArea(WP_VFX_2_2);

    // creatures
    object oCre_Narrator = CreateObject(OBJECT_TYPE_CREATURE, TAG_NARRATOR, cs_GetCameraWaypointLocation(21));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oCre_Narrator);

    object oCre_Halaster = CreateObject(OBJECT_TYPE_CREATURE, TAG_HALASTER, GetLocation(oWP_Halaster1));

    // placeables

    // audio
    object oAud_VO1 = GetObjectByTagInArea(TAG_AUDIO_VO_1);
    object oAud_VO2 = GetObjectByTagInArea(TAG_AUDIO_VO_2);
    object oAud_VO3 = GetObjectByTagInArea(TAG_AUDIO_VO_3);
    object oAud_VO4 = GetObjectByTagInArea(TAG_AUDIO_VO_4);

    //==========================================================================

    // set fog
    cs_SetFogColor(0.0, FOG_TYPE_ALL, FOG_COLOR_BLACK);
    cs_SetFogAmount(0.0, FOG_TYPE_ALL, 50);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 21);
    cs_ActionJumpToLocation(0.0, oCre_Narrator, cs_GetCameraWaypointLocation(21));

    fDelayStart = cs_GetDelay();

    // start camera 2
    cs_CameraUseCameraWaypoint(0.8, 22);

    // fade-in
    cs_CameraDoFade(0.2, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_MEDIUM);

// VO START
    cs_SoundObjectPlay(0.5, oAud_VO1);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_1);

    cs_SoundObjectPlay(VO_LENGTH_1, oAud_VO2);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_2);

    cs_SoundObjectPlay(VO_LENGTH_2, oAud_VO3);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_3);

    cs_SoundObjectPlay(VO_LENGTH_3, oAud_VO4);
    cs_SpeakString(0.0, oCre_Narrator, S_NARRATION_4);

// VO END

    // fade-out
    cs_CameraDoFade(VO_LENGTH_4 - 1.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_MEDIUM);

    // clean-up
    cs_DestroyObject(2.0, oCre_Halaster);
    cs_DestroyObject(0.0, oCre_Narrator);

    // restore fog
    cs_SetFogColor(0.0, FOG_TYPE_MOON, nOriginalFogNight);
    cs_SetFogColor(0.0, FOG_TYPE_SUN, nOriginalFogDay);
    cs_SetFogAmount(0.0, FOG_TYPE_MOON, nOriginalFogAmountNight);
    cs_SetFogAmount(0.0, FOG_TYPE_SUN, nOriginalFogAmountDay);

    cs_SoundObjectStop(0.0, oAud_VO1);
    cs_SoundObjectStop(0.0, oAud_VO2);
    cs_SoundObjectStop(0.0, oAud_VO3);
    cs_SoundObjectStop(0.0, oAud_VO4);

    fDelayEnd = cs_GetDelay();

    cs_EndCutscene(1.0, FALSE, TRUE);

// =============================================================================
// Flying tile stuff

    cs_ResetDelay(-1.0, fDelayStart);
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);

    // create the invisible objects
    vector v1,v2,vNew;
    vNew.z = -16.0;
    location l;
    float fAngle, fDistance, fAngleCos, fAngleSin;
    int i;
    object oObject;

    // left side
    v1 = GetPosition(oWP_VFX_BL);
    v2 = GetPosition(oWP_VFX_FL);
    fAngle = VectorToAngle(v2-v1);
    fAngleCos = cos(fAngle);
    fAngleSin = sin(fAngle);
    // NOTE: If # of objects is changed, please adjust clean-up in
    // cut_id1_narr_e.nss
    for (i=0;i<50;i++)
    {
        fDistance = GetDistanceBetween(oWP_VFX_BL, oWP_VFX_FL) * IntToFloat(i) / 50.0;
        vNew.x = fAngleCos * fDistance + v1.x;
        vNew.y = fAngleSin * fDistance + v1.y;
        l = Location(OBJECT_SELF, vNew, 0.0);
        oObject = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, l, FALSE, "VFX_L_" + IntToString(i));
        cs_DestroyObject(fDelayEnd, oObject);
    }

    // right side
    v1 = GetPosition(oWP_VFX_BR);
    v2 = GetPosition(oWP_VFX_FR);
    fAngle = VectorToAngle(v2-v1);
    fAngleCos = cos(fAngle);
    fAngleSin = sin(fAngle);
    for (i=0;i<50;i++)
    {
        fDistance = GetDistanceBetween(oWP_VFX_BR, oWP_VFX_FR) * IntToFloat(i) / 50.0;
        vNew.x = fAngleCos * fDistance + v1.x;
        vNew.y = fAngleSin * fDistance + v1.y;
        l = Location(OBJECT_SELF, vNew, 0.0);
        oObject = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, l, FALSE, "VFX_R_" + IntToString(i));
        cs_DestroyObject(fDelayEnd, oObject);
    }


    fDelay = fDelayStart;
    int nSpell, nRealSpell;
    object oNode1, oNode2;

    while(fDelay < fDelayEnd)
    {
        i = 49 - (FloatToInt((fDelay - fDelayStart) / (fDelayEnd - fDelayStart)) * 25);

        oNode1 = GetObjectByTag("VFX_L_"+IntToString(GetNodeNumber(i-24, 7)));
        oNode2 = GetObjectByTag("VFX_R_"+IntToString(GetNodeNumber(i, 7)));
        nSpell = MyRandom(4);
        switch(nSpell)
        {
            case 0: nRealSpell = 753; break;
            case 1: nRealSpell = 754; break;
            case 2: nRealSpell = 755; break;
            case 3: nRealSpell = 766; break;
        }
        cs_ActionCastFakeSpellAtObject(fDelay, oNode1, nRealSpell, oNode2, PROJECTILE_PATH_TYPE_BALLISTIC);

        oNode1 = GetObjectByTag("VFX_R_"+IntToString(GetNodeNumber(i-24, 7)));
        oNode2 = GetObjectByTag("VFX_L_"+IntToString(GetNodeNumber(i, 7)));
        nSpell = MyRandom(4);
        switch(nSpell)
        {
            case 0: nRealSpell = 753; break;
            case 1: nRealSpell = 754; break;
            case 2: nRealSpell = 755; break;
            case 3: nRealSpell = 766; break;
        }
        cs_ActionCastFakeSpellAtObject(fDelay+0.65, oNode1, nRealSpell, oNode2, PROJECTILE_PATH_TYPE_BALLISTIC);

        fDelay = fDelay + 1.3;
    }

    // next bit of vfx stuff - a few tiles just flying straight across
    object oVFX1_1 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX_1_1));
    object oVFX1_2 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX_1_2));
    object oVFX2_1 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX_2_1));
    object oVFX2_2 = CreateObject(OBJECT_TYPE_PLACEABLE, RESREF_VFX_OBJECT, GetLocation(oWP_VFX_2_2));
    cs_DestroyObject(fDelayEnd, oVFX1_1);
    cs_DestroyObject(fDelayEnd, oVFX1_2);
    cs_DestroyObject(fDelayEnd, oVFX2_1);
    cs_DestroyObject(fDelayEnd, oVFX2_2);

    fDelay = (fDelayEnd - 2.5) - fDelayStart;
    cs_ActionCastFakeSpellAtObject((fDelay / 5) + fDelayStart, oVFX1_2, 753, oVFX1_1);
    cs_ActionCastFakeSpellAtObject((fDelay / 5 * 2) + fDelayStart, oVFX2_1, 755, oVFX1_2);
    cs_ActionCastFakeSpellAtObject((fDelay / 5 * 3) + fDelayStart, oVFX1_2, 766, oVFX2_1);
    cs_ActionCastFakeSpellAtObject((fDelay / 5 * 4) + fDelayStart, oVFX1_1, 753, oVFX2_2);
    cs_ActionCastFakeSpellAtObject(fDelay + fDelayStart, oVFX2_2, 765, oVFX2_1);

}

/*
753 = city exterior, plaza 1
754 = city exterior, slum house 2
755 = dungeon, pillar 3
765 = forest, big tree
766 = crypt, treasure 2
*/

// Very simple random routine, sometimes breaks (gets into loops) with the
// wrong seeds. I just needed something I could seed for predictable random
// results, and this does a good enough job for my needs.
int MyRandom(int nMaxInteger, int nNewSeed = 0)
{
    int nSeed;
    string sSeed;

    if (nNewSeed > 0) nSeed = nNewSeed;
    else nSeed = GetLocalInt(OBJECT_SELF, "MyRandomSeed");

    while(nSeed < 1000) nSeed += 1234;

    nSeed = nSeed * nSeed;
    sSeed = IntToString(nSeed);
    sSeed = GetSubString(sSeed, GetStringLength(sSeed)-6, 4);
    nSeed = StringToInt(sSeed);

    SetLocalInt(OBJECT_SELF, "MyRandomSeed", nSeed);

    nSeed = nSeed * nMaxInteger / 10000;
    return nSeed;
}

int GetNodeNumber(int nNodeNumber, int nRange)
{
    int nNode = nNodeNumber + (MyRandom(nRange) - (nRange/2));
    if (nNode < 0) nNode = 0;
    if (nNode > 49) nNode = 49;
    return nNode;
}
