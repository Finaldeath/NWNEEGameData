// this is the cutscene where ivrin's cow vanishes
// .. in the wild pastures

#include "hf_in_cutscene"
#include "hf_in_npc"

// equip a torch if it is night
void EquipTorch(object oNPC)
{
    if (GetIsNight())
    {
        object oTorch = CreateItemOnObject("NW_IT_TORCH001", oNPC, 1, "torch");
        AssignCommand(oNPC, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    }
}

// spawn NPCs used in the cutscene
void SpawnNPCs(object oPC)
{
    // create ivrin
    object oWP = GetWaypointByTag("WP_AR1500_CUT2_IVRIN");
    object oIvrin = CreateObject(OBJECT_TYPE_CREATURE, "ks_ivrin", GetLocation(oWP));
    CutsceneAddActor("ks_ivrin", oIvrin);
    EquipTorch(oIvrin);
    SetLocalInt(oIvrin, "HF_DISABLE_AM", 1);

    // create laddie
    oWP = GetWaypointByTag("WP_AR1500_CUT2_LADDIE");
    object oLaddie = CreateObject(OBJECT_TYPE_CREATURE, "ks_laddie", GetLocation(oWP));
    CutsceneAddActor("ks_laddie", oLaddie);

    // create betty cow
    oWP = GetWaypointByTag("WP_AR1500_CUT2_COW1");
    object oCow1 = CreateObject(OBJECT_TYPE_CREATURE, "nw_cow", GetLocation(oWP), FALSE, "_cow_betty");
    CutsceneAddActor("_cow_betty", oCow1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION), oCow1, 0.5);

    // create two generic cows
    oWP = GetWaypointByTag("WP_AR1500_CUT2_COW2");
    object oCow2 = CreateObject(OBJECT_TYPE_CREATURE, "nw_cow", GetLocation(oWP), FALSE, "_cow2");
    CutsceneAddActor("_cow2", oCow2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION), oCow2, 1.1);
    oWP = GetWaypointByTag("WP_AR1500_CUT2_COW3");
    object oCow3 = CreateObject(OBJECT_TYPE_CREATURE, "nw_cow", GetLocation(oWP), FALSE, "_cow3");
    CutsceneAddActor("_cow3", oCow3);

    // create the voice
    oWP = GetWaypointByTag("WP_AR1500_CUT2_LAUGH");
    vector v = GetPosition(oWP);
    v.z += 1.0;
    location lLoc = Location(GetArea(oWP), v, 0.0);
    object oVoice = CreateObject(OBJECT_TYPE_PLACEABLE, "pm_voice", lLoc, FALSE, "_voice");
    CutsceneAddActor("_voice", oVoice);
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    FadeToBlack(oPC, FADE_SPEED_FASTEST);
    CutsceneStart(TRUE, FALSE, "WP_AR1500_CUT2_START", TRUE);
    CutsceneMusic(TRACK_CITYSLUMNIGHT);
    SpawnNPCs(oPC);
}

// laddie barks
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oIvrin = CutsceneGetActor("ks_ivrin");
    object oLaddie = CutsceneGetActor("ks_laddie");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // sometimes this scene fails to move the player into position?
        // .. keep trying for a maximum of two seconds
        CutsceneForceMoveTo("WP_AR1500_CUT2_START", 0.5, 4);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera to look at the cows
        CutsceneCameraSetup(-1.0, 240.0, 10.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        AssignCommand(oPC, PlaySound("as_an_cows2"));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // laddie barks
        AssignCommand(oLaddie, PlaySound("as_an_dogbark6"));
        AssignCommand(oLaddie, ActionSpeakString("Yap! Yip-yap!"));
        AssignCommand(oLaddie, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // ivrin is puzzled
        CutsceneCameraSetup(-1.0, 240.0, 10.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP); // repeat
        AssignCommand(oIvrin, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        AssignCommand(oIvrin, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        AssignCommand(oIvrin, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // laddie barks some more
        AssignCommand(oLaddie, PlaySound("as_an_dogbark6"));
        AssignCommand(oLaddie, ActionSpeakString("Yap! Yip-yap!"));
        AssignCommand(oLaddie, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // cows moo
        AssignCommand(oPC, PlaySound("as_an_cows1"));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        // ivrin is puzzled
        AssignCommand(oIvrin, ActionSpeakString(q+"What is it, Laddie? Do you smell something, boy?"+q));
        AssignCommand(oIvrin, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        // cows moo
        AssignCommand(oPC, PlaySound("as_an_cows2"));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        CutsceneNextShot();
    }
}

// a cow vanishes
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oIvrin = CutsceneGetActor("ks_ivrin");
    object oLaddie = CutsceneGetActor("ks_laddie");
    object oCow = CutsceneGetActor("_cow_betty");
    object oVoice = CutsceneGetActor("_voice");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // zoom in on the cows
        CutsceneCameraSetup(-1.0, 240.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // cow vanishes
        DestroyObject(oCow);
        AssignCommand(oPC, PlaySound("sdr_invisible"));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // zoom camera back out
        CutsceneCameraSetup(-1.0, 240.0, 10.0, 80.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // ivrin speaks
        AssignCommand(oIvrin, ActionSpeakString(q+"Jumping jackrabbits! Did you see that?"+q));
        AssignCommand(oIvrin, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // dog barks
        AssignCommand(oLaddie, PlaySound("as_an_dogbark6"));
        AssignCommand(oLaddie, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // invisible goblin laughs
        AssignCommand(oVoice, SpeakString(q+"Hihihihi!"+q));
        AssignCommand(oPC, PlaySound("vs_nx2deekm_haha"));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        CutsceneNextShot();
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

// a cow is gone
void end()
{
    object oPC = GetFirstPC();
    object oCow = CutsceneGetActor("_cow_betty");
    object oVoice = CutsceneGetActor("_voice");
    object oIvrin = CutsceneGetActor("ks_ivrin");

    // the cow and voice are gone
    DestroyObject(oCow);
    DestroyObject(oVoice);

    // give a journal entry
    AddJournalQuestEntry("j13", 5, oPC);

    // ivrin can play his animations now
    SetLocalInt(oIvrin, "HF_DISABLE_AM", 0);

    // the invisible goblin is created
    object oWP = GetWaypointByTag("WP_AR1500_CUT2_GOBLIN");
    object oGoblin = CreateObject(OBJECT_TYPE_CREATURE, "ks_goblin_invis", GetLocation(oWP), FALSE, "_ar1500_goblin_invis");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED), oGoblin);
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
