// this is the cutscene in Gills Hills where Porto meets Yentai

#include "hf_in_cutscene"

// spawn npcs used in this cutscene
void SpawnNPCs(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR1000_CUT1_PORTO");
    object oPorto = CreateObject(OBJECT_TYPE_CREATURE, "ac_porto2", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oPorto);
    CutsceneAddActor("ac_porto2", oPorto);

    oWP = GetWaypointByTag("WP_AR1000_CUT1_YENTAI");
    object oYentai = CreateObject(OBJECT_TYPE_CREATURE, "ac_yentai", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10), oYentai);
    CutsceneAddActor("ac_yentai", oYentai);

    oWP = GetObjectByTag("ac_spawn_sejellus");
    object oSejellus = CreateObject(OBJECT_TYPE_CREATURE, "ac_sejellus", GetLocation(oWP));
    CutsceneAddActor("ac_sejellus", oSejellus);
    if (GetIsDusk() || GetIsNight())
    {
        object oTorch = GetItemPossessedBy(oSejellus, "NW_IT_TORCH001");
        AssignCommand(oSejellus, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    }
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(TRUE, FALSE, "WP_AR1000_CUT1_START");
    SpawnNPCs(oPC);
}

// porto and yentai are talking
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oPorto = CutsceneGetActor("ac_porto2");
    object oYentai = CutsceneGetActor("ac_yentai");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_EAST, 3.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oYentai, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        AssignCommand(oPorto, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oYentai, ActionSpeakString(q+"Porto? Is it done already?"+q));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oPorto, ActionSpeakString(q+"Yes, I reckon it is."+q));
        AssignCommand(oPorto, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oYentai, ActionSpeakString(q+"So? Why are you still here? Scram!"+q));
        AssignCommand(oYentai, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        CutsceneNextShot();
    }
}

// porto and yentai exit
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oPorto = CutsceneGetActor("ac_porto2");
    object oYentai = CutsceneGetActor("ac_yentai");
    object oDoor = GetObjectByTag("C1AR1000_C1AR1006_EXIT");

    if (fTime == 0.0)
    {
        // porto runs away
        object oExit = GetObjectByTag("WP_AR1000_CUT1_PORTO_EXIT");
        AssignCommand(oPorto, ActionMoveToObject(oExit, TRUE, 0.5));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // yentai enters his house
        object oExit = GetObjectByTag("WP_AR1000_CUT1_YENTAI_EXIT");
        AssignCommand(oYentai, ActionMoveToObject(oExit, TRUE, 0.1));
        AssignCommand(oYentai, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
        AssignCommand(oYentai, ActionDoCommand(AssignCommand(oDoor, ActionOpenDoor(oDoor))));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        DestroyObject(oYentai);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneEnd();
    }
}

// porto and yentai are both gone; sejellus talks to the player
void end()
{
    object oPC = GetFirstPC();
    object oPorto = CutsceneGetActor("ac_porto2");
    object oYentai = CutsceneGetActor("ac_yentai");
    object oSejellus = CutsceneGetActor("ac_sejellus");

    // porto has run away
    DestroyObject(oPorto);
    DestroyObject(oYentai);

    // Sejellus talks to the player
    AssignCommand(oSejellus, ClearAllActions());
    AssignCommand(oSejellus, ActionWait(1.0));
    AssignCommand(oSejellus, ActionStartConversation(oPC));
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
