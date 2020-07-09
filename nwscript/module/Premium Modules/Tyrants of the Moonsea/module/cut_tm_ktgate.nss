//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ktgate
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene at Kur-Tharsu Gate
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_spells"

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

#include "inc_ktgate"

const string NPC_TAG_CAPTAIN = "KTGateGuardCaptain";
const string NPC_TAG_GUARD1 = "KTGateGuardCatapult";
const string NPC_TAG_GUARD2 = "KTGateGuardSentry";
const string NPC_TAG_GUARD3 = "KTGateGuardOil";
const string NPC_TAG_ARCHER1 = "KurTharsuArcher1";
const string NPC_TAG_ARCHER2 = "KurTharsuArcher2";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_CAPTAIN, oPC);
    CutsceneAddActor(NPC_TAG_CAPTAIN, oActor);

    oActor = GetObjectInArea(NPC_TAG_GUARD1, oPC);
    CutsceneAddActor(NPC_TAG_GUARD1, oActor);

    oActor = GetObjectInArea(NPC_TAG_GUARD2, oPC);
    CutsceneAddActor(NPC_TAG_GUARD2, oActor);

    oActor = GetObjectInArea(NPC_TAG_GUARD3, oPC);
    CutsceneAddActor(NPC_TAG_GUARD3, oActor);

    oActor = GetObjectInArea(NPC_TAG_ARCHER1, oPC);
    CutsceneAddActor(NPC_TAG_ARCHER1, oActor);

    oActor = GetObjectInArea(NPC_TAG_ARCHER2, oPC);
    CutsceneAddActor(NPC_TAG_ARCHER2, oActor);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    CutsceneStart(TRUE, FALSE, "WP_THKTMG_CS_PC_START", FALSE);
    SetupActors(oPC);
}

// Guards prepare for battle
void next0(float fTime)
{
    object oArcher1 = CutsceneGetActor(NPC_TAG_ARCHER1);
    object oArcher2 = CutsceneGetActor(NPC_TAG_ARCHER2);
    object oCaptain = CutsceneGetActor(NPC_TAG_CAPTAIN);
    object oCatapult = CutsceneGetActor(NPC_TAG_GUARD1);
    object oOil = CutsceneGetActor(NPC_TAG_GUARD3);
    object oSentry = CutsceneGetActor(NPC_TAG_GUARD2);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
         BlackScreen(oPC);
         // position the camera (height, dir, dist, pitch)
         CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
         CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        //StopFade proved a better option to avoid a double fade from black
        //possibly being triggered by the map exit script
        StopFade(oPC);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        //Guards spot PC
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_DUR_INFERNO),
                            GetNearestObjectByTag("KTCatapultMissile", oPC),
                            30.0);
        AssignCommand(oSentry,
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 3.0));
        AssignCommand(oSentry,
            ActionSpeakString("I see dem approaching the bridge, Captain!"));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oCatapult,
            SetFacingPoint(GetPosition(GetNearestObjectByTag("KTCatapultMissile", oPC))));
        AssignCommand(oCatapult,
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 25.0));

        AssignCommand(oCaptain,
            ActionDoCommand(SetFacingPoint(GetPosition(oOil))));
        AssignCommand(oCaptain,
            ActionSpeakString("Is that oil warm?"));
        AssignCommand(oOil, ActionWait(2.0));
        AssignCommand(oOil, ActionSpeakString("Yeah, Captain."));
        AssignCommand(oCaptain, ActionWait(4.0));
        AssignCommand(oCaptain,
            ActionSpeakString("Well, 'warm' ain't hot enough! I want it scalding!"));
        AssignCommand(oCaptain, ActionWait(4.0));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oCaptain, ClearAllActions());
        AssignCommand(oCaptain,
            ActionDoCommand(SetFacingPoint(GetPosition(oCatapult))));
        AssignCommand(oCaptain, ActionWait(2.0));
        AssignCommand(oCaptain,
            ActionSpeakString("You, get that catapult loaded. Archers, take positions!"));
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        AssignCommand(oArcher1,
            ActionMoveToObject(GetWaypointByTag("WP_THKTMG_ARCHER_MOVE"), TRUE));
        AssignCommand(oArcher2,
            ActionMoveToObject(GetWaypointByTag("WP_THKTMG_ARCHER_MOVE"), TRUE));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 260.0, 2.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oCaptain, ClearAllActions());
        CutsceneNext(32.0);
    }
    else if (fTime == 32.0)
    {
        BlackScreen(oPC);
        AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTMG_CS_PC_JUMP"))));
        CutsceneNextShot();
    }
}

//Change view to beginning of bridge
void next1(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if(fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(5.0);
    }
    //Catapult fires near to PC
    else if (fTime == 5.0)
    {
        AssignCommand(GetNearestObjectByTag("KTCatapult", oPC),
            ActionCastSpellAtLocation(553,
                                      GetLocation(GetWaypointByTag("WP_THKTMG_CS_CAT")),
                                      METAMAGIC_ANY,
                                      TRUE,
                                      PROJECTILE_PATH_TYPE_BALLISTIC,
                                      TRUE));
        CutsceneNext(8.0);
    }
    else if(fTime == 8.0)
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

void abort()
{

}

void end()
{
    int nNumAllies = 0;
    int nJournalState = 0;
    int nXP;

    object oArcher1 = CutsceneGetActor(NPC_TAG_ARCHER1);
    object oArcher2 = CutsceneGetActor(NPC_TAG_ARCHER2);
    object oCaptain = CutsceneGetActor(NPC_TAG_CAPTAIN);
    object oCatapult = CutsceneGetActor(NPC_TAG_GUARD1);
    object oOil = CutsceneGetActor(NPC_TAG_GUARD3);
    object oSentry = CutsceneGetActor(NPC_TAG_GUARD2);
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTMG_CS_PC_END"))));
    AssignCommand(oPC, SetCameraFacing(90.0, 25.0, 50.0));

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());

    FadeFromBlack(oPC, FADE_SPEED_FAST);

    DestroyObject(GetNearestObjectByTag("KTCatapultMissile", oPC));
    DestroyObject(oArcher1);
    DestroyObject(oArcher2);
    DestroyObject(oCaptain);
    DestroyObject(oCatapult);
    DestroyObject(oOil);
    DestroyObject(oSentry);

    PlotLevelSet("KTBridgeMissile", 1);

    //Update Assault on Kur-Tharsu journal entry
    AddJournalQuestEntry("AssaultonKurTharsu", 30, oPC);

    //Update journal Expedition to Thar: Allies according to how many allies have been hired
    if(PlotLevelGet("Blizzard") == 10)
        nNumAllies++;
    if(PlotLevelGet("TheWrecker") == 1)
        nNumAllies++;
    if(PlotLevelGet("Elf") == 15)
        nNumAllies++;

    if(nNumAllies == 0)
    {
        //No allies hired
        nJournalState = 70;
        nXP = 0;
    }
    else if(nNumAllies < 3)
    {
        //Some but not all allies hired
        nJournalState = 60;
        nXP = GetJournalQuestExperience("TharAllies") / 2;
    }
    else
    {
        //All allies hired
        nJournalState = 50;
        nXP = GetJournalQuestExperience("TharAllies");
    }

    AddJournalQuestEntry("TharAllies", nJournalState, oPC);
    GiveXPToCreature(oPC, nXP);

    //Turn Kur-Tharsu guards hostile
    TurnHostileByTag("KTGateTroop", oPC);
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
