//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_merrik
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue with Merrik
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_RESREF_MERRIK = "merrik001";
const string NPC_TAG_MERRIK = "IyraurothMerrik";
const string WP_TAG_MERRIK_INIT = "WP_THID_CS_MERRIK_SPAWN";
const string WP_TAG_MERRIK_MOVE = "WP_THID_CS_MERRIK_MOVE";

const string NPC_TAG_OFFICER = "IyraurothZhentarimOfficer";
const string WP_TAG_OFFICER_INIT = "WP_THID_CS_OFFICER_JUMP";

const string NPC_TAG_ZHENT1 = "IyraurothZhentFighter1";
const string WP_TAG_ZHENT1_INIT = "WP_THID_CS_ZHENT1_JUMP";

const string NPC_TAG_ZHENT2 = "IyraurothZhentFighter2";
const string WP_TAG_ZHENT2_INIT = "WP_THID_CS_ZHENT2_JUMP";

const string NPC_TAG_ZHENT3 = "IyraurothZhentFighter3";
const string WP_TAG_ZHENT3_INIT = "WP_THID_CS_ZHENT3_JUMP";

const string NPC_TAG_ZHENT4 = "IyraurothZhentFighter4";
const string WP_TAG_ZHENT4_INIT = "WP_THID_CS_ZHENT4_JUMP";

const string NPC_TAG_PRIEST1 = "PriestofBane1";
const string NPC_TAG_PRIEST2 = "PriestofBane2";
const string NPC_TAG_MAGE1 = "IyraurothZhentarimMage1";
const string NPC_TAG_MAGE2 = "IyraurothZhentarimMage2";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_OFFICER, oPC);
    CutsceneAddActor(NPC_TAG_OFFICER, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZHENT1, oPC);
    CutsceneAddActor(NPC_TAG_ZHENT1, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZHENT2, oPC);
    CutsceneAddActor(NPC_TAG_ZHENT2, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZHENT3, oPC);
    CutsceneAddActor(NPC_TAG_ZHENT3, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZHENT4, oPC);
    CutsceneAddActor(NPC_TAG_ZHENT4, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_PRIEST1, oPC);
    CutsceneAddActor(NPC_TAG_PRIEST1, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_PRIEST2, oPC);
    CutsceneAddActor(NPC_TAG_PRIEST2, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_MAGE1, oPC);
    CutsceneAddActor(NPC_TAG_MAGE1, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_MAGE2, oPC);
    CutsceneAddActor(NPC_TAG_MAGE2, oActor);

    CutsceneSpawnActor(NPC_RESREF_MERRIK, NPC_TAG_MERRIK, WP_TAG_MERRIK_INIT);
}

void MoveActor(object oCreature)
{
    object oPC = CutsceneGetPC();

    SetLocalInt(oCreature, "HF_DISABLE_AM", 1);
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oCreature);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oCreature);
    SetIsTemporaryFriend(oPC, oCreature);

    AssignCommand(oCreature, ClearAllActions());
    AssignCommand(oCreature,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_THIL_" + GetTag(oCreature)))));
}

//Move Zhents to Iyrauroth's Lair
void MoveActors()
{
    object oMerrik = CutsceneGetActor(NPC_TAG_MERRIK);
    object oZhent1 = CutsceneGetActor(NPC_TAG_ZHENT1);
    object oZhent2 = CutsceneGetActor(NPC_TAG_ZHENT2);
    object oZhent3 = CutsceneGetActor(NPC_TAG_ZHENT3);
    object oZhent4 = CutsceneGetActor(NPC_TAG_ZHENT4);
    object oPriest1 = CutsceneGetActor(NPC_TAG_PRIEST1);
    object oPriest2 = CutsceneGetActor(NPC_TAG_PRIEST2);
    object oMage1 = CutsceneGetActor(NPC_TAG_MAGE1);
    object oMage2 = CutsceneGetActor(NPC_TAG_MAGE2);

    MoveActor(oMerrik);
    MoveActor(oZhent1);
    MoveActor(oZhent2);
    MoveActor(oZhent3);
    MoveActor(oZhent4);
    MoveActor(oPriest1);
    MoveActor(oPriest2);
    MoveActor(oMage1);
    MoveActor(oMage2);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_THID_CS2_PC_START", FALSE);
    SetupActors(oPC);
}

// Merrik arrives in camp
void next0(float fTime)
{
    object oMerrik = CutsceneGetActor(NPC_TAG_MERRIK);
    object oOfficer = CutsceneGetActor(NPC_TAG_OFFICER);
    object oZhent1 = CutsceneGetActor(NPC_TAG_ZHENT1);
    object oZhent2 = CutsceneGetActor(NPC_TAG_ZHENT2);
    object oZhent3 = CutsceneGetActor(NPC_TAG_ZHENT3);
    object oZhent4 = CutsceneGetActor(NPC_TAG_ZHENT4);
    object oPriest1 = CutsceneGetActor(NPC_TAG_PRIEST1);
    object oPriest2 = CutsceneGetActor(NPC_TAG_PRIEST2);
    object oMage1 = CutsceneGetActor(NPC_TAG_MAGE1);
    object oMage2 = CutsceneGetActor(NPC_TAG_MAGE2);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        //Switch off ambient behaviour and waypoint walking
        SetLocalInt(oZhent3, "HF_DISABLE_AM", 1);
        SetLocalInt(oZhent4, "HF_DISABLE_AM", 1);
        SetLocalInt(oPriest1, "HF_DISABLE_AM", 1);
        SetLocalInt(oPriest2, "HF_DISABLE_AM", 1);
        SetLocalInt(oMage1, "HF_DISABLE_AM", 1);
        SetLocalInt(oMage2, "HF_DISABLE_AM", 1);

        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oZhent1);
        SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oZhent1);
        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oZhent2);
        SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oZhent2);

        AssignCommand(oZhent1, ClearAllActions());
        AssignCommand(oZhent2, ClearAllActions());
        AssignCommand(oZhent3, ClearAllActions());
        AssignCommand(oZhent4, ClearAllActions());
        AssignCommand(oPriest1, ClearAllActions());
        AssignCommand(oPriest2, ClearAllActions());
        AssignCommand(oMage1, ClearAllActions());
        AssignCommand(oMage2, ClearAllActions());

        AssignCommand(oZhent1,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_ZHENT1_INIT))));
        AssignCommand(oZhent2,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_ZHENT2_INIT))));
        AssignCommand(oZhent3,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_ZHENT3_INIT))));
        AssignCommand(oZhent4,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_ZHENT4_INIT))));
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 2.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        //Guards spot Merrik coming towards camp
        AssignCommand(oPC, PlaySound("vs_mzhent1_001"));
        AssignCommand(oZhent1,
            ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 3.0));
        AssignCommand(oZhent2,
            ActionSpeakString("Something's coming!"));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oZhent1,
            ActionDoCommand(SetFacingPoint(GetPosition(oOfficer))));
        AssignCommand(oPC, PlaySound("vs_mzhent1_002"));
        AssignCommand(oZhent1,
            ActionSpeakString("Captain, come quickly!"));
        AssignCommand(oZhent1, ActionWait(2.0));
        AssignCommand(oZhent1, ActionDoCommand(SetFacing(90.0)));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 2.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);

        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oOfficer);
        SetWalkCondition(NW_WALK_FLAG_INITIALIZED, FALSE, oOfficer);
        AssignCommand(oOfficer, ClearAllActions());
        AssignCommand(oOfficer,
            JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_OFFICER_INIT))));
        AssignCommand(oMerrik,
            ActionForceMoveToObject(GetWaypointByTag(WP_TAG_MERRIK_MOVE), TRUE, 0.25, 5.0));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 15.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        RemoveAssociateEffects(oPC);
        //CutsceneNextShot() invoked from Merrik conversation
        AssignCommand(oMerrik, ActionStartConversation(oPC, "", FALSE, FALSE));
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

//Ensure Merrik dialog aborted
void abort()
{
    object oMerrik = CutsceneGetActor(NPC_TAG_MERRIK);
    object oPC = CutsceneGetPC();

    AssignCommand(oMerrik, ClearAllActions());
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oOfficer = CutsceneGetActor(NPC_TAG_OFFICER);
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    AssignCommand(oPC, SetCameraFacing(90.0, 25.0, 50.0));

    //Set appropriate plot flags for dialog
    PlotLevelSet(NPC_TAG_OFFICER, 2);
    PlotLevelSet(NPC_TAG_MERRIK, 2);
    PlotLevelSet(NPC_TAG_ZHENT1, 1);
    PlotLevelSet(NPC_TAG_ZHENT2, 1);
    PlotLevelSet(NPC_TAG_ZHENT3, 1);
    PlotLevelSet(NPC_TAG_ZHENT4, 1);
    PlotLevelSet(NPC_TAG_PRIEST1, 1);
    PlotLevelSet(NPC_TAG_PRIEST2, 1);
    PlotLevelSet(NPC_TAG_MAGE1, 1);
    PlotLevelSet(NPC_TAG_MAGE2, 1);

    SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oOfficer);

    //Move Zhents to Iyrauroth's Lair
    MoveActors();

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());

    FadeFromBlack(oPC, FADE_SPEED_SLOW);
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
