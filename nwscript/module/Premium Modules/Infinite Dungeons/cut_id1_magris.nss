//::///////////////////////////////////////////////
//:: cut_id1_magris
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Magris boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_THEME_MORAG;
const int MUSIC_BATTLE = 76; // ID music

const string WP_MAGGRIS1 = "ID1_STATIC_WP_CS_MAGGRIS1";
const string WP_MAGGRIS2 = "ID1_STATIC_WP_CS_MAGGRIS2";
const string WP_COCOON1 = "ID1_STATIC_WP_CS_COCOON1";
const string WP_COCOON2 = "ID1_STATIC_WP_CS_COCOON2";
const string WP_COCOON3 = "ID1_STATIC_WP_CS_COCOON3";
const string WP_COCOON4 = "ID1_STATIC_WP_CS_COCOON4";
const string WP_COCOON5 = "ID1_STATIC_WP_CS_COCOON5";
const string WP_INSECT1 = "ID1_STATIC_WP_CS_INSECT1";
const string WP_INSECT2 = "ID1_STATIC_WP_CS_INSECT2";
const string WP_INSECT3 = "ID1_STATIC_WP_CS_INSECT3";
const string WP_INSECT4 = "ID1_STATIC_WP_CS_INSECT4";
const string WP_EXTRACOCOON1 = "ID1_STATIC_WP_CS_COCOON60";
const string WP_EXTRACOCOON2 = "ID1_STATIC_WP_CS_COCOON61";
const string WP_EXTRACOCOON3 = "ID1_STATIC_WP_CS_COCOON62";
const string WP_EXTRACOCOON4 = "ID1_STATIC_WP_CS_COCOON63";
const string WP_EXTRACOCOON5 = "ID1_STATIC_WP_CS_COCOON64";
const string WP_EXTRACOCOON6 = "ID1_STATIC_WP_CS_COCOON65";
const string WP_EXTRACOCOON7 = "ID1_STATIC_WP_CS_COCOON66";
const string WP_EXTRAINSECT1_1 = "ID1_STATIC_WP_CS_INSECT60_1";
const string WP_EXTRAINSECT1_2 = "ID1_STATIC_WP_CS_INSECT60_2";
const string WP_EXTRAINSECT2_1 = "ID1_STATIC_WP_CS_INSECT61_1";
const string WP_EXTRAINSECT2_2 = "ID1_STATIC_WP_CS_INSECT61_2";
const string WP_EXTRAINSECT3_1 = "ID1_STATIC_WP_CS_INSECT62_1";
const string WP_EXTRAINSECT3_2 = "ID1_STATIC_WP_CS_INSECT62_2";

const string TAG_COCOON = "plc_spdcocoon";
const string TAG_INSECT1 = "id1_cs_mag_nsct1";
const string TAG_INSECT2 = "id1_cs_mag_nsct2";
const string TAG_INSECT3 = "id1_cs_mag_nsct3";
const string TAG_INSECT4 = "id1_cs_mag_nsct4";
const string TAG_INSECT5 = "id1_cs_mag_nsct5";
const string TAG_INSECT6 = "id1_cs_mag_nsct6";
const string TAG_MAGGRIS = "id1_cs_mag_magrs";

void cs_SpawnCocoon(location lLoc, int nCutNumber);

void main()
{
    int nCutNumber = GetLocalInt(OBJECT_SELF, "cs_last_cut_number");

    // using incremented delay type
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // Object setup

    // waypoints
    object oWP_Maggris1 = GetObjectByTagInArea(WP_MAGGRIS1);
    object oWP_Maggris2 = GetObjectByTagInArea(WP_MAGGRIS2);
    object oWP_Cocoon1 = GetObjectByTagInArea(WP_COCOON1);
    object oWP_Cocoon2 = GetObjectByTagInArea(WP_COCOON2);
    object oWP_Cocoon3 = GetObjectByTagInArea(WP_COCOON3);
    object oWP_Cocoon4 = GetObjectByTagInArea(WP_COCOON4);
    object oWP_Cocoon5 = GetObjectByTagInArea(WP_COCOON5);
    object oWP_Insect1 = GetObjectByTagInArea(WP_INSECT1);
    object oWP_Insect2 = GetObjectByTagInArea(WP_INSECT2);
    object oWP_Insect3 = GetObjectByTagInArea(WP_INSECT3);
    object oWP_Insect4 = GetObjectByTagInArea(WP_INSECT4);
    object oWP_ExtraCocoon1 = GetObjectByTagInArea(WP_EXTRACOCOON1);
    object oWP_ExtraCocoon2 = GetObjectByTagInArea(WP_EXTRACOCOON2);
    object oWP_ExtraCocoon3 = GetObjectByTagInArea(WP_EXTRACOCOON3);
    object oWP_ExtraCocoon4 = GetObjectByTagInArea(WP_EXTRACOCOON4);
    object oWP_ExtraCocoon5 = GetObjectByTagInArea(WP_EXTRACOCOON5);
    object oWP_ExtraCocoon6 = GetObjectByTagInArea(WP_EXTRACOCOON6);
    object oWP_ExtraCocoon7 = GetObjectByTagInArea(WP_EXTRACOCOON7);
    object oWP_ExtraInsect1_1 = GetObjectByTagInArea(WP_EXTRAINSECT1_1);
    object oWP_ExtraInsect1_2 = GetObjectByTagInArea(WP_EXTRAINSECT1_2);
    object oWP_ExtraInsect2_1 = GetObjectByTagInArea(WP_EXTRAINSECT2_1);
    object oWP_ExtraInsect2_2 = GetObjectByTagInArea(WP_EXTRAINSECT2_2);
    object oWP_ExtraInsect3_1 = GetObjectByTagInArea(WP_EXTRAINSECT3_1);
    object oWP_ExtraInsect3_2 = GetObjectByTagInArea(WP_EXTRAINSECT3_2);

    effect eCutGhost = EffectCutsceneGhost();
    // creatures
    object oCre_Maggris = CreateObject(OBJECT_TYPE_CREATURE, TAG_MAGGRIS, GetLocation(oWP_Maggris1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_Maggris);

    object oCre_Insect1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT1, GetLocation(oWP_Cocoon1));
    object oCre_Insect2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT4, GetLocation(oWP_Cocoon2));
    object oCre_Insect3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT2, GetLocation(oWP_Cocoon3));
    object oCre_Insect4 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT3, GetLocation(oWP_Cocoon4));
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Insect1);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Insect2);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Insect3);
    cs_ApplyVFXToObject(0.0, DURATION_TYPE_PERMANENT, VFX_DUR_CUTSCENE_INVISIBILITY, oCre_Insect4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_Insect1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_Insect2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_Insect3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_Insect4);

    object oCre_ExtraInsect1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT5, GetLocation(oWP_ExtraInsect1_1));
    object oCre_ExtraInsect2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT1, GetLocation(oWP_ExtraInsect2_1));
    object oCre_ExtraInsect3 = CreateObject(OBJECT_TYPE_CREATURE, TAG_INSECT6, GetLocation(oWP_ExtraInsect3_1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_ExtraInsect1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_ExtraInsect2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCutGhost, oCre_ExtraInsect3);

    // placeables
    //object oPla_Cocoon1 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_Cocoon1));
    object oPla_Cocoon2 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_Cocoon2));
    object oPla_Cocoon3 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_Cocoon3));
    object oPla_Cocoon4 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_Cocoon4));
    object oPla_Cocoon5 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_Cocoon5));

    object oPla_ExtraCocoon1 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon1));
    object oPla_ExtraCocoon2 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon2));
    object oPla_ExtraCocoon3 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon3));
    object oPla_ExtraCocoon4 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon4));
    object oPla_ExtraCocoon5 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon5));
    object oPla_ExtraCocoon6 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon6));
    object oPla_ExtraCocoon7 = CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, GetLocation(oWP_ExtraCocoon7));

    //==========================================================================

    effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);

    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeDay(10.0, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    cs_ResetDelay(-1.0, 0.0);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 1);

    // maggris web attack (to spawn cocoon)
    location lLoc = GetLocation(oWP_Cocoon1);
    cs_ActionCastFakeSpellAtLocation(0.0, oCre_Maggris, SPELL_WEB, lLoc);
    DelayCommand(cs_GetDelay()+3.0, cs_SpawnCocoon(lLoc, nCutNumber));
    vector vLoc = GetPositionFromLocation(lLoc);
    vLoc.z -= 0.15;
    lLoc = Location(OBJECT_SELF, vLoc, 0.0);
    cs_ApplyEffectAtLocation(3.0, DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_WEB_MASS), lLoc, 6.0, TRUE);
    cs_PlaySound(0.0, oCre_Insect1, "sdr_web");
    cs_ResetDelay(-1.0, cs_GetDelay() - 3.0);

    // start extra insects moving
    cs_ActionMoveToObject(0.0, oCre_ExtraInsect1, oWP_ExtraInsect1_2);
    cs_ActionMoveToObject(0.0, oCre_ExtraInsect2, oWP_ExtraInsect2_2);
    cs_ActionMoveToObject(0.0, oCre_ExtraInsect3, oWP_ExtraInsect3_2);

    // start camera turn
    cs_CameraUseCameraWaypoint(0.7, 2);

    // fade-in
    cs_CameraDoFade(0.9, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // 1st cocoon hatch
    cs_ApplyEffectAtLocation(2.5, DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP_Cocoon2));
    cs_PlaySound(0.0, oCre_Insect2, "sff_gasnatr");
    //cs_DestroyObject(0.0, oPla_Cocoon2);
    cs_RemoveVFXFromObject(0.25, oCre_Insect2);
    cs_ActionMoveToObject(1.0, oCre_Insect2, oWP_Insect2);

    // 2nd cocoon hatch
    cs_ApplyEffectAtLocation(0.0, DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP_Cocoon1));
    cs_PlaySound(0.0, oCre_Insect1, "sff_gasnatr");
    //cs_DestroyObject(0.0, oPla_Cocoon1);
    cs_RemoveVFXFromObject(0.25, oCre_Insect1);
    cs_ActionMoveToObject(1.0, oCre_Insect1, oWP_Insect1);

    // start maggris moving
    cs_ActionMoveToObject(1.0, oCre_Maggris, oWP_Maggris2);

    // 3rd cocoon hatch
    cs_ApplyEffectAtLocation(1.5, DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP_Cocoon3));
    cs_PlaySound(0.0, oCre_Insect3, "sff_gasnatr");
    //cs_DestroyObject(0.0, oPla_Cocoon3);
    cs_RemoveVFXFromObject(0.25, oCre_Insect3);
    cs_ActionMoveToObject(1.0, oCre_Insect3, oWP_Insect3);

    // 4th cocoon hatch
    cs_ApplyEffectAtLocation(1.0, DURATION_TYPE_INSTANT, eVFX, GetLocation(oWP_Cocoon4));
    cs_PlaySound(0.0, oCre_Insect4, "sff_gasnatr");
    //cs_DestroyObject(0.0, oPla_Cocoon4);
    cs_RemoveVFXFromObject(0.25, oCre_Insect4);
    cs_ActionMoveToObject(1.0, oCre_Insect4, oWP_Insect4);

    // fade-out
    cs_CameraDoFade(3.0, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(2.0, oCre_Maggris);
    //cs_DestroyObject(0.0, oPla_Cocoon1);
    cs_DestroyObject(0.0, oPla_Cocoon2);
    cs_DestroyObject(0.0, oPla_Cocoon3);
    cs_DestroyObject(0.0, oPla_Cocoon4);
    cs_DestroyObject(0.0, oPla_Cocoon5);
    cs_DestroyObject(0.0, oCre_Insect1);
    cs_DestroyObject(0.0, oCre_Insect2);
    cs_DestroyObject(0.0, oCre_Insect3);
    cs_DestroyObject(0.0, oCre_Insect4);
    cs_DestroyObject(0.0, oPla_ExtraCocoon1);
    cs_DestroyObject(0.0, oPla_ExtraCocoon2);
    cs_DestroyObject(0.0, oPla_ExtraCocoon3);
    cs_DestroyObject(0.0, oPla_ExtraCocoon4);
    cs_DestroyObject(0.0, oPla_ExtraCocoon5);
    cs_DestroyObject(0.0, oPla_ExtraCocoon6);
    cs_DestroyObject(0.0, oPla_ExtraCocoon7);
    cs_DestroyObject(0.0, oCre_ExtraInsect1);
    cs_DestroyObject(0.0, oCre_ExtraInsect2);
    cs_DestroyObject(0.0, oCre_ExtraInsect3);

    cs_EndCutscene(1.4);
}

void cs_SpawnCocoon(location lLoc, int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    CreateObject(OBJECT_TYPE_PLACEABLE, TAG_COCOON, lLoc, FALSE, "cs_to_delete");
}
