//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ktsummon
// DATE: January 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene in Kur-Tharsu Summoning Chamber - preparations for Orcus summon
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_plot"

#include "inc_ktgate"

const string NPC_RESREF_MAGANUS = "elventreemagn001";
const string NPC_TAG_MAGANUS = "StrongholdMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_THKTUF_CS_MAGANUS_SPAWN";

const string WP_TAG_PC_INIT = "WP_THKTUF_CS_PC_START";

const string NPC_TAG_OGRE1 = "KTOgreMage1";
const string NPC_TAG_OGRE2 = "KTOgreMage2";
const string NPC_TAG_OGRE3 = "KTOgreMage3";
const string NPC_TAG_OGRE4 = "KTOgreMage4";
const string PLC_TAG_DIRECTOR = "KTUFDirector";
const string PLC_TAG_DOOR = "KTMaganusDoor";
const string PLC_TAG_PORTAL = "OrcusPortal";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_MAGANUS, oPC);

    CutsceneAddActor(NPC_TAG_MAGANUS, oActor);

    oActor = GetNearestObjectByTag(PLC_TAG_DIRECTOR, oPC);
    CutsceneAddActor(PLC_TAG_DIRECTOR, oActor);
    oActor = GetNearestObjectByTag(PLC_TAG_DOOR, oPC);
    CutsceneAddActor(PLC_TAG_DOOR, oActor);
    oActor = GetNearestObjectByTag(PLC_TAG_PORTAL, oPC);
    CutsceneAddActor(PLC_TAG_PORTAL, oActor);
}

//Ensure visual effects have been applied
void ApplyVisualEffects()
{
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);

    //Apply visual 'black circle' effect to ogres
    SignalEvent(oDirector, EventUserDefined(4600));

    //Apply glyph effect to portal
    SignalEvent(oDirector, EventUserDefined(4601));
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    //Set home location for Shadovar Assassins inside Maganus chamber
    SetAssassinHomeLocation();
    //Signal to assassins that they should move to starting position
    SignalAssassinEvent(4700);

    CutsceneStart(TRUE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

// View ogre mages in summoning chamber
void next0(float fTime)
{
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);
    object oPC = CutsceneGetPC();
    object oPortal = CutsceneGetActor(PLC_TAG_PORTAL);

    effect eVFX;

    if (fTime == 0.0)
    {
        //give a bit of time for the camera to settle before moving it again
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        PlotLevelSet("OgreAnimation", 1);
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(2.0, 90.0, 2.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    //Close-up of Ogre Mage
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(9.0);
    }
    //A view of all four Ogre Mages beginning their summoning
    else if (fTime == 9.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 20.0, 40.0, CAMERA_TRANSITION_TYPE_SNAP);

        //Apply visual 'black circle' effect to ogres
        SignalEvent(oDirector, EventUserDefined(4600));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        //Apply small black circle effect to portal
        eVFX =  EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPortal, 4.0);
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        //Apply glyph effect to portal
        SignalEvent(oDirector, EventUserDefined(4601));
        CutsceneNextShot();
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

//Ensure relevant effects applied to ogre and portal, and clear any dialog
void abort()
{
    object oPC = CutsceneGetPC();

    SetupActors(oPC);
    ApplyVisualEffects();
    //Set home location for Shadovar Assassins inside Maganus chamber
    SetAssassinHomeLocation();
    //Signal to assassins that they should move to starting position
    SignalAssassinEvent(4700);

    PlotLevelSet("OgreAnimation", 1);
}

void end()
{
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);
    object oDoor = CutsceneGetActor(PLC_TAG_DOOR);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);

    //Set correct plot level for this tag
    PlotLevelSet(NPC_TAG_MAGANUS, 3);

    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));

    AssignCommand(oPC, SetCameraFacing(90.0, 25.0, 50.0));
    AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTUF_CS_PC_END"))));

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());

    FadeFromBlack(oPC, FADE_SPEED_FAST);
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
