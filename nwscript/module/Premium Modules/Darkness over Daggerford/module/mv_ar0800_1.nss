// this is the cutscene where millie waves good-bye and gets on a boat
// .. in the eastern farmlands

#include "hf_in_cutscene"
#include "hf_in_npc"

// equip a torch if it is night
void EquipTorch(object oNPC)
{
    if (GetIsNight())
    {
        object oTorch = CreateItemOnObject("NW_IT_TORCH001", oNPC, 1);
        AssignCommand(oNPC, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    }
}

// spawn npcs used in cutscene
void SpawnNPCs(object oPC)
{
    // create millie
    object oWP = GetWaypointByTag("wp_ef_createmags");
    object oMillie = CreateObject(OBJECT_TYPE_CREATURE, "ac_millie2", GetLocation(oWP));
    CutsceneAddActor("ac_millie2", oMillie);

    // create yentai
    oWP = GetWaypointByTag("wp_ef_createyentai");
    object oYentai = CreateObject(OBJECT_TYPE_CREATURE, "ac_yentai2", GetLocation(oWP));
    EquipTorch(oYentai);
    CutsceneAddActor("ac_yentai2", oYentai);

    // create the skiff
    oWP = GetWaypointByTag("wp_ef_createskiff");
    object oBoat = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_skiff", GetLocation(oWP));
    CutsceneAddActor("ks_pl_skiff", oBoat);
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    FadeToBlack(oPC, FADE_SPEED_FASTEST);
    CutsceneStart(FALSE, FALSE, "wp_ef_pcarrive", FALSE);
    SpawnNPCs(oPC);
}

// millie waves good-bye to player and gets on the boat
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oMillie = CutsceneGetActor("ac_millie2");
    object oYentai = CutsceneGetActor("ac_yentai2");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        //CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 4.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 10.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // millie waves goodbye
        string sName = GetName(oPC);
        AssignCommand(oMillie, ActionSpeakString(q+"Goodbye! I shall be forever in your debt, "+sName+"!"+q));
        AssignCommand(oMillie, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        AssignCommand(oPC, PlaySound("as_wt_thunderds4"));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // millie walks towards the boat
        object oDest = GetWaypointByTag("WP_AR0800_CUT1_MILLIE_BOAT");
        AssignCommand(oMillie, ActionMoveToObject(oDest, FALSE, 0.5));
        AssignCommand(oPC, PlaySound("as_cv_woodwater2"));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        // millie climbs into the boat
        AssignCommand(oYentai, SetFacingPoint(GetPosition(oMillie)));
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        CutsceneNextShot();
    }
}

// camera spins to focus on the player for the closing dialog
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oMillie = CutsceneGetActor("ac_millie2");
    object oYentai = CutsceneGetActor("ac_yentai2");
    object oBoat =   CutsceneGetActor("ks_pl_skiff");

    if (fTime == 0.0)
    {
        // turn camera away from yentai and the boat
        CutsceneCameraSetup(-1.0, 250.0, 2.0, 85.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oPC, SetFacingPoint(GetPosition(oYentai)));
        AssignCommand(oYentai, SetFacingPoint(GetPosition(oPC)));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // the boat sails away while the camera is turned
        AssignCommand(oPC, PlaySound("as_cv_shipsail1"));
        DestroyObject(oMillie);
        DestroyObject(oBoat);
        DestroyObject(oYentai);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // play descriptive text for yentai leaving
        AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar0800_yentai", FALSE, FALSE));
    }
}

// just end the scene
void next2(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

// yentai, millie, and boat are gone
void end()
{
    object oPC = GetFirstPC();
    object oMillie = CutsceneGetActor("ac_millie2");
    object oYentai = CutsceneGetActor("ac_yentai2");
    object oBoat =   CutsceneGetActor("ks_pl_skiff");

    // millie and yentai have left on the boat
    DestroyObject(oBoat);
    DestroyObject(oMillie);
    DestroyObject(oYentai);
    DestroyObject(GetObjectByTag("ac_millie"));
    DestroyObject(GetObjectByTag("ac_filia"));
    DestroyObject(GetObjectByTag("ac_ruben"));
    DestroyObject(GetObjectByTag("ac_porto"));
    DestroyObject(GetObjectByTag("ac_eustachia"));
    DestroyObject(GetObjectByTag("ac_charlice"));
    DestroyObject(GetObjectByTag("ac_crispin"));
    DestroyObject(GetObjectByTag("ac_yent_bodyg1"));
    DestroyObject(GetObjectByTag("ac_yent_bodyg2"));
    DestroyObject(GetObjectByTag("ac_yentai"));

    SetLocalInt(GetModule(), "iChurlgoDead", 1);

    AssignCommand(oPC, SetCameraFacing(90.0, 15.0, 60.0));

    // yentai left a note behind
    CreateObject(OBJECT_TYPE_PLACEABLE, "ac_plc_yentai", GetLocation(GetObjectByTag("wp_yentai_note")));
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
