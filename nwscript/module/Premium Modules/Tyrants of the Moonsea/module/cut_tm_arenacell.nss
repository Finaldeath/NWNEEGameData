//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_arenacell
// DATE: February 17, 2006
// AUTH: Luke Scull
// NOTE: Quick cutscene when player awakens in Arena Cell.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "cut_tm_arena_inc"


const string WP_TAG_PLAYER = "WP_hfcells_pc_arrival";

const string LVAR_QUEST_UPDATE_DONCE = "cut_arenacell_donce";


void setupActors(object oPC)
{
    object oActor;

    oActor = GetObjectInArea(NPC_TAG_GARTH, oPC);
    CutsceneAddActor(NPC_TAG_GARTH, oActor);

    oActor = GetObjectInArea(NPC_TAG_ELF, oPC);
    CutsceneAddActor(NPC_TAG_ELF, oActor);

    oActor = GetObjectInArea(NPC_TAG_BLIZZARD, oPC);
    CutsceneAddActor(NPC_TAG_BLIZZARD, oActor);
}


void questUpdate1(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        AddJournalQuestEntry("TheArena", 10, oPC);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    setupActors(oPC);

    questUpdate1(oPC);

    // Jump Actors to final positions during black screen
    BlackScreen(oPC);
    object oActorElf = CutsceneGetActor(NPC_TAG_ELF);
    object oElfWP = GetObjectInArea(WP_TAG_ELF_CELLS, oPC);
    AssignCommand(oActorElf, ActionJumpToObject(oElfWP, FALSE));
    AssignCommand(oActorElf, SetFacing(0.0));

    object oActorBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    object oBlizzardWP = GetObjectInArea(WP_TAG_BLIZZARD_CELLS, oPC);
    AssignCommand(oActorBlizzard, ActionJumpToObject(oBlizzardWP, FALSE));
    AssignCommand(oActorBlizzard, SetFacing(270.0));
}


void end()
{
    object oPC = CutsceneGetPC();

    // Don't leave any traces on PC
    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Initiate Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorFather = CutsceneGetActor(NPC_TAG_GARTH);
    object oActorElf = CutsceneGetActor(NPC_TAG_ELF);
    object oActorBlizzard = CutsceneGetActor(NPC_TAG_BLIZZARD);
    // Waypoint
    object oPlayerWP = GetObjectInArea(WP_TAG_PLAYER, oPC);
    object oElfWP = GetObjectInArea(WP_TAG_ELF_CELLS, oPC);
    object oBlizzardWP = GetObjectInArea(WP_TAG_BLIZZARD_CELLS, oPC);

    if (fTime == 0.0)
    {
        // Immediate Black screen (still unconscious)
        BlackScreen(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, SetFacing(GetFacing(oPlayerWP)));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 40.0));

        CutsceneCameraSetup(0.0, 112.0, 5.0, 0.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneCameraSetup(-1.0, 75.0, 10.0, 0.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneCameraSetup(-1.0, 90.0, 2.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oActorFather, PlaySound("vs_garth_001"));
        AssignCommand(oActorFather, SpeakString("That was a nasty head wound. I'm glad I could treat it before any permanent damage was done."));
        AssignCommand(oActorFather, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 3.0));

        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oActorElf, PlaySound("vs_elf_050"));
        AssignCommand(oActorElf, SpeakString("So, this is the one they're all talking about..."));
        AssignCommand(oActorElf, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 3.0));

        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        AssignCommand(oActorBlizzard, PlaySound("vs_blizzard_051"));
        AssignCommand(oActorBlizzard, SpeakString("Apparently, Onehand himself signed the arrest warrant."));
        AssignCommand(oActorBlizzard, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 3.0));

        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        AssignCommand(oActorFather, PlaySound("vs_garth_002"));
        AssignCommand(oActorFather, SpeakString("Quiet - they are waking up."));

        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        AssignCommand(oActorElf, ActionMoveToObject(oElfWP, FALSE));
        AssignCommand(oActorBlizzard, ActionMoveToObject(oBlizzardWP, FALSE));

        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        AssignCommand(oActorElf, SetFacing(0.0));
        AssignCommand(oActorBlizzard, SetFacing(270.0));

        CutsceneNext(40.0);
    }
    else if (fTime >= 40.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: End Cutscene
void next1(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        questUpdate1(oPC);
        CutsceneEnd();
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
        if (nShot >= 1) next1(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        StopFade(GetFirstPC());
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}
