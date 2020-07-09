// this is the cutscene in in Gill's Hill where the lizardfolk
// .. raid the town

#include "hf_in_cutscene"
#include "hf_in_util"

// equip a torch if it is night
void EquipTorch(object oNPC)
{
    if (GetIsNight())
    {
        object oTorch = CreateItemOnObject("NW_IT_TORCH001", oNPC, 1);
        AssignCommand(oNPC, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    }
}

// remove invis effect
void removeEffects(object oTarget)
{
    effect e = GetFirstEffect(oTarget);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(oTarget, e);
        e = GetNextEffect(oTarget);
    }
}

// hide the town NPCs
void hideNPCs(object oPC)
{
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    object oJouka = GetObjectInArea("ac_jouka", oPC);
    if (GetIsObjectValid(oJouka))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oJouka, 60.0);
    }
    object oEFarmer = GetObjectInArea("ac_elderlyfarmer", oPC);
    if (GetIsObjectValid(oEFarmer))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oEFarmer, 60.0);
    }
    object oYFarmer = GetObjectInArea("ac_youngfarmer", oPC);
    if (GetIsObjectValid(oYFarmer))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oYFarmer, 60.0);
    }
    object oWFarmer = GetObjectInArea("ac_farmerswife", oPC);
    if (GetIsObjectValid(oWFarmer))
    {
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oWFarmer, 60.0);
    }
}

// unhide the town NPCs
void unhideNPCs(object oPC)
{
    object oJouka = GetObjectInArea("ac_jouka", oPC);
    if (GetIsObjectValid(oJouka))
    {
        removeEffects(oJouka);
    }
    object oEFarmer = GetObjectInArea("ac_elderlyfarmer", oPC);
    if (GetIsObjectValid(oEFarmer))
    {
        removeEffects(oEFarmer);
    }
    object oYFarmer = GetObjectInArea("ac_youngfarmer", oPC);
    if (GetIsObjectValid(oYFarmer))
    {
        removeEffects(oYFarmer);
    }
    object oWFarmer = GetObjectInArea("ac_farmerswife", oPC);
    if (GetIsObjectValid(oWFarmer))
    {
        removeEffects(oWFarmer);
    }
}

// spawn the NPCs used in the cutscene
void spawnNPCs(object oPC)
{
    object oWP;

    // spawn a copy of jouka to use in the scene
    oWP = GetWaypointByTag("WP_AR1000_CUT2_JOUKA");
    object oJouka = CreateObject(OBJECT_TYPE_CREATURE, "ac_jouka", GetLocation(oWP), FALSE, "_jouka");
    CutsceneAddActor("ac_jouka", oJouka);
    EquipTorch(oJouka);
    SetLocalInt(oJouka, "HF_DISABLE_AM", 1);

    // spawn some lizards
    int i;
    for (i=1; i<=5; i++)
    {
        string sTag = "ks_lizman" + IntToString(i);
        object oWP = GetWaypointByTag("WP_AR1000_CUT2_LIZARD_0_" + IntToString(i));
        object oLiz1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_lizman1", GetLocation(oWP), FALSE, sTag);
        SetLocalInt(oLiz1, "HF_DISABLE_AM", 1);
        CutsceneAddActor(sTag, oLiz1);
        ChangeToStandardFaction(oLiz1, STANDARD_FACTION_COMMONER);
        AssignCommand(oLiz1, ActionEquipMostDamagingMelee());
    }
}

// move the lizard mass to a set of waypoints
void lizardsMoveTo(int n)
{
    string sDest = "WP_AR1000_CUT2_LIZARD_" + IntToString(n) + "_";
    int i;
    for (i=1; i<=5; i++)
    {
        string sTag = "ks_lizman" + IntToString(i);
        object oDest = GetWaypointByTag(sDest + IntToString(i));
        object oLiz = CutsceneGetActor(sTag);
        AssignCommand(oLiz, ActionMoveToObject(oDest, TRUE));
    }
}

// play some random lizard hissing
void lizardHiss(object oPC)
{
    string sSnd;
    int n = d4();
    if      (n == 1) sSnd = "c_lizardm_bat1";
    else if (n == 2) sSnd = "c_lizardm_bat2";
    else if (n == 3) sSnd = "c_lizardm_atk1";
    else if (n == 4) sSnd = "c_lizardm_atk2";
    AssignCommand(oPC, PlaySound(sSnd));
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1000_CUT2_START");
    CutsceneMusic(TRACK_BATTLE_LIZARDBOSS);
    hideNPCs(oPC);
    spawnNPCs(oPC);
}

// jouka is lurking around town happy as a clam
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oJouka = CutsceneGetActor("ac_jouka");

    if (fTime == 0.0)
    {
        // allow the camera to settle down a bit
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // set camera angle
        CutsceneCameraSetup(-1.0, 110.0, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 110.0, 18.0, 70.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        FadeFromBlack(oPC);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        CutsceneNextShot();
    }
}

// lizards rampage thru town
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oJouka = CutsceneGetActor("ac_jouka");

    if (fTime == 0.0)
    {
        AssignCommand(oJouka, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        lizardHiss(oPC);
        lizardsMoveTo(1);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oJouka, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 20.0));
        lizardHiss(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        lizardHiss(oPC);
        lizardsMoveTo(2);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        lizardHiss(oPC);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        lizardHiss(oPC);
        lizardsMoveTo(3);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        lizardHiss(oPC);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        CutsceneEnd();
    }
}

// destroy the lizards and unhide the town NPCs
void end()
{
    object oPC = GetFirstPC();
    object oJouka = CutsceneGetActor("ac_jouka");

    // destroy the cutscene-version of jouka
    DestroyObject(oJouka);

    // destroy the lizards
    int i;
    for (i=1; i<=5; i++)
    {
        string sTag = "ks_lizman" + IntToString(i);
        object oLiz = CutsceneGetActor(sTag);
        DestroyObject(oLiz);
    }

    // unhide the NPCs
    unhideNPCs(oPC);
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
