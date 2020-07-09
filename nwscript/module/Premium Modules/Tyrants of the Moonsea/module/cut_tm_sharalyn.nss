//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_sharalyn
// DATE: September 5, 2005
// AUTH: Luke Scull
// NOTE: Cutcscene dialogue with Sharalyn
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string WP_TAG_PLAYER = "WP_cut_sharalyn_pc_init";

// Old Sharalyn in The Swords Meet inn
const string NPC_TAG_SHARALYN_OLD = "Sharalyn";

// New Sharalyn spawned for cutscene
const string NPC_RESREF_SHARALYN = "sharalyn001";
const string NPC_TAG_SHARALYN = "CutsceneSharalyn";
const string WP_TAG_SHARALYN_SPAWN = "WP_cut_sharalyn_shara_spawn";
const string WP_TAG_SHARALYN_EXIT = "WP_cut_sharalyn_shara_exit";

// Key for The Swords Meet upper floor
const string ITEM_TAG_INN_KEY = "item002";

// Set up followers
const string NPC_TAG_ASTAR = "Astar";
const string NPC_RESREF_ASTAR = "astar";
const string WP_TAG_ASTAR_SPAWN = "WP_Astar_Spawn";

const string NPC_TAG_EREMUTH = "Eremuth";
const string NPC_RESREF_EREMUTH = "eremuth";
const string WP_TAG_EREMUTH_SPAWN = "WP_Eremuth_Spawn";

// Footsteps tags from Voonrun cutscene (+number suffix)
const string PLC_TAG_FOOTSTEPx = "plc_cut_voonrun_footstep";

const string LVAR_QUEST_UPDATE_DONCE = "cut_sharalyn_donce";


// Quest update at shot 1 (Sharalyn gives key)
void updateQuestShot1(object oPC)
{
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, ITEM_TAG_INN_KEY)))
    {
        CreateItemOnObject(ITEM_TAG_INN_KEY, oPC, 1);
    }
}


// Quest update at shot 2
void updateQuestShot2(object oPC)
{
    object oWaypoint = OBJECT_INVALID;
    object oDoor = OBJECT_INVALID;

    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        AddJournalQuestEntry("Voonlar", 40, oPC);

        // Spawn in NPC: Astar
        oWaypoint = GetWaypointByTag(WP_TAG_ASTAR_SPAWN);
        if (!GetIsObjectValid(GetObjectByTag(NPC_TAG_ASTAR)))
            CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_ASTAR, GetLocation(oWaypoint));
        SetLocalInt(oPC, "astartrigger", 1);

        // Spawn in NPC: Eremuth
        oWaypoint = GetWaypointByTag(WP_TAG_EREMUTH_SPAWN);
        if (!GetIsObjectValid(GetObjectByTag(NPC_TAG_EREMUTH)))
            CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_EREMUTH, GetLocation(oWaypoint));
        SetLocalInt(oPC, "eremuthtrigger", 1);

        // Destroy door to the Meet (has been destroyed during the attack)
        oDoor = GetObjectByTag("Voonlar_To_TheSwordsMeet");
        if (GetIsObjectValid(oDoor))
        {
            AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE));
            DestroyObject(oDoor, 0.5);
        }
        oDoor = GetObjectByTag("TheSwordsMeet_To_Voonlar");
        if (GetIsObjectValid(oDoor))
        {
            AssignCommand(oDoor, SetLocked(OBJECT_SELF, FALSE));
            DestroyObject(oDoor, 0.5);
        }

        // Unlock Boring Pig door.
        oDoor = GetObjectByTag("Voonlar_To_TheBoringPig");
        SetLocked(oDoor, FALSE);
    }
}


// Clean up footsteps from Voonrun cutscene (cut_tm_voonrun.nss)
void cleanupFootsteps(object oPC)
{
    object oFootstepPlc = OBJECT_INVALID;
    int i = 0;

    oFootstepPlc = GetObjectByTag(PLC_TAG_FOOTSTEPx + IntToString(i));
    while (GetIsObjectValid(oFootstepPlc))
    {
        DestroyObject(oFootstepPlc);
        i++;
        oFootstepPlc = GetObjectByTag(PLC_TAG_FOOTSTEPx + IntToString(i));
    }
}


void setupActors(object oPC)
{
    object oActor;
    object oSpawnWP;

    CutsceneSpawnActor(NPC_RESREF_SHARALYN, NPC_TAG_SHARALYN, WP_TAG_SHARALYN_SPAWN);

    // Destroy old Sharalyn in The Swords Meet inn
    object oSharalynOld = GetObjectByTag(NPC_TAG_SHARALYN_OLD);
    if (GetIsObjectValid(oSharalynOld))
        DestroyObject(oSharalynOld);
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    setupActors(oPC);

    updateQuestShot1(oPC);
    updateQuestShot2(oPC);

    // Remove spawned Sharalyn
    oActor = CutsceneGetActor(NPC_TAG_SHARALYN);
    if (GetIsObjectValid(oActor))
        DestroyObject(oActor);
}


void end()
{
    object oPC = CutsceneGetPC();

    cleanupFootsteps(oPC);
    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Sharalyn spawns and initiates convo
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    // Waypoints
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oWpPlayer, FALSE));

        CutsceneCameraSetup(2.0, 215.0, 6.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oActorSharalyn, ActionMoveToObject(oWpPlayer, TRUE));
        AssignCommand(oActorSharalyn, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 1: Sharalyn gives key
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);

    if (fTime == 0.0)
    {
        AssignCommand(oActorSharalyn, ActionMoveToObject(oPC, FALSE, 0.2));
        updateQuestShot1(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime >= 1.0)
    {
        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 2: Sharalyn dissappears
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    // Waypoints
    object oWpSharalynExit = GetWaypointByTag(WP_TAG_SHARALYN_EXIT);

    if (fTime == 0.0)
    {
        updateQuestShot2(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        AssignCommand(oActorSharalyn, ClearAllActions());
        AssignCommand(oActorSharalyn, ActionMoveToObject(oWpSharalynExit, TRUE));
        DestroyObject(oActorSharalyn, 2.0);

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        CutsceneNextShot();
    }
}


// Shot 3: End Cutscene
void next3(float fTime)
{
    if (fTime >= 0.0)
    {
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
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
        if (nShot >= 3) next3(fTime);
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
