//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_voonrun
// DATE: September 1, 2005
// AUTH: Luke Scull
// NOTE: Voonlar "Order Attacks" cutscene.
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

#include "nw_i0_generic"

const string NPC_RESREF_BALOR = "demon001";
const string NPC_TAG_BALOR = "VoonlarBalor";
const string WP_TAG_BALOR_SPAWN = "WP_cut_voonrun_balor_spawn";
const string WP_TAG_BALOR_MOVE = "WP_cut_voonrun_balor_move";

const string NPC_TAG_BRON = "TheBron";
const string WP_TAG_BRON_PRONE = "WP_cut_voonrun_bron_prone";

const string NPC_TAG_ZHENTMAGE = "VoonlarZhentarimMage";
const string NPC_TAG_MADOC = "MadoctheUncouthInn";
const string NPC_TAG_GORMSTADD = "Gormstadd";

const string WP_TAG_PLAYER = "WP_cut_voonrun_pc_init";

// Spawn footstep placeables pointing towards Bane temple
const string WP_TAG_FOOTSTEPx = "WP_cut_voonrun_footstep";
const string PLC_TAG_FOOTSTEPx = "plc_cut_voonrun_footstep";

// Enable trigger with message pointing to Bane temple
const string TRG_TAG_TEMPLE_HINT = "trg_voonlar_hint_to_temple";


void updateQuest(object oPC)
{
    AddJournalQuestEntry("Voonlar", 30, oPC);
    SetLocalInt(oPC, "nobronfollow", 0);
}


// Add footstep placeables and activate triggers
void setupFootsteps(object oPC)
{
    object oWaypoint = OBJECT_INVALID;
    int i = 0;

    oWaypoint = GetWaypointByTag(WP_TAG_FOOTSTEPx + IntToString(i));
    while (GetIsObjectValid(oWaypoint))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, "tm_pl_tracks_ns", GetLocation(oWaypoint), FALSE, PLC_TAG_FOOTSTEPx+IntToString(i));
        i++;
        oWaypoint = GetWaypointByTag(WP_TAG_FOOTSTEPx + IntToString(i));
    }

    // Enable flavor text/hint pointing to voonlar temple
    SetLocalInt(GetObjectByTag(TRG_TAG_TEMPLE_HINT), "nDone", 0);
}


void setupActors(object oPC)
{
    object oActor;

    oActor = GetNearestObjectByTag(NPC_TAG_MADOC, oPC);
    CutsceneAddActor(NPC_TAG_MADOC, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_GORMSTADD, oPC);
    CutsceneAddActor(NPC_TAG_GORMSTADD, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ZHENTMAGE, oPC);
    CutsceneAddActor(NPC_TAG_ZHENTMAGE, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_BRON, oPC);
    CutsceneAddActor(NPC_TAG_BRON, oActor);

    CutsceneSpawnActor(NPC_RESREF_BALOR, NPC_TAG_BALOR, WP_TAG_BALOR_SPAWN);
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


// Called when the cutscene is aborted by the player to ensure post-conditions
void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    setupActors(oPC);

    // Ensure Madoc is dead
    oActor = CutsceneGetActor(NPC_TAG_MADOC);
    if (GetIsObjectValid(oActor))
    {
        SetPlotFlag(oActor, FALSE);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE, TRUE), oActor));
    }

    // Lock the door to The Swords Meet
    object oDoor = GetObjectByTag("Voonlar_To_TheSwordsMeet");
    AssignCommand(oDoor, ActionCloseDoor(OBJECT_SELF));
    DelayCommand(0.5, SetLocked(oDoor, TRUE));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActorBalor = CutsceneGetActor(NPC_TAG_BALOR);
    object oActorBron = CutsceneGetActor(NPC_TAG_BRON);
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    object oActorZhentMage = CutsceneGetActor(NPC_TAG_ZHENTMAGE);

    updateQuest(oPC);
    setupFootsteps(oPC);

    // Clear actions of the Bron (else he might continue lying on the ground)
    oActorBron = CutsceneGetActor(NPC_TAG_BRON);
    AssignCommand(oActorBron, ClearAllActions());

    // Remove Plot flags
    SetPlotFlag(oActorGormstadd, FALSE);
    SetPlotFlag(oActorZhentMage, FALSE);
    //Update guard dialogs
    PlotLevelSet("VoonlarGuards", 1);
    // Balor attacks
    // (target Zhent Mage instead of PC, too many other NPC getting in the way)
    ChangeToStandardFaction(oActorBalor, STANDARD_FACTION_HOSTILE);
    AssignCommand(oActorBalor, DetermineCombatRound(oActorZhentMage));
    // Follow up events, after cutscene
    DelayCommand(1.0, ExecuteScript("exe_tm_fiendspwn", oPC));
}


// Shot 0:  Madoc boasts after player defeats The Bron
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMadoc = CutsceneGetActor(NPC_TAG_MADOC);
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    object oActorZhentMage = CutsceneGetActor(NPC_TAG_ZHENTMAGE);
    object oActorBron = CutsceneGetActor(NPC_TAG_BRON);
    // Waypoints
    object oWpBron = GetWaypointByTag(WP_TAG_BRON_PRONE);
    object oWpPlayer = GetWaypointByTag(WP_TAG_PLAYER);

    object oDoorTheSwordsMeet;

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);
        MusicBattleStop(GetArea(oPC));
        AssignCommand(oPC, ClearAllActions(TRUE));

        // Lock the door to The Swords Meet
        oDoorTheSwordsMeet = GetObjectByTag("Voonlar_To_TheSwordsMeet");
        AssignCommand(oDoorTheSwordsMeet, ActionCloseDoor(OBJECT_SELF));
        DelayCommand(0.5, SetLocked(oDoorTheSwordsMeet, TRUE));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, ActionJumpToObject(oWpPlayer, FALSE));
        CutsceneCameraSetup(0.0, 291.0, 5.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        AssignCommand(oActorMadoc, SetFacing(DIRECTION_EAST));
        AssignCommand(oActorBron, ClearAllActions(TRUE));
        AssignCommand(oActorBron, ActionJumpToObject(oWpBron, FALSE));
        AssignCommand(oActorBron, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 90.0));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorMadoc, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
        AssignCommand(oActorMadoc, SpeakString("Ye did it! I'm going to live!"));
        AssignCommand(oPC, PlaySound("vs_madoc_063"));

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oActorMadoc, PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0));
        AssignCommand(oActorMadoc, SpeakString("I knew ye'd beat him! Har har! Ten thousand gold, and ye were worth every piece!"));
        AssignCommand(oPC, PlaySound("vs_madoc_064"));

        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
        AssignCommand(oActorGormstadd, SpeakString("Someone please kill him."));
        AssignCommand(oPC, PlaySound("vs_gormstadd_006"));

        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oActorMadoc, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 4.0));
        AssignCommand(oActorMadoc, SpeakString("What?! But the Bron agreed..."));
        AssignCommand(oPC, PlaySound("vs_madoc_065"));

        CutsceneNext(21.0);
    }
    else if (fTime == 21.0)
    {
        AssignCommand(oActorZhentMage, ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING, oActorMadoc, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oActorGormstadd, SetFacingPoint(GetPosition(oActorMadoc)));
        AssignCommand(oActorMadoc, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 3.5));

        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        SetPlotFlag(oActorMadoc, FALSE);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE, TRUE), oActorMadoc));

        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        AssignCommand(oActorGormstadd, SpeakString("The Bron agreed to let you go, aye. The Zhentarim won't be requiring your services any longer. Farewell, Madoc."));
        AssignCommand(oPC, PlaySound("vs_gormstadd_007"));

        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        AssignCommand(oActorGormstadd, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oActorGormstadd, SpeakString("Now, as for you... I'm afraid assault upon a town official is a hanging offence. Gentlemen, if you'd do the honors…"));
        AssignCommand(oPC, PlaySound("vs_gormstadd_008"));

        CutsceneNext(39.0);
    }
    else if (fTime >= 39.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Balor attacks
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    object oActorZhentMage = CutsceneGetActor(NPC_TAG_ZHENTMAGE);
    object oActorBalor = CutsceneGetActor(NPC_TAG_BALOR);
    // Waypoints
    object oBalorMoveWP = GetWaypointByTag(WP_TAG_BALOR_MOVE);

    if (fTime == 0.0)
    {
        effect eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPC, 3.0);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oPC, PlaySound("c_demon_bat1"));

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorGormstadd, SpeakString("What was that?"));
        AssignCommand(oActorGormstadd, PlaySound("vs_gormstadd_009"));

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oActorBalor, ActionMoveToObject(oBalorMoveWP, TRUE));

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oActorGormstadd, SetFacingPoint(GetPosition(oBalorMoveWP)));
        AssignCommand(oActorZhentMage, SetFacingPoint(GetPosition(oBalorMoveWP)));

        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oActorBalor, SetFacingPoint(GetPosition(oActorZhentMage)));
        DelayCommand(0.5, AssignCommand(oActorBalor, PlayAnimation(ANIMATION_FIREFORGET_TAUNT)));
        DelayCommand(0.5, AssignCommand(oPC, PlaySound("c_demon_atk1")));

        CutsceneNext(16.0);
    }
    else if (fTime >= 16.0)
    {
        // Give the scene a little time to play out
        CutsceneNextShot();
    }
}

// Shot 2: Ends the cutscene
void next2(float fTime)
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
        if (nShot >= 2) next2(fTime);
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
