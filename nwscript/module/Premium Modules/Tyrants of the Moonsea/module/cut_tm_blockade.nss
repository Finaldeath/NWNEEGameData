//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_blockade
// DATE: February 16, 2019
// AUTH: Rich Barker
// NOTE: Cutscene of Pirate Blockade
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"

const string NPC_TAG_KETTIA = "CaptainKettia";
const string NPC_TAG_PIRATE1 = "PirateBlockade1";
const string NPC_TAG_PIRATE2 = "PirateBlockade2";
const string NPC_TAG_PIRATE3 = "PirateBlockade3";
const string NPC_TAG_PIRATE4 = "PirateBlockade4";
const string NPC_TAG_PIRATE5 = "PirateBlockade5";
const string NPC_TAG_PIRATE7 = "PirateBlockade7";
const string NPC_TAG_PRISONER = "PiratePrisoner";
const string NPC_TAG_WHIP = "PirateBlockadeWhip";
const string NPC_TAG_BOY = "CabinBoy";

const string WP_TAG_PC_INIT = "WP_MOBL_CS_PC_START";

void SetupActors(object oPC)
{
    int i = 1;

    object oActor = GetObjectInArea(NPC_TAG_KETTIA, oPC);
    CutsceneAddActor(NPC_TAG_KETTIA, oActor);

    oActor = GetObjectInArea(NPC_TAG_PRISONER, oPC);
    CutsceneAddActor(NPC_TAG_PRISONER, oActor);

    oActor = GetObjectInArea(NPC_TAG_PIRATE1, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE1, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE2, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE2, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE3, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE3, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE4, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE4, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE5, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE5, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE7, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE7, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_WHIP, oPC);
    CutsceneAddActor(NPC_TAG_WHIP, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_BOY, oPC);
    CutsceneAddActor(NPC_TAG_BOY, oActor);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

void next0(float fTime)
{
    object oBoy = CutsceneGetActor(NPC_TAG_BOY);
    object oPC = CutsceneGetPC();
    object oPirate1 = CutsceneGetActor(NPC_TAG_PIRATE1);
    object oPirate2 = CutsceneGetActor(NPC_TAG_PIRATE2);
    object oPirate3 = CutsceneGetActor(NPC_TAG_PIRATE3);
    object oPirate4 = CutsceneGetActor(NPC_TAG_PIRATE4);
    object oPirate5 = CutsceneGetActor(NPC_TAG_PIRATE5);
    object oPirate7 = CutsceneGetActor(NPC_TAG_PIRATE7);
    object oPrisoner = CutsceneGetActor(NPC_TAG_PRISONER);
    object oWhip = CutsceneGetActor(NPC_TAG_WHIP);

    effect eGhost = EffectCutsceneGhost();

    //Start pirate crew animations
    if (fTime == 0.0)
    {
        AssignCommand(oBoy, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 50.0));
        AssignCommand(oPrisoner, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 50.0));
        AssignCommand(oPirate4, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 50.0));
        AssignCommand(oPirate7, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 50.0));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oWhip);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 15.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oWhip, SpeakString("Get up and keep walkin'!"));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oPrisoner, SpeakString("But I'm just a fisherman. I didn't know 'bout any blockade."));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oWhip, ActionAttack(oPrisoner));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oWhip, ClearAllActions(TRUE));
        AssignCommand(oPirate3, PlayVoiceChat(VOICE_CHAT_LAUGH));
        AssignCommand(oPirate3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0));
        CutsceneNext(15.0);
    }
    //Pan the camera to give view of blockade
    else if (fTime == 15.0)
    {
       AssignCommand(oWhip, ActionAttack(oPrisoner));
       CutsceneCameraSetup(-1.0, 0.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SLOW);
       CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        AssignCommand(oPirate1, PlayVoiceChat(VOICE_CHAT_YES));
        AssignCommand(oPirate1, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oWhip, ClearAllActions(TRUE));
        AssignCommand(oPirate2, SpeakString("Hey, Cap'n, there's a ship over there!"));
        AssignCommand(oPC,
            ActionForceMoveToLocation(GetLocation(GetWaypointByTag("WP_MOBL_CS_PC_JUMP")), FALSE, 4.0));
        CutsceneNext(23.0);
    }
    //Pirate crew taunt onlookers
    else if (fTime == 23.0)
    {
        AssignCommand(oPirate1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oPirate3, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oPirate5, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));

        CutsceneNext(25.0);
    }
     else if (fTime == 25.0)
    {
        AssignCommand(oPirate1, SpeakString("You'd better turn back if you want to stay afloat!"));
        AssignCommand(oPirate1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oPirate2, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oPirate5, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0));
        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        AssignCommand(oPirate1, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oPirate2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oPirate3, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oPC,
            ActionForceMoveToLocation(GetLocation(GetWaypointByTag(WP_TAG_PC_INIT)), FALSE, 4.0));
        CutsceneNext(32.0);
    }
    //Pan the camera to give view of blockade
    else if (fTime == 32.0)
    {
        CutsceneCameraSetup(-1.0, 270.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
       AssignCommand(oWhip, SpeakString("Get up and walk unless you want another lash!")) ;
       CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        AssignCommand(oPrisoner, ClearAllActions());
        AssignCommand(oPrisoner, ActionMoveAwayFromObject(oWhip));
        CutsceneNext(39.0);
    }
    else if(fTime == 39.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(40.0);
    }
    else if(fTime == 40.0)
    {
        AssignCommand(oPrisoner, PlayVoiceChat(VOICE_CHAT_DEATH));
        CutsceneNext(41.0);
    }
    else if(fTime == 41.0)
    {
        AssignCommand(oPC, PlaySound("as_na_splash1"));
        RemoveAssociateEffects(oPC);
        CutsceneNextShot();
    }
}

//Converse with Kettia
void next1(float fTime)
{
    object oKettia = CutsceneGetActor(NPC_TAG_KETTIA);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 3.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBL_CS_PC_SHIP"))));
        CutsceneNext(3.0);
    }
    //Dialog with Kettia
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        //CutsceneNextShot called from Kettia dialog
        AssignCommand(oKettia, ActionStartConversation(oPC, "", FALSE, FALSE));
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

//Clear any dialog
void abort()
{
    object oPC = CutsceneGetPC();

     AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBL_CS_PC_SHIP"))));
     AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oPC = CutsceneGetPC();
    object oPrisoner = CutsceneGetActor(NPC_TAG_PRISONER);
    object oWhip = CutsceneGetActor(NPC_TAG_WHIP);

    AssignCommand(oPC, SetCameraFacing(180.0, 15.0, 50.0));
    AssignCommand(oWhip,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBL_WHIP_JUMP"))));
    DestroyObject(oPrisoner);

    AddJournalQuestEntry("ThePirateKingsBlockade", 10, oPC);
    AddJournalQuestEntry("SoHighAPrice", 20, oPC);

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());
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
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
