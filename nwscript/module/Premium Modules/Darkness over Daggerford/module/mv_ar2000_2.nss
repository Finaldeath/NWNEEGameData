// this is the cutscene where griswald and feldran fight

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_util"

// open the drawbridge doors
void DrawbridgeOpen(object oPC)
{
    object oDoor1 = GetObjectInArea("dt_ar2000_drawbridge2", oPC);
    object oDoor2 = GetObjectInArea("dt_ar2000_drawbridge3", oPC);
    SetLocked(oDoor1, FALSE);
    SetLocked(oDoor2, FALSE);
    AssignCommand(oDoor1, ActionOpenDoor(oDoor1));
    AssignCommand(oDoor2, ActionOpenDoor(oDoor2));
}

// a knight runs down the bridge and enters the castle
void DrawbridgeRun(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR2000_CUT2_GKNIGHT_1");
    object oKnight = CreateObject(OBJECT_TYPE_CREATURE, "ks_gris_knight", GetLocation(oWP));
    object oTorch = CreateItemOnObject("NW_IT_TORCH001", oKnight, 1);
    AssignCommand(oKnight, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    SetLocalString(oKnight, "HF_EXIT_NAME", "WP_AR2000_CUT2_GKNIGHT_2");
    SetLocalInt(oKnight, "HF_EXIT_RUN", TRUE);
    DelayCommand(0.3, ExecuteScript("hf_cs_exit", oKnight));
}

// spawn some knights in the courtyard
void SpawnKnights(object oPC)
{
    // remove griswald's knights from the camp
    int i = 1;
    object oKnight = GetObjectInArea("ks_gris_knight", oPC, i);
    while (GetIsObjectValid(oKnight))
    {
        DestroyObject(oKnight);
        oKnight = GetObjectInArea("ks_gris_knight", oPC, ++i);
    }
    object oPage = GetObjectByTag("ks_gris_page");
    DestroyObject(oPage);

    // griswald's knights are in the courtyard now
    i = 0;
    object oWP1 = GetObjectByTag("WP_AR2000_CUT2_GKNIGHT_3", i);
    while (GetIsObjectValid(oWP1))
    {
        object o = CreateObject(OBJECT_TYPE_CREATURE, "ks_gris_knight", GetLocation(oWP1));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6(5)), o);
        oWP1 = GetObjectByTag("WP_AR2000_CUT2_GKNIGHT_3", ++i);
    }

    // feldran's knights are dead (unless player already defeated feldran)
    if (GetLocalInt(GetModule(), "nFandocFeldranSpawned") == 0)
    {
        i = 0;
        object oWP2 = GetObjectByTag("WP_AR2000_CUT2_FKNIGHT_3", i);
        while (GetIsObjectValid(oWP2))
        {
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oWP2));
            object o = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_knigh", GetLocation(oWP2));
            SetLootable(o, TRUE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), o);
            oWP2 = GetObjectByTag("WP_AR2000_CUT2_FKNIGHT_3", ++i);
        }
    }
}

// create the bulter near the door
void SpawnButler(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR2000_CUT2_DOORMAN");
    object oButler = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_butlr", GetLocation(oWP));
    CutsceneAddActor("ks_exeltis_butlr", oButler);
}

// create npcs for scene
void SpawnNPCs(object oPC)
{
    // spawn griswald in the castle courtyard (if he is still alive)
    if (GetLocalInt(GetModule(), "nFandocGriswaldDead") == 0)
    {
        object oGriswald = GetObjectByTag("ks_griswald");
        if (GetIsObjectValid(oGriswald))
        {
            DestroyObject(oGriswald);
        }
        object oWP = GetObjectByTag("WP_AR2000_CUT2_GRISWALD");
        oGriswald = CreateObject(OBJECT_TYPE_CREATURE, "ks_griswald", GetLocation(oWP));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oGriswald);
        AssignCommand(oGriswald, ActionEquipMostDamagingMelee());
        SetPlotFlag(oGriswald, FALSE);
        SetImmortal(oGriswald, FALSE);
        CutsceneAddActor("ks_griswald", oGriswald);

        // if griswald's faction is hostile to the player, heal it
        if (GetIsEnemy(oGriswald, oPC))
        {
            SetLocalInt(GetModule(), "nFandocGriswaldMad", 1);
            AdjustReputation(oPC, oGriswald, 50);
        }

        // spawn feldran in the castle courtyard (unless player already defeated him)
        if (GetLocalInt(GetModule(), "nFandocFeldranSpawned") == 0)
        {
            object oFeldran = GetObjectByTag("ks_feldran");
            if (GetIsObjectValid(oFeldran))
            {
                DestroyObject(oFeldran);
            }
            oWP = GetObjectByTag("WP_AR2000_CUT2_FELDRAN");
            oFeldran = CreateObject(OBJECT_TYPE_CREATURE, "ks_feldran", GetLocation(oWP));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oFeldran);
            SetPlotFlag(oFeldran, FALSE);
            SetImmortal(oFeldran, FALSE);
            SetLocalInt(oFeldran, "nState", 4);
            CutsceneAddActor("ks_feldran", oFeldran);
        }
    }
}

// move to position and start the scene
void start()
{
    object oPC = GetFirstPC();
    SetLocalInt(oPC, "nRunningCutscene", 1);
    CutsceneStart(TRUE, FALSE, "WP_AR2000_CUT2_CAM2");
    CutsceneMusic(64, TRUE);
    SpawnButler(oPC);
}

// shot of the drawbridge from inside the castle
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oButler = CutsceneGetActor("ks_exeltis_butlr");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_EAST, 4.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, PlaySound("as_dr_metlprtop1"));
        AssignCommand(oButler, ActionSpeakString(q+"The gate! It's opening! How can this be?"+q));
        AssignCommand(oButler, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        AssignCommand(oButler, ActionWait(0.5));
        AssignCommand(oButler, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, PlaySound("as_dr_stonvlgcl1"));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oPC, PlaySound("as_dr_metlprtop1"));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneNextShot();
    }
}

// watch the drawbridge lower from outside the castle
void next1(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        SpawnNPCs(oPC);
        CutsceneMoveTo("WP_AR2000_CUT2_CAM1");
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        DrawbridgeOpen(oPC);
        AssignCommand(oPC, PlaySound("as_dr_x2ttu9op"));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, PlaySound("as_dr_metlmedop2"));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oPC, PlaySound("as_dr_stonlgop1"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oPC));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        if (GetLocalInt(GetModule(), "nFandocGriswaldDead") == 0)
        {
            CutsceneNextShot();
        } else {
            CutsceneEnd();
        }
    }
}

// watch the knights storm the castle
void next2(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
       // set the camera for a side shot of the bridge
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 25.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // knights run down the bridge
        AssignCommand(oPC, PlaySound("as_pl_battlegrp1"));
        DrawbridgeRun(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // knights run down the bridge
        AssignCommand(oPC, PlaySound("as_pl_battlegrp2"));
        DrawbridgeRun(oPC);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // knights run down the bridge
        AssignCommand(oPC, PlaySound("as_pl_battlegrp3"));
        DrawbridgeRun(oPC);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // knights run down the bridge
        CutsceneCameraSetup(-1.0, 200.0, 15.0, 85.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        AssignCommand(oPC, PlaySound("as_pl_battlegrp6"));
        DrawbridgeRun(oPC);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        // give the knights some time to finish running
        AssignCommand(oPC, PlaySound("as_pl_battlegrp1"));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // give the knights some time to finish running
        AssignCommand(oPC, PlaySound("as_pl_battlegrp2"));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        CutsceneNextShot();
    }
}

// griswald and feldran insult each other in the courtyard
void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oGriswald = CutsceneGetActor("ks_griswald");
    object oFeldran = CutsceneGetActor("ks_feldran");
    object oButler = CutsceneGetActor("ks_exeltis_butlr");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (GetLocalInt(GetModule(), "nFandocFeldranSpawned") != 0)
    {
        CutsceneNextShot();
    }

    if (fTime == 0.0)
    {
        DestroyObject(oButler);
        CutsceneMoveTo("WP_AR2000_CUT2_CAM2");
        CutsceneCameraSetup(-1.0, DIRECTION_EAST, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oGriswald, ActionSpeakString(q+"Feldran! Where is Soliana?"+q, TALKVOLUME_SHOUT));
        AssignCommand(oGriswald, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oFeldran, PlaySound("vs_nclerkm1_haha"));
        AssignCommand(oFeldran, ActionSpeakString(q+"Why, if it isn’t our blustering barbarian, Griswald! Had to get your lackey to open the door for you I see?"+q, TALKVOLUME_SHOUT));
        AssignCommand(oFeldran, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        AssignCommand(oGriswald, ActionSpeakString(q+"Arrgghh! I'll have your head!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oGriswald, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        CutsceneNextShot();
    }
}

// griswald attacks feldran (unless feldran is already dead)
void next4(float fTime)
{
    object oPC = GetFirstPC();
    object oGriswald = CutsceneGetActor("ks_griswald");
    object oFeldran = CutsceneGetActor("ks_feldran");

    if (GetLocalInt(GetModule(), "nFandocFeldranSpawned") != 0)
    {
        CutsceneNextShot();
    }

    if (fTime == 0.0)
    {
        AssignCommand(oGriswald, ActionAttack(oFeldran));
        // next shot will be given when feld is damaged
    }
}

// griswald runs off to soliana
void next5(float fTime)
{
    object oPC = GetFirstPC();
    object oGriswald = CutsceneGetActor("ks_griswald");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oGriswald, ClearAllActions(TRUE));
        AssignCommand(oGriswald, ActionSpeakString(q+"Soliana! I am here!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oGriswald, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        object oExit = GetWaypointByTag("WP_AR2000_CUT2_GRISWALD_EXIT");
        AssignCommand(oGriswald, ActionMoveToObject(oExit, TRUE));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneEnd();
    }
}

// griswald's knights are inside the castle (if they aren't dead)
void end()
{
    object oPC = GetFirstPC();
    object oFeldran = CutsceneGetActor("ks_feldran");
    object oGriswald = CutsceneGetActor("ks_griswald");
    object oButler = CutsceneGetActor("ks_exeltis_butlr");

    // clear the cutscene flag
    DeleteLocalInt(oPC, "nRunningCutscene");

    // the doorman runs away
    DestroyObject(oButler);

    // the drawbridge is now open
    PlotLevelSet("dt_ar2000_drawbridge", 8);

    if (GetLocalInt(GetModule(), "nFandocGriswaldDead") == 0)
    {
        // post-battle dialog node is ready
        PlotLevelSet("ks_griswald", 5);
        PlotLevelSet("ks_soliana", 2);
        PlotLevelSet("ks_olree", 2);

        // knights in courtyard for battle
        SpawnKnights(oPC);

        // feldran is dead (killed by griswald)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oFeldran);
        SetLocalInt(GetModule(), "nFandocFeldranDead", 1);
        SetLocalInt(GetModule(), "nFandocFeldranSpawned", 1);
        SetLocalInt(GetModule(), "iDisableOilBarrels", 1);
        // griswald runs inside to Soliana's bedroom
        DestroyObject(oGriswald);

        // update player's journal
        AddJournalQuestEntry("j85", 9, oPC);
    }
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
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        //CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
