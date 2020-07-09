// this is the cutscene with edalseye on top of the tower

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;

    // edalseye
    oWP = GetWaypointByTag("WP_AR1100_CUT1_EDALSEYE");
    object oEdalseye = CreateObject(OBJECT_TYPE_CREATURE, "ks_edalseye", GetLocation(oWP));
    CutsceneAddActor("ks_edalseye", oEdalseye);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(585), oEdalseye); // silver eyes

    // fake portal
    oWP = GetWaypointByTag("WP_AR1100_CUT1_PORTAL");
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
    CutsceneAddActor("ks_pl_devportal", oPortal);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    spawnActors(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR1100_CUT1_START", FALSE);
    CutsceneMusic(66);
}

// edalseye talks
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oEdalseye = CutsceneGetActor("ks_edalseye");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        object oArea = GetArea(oPC);
        ExploreAreaForPlayer(oArea, oPC, TRUE);
        SetWeather(oArea, WEATHER_RAIN);
        SetTime(16, 0, 0, 0);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_WEST, 19.0, 77.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 5.0, 65.0, CAMERA_TRANSITION_TYPE_SLOW);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        // edalseye speaks to player
        AssignCommand(oEdalseye, ActionStartConversation(oPC, "ks_ar1100_edalse", FALSE, FALSE));
    }
}

// edalseye walks to the portal and vanishes
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oEdalseye = CutsceneGetActor("ks_edalseye");

    if (fTime == 0.0)
    {
        // the wind howls
        AssignCommand(oEdalseye, PlaySound("as_wt_guststrng1"));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        object oPortal = CutsceneGetActor("ks_pl_devportal");
        AssignCommand(oEdalseye, ActionMoveToObject(oPortal, FALSE, 0.0));
        AssignCommand(oEdalseye, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneEnd();
    }
}

// edalseye is gone
void end()
{
    object oPC = GetFirstPC();
    object oEdalseye = CutsceneGetActor("ks_edalseye");
    object oPortal = CutsceneGetActor("ks_pl_devportal");
    object oDeldarine = GetObjectInArea("ks_deldarine", oPC);

    // edalseye and portal are both gone; deldarine is dead
    DestroyObject(oDeldarine);
    DestroyObject(oEdalseye);
    DestroyObject(oPortal);
    SetLocalInt(GetModule(), "nDeldarineDead", 1);

    // give the journal
    AddJournalQuestEntry("j83", 9, oPC);

    // skully has a new dialog in the bedroom
    // .. this is reset onEnter the basement
    PlotLevelSet("ks_skully", 2);

    // skully can now talk to the player
    object oWP = GetWaypointByTag("WP_AR1100_CUT1_PORTAL");
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_skully_voi", GetLocation(oWP));
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
