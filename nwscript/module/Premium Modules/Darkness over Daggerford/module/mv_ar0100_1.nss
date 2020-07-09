// this is the "gorgomorz" final battle cutscene

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "x0_i0_position"
#include "hf_in_util"
#include "hf_in_henchman"
#include "hf_in_rest"

int TileGetCol(object oMarker)
{
    vector v = GetPosition(oMarker);
    return FloatToInt(v.x) / 10;
}

int TileGetRow(object oMarker)
{
    vector v = GetPosition(oMarker);
    return FloatToInt(v.y) / 10;
}

void TileDraw(object oArea, int nTile, int nRow, int nCol, float fZ, float fDir=0.0)
{
    float fX = 10.0 * nCol + 5.0;
    float fY = 10.0 * nRow + 5.0;
    location lLoc = Location(oArea, Vector(fX, fY, fZ), fDir);
    object oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLoc, FALSE, "x2_tmp_tile");
    effect eTile = EffectVisualEffect(nTile);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTile, oTile);
    SetPlotFlag(oTile, TRUE);
}

string GetFirstName(object oPC)
{
    string sName = GetName(oPC);
    int nPos = FindSubString(sName, " ");
    if (nPos > 0)
    {
        sName = GetStringLeft(sName, nPos);
    }
    return (sName);
}

string GetHeShe(object oPC, int nCaps=FALSE)
{
    string s;
    if (GetGender(oPC) == GENDER_FEMALE)
    {
        if (nCaps)
            s = "She";
        else
            s = "she";
    }
    else
    {
        if (nCaps)
            s = "He";
        else
            s = "he";
    }
    return(s);
}

void SpawnNPCs()
{
    object oWP;
    object o;

    // create bugo
    oWP = GetWaypointByTag("WP_AR0100_CUT1_BUGO");
    o = CreateObject(OBJECT_TYPE_CREATURE, "db_matagar", GetLocation(oWP));
    CutsceneAddActor("db_matagar", o);

    // create gorgomorz
    oWP = GetWaypointByTag("WP_AR0100_GORGO_1");
    o = CreateObject(OBJECT_TYPE_CREATURE, "ks_gorgomorz", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_10), o, 6000.0);
    CutsceneAddActor("ks_gorgomorz", o);
}

// this should really just move them, but didn't work all the time,
// ... so we'll actually destroy and create.
void TanarukkEnter(string sTag, object oDest)
{
    object oArea = GetArea(oDest);
    string sName = "nEntered_"+sTag;
    if (GetLocalInt(oArea, sName) == 0)
    {
        SetLocalInt(oArea, sName, 1);
        location lLoc = GetBehindLocation(oDest);
        int i = 1;
        object o = GetObjectInArea(sTag, oDest, i);
        while (GetIsObjectValid(o))
        {
            DestroyObject(o);
            o = GetObjectInArea(sTag, oDest, ++i);
        }
        int j;
        for (j=1; j<=i; j++)
        {
            CreateObject(OBJECT_TYPE_CREATURE, sTag, lLoc);
        }
    }
}

void ExplodeHouse(object oHouse, int nVfx=TRUE)
{
    object oTile = GetNearestObjectByTag("x2_tmp_tile", oHouse);
    DestroyObject(oTile);

    int i;
    location lLoc = GetLocation(oHouse);

    if (nVfx)
    {
        vector vPos = GetPosition(oHouse);
        object oArea = GetArea(oHouse);
        for (i=1; i<=11; i++)
        {
            vector v;
            v.x = vPos.x + -5.0 + Random(10);
            v.y = vPos.y + -5.0 + Random(10);
            v.z = vPos.z + Random(10);
            location lTmp = Location(oArea, v, 0.0);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lTmp);
        }
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), lLoc);
    }

    i = 1;
    object oCrate = GetNearestObjectByTag("_ar0100_crate", oHouse, i);
    while (GetIsObjectValid(oCrate))
    {
        if (GetDistanceBetween(oHouse, oCrate) > 7.0)
            break;
        location lLoc = GetLocation(oCrate);
        if (nVfx)
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
        DestroyObject(oCrate);
        if (d2() == 1)
            CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamemedium", lLoc);
        oCrate = GetNearestObjectByTag("_ar0100_crate", oHouse, ++i);
    }

    i = 1;
    object oBalista = GetNearestObjectByTag("_ar0100_balista", oHouse, i);
    while (GetIsObjectValid(oBalista))
    {
        if (nVfx)
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
        DestroyObject(oBalista);
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lLoc);
        oBalista = GetNearestObjectByTag("_ar0100_balista", oHouse, ++i);
    }

    if (nVfx)
    {
        i = 1;
        object oMilitia = GetNearestObjectByTag("pm_malitia", oHouse, i);
        while (GetIsObjectValid(oMilitia))
        {
            if (GetDistanceBetween(oHouse, oMilitia) > 9.0)
                break;
            AssignCommand(oMilitia, PlaySound("as_pl_screamm"+IntToString(d6())));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DAZED_S), oMilitia);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oMilitia, 60.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oMilitia, 30.0);
            oMilitia = GetNearestObjectByTag("pm_malitia", oHouse, ++i);
        }
    }
}

void ExplodeBugo(object oBugo)
{
    location lLoc = GetLocation(oBugo);
    SetPlotFlag(oBugo, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oBugo);
    AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oBugo));
    AssignCommand(oBugo, PlaySound("vs_bugo_074"));
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamemedium", lLoc);
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", lLoc);
}

void ExplodeGates(object oGates)
{
    int i;
    location lLoc = GetLocation(oGates);
    vector vPos = GetPosition(oGates);
    object oArea = GetArea(oGates);

    object oGates2 = GetNearestObjectByTag("drawbridge", oGates);
    DestroyObject(oGates2);

    for (i=1; i<=3; i++)
    {
        vector v;
        v.x = vPos.x + -2.0 + Random(2);
        v.y = vPos.y + -2.0 + Random(2);
        v.z = vPos.z + Random(2);
        location lTmp = Location(oArea, v, 0.0);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lTmp);
    }
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lLoc);

    i = 0;
    object oWP = GetObjectByTag("WP_AR0100_FIRE1", i);
    while (GetIsObjectValid(oWP))
    {
        string sFire;
        int n = d3();
        if      (n == 1) sFire = "plc_flamesmall";
        else if (n == 2) sFire = "plc_flamemedium";
        else if (n == 3) sFire = "plc_flamelarge";
        CreateObject(OBJECT_TYPE_PLACEABLE, sFire, GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR0100_FIRE1", ++i);
    }

    object oOrc;
    oOrc = GetObjectInArea("ks_farm_orc1", oGates);
    DestroyObject(oOrc);
    oOrc = GetObjectInArea("ks_farm_orc2", oGates);
    DestroyObject(oOrc);
}

void GuardsAmbientActions(object oGuard, int nAttack=FALSE)
{
    string s;
    int n = d8();
    if      (n == 1) s = "Fire!";
    else if (n == 2) s = "Attack!";
    else if (n == 3) s = "Get 'em!";
    else if (n == 4) s = "Kill him!";
    else if (n == 5) s = "Fire!";
    else if (n == 6) s = "Hit him!";
    else if (n == 7) s = "Fire now!";
    else if (n == 8) s = "Shoot!";
    AssignCommand(oGuard, ActionSpeakString(s, TALKVOLUME_SHOUT));

    n = d6();
    int nAnim;
    if      (n == 1) nAnim = ANIMATION_FIREFORGET_TAUNT;
    else if (n == 2) nAnim = ANIMATION_FIREFORGET_SPASM;
    else if (n == 3) nAnim = ANIMATION_FIREFORGET_VICTORY1;
    else if (n == 4) nAnim = ANIMATION_FIREFORGET_VICTORY2;
    else if (n == 5) nAnim = ANIMATION_FIREFORGET_VICTORY3;
    else if (n == 6) nAnim = ANIMATION_FIREFORGET_DODGE_DUCK;
    AssignCommand(oGuard, ActionPlayAnimation(nAnim));
}

void GuardsAttack(object oGorg)
{
    int i = 1;
    object oGuard = GetObjectInArea("pm_malitia", oGorg, i);
    while (GetIsObjectValid(oGuard))
    {
        DelayCommand(0.2*i, GuardsAmbientActions(oGuard, TRUE));
        AssignCommand(oGuard, ActionEquipMostDamagingRanged());
        AssignCommand(oGuard, PlaySound("as_pl_battlegrp"+IntToString(d8())));
        oGuard = GetObjectInArea("pm_malitia", oGorg, ++i);
    }

    i = 0;
    object oBalista = GetObjectByTag("_ar0100_balista", i);
    while (GetIsObjectValid(oBalista))
    {
        DelayCommand(0.33*i, AssignCommand(oBalista, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oGorg, PROJECTILE_PATH_TYPE_BALLISTIC)));
        oBalista = GetObjectByTag("_ar0100_balista", ++i);
    }
}

void start()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    object oTile1 = GetWaypointByTag("WP_AR0100_HOUSE1");
    object oTile2 = GetWaypointByTag("WP_AR0100_HOUSE2");

    // black screen while we adjust the time to midnight
    BlackScreen(oPC);
    SetTime(0, 0, 0, 0);

    // draw the houses which will be exploded
    TileDraw(oArea, 580, TileGetRow(oTile1), TileGetCol(oTile1), -0.1, 0.0);
    TileDraw(oArea, 581, TileGetRow(oTile2), TileGetCol(oTile2), -0.1, 270.0);

    // create some light to dodge bugs in TNO tileset
    object oWP = GetWaypointByTag("WP_AR0100_CUT1_CAMERA2");
    object oFire = GetNearestObjectByTag("_ar0100_crate", oWP);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15), oFire);

    CutsceneStart(TRUE);
}

// the city sleeps
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA4", FALSE, FALSE);
        SetCameraHeight(oPC, 10.0);
        AssignCommand(oPC, SetCameraFacing(0.0, 7.0, 75.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, SetCameraFacing(300.0, 7.0, 75.0, CAMERA_TRANSITION_TYPE_SLOW));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        CutsceneNextShot();
    }
}

// militia stand around talking before battle
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oAreaWP = GetWaypointByTag("WP_AR0100_CUT1_CAMERA2");
    object oMilitia1 = GetNearestObjectByTag("pm_malitia", oAreaWP, 1);
    object oMilitia2 = GetNearestObjectByTag("pm_malitia", oAreaWP, 2);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        SetCameraHeight(oPC, 0.0);
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA0");
        AssignCommand(oPC, SetCameraFacing(DIRECTION_SOUTH, 25.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        object oWP = GetWaypointByTag("WP_AR0100_CUT1_CAMERA2");
        AssignCommand(oPC, ActionMoveToObject(oWP));
        AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 2.0, 85.0, CAMERA_TRANSITION_TYPE_MEDIUM));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        MusicBackgroundStop(GetArea(oPC));
        AssignCommand(oMilitia1, ActionSpeakString(q+"Sergeant? Any sign of them orcs yet?"+q));
        AssignCommand(oMilitia1, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 5.0));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oMilitia2, ActionSpeakString(q+"Easy, lad. They'll be here soon enough."+q));
        AssignCommand(oMilitia2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oMilitia2, ActionDoCommand(PlaySound("as_pl_hiccupm1")));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        AssignCommand(oMilitia1, ActionSpeakString(q+GetFirstName(oPC)+" said there's a whole army coming!"+q));
        AssignCommand(oMilitia1, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oMilitia1, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        AssignCommand(oMilitia2, ActionSpeakString(q+"Don't worry, lad, our ballista will take care of 'em!"+q));
        AssignCommand(oMilitia2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oMilitia2, ActionDoCommand(PlaySound("as_pl_hiccupm1")));
        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        AssignCommand(oMilitia1, ActionDoCommand(PlaySound("as_cv_woodbreak3")));
        AssignCommand(oMilitia1, ActionSpeakString(q+"Sergeant! Did you hear that?"+q));
        AssignCommand(oMilitia1, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 5.0));
        CutsceneNext(40.0);
    }
    else if (fTime == 40.0)
    {
        CutsceneNextShot();
    }
}

// orcs outside gates talking
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    object oGates = GetObjectInArea("Wall1Gate", oGorg);
    object oOrc1 = GetNearestObjectByTag("ks_farm_orc1", oGates, 1);
    object oOrc2 = GetNearestObjectByTag("ks_farm_orc2", oGates, 1);
    object oTanarukk = GetNearestObjectByTag("ks_gate_tanarukk", oGates, 1);
    location lGorg = GetLocation(oGorg);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA3");
        DelayCommand(0.5, AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 2.0, 80.0)));
        SpawnNPCs();
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);
        MusicBackgroundPlay(GetArea(oPC));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oOrc1, ActionSpeakString(q+"Isn't dis supposed to be open?"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oOrc2, ActionSpeakString(q+"Maybe we at da wrong gate?"+q));
        AssignCommand(oOrc2, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_bat1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Quiet down!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        AssignCommand(oOrc1, ActionSpeakString(q+"Is dis da right town?"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_bat2"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"I said silence!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oOrc2, ActionSpeakString(q+"Do you smells smoke?"+q));
        AssignCommand(oOrc2, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oOrc2, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        AssignCommand(oOrc1, ActionSpeakString(q+"Outta da way!"+q));
        AssignCommand(oOrc1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        AssignCommand(oTanarukk, PlaySound("c_orc_bat1"));
        AssignCommand(oTanarukk, ActionSpeakString(q+"Move or you gonna roast!"+q));
        AssignCommand(oTanarukk, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(39.0);
    }
    else if (fTime == 39.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lGorg);
        AssignCommand(oGorg, PlaySound("fs_x0snd_drg1"));
        CutsceneNext(40.0);
    }
    else if (fTime == 40.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lGorg);
        AssignCommand(oGorg, PlaySound("fs_x0snd_drg2"));
        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lGorg);
        AssignCommand(oGorg, PlaySound("fs_x0snd_drg3"));
        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lGorg);
        AssignCommand(oGorg, PlaySound("fs_x0snd_drg1"));
        CutsceneNext(43.0);
    }
    else if (fTime == 43.0)
    {
        SetCameraHeight(oPC, 0.1);
        //AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 8.0, 80.0, CAMERA_TRANSITION_TYPE_FAST));
        AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 12.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        DrawCircle(lGorg, 2.0, VFX_IMP_HEAD_FIRE);
        AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        CutsceneNext(47.0);
    }
    else if (fTime == 47.0)
    {
        CutsceneNextShot();
    }
}

// the gates blow-up
void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    object oGates = GetObjectInArea("Wall1Gate", oGorg);
    object oTarget1 = GetObjectInArea("WP_AR0100_TARGET1", oGorg);

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        SetCameraHeight(oPC, 0.0);
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA1");
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 5.0, 80.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        ExplodeGates(oGates);
        DestroyObject(oGates);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        CutsceneNextShot();
    }
}

// gorgo leaps onto the city walls
void next4(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    location lGorg = GetLocation(oGorg);

    if (fTime == 0.0)
    {
        MusicBattlePlay(GetArea(oPC));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        object oDest = GetWaypointByTag("WP_AR0100_GORGO_2");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(GetLocation(oDest)), oGorg, 4.0);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 20.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        AssignCommand(oGorg, PlayVoiceChat(VOICE_CHAT_BATTLECRY1));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        CutsceneNextShot();
    }
}

// gorgo roars, and flames some houses
void next5(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    object oHouse1 = GetWaypointByTag("WP_AR0100_HOUSE1");
    object oHouse2 = GetWaypointByTag("WP_AR0100_HOUSE2");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA6");
        AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 25.0, 50.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, PlaySound("c_gorgo_057"));
        AssignCommand(oGorg, ActionSpeakString(q+"Mortals! Tremble before the mighty Gorgomorz!"+q));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        GuardsAttack(oGorg);
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        DrawCircle(GetLocation(oGorg), 3.0, VFX_IMP_FLAME_M);
        AssignCommand(oGorg, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oHouse1, PROJECTILE_PATH_TYPE_DEFAULT));
        AssignCommand(oGorg, ActionDoCommand(ExplodeHouse(oHouse1)));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        DrawCircle(GetLocation(oGorg), 3.0, VFX_IMP_FLAME_M);
        AssignCommand(oGorg, PlayVoiceChat(VOICE_CHAT_BATTLECRY2));
        AssignCommand(oGorg, ClearAllActions(TRUE));
        AssignCommand(oGorg, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oHouse2, PROJECTILE_PATH_TYPE_DEFAULT));
        AssignCommand(oGorg, ActionDoCommand(ExplodeHouse(oHouse2)));
        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        CutsceneNextShot();
    }
}

// bugo talks to gorgo and gets flamed
void next6(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    object oBugo = CutsceneGetActor("db_matagar");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oDest = GetWaypointByTag("WP_AR0100_GORGO_3");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(GetLocation(oDest)), oGorg, 4.5);
        CutsceneNext(3.0);
    }
    if (fTime == 3.0)
    {
        CutsceneMoveTo("WP_AR0100_CUT1_CAMERA1");
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 10.0, 88.0));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        DrawCircle(GetLocation(oGorg), 3.0, VFX_IMP_FLAME_M);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oGorg, PlaySound("c_gorgo_058"));
        AssignCommand(oGorg, ActionSpeakString(q+"Feast on their flesh! Leave no one alive!"+q));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oBugo, PlaySound("vs_bugo_071"));
        AssignCommand(oBugo, ActionSpeakString(q+"Gorgomorz! Together we can triumph."+q));
        AssignCommand(oBugo, ActionMoveToObject(oGorg, TRUE, 3.0));
        AssignCommand(oBugo, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oGorg, SetFacingPoint(GetPosition(oBugo)));
        AssignCommand(oGorg, PlaySound("c_gorgo_059"));
        AssignCommand(oGorg, ActionSpeakString(q+"What? Bugo..."+q));
        //AssignCommand(oGorg, PlaySound("c_devil_bat2"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oBugo, PlaySound("vs_bugo_072"));
        AssignCommand(oBugo, ActionSpeakString(q+"Quickly Gorgomorz! Kill "+GetFirstName(oPC)+", that troublemaker! They are the only threat here!"+q));
        AssignCommand(oBugo, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oGorg, PlaySound("c_gorgo_060"));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionSpeakString(q+"Ha ha ha ha!"+q));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(32.0);
    }
    else if (fTime == 32.0)
    {
        AssignCommand(oBugo, PlaySound("vs_bugo_073"));
        AssignCommand(oBugo, ActionSpeakString(q+"What is so funny?"+q));
        AssignCommand(oBugo, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        AssignCommand(oGorg, PlaySound("c_gorgo_061"));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionSpeakString(q+"You are an idiot, Bugo. Do I look like your servant?"+q));
        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        AssignCommand(oGorg, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR), oBugo, 60.0)));
        AssignCommand(oGorg, ActionCastFakeSpellAtObject(SPELL_FIREBRAND, oBugo));
        AssignCommand(oGorg, ActionDoCommand(ExplodeBugo(oBugo)));
        AssignCommand(oGorg, ActionDoCommand(CutsceneNextShot()));
    }
}

// gorgo wants to kill PC
void next7(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        //AssignCommand(oGorg, PlaySound("c_gorgo_062"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        //AssignCommand(oGorg, ActionSpeakString(q+"Your death is long overdue, worm!"+q));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oGorg, PlaySound("c_gorgo_062"));
        AssignCommand(oGorg, ActionSpeakString(q+"Your death is long overdue, worm!"+q));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneCameraCloseup(oGorg);
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 10.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP));
        AssignCommand(oGorg, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oGorg, ActionDoCommand(PlaySound("c_gorgo_063")));
        //AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oGorg);
        AssignCommand(oGorg, ActionSpeakString(q+"Now you will know the true meaning of pain, " + GetFirstName(oPC) + "!"+q));
        DrawCircle(GetLocation(oGorg), 3.0, VFX_IMP_FLAME_M);
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        TanarukkEnter("ks_gate_tanarukk", oGorg);
        TanarukkEnter("ks_farm_orc1", oGorg);
        TanarukkEnter("ks_farm_orc2", oGorg);
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        location lLoc = GetLocation(oGorg);
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), lLoc);
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        DestroyObject(oGorg);
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        CutsceneEnd();
    }
}

// all creatures with this tag in the area go hostile and attack PC
// .. don't use GetNearestObjectByTag here because that seems unreliable
// .. in area enter events when applied to the player object
void GoHostile(string sTag, object oPC, object oArea)
{
    int i = 0;
    object o = GetObjectByTag(sTag, i);
    while (GetIsObjectValid(o))
    {
        if (GetArea(o) == oArea)
        {
            SetPlotFlag(o, FALSE);
            SetImmortal(o, FALSE);
            ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
            AssignCommand(o, ActionAttack(oPC));
        }
        o = GetObjectByTag(sTag, ++i);
    }
}

// at the end of the scene, the tanarukk and orcs go hostile and gorgo vanishes
void end()
{
    object oPC = GetFirstPC();

    AssignCommand(oPC, SetCameraFacing(210.0, 20.0, 55.0));
    AssignCommand(oPC, StoreCameraFacing());

    RestSetTired(oPC, FALSE);

    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        HenchmanRest(oHench);
        ForceRest(oHench);
        oHench = GetHenchman(oPC, ++i);
    }

    ForceRest(oPC);

    // gorgo has vanished (for now)
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    DestroyObject(oGorg);

    // bugo is dead
    object oBugo = CutsceneGetActor("db_matagar");
    DestroyObject(oBugo);

    // houses are destroyed
    object oHouse1 = GetWaypointByTag("WP_AR0100_HOUSE1");
    object oHouse2 = GetWaypointByTag("WP_AR0100_HOUSE2");
    ExplodeHouse(oHouse1, FALSE);
    ExplodeHouse(oHouse2, FALSE);

    // tanarukk are inside the city
    object oGate = GetWaypointByTag("WP_AR0100_GATES");
    TanarukkEnter("ks_gate_tanarukk", oGate);
    TanarukkEnter("ks_farm_orc1", oGate);
    TanarukkEnter("ks_farm_orc2", oGate);

    // gates are destroyed
    object oGate1 = GetObjectInArea("Wall1Gate", oGate);
    DestroyObject(oGate1);
    object oGate2 = GetObjectInArea("drawbridge", oGate);
    DestroyObject(oGate2);

    // this is the heartbeat object which respawns gorgo when generals die
    object oWP = GetWaypointByTag("WP_AR0100_GORGO_0");
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_gorgomorz_pl", GetLocation(oWP));

    AssignCommand(oPC, RestoreCameraFacing());

    // tanarukk will attack
    object oArea = GetArea(oWP);
    DelayCommand(4.0, GoHostile("ks_farm_orc1", oPC, oArea));
    DelayCommand(4.0, GoHostile("ks_farm_orc2", oPC, oArea));
    DelayCommand(4.0, GoHostile("ks_gate_tanarukk", oPC, oArea));
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
        if (nShot == 3) next3(fTime);
        if (nShot == 4) next4(fTime);
        if (nShot == 5) next5(fTime);
        if (nShot == 6) next6(fTime);
        if (nShot == 7) next7(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        StopFade(GetFirstPC());
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
