// cutscene: player enters voonlar with bennart waters
// outside the locktower: start a conversation

#include "hf_in_cutscene"

const string NPC_TAG_BENNART = "Bennart";
const string WP_TAG_PC_INIT = "WP_VN_CSBW_PC_START";

// spawn bennart waters into the scene
void SetupActors(object oPC)
{
    object oTarget = GetWaypointByTag("WP_Bennart_Spawn");;
    location lTarget = GetLocation(oTarget);
    object oBennart = CreateObject(OBJECT_TYPE_CREATURE, "bennart", lTarget);
    CutsceneAddActor(NPC_TAG_BENNART, oBennart);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    StopFade(oPC);
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);

    // advance the plot
    SetLocalInt(oPC, "bennartrescued", 1);

    // player no longer has bennart's body item
    object oItem = GetItemPossessedBy(oPC, "BennartWaters");
    DestroyObject(oItem);
}

// start conversation with bennart
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    object oBennart = CutsceneGetActor(NPC_TAG_BENNART);

    if (fTime == 0.0)
    {
        // give the camera some time to settle
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(2.0, 135.0, 20.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);

        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oBennart, ActionStartConversation(oPC));
    }
}

// called from conversation
void end()
{
    CutsceneEnd();
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
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        // can't abort this scene; c'mon it's just a convo
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
