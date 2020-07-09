// this is the cutscene where the cleric opens a portal to Umgatlik's Realm

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_npc"
#include "hf_in_graphics"
#include "hf_in_plot"
#include "hf_in_util"

// create the NPCs
void spawnNPCs(object oPC)
{
    object oWP1 = GetWaypointByTag("WP_AR2104_CUT1_GUMBRIL");
    object oGumbril = CreateObject(OBJECT_TYPE_CREATURE, "ks_gumbril", GetLocation(oWP1));
    CutsceneAddActor("ks_gumbril", oGumbril);

    object oWP2 = GetWaypointByTag("WP_AR2104_CUT1_JARED");
    object oJared = GetObjectInArea("ks_jared", oPC);
    if (!GetIsObjectValid(oJared))
    {
        oJared = CreateObject(OBJECT_TYPE_CREATURE, "ks_jared", GetLocation(oWP2));
    }
    else
    {
        AssignCommand(oJared, ClearAllActions());
        AssignCommand(oJared, ActionJumpToObject(oWP2, FALSE));
    }
    CutsceneAddActor("ks_jared", oJared);
    PlotLevelSet("ks_jared", 5);

    object oWP3 = GetWaypointByTag("WP_AR2104_CUT1_VETRIXIA");
    object oVetrixia = GetObjectInArea("ks_vetrixia", oPC);
    if (!GetIsObjectValid(oVetrixia))
    {
        oVetrixia = CreateObject(OBJECT_TYPE_CREATURE, "ks_vetrixia", GetLocation(oWP3));
    }
    else
    {
        AssignCommand(oVetrixia, ClearAllActions());
        AssignCommand(oVetrixia, ActionJumpToObject(oWP3, FALSE));
    }
    CutsceneAddActor("ks_vetrixia", oVetrixia);
    PlotLevelSet("ks_vetrixia", 5);

    int i = 0;
    object oWP = GetObjectByTag("WP_AR2104_CUT1_WORKER", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_CREATURE, "ks_dig_worker", GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR2104_CUT1_WORKER", ++i);
    }
}

// spawn succubae
void spawnSuccubae(object oPC, int nHostile=FALSE)
{
    object oSuc1 = GetObjectInArea("ks_dig_suc", oPC, 1);
    if (!GetIsObjectValid(oSuc1))
    {
        object oWP1 = GetWaypointByTag("WP_AR2104_CUT1_SUC1");
        location lLoc1 = GetLocation(oWP1);
        oSuc1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_dig_suc", lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), lLoc1);
        SpawnLevelupCreature(oSuc1, SpawnGetPartyCR(oPC, 50));
        CutsceneAddActor("ks_dig_suc1", oSuc1);
    }

    object oSuc2 = GetObjectInArea("ks_dig_suc", oPC, 2);
    if (!GetIsObjectValid(oSuc2))
    {
        object oWP2 = GetWaypointByTag("WP_AR2104_CUT1_SUC2");
        location lLoc2 = GetLocation(oWP2);
        oSuc2 = CreateObject(OBJECT_TYPE_CREATURE, "ks_dig_suc", lLoc2);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), lLoc2);
        SpawnLevelupCreature(oSuc2, SpawnGetPartyCR(oPC, 50));
        CutsceneAddActor("ks_dig_suc2", oSuc2);
    }

    if (nHostile == TRUE)
    {
        ChangeToStandardFaction(oSuc1, STANDARD_FACTION_HOSTILE);
        ChangeToStandardFaction(oSuc2, STANDARD_FACTION_HOSTILE);
    }
}

// create the portal
object spawnPortal(object oPC, int nActive=FALSE)
{
    object oPortal = GetObjectInArea("ks_dig_portal", oPC);
    if (!GetIsObjectValid(oPortal))
    {
        object oWP = GetWaypointByTag("WP_AR2104_CUT1_PORTAL");
        location lLoc = GetLocation(oWP);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMONDRAGON), lLoc);
        oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_dig_potal", lLoc);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR), oPortal);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_15), oPortal);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD), oPortal);
        DrawCircle(lLoc, 4.0, VFX_IMP_NEGATIVE_ENERGY);
    }
    SetLocalInt(oPortal, "nActive", nActive);
    return(oPortal);
}

// scare the workers
void scareWorkers(object oPC, object oNPC)
{
    int i = 1;
    object o = GetObjectInArea("ks_dig_worker", oPC, i);
    while (GetIsObjectValid(o))
    {
        if (oNPC != OBJECT_INVALID)
        {
            AssignCommand(o, ClearAllActions());
            AssignCommand(o, SetFacingPoint(GetPosition(oNPC)));
        }
        SetLocalInt(o, "HF_ATTR_LAZY", 1);
        o = GetObjectInArea("ks_dig_worker", oPC, ++i);
    }
}

// lock the shrine doors
void LockShrineDoors(object oPC)
{
    object oDoors = GetObjectByTag("dt_dig_exit");
    if (GetIsOpen(oDoors))
        AssignCommand(oDoors, ActionCloseDoor(oDoors));
    if (!GetLocked(oDoors))
        SetLocked(oDoors, TRUE);
}

// teleport the player's followers to a waypoint
void TeleportFollowers(object oPC, string sWP)
{
    object oWP = GetObjectByTag(sWP);
    location lLoc = GetLocation(oWP);

    // move all party members
    object oParty = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        AssignCommand(oParty, ClearAllActions(TRUE));
        AssignCommand(oParty, JumpToLocation(lLoc));
        oParty = GetNextFactionMember(oPC, TRUE);
    }

    // move all non-party members such as familiars
    oParty = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        AssignCommand(oParty, ClearAllActions(TRUE));
        AssignCommand(oParty, JumpToLocation(lLoc));
        oParty = GetNextFactionMember(oPC, FALSE);
    }
}

// move to position and start the scene
void start()
{
    object oPC = GetFirstPC();
    TeleportToWaypoint(oPC, "WP_AR2104_CUT1_START", FALSE);
    DelayCommand(1.0, CutsceneStart(FALSE, FALSE, "WP_AR2104_CUT1_START"));
}

// set the camera
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        spawnNPCs(oPC);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, 225.0, 3.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNextShot();
    }
}

// gumbril talks
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oGumbril = CutsceneGetActor("ks_gumbril");

    if (fTime == 0.0)
    {
        AssignCommand(oGumbril, ActionStartConversation(oPC, "", FALSE, FALSE));
        // next shot is given by a dialog event
    }
}

// vetrixia starts the ritual and dies
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oVetrixia = CutsceneGetActor("ks_vetrixia");
    object oJared = CutsceneGetActor("ks_jared");
    object oSuc1 = CutsceneGetActor("ks_dig_suc1");
    object oSuc2 = CutsceneGetActor("ks_dig_suc2");
    object oGumbril = CutsceneGetActor("ks_gumbril");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, 280.0, 15.0, 50.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oVetrixia, PlaySound("vs_fkillerf_haha"));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oVetrixia, ActionSpeakString(q+"Come to me, great Umgatlik!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 7.0));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oJared, ActionSpeakString(q+"Vetrixia, stop this madness!"+q));
        AssignCommand(oJared, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        LockShrineDoors(oPC);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oVetrixia, ActionSpeakString(q+"Awaken from your slumber, great Umgatlik!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 3.0));
        spawnPortal(oPC);
        scareWorkers(oPC, oVetrixia);
        object oArea = GetArea(oPC);
        SetFogAmount(FOG_TYPE_ALL, 25, oArea);
        SetFogColor(FOG_TYPE_ALL, FOG_COLOR_RED_DARK, oArea);
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oGumbril, ActionSpeakString(q+"Oh dear me! What's going on?"+q));
        spawnSuccubae(oPC);
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        AssignCommand(oSuc1, ActionSpeakString(q+"At last! We are free! The portal is open!"+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc1);
        AssignCommand(oSuc1, PlaySound("c_succubus_atk1"));
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oSuc2, ActionSpeakString(q+"She has opened Umgatlik's sacred portal!"+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc2);
        AssignCommand(oSuc2, PlaySound("c_succubus_atk2"));
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        AssignCommand(oSuc1, ActionSpeakString(q+"Then she shall become Umgatlik's first victim!"+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc1);
        AssignCommand(oSuc1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oSuc2, PlaySound("c_succubus_atk1"));
        AssignCommand(oSuc2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        AssignCommand(oSuc1, PlaySound("vs_chant_necr_hf"));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR), oSuc1, 4.0);
        AssignCommand(oSuc1, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0));
        AssignCommand(oSuc2, PlaySound("vs_chant_necr_hf"));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR), oSuc2, 4.0);
        AssignCommand(oSuc2, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0));
        AssignCommand(oVetrixia, ActionSpeakString(q+"What? No!"+q));
        AssignCommand(oVetrixia, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0));
        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        effect eBeam1 = EffectBeam(VFX_BEAM_EVIL, oSuc1, BODY_NODE_HAND);
        effect eBeam2 = EffectBeam(VFX_BEAM_EVIL, oSuc2, BODY_NODE_HAND);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam1, oVetrixia, 1.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam2, oVetrixia, 1.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE), oVetrixia, 1.5);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLOW), oVetrixia);
        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        location lLoc = GetLocation(oVetrixia);
        DrawLineVert(lLoc, VFX_IMP_DESTRUCTION);
        CutsceneNext(37.5);
    }
    else if (fTime == 37.5)
    {
        SetPlotFlag(oVetrixia, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE), oVetrixia);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oVetrixia);
        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc1);
        AssignCommand(oSuc1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc2);
        AssignCommand(oSuc2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        CutsceneNextShot();
    }
}

void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oSuc1 = CutsceneGetActor("ks_dig_suc1");
    object oSuc2 = CutsceneGetActor("ks_dig_suc2");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, 280.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oSuc1, ActionSpeakString(q+"Sister, we must complete the ritual by striking a bone against Umgatlik's altar."+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc1);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oSuc2, ActionSpeakString(q+"Perhaps those mortals have bones hidden beneath their pale flesh!"+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc2);
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        AssignCommand(oSuc1, ActionSpeakString(q+"Come, sweet sister, let us tear the flesh from their bones!"+q));
        AssignCommand(oSuc1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc1);
        AssignCommand(oSuc1, PlaySound("vs_fkillerf_haha"));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSuc2);
        AssignCommand(oSuc2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oSuc2, PlaySound("vs_fkillerf_haha"));
        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        CutsceneEnd();
    }
}

// Vetrixia is dead, portal is open, succubae are hostile
void end()
{
    object oPC = GetFirstPC();
    object oSuc1 = CutsceneGetActor("ks_dig_suc1");
    object oSuc2 = CutsceneGetActor("ks_dig_suc2");
    object oVetrixia = CutsceneGetActor("ks_vetrixia");
    object oJared = CutsceneGetActor("ks_jared");
    object oGumbril = CutsceneGetActor("ks_gumbril");

    // vetrixia is dead
    if (!GetIsDead(oVetrixia))
    {
        SetPlotFlag(oVetrixia, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oVetrixia);
    }

    // jared can fight now
    SetPlotFlag(oJared, FALSE);

    // succubae exist and go hostile
    spawnSuccubae(oPC, TRUE);

    // portal is created and activated
    object oPortal = spawnPortal(oPC, TRUE);

    // gumbril is now moaning in despair
    PlotLevelSet("ks_gumbril", 1);
    AssignCommand(oGumbril, ClearAllActions());

    // workers are scared now; this stops them from digging
    scareWorkers(oPC, oPortal);

    // make sure that the player's henchmen are inside the room
    LockShrineDoors(oPC);
    TeleportFollowers(oPC, "WP_AR2104_CUT1_START");
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
        if (nShot == 3) next3(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        //Allow cutscene abort once Gumbril's conversation complete
        if(nShot > 1)
        {
            CutsceneEnd();
        }
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
