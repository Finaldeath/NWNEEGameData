// this is the cutscene where griswald knocks on the castle gates
// .. and all the knights are killed

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_util"

// create npcs for scene
void spawnNPCs(object oPC)
{
    object oGate = GetObjectByTag("dt_ar2000_drawbridge");
    object oGriswald = GetObjectByTag("ks_griswald");
    if (GetIsObjectValid(oGriswald))
    {
        DestroyObject(oGriswald);
    }
    object oWP = GetObjectByTag("WP_AR2000_CUT1_GRIS");
    oGriswald = CreateObject(OBJECT_TYPE_CREATURE, "ks_griswald", GetLocation(oWP));
    object oTorch = GetItemPossessedBy(oGriswald, "NW_IT_TORCH001");
    if (GetIsObjectValid(oTorch))
    {
        AssignCommand(oGriswald, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    }
    AssignCommand(oGriswald, SetFacingPoint(GetPosition(oGate)));
}

void KillKnights(object oPC)
{
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "nKilledKnights") == 0)
    {
        SetLocalInt(oArea, "nKilledKnights", 1);

        // two knights are outside (dead) the rest are sleeping (dead)
        int i = 0;
        int n = 0;
        object oKnight = GetObjectByTag("ks_gris_knight", i);
        while (GetIsObjectValid(oKnight) && !GetIsDead(oKnight))
        {
            DestroyObject(oKnight);
            oKnight = GetObjectByTag("ks_gris_knight", ++i);
        }

        for(n = 1; n < 3; n++)
        {
            string sWP = "WP_AR2000_CUT1_KNIGHTDEATH" + IntToString(n);
            object oWP = GetObjectByTag(sWP);
            object oArea = GetArea(oWP);
            vector vPos = GetPosition(oWP);
            vPos.z = vPos.z;
            location lLoc = Location(oArea, vPos, GetFacing(oWP));
            CreateObject(OBJECT_TYPE_CREATURE, "ks_gris_knightcp", lLoc);
        }

        // spawn the "dead sleeping knight" placeables beside fires
        i = 0;
        object oWP = GetObjectByTag("WP_AR2000_DEAD_KNIGHT", i);
        while (GetIsObjectValid(oWP))
        {
            object oArea = GetArea(oWP);
            vector vPos = GetPosition(oWP);
            vPos.z = vPos.z;
            location lLoc = Location(oArea, vPos, GetFacing(oWP));
            CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(oWP));
            CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_deadknight", lLoc);
            oWP = GetObjectByTag("WP_AR2000_DEAD_KNIGHT", i++);
        }

        // kill the page in griswald's tent
        object oPage = GetObjectByTag("ks_gris_page");
        if (GetIsObjectValid(oPage) && !GetIsDead(oPage))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPage);
        }
    }
}

// move to position and start the scene
void start()
{
    object oPC = GetFirstPC();
    SetTime(0,0,0,0);
    TeleportToWaypoint(oPC, "WP_AR2000_CUT1_START", FALSE);
    DelayCommand(1.0, CutsceneStart(FALSE, FALSE));
    spawnNPCs(oPC);
    //DayToNight(oPC);

    CutsceneMusic(64, FALSE);
}

// set the camera
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        object oGate = GetObjectInArea("dt_ar2000_drawbridge", oPC);
        AssignCommand(oPC, SetFacingPoint(GetPosition(oGate)));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 20.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        object oWP = GetWaypointByTag("WP_AR2000_CUT1_GATE");
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToObject(oWP, TRUE, 0.1));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 5.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNextShot();
    }
}

// convo at the drawbridge
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oGate = GetObjectInArea("dt_ar2000_drawbridge", oPC);
    object oGriswald = GetObjectInArea("ks_griswald", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
       // griswald yells
        AssignCommand(oGriswald, ActionSpeakString(q+"Feldran! Open these gates!"+q));
        AssignCommand(oGriswald, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // convo with gate starts
        PlotLevelSet("dt_ar2000_drawbridge", 4);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionStartConversation(oGate));
    }
}

// griswald runs back to camp
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oGriswald = GetObjectInArea("ks_griswald", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // delay to allow camera control to return
        KillKnights(oPC);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        AssignCommand(oGriswald, ActionSpeakString(q+"Something is not right!"+q, TALKVOLUME_SHOUT));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // player watches griswald flee
        CutsceneCameraSetup(-1.0, DIRECTION_EAST, 15.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // griswald runs back to camp
        object oWP = GetWaypointByTag("WP_AR2000_CAMP");
        AssignCommand(oGriswald, ActionMoveToObject(oWP, TRUE));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneEnd();
    }
}

// griswald runs back to camp and finds everyone dead
void end()
{
    object oPC = GetFirstPC();
    object oGriswald = GetObjectInArea("ks_griswald", oPC);

    // drawbridge dialog is done
    PlotLevelSet("dt_ar2000_drawbridge", 5);

    // gold is waiting for player
    object oWP = GetWaypointByTag("WP_AR2000_GOLD");
    object oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_lootbag6", GetLocation(oWP));
    SetLocalInt(oBag, "NW_DO_ONCE", 1);
    CreateItemOnObject("nw_it_gold001", oBag, 500);

    // enable map note
    object oMapNote = GetNearestObjectByTag("MN_AR2000_GNARLED_TREE", oPC);
    SetMapPinEnabled(oMapNote, TRUE);

    // the troops are all dead
    KillKnights(oPC);

    // griswald is back at camp, crying
    oWP = GetWaypointByTag("WP_AR2000_CAMP");
    DestroyObject(oGriswald);
    oGriswald = CreateObject(OBJECT_TYPE_CREATURE, "ks_griswald", GetLocation(oWP));
    AssignCommand(oGriswald, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 65535.0));
    PlotLevelSet("ks_griswald", 4);
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
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
