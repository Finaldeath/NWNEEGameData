//Cutscene to play a game of 21 in the Gate of Good Fortune

#include "hf_in_cutscene"
#include "hf_in_util"

const string NPC_TAG_CROUPIER = "Croupier3";
const string PLC_TAG_CROUPIER = "Croupier4";

const string WP_TAG_PC_INIT = "WP_MULGG_CS_PC";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(PLC_TAG_CROUPIER, oPC);
    CutsceneAddActor(PLC_TAG_CROUPIER, oActor);
    oActor = GetObjectInArea(NPC_TAG_CROUPIER, oPC);
    CutsceneAddActor(NPC_TAG_CROUPIER, oActor);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

// Avagard speaks with PC
void next0(float fTime)
{
    object oCroupier = CutsceneGetActor(NPC_TAG_CROUPIER);
    object oCroupierPlc = CutsceneGetActor(PLC_TAG_CROUPIER);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(1.0, 0.0, 3.0, 15.0, CAMERA_TRANSITION_TYPE_SNAP);
        SetLocalInt(oCroupier, "HF_DISABLE_AM", 1);
        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)));
        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        //CutsceneNextShot called from Croupier placeable dialog
        AssignCommand(oCroupierPlc, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
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

    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oCroupier = CutsceneGetActor(NPC_TAG_CROUPIER);
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(0.0, 25.0, 50.0));

    SetLocalInt(oCroupier, "HF_DISABLE_AM", 0);

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
