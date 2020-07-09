//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_hillsfar
// DATE: November 27, 2005
// AUTH: Luke Scull
// NOTE: Spawns in Onehand and gets him to initiate
//       dialogue with PC.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_henchman"
#include "hf_in_util"
#include "hf_in_plot"


const string NPC_RESREF_ONEHAND = "kaloronehand";
const string NPC_TAG_ONEHAND = "KalorOnehand";

const string WP_TAG_PLAYER_CITY_OUT = "WP_hfmerch_cutscene_pc_01";
const string WP_TAG_PLAYER_CITY_IN = "WP_hfmerch_cutscene_pc_02";

const string WP_TAG_ONEHAND_CITY_OUT = "WP_hfmerch_cutscene_onehand_01";
const string WP_TAG_ONEHAND_CITY_IN  = "WP_hfmerch_cutscene_onehand_02";
const string WP_TAG_ONEHAND_INN = "WP_Onehand_Diamond";

const string PLOT_HENCH_HOME = "hench_home_base";

const string LVAR_QUEST_UPDATE_DONCE = "cut_hillsfar_donce";


void setupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_ONEHAND, NPC_TAG_ONEHAND, WP_TAG_ONEHAND_CITY_OUT);
}


// Updates quests at Shot 1, dialog outside city gates is finished
void questUpdate1(object oPC)
{
    // from cac_tm_onehand 2 + 3
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, "hillsfarhenchmen", 1);
        SetLocalInt(oPC, "onehand", 1);
        AddJournalQuestEntry("OrderoftheCrippledFang", 31, oPC);
        GiveXPToCreature(oPC, 3000);
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);
    }
}


// Updates quests at Shot 2, dialog inside city gates is finished
void questUpdate2(object oPC)
{
    object oNPC = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        // cac_tm_onehand 4 + 12
        AddJournalQuestEntry("TheCityofHillsfar", 10, oPC);
        SetLocalInt(oPC, "henchmengonetoelventree", 1);

        oNPC = GetObjectByTag("Astar");
        oWaypoint = GetObjectByTag("WP_Astar_Swaying");
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        HenchmanGoHome(oNPC);

        oNPC = GetObjectByTag("Eremuth");
        oWaypoint = GetObjectByTag("WP_Eremuth_Swaying");
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        HenchmanGoHome(oNPC);

        oNPC = GetObjectByTag("Lyressa");
        oWaypoint = GetObjectByTag("WP_Lyressa_Swaying");
        HenchmanSetHome(oNPC, GetLocation(oWaypoint));
        HenchmanGoHome(oNPC);

        // Hench home variable for dialogs
        PlotLevelSet(PLOT_HENCH_HOME, 20); // 20 = Elventree

        //We don't want Lyressa's Boring Pig trigger activated if she hasn't
        //previously been hired at this point or it will reset her home location
        DestroyObject(GetObjectByTag("LyressaHomeTrigger"));

        oNPC = GetObjectByTag("InnUpstairsSharalyn");
        DestroyObject(oNPC);

        oNPC = GetObjectByTag("Raest");
        DestroyObject(oNPC);

        oNPC = GetObjectByTag("Zain");
        DestroyObject(oNPC);

        oNPC = GetObjectByTag("Thorne");
        DestroyObject(oNPC);

        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);
    }
}


void unequipWeapons(object oTarget)
{
    object oItem;

    // Right Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oTarget, ActionUnequipItem(oItem));
    }
    // Left Hand
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oTarget, ActionUnequipItem(oItem));
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


// Called when the cutscene is aborted to ensure post conditions
void abort()
{
    object oPC = CutsceneGetPC();
    setupActors(oPC);

    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    object oTargetWP = OBJECT_INVALID;

    // Quests should have been updated
    questUpdate1(oPC);
    questUpdate2(oPC);

    // Setup during a brief black screen
    BlackScreen(oPC);

    // Move player inside city
    oTargetWP = GetWaypointByTag(WP_TAG_PLAYER_CITY_IN);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oTargetWP, FALSE));

    // Move Onehand to Diamond In The Dung inn
    oTargetWP = GetWaypointByTag(WP_TAG_ONEHAND_INN);
    AssignCommand(oActorOnehand, ClearAllActions());
    AssignCommand(oActorOnehand, unequipWeapons(oActorOnehand));
    DelayCommand(0.5, AssignCommand(oActorOnehand, ActionJumpToObject(oTargetWP, FALSE)));
    DelayCommand(1.0, FadeFromBlack(oPC, FADE_SPEED_FASTEST));
}


void end()
{
    object oPC = CutsceneGetPC();

    // Don't leave any traces on PC
    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Spawn Kalor in front of City Gates and init conversation
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    // Waypoints
    object oPlayerWP = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Black screen
        setupActors(oPC);

        oPlayerWP = GetObjectInArea(WP_TAG_PLAYER_CITY_OUT, oPC);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oPlayerWP, FALSE));

        CutsceneCameraSetup(2.0, 75.0, 6.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);

        AssignCommand(oPC, PlaySound("as_dr_metllgop1"));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oPC, PlaySound("as_dr_metlmedcl1"));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorOnehand, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 1: Move Kalor inside city gates and re-init conversation
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    // Waypoints
    object oOnehandWP = OBJECT_INVALID;
    object oPlayerWP = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        questUpdate1(oPC);
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Black screen
        oPlayerWP = GetObjectInArea(WP_TAG_PLAYER_CITY_IN, oPC);
        AssignCommand(oPC, ActionJumpToObject(oPlayerWP, FALSE));

        oOnehandWP = GetObjectInArea(WP_TAG_ONEHAND_CITY_IN, oPC);
        AssignCommand(oActorOnehand, ActionJumpToObject(oOnehandWP, FALSE));

        AssignCommand(oPC, PlaySound("as_dr_metllgop1"));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oPC, PlaySound("as_dr_metlmedcl1"));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        unequipWeapons(oActorOnehand);
        DelayCommand(0.5, AssignCommand(oActorOnehand, ActionStartConversation(oPC, "", FALSE, FALSE)));

        // Called from dialog
        //CutsceneNextShot();
    }
}


// Shot 2: Move Onehand to Diamond in the Dung inn
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorOnehand = CutsceneGetActor(NPC_TAG_ONEHAND);
    //Waypoints
    object oWpOnehand = OBJECT_INVALID;

    if (fTime == 0.0)
    {
        questUpdate2(oPC);
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        oWpOnehand = GetWaypointByTag(WP_TAG_ONEHAND_INN);
        AssignCommand(oActorOnehand, ClearAllActions());
        AssignCommand(oActorOnehand, ActionJumpToObject(oWpOnehand, FALSE));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNextShot();
    }
}


// Shot 3: Ends the cutscene
void next3(float fTime)
{
    if (fTime == 0.0)
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
