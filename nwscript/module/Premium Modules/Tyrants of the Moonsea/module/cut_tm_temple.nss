//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_temple
// DATE: September 5, 2005
// AUTH: Luke Scull, Attila Gyoerkoes
// NOTE: Voonlar "Temple of Bane" cutscene.
//////////////////////////////////////////////////////
// Notable events:
//  - Gormstadd is killed
//  - Mysterious mage teleported away
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string NPC_RESREF_GORMSTADD = "gormstadd001";

const string NPC_TAG_GORMSTADD = "TempleGormstadd";
const string NPC_TAG_ZACHARUS = "Zacharus";
const string NPC_TAG_MYSTMAGE = "MysteriousMage";

const string WP_TAG_PLAYER_1 = "WP_Temple_Initial";
const string WP_TAG_PLAYER_2 = "WP_Temple_Player";
const string WP_TAG_PLAYER_3 = "WP_Temple_Move";
//const string WP_TAG_GORMSTADD_SPAWN = "WP_Gormstadd_TempleSpawn";
const string WP_TAG_GORMSTADD_MOVE = "WP_Gormstadd_GormJump";
const string WP_TAG_MYSTMAGE_MOVE = "WP_Mysterious_Move";

const string PLC_TAG_INVIS_1 = "TempleInvisibleObject";
const string PLC_TAG_INVIS_2 = "TempleInvisibleObject2";
const string PLC_TAG_INVIS_3 = "TempleInvisibleObject3";

// Trigger with message pointing to Bane temple
const string TRG_TAG_TEMPLE_HINT = "trg_voonlar_hint_to_temple";

void renderInvisible(object oPC, float fDuration = 0.0f)
{
    object oCreator = CutsceneGetScene();
    effect eInv = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    if (fDuration > 0.01f)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInv, oPC, fDuration);
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInv, oPC);
    }
}


void renderVisible(object oPC)
{
    object oCreator = CutsceneGetScene();
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        if ((GetEffectCreator(eEffect) == oCreator) && (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT))
        {
            RemoveEffect(oPC, eEffect);
        }
        eEffect = GetNextEffect(oPC);
    }
}


void setupActors(object oPC)
{
    object oActor;

    oActor = GetObjectInArea(NPC_TAG_GORMSTADD, oPC);
    CutsceneAddActor(NPC_TAG_GORMSTADD, oActor);

    oActor = GetObjectInArea(NPC_TAG_MYSTMAGE, oPC);
    CutsceneAddActor(NPC_TAG_MYSTMAGE, oActor);

    oActor = GetObjectInArea(NPC_TAG_ZACHARUS, oPC);
    CutsceneAddActor(NPC_TAG_ZACHARUS, oActor);
}


void start()
{
    object oPC = CutsceneGetPC();

    FadeToBlack(oPC, FADE_SPEED_FAST);

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


// Called when the cutscene is aborted to ensure post conditions
void abort()
{
    object oPC = CutsceneGetPC();

    // Ensure actors have been set up
    setupActors(oPC);

    // Gormstadd should be killed
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    if (GetIsObjectValid(oActorGormstadd))
    {
        DestroyObject(oActorGormstadd);
    }

    // Mysterious Mage should be teleported away
    object oActorMystMage = CutsceneGetActor(NPC_TAG_MYSTMAGE);
    if (GetIsObjectValid(oActorMystMage))
    {
        DestroyObject(oActorMystMage);
    }

    // Make sure the PC is at the final location
    object oPlayerFinalWP = GetObjectInArea(WP_TAG_PLAYER_3, oPC);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oPlayerFinalWP, FALSE));
}


void end()
{
    object oPC = CutsceneGetPC();

    // Remove any cutscene invisibility
    renderVisible(oPC);

    // Enable flavor text/hint pointing to voonlar temple
    SetLocalInt(GetObjectByTag(TRG_TAG_TEMPLE_HINT), "nDone", 1);

    // Make the Boss killable
    object oActorZacharus = CutsceneGetActor(NPC_TAG_ZACHARUS);
    SetPlotFlag(oActorZacharus, FALSE);

    // Remove Helper Objects
    object oPlcInvis1 = GetObjectInArea(PLC_TAG_INVIS_1, oPC);
    object oPlcInvis2 = GetObjectInArea(PLC_TAG_INVIS_2, oPC);
    object oPlcInvis3 = GetObjectInArea(PLC_TAG_INVIS_3, oPC);
    DestroyObject(oPlcInvis1);
    DestroyObject(oPlcInvis2);
    DestroyObject(oPlcInvis3);

    // Follow up events, after cutscene
    DoSinglePlayerAutoSave();
    DelayCommand(2.0, ExecuteScript("exe_tm_temple", oPC));
}


// Shot 0: Gormstadd tells the player off
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    // Waypoints
    object oGormstaddMoveWP = GetWaypointByTag(WP_TAG_GORMSTADD_MOVE);
    object oPlayerIntialWP = GetWaypointByTag(WP_TAG_PLAYER_1);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Setup during black screen
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oPlayerIntialWP, FALSE));

        // Match camera setup to old system (Top view camera)
        // cs_CameraUseCameraWaypoint(0.4, 5, FALSE, OBJECT_SELF, 1);
        // Use PC location directly instead of Camera No5
        CutsceneCameraSetup(6.0, 0.0, 15.0, 10.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorGormstadd, SpeakString("Stand back, you fool. Let me deal with this."));
        AssignCommand(oActorGormstadd, PlaySound("vs_gormstadd_001"));

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oActorGormstadd, ActionMoveToObject(oGormstaddMoveWP, FALSE));

        CutsceneNext(10.0);
    }
    else if (fTime >= 10.0)
    {
        CutsceneNextShot();
    }
}


// Shot 1: Gormstadd fails and is killed
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorGormstadd = CutsceneGetActor(NPC_TAG_GORMSTADD);
    object oActorMystMage = CutsceneGetActor(NPC_TAG_MYSTMAGE);
    // Waypoints
    //object oGormstaddJumpWP = GetWaypointByTag(WP_TAG_GORMSTADD_2);
    object oPlayerJumpWP = GetWaypointByTag(WP_TAG_PLAYER_2);
    object oCameraWP;

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // Make PC invisible for camera switching
        renderInvisible(oPC);

        // Match camera setup to old system (Camera No1, facing Gormstadd)
        // cs_CameraUseCameraWaypoint(0.2, 1, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_1", oPC);
        AssignCommand(oPC, ActionJumpToObject(oCameraWP, FALSE));
        CutsceneCameraSetup(0.0, GetFacing(oCameraWP), 2.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oActorGormstadd, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        AssignCommand(oActorGormstadd, SpeakString("Infidel! How dare you invade a sacred temple of Lord Bane and slay his worshippers? I shall hang your body over the town walls for the crows to feast upon!"));
        AssignCommand(oPC, PlaySound("vs_gormstadd_002"));

        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        // Match camera setup to old system (Camera No2, facing Mage)
        // cs_CameraUseCameraWaypoint(7.5, 2, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_2", oPC);
        BlackScreen(oPC);
        AssignCommand(oPC, ActionJumpToObject(oCameraWP, FALSE));
        DelayCommand(0.2, StopFade(oPC));
        CutsceneCameraSetup(2.0, GetFacing(oCameraWP), 1.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oActorMystMage, PlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0));
        AssignCommand(oActorMystMage, SpeakString("I once lost an eye in similar circumstances. It's not something I care to repeat."));
        AssignCommand(oPC, PlaySound("vs_maganus_097"));

        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        // Match camera setup to old system (Camera No1, facing Gormstadd)
        // cs_CameraUseCameraWaypoint(12.0, 1, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_1", oPC);
        AssignCommand(oPC, ActionJumpToObject(oCameraWP, FALSE));
        CutsceneCameraSetup(1.0, GetFacing(oCameraWP), 2.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oActorGormstadd, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        AssignCommand(oActorGormstadd, SpeakString("Fool! You mock me? Do you really believe your pathetic Order can threaten the might of the Zhentarim?"));
        AssignCommand(oPC, PlaySound("vs_gormstadd_003"));

        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        // Match camera setup to old system (Camera No3, facing Mage)
        // cs_CameraUseCameraWaypoint(10.5, 3, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_3", oPC);
        BlackScreen(oPC);
        AssignCommand(oPC, ActionJumpToObject(oCameraWP, FALSE));
        DelayCommand(0.2, StopFade(oPC));
        CutsceneCameraSetup(2.0, GetFacing(oCameraWP), 1.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        AssignCommand(oActorMystMage, PlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0));
        AssignCommand(oActorMystMage, SpeakString("With every day that passes, the Order of the Crippled Fang grows stronger."));
        AssignCommand(oPC, PlaySound("vs_maganus_098"));

        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        // Match camera setup to old system (Camera No1, facing Gormstadd)
        // cs_CameraUseCameraWaypoint(13.0, 1, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_1", oPC);
        BlackScreen(oPC);
        AssignCommand(oPC, ActionJumpToObject(oCameraWP, FALSE));
        DelayCommand(0.2, StopFade(oPC));
        CutsceneCameraSetup(1.0, GetFacing(oCameraWP), 2.0, 89.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(45.0);
    }
    else if (fTime == 45.0)
    {
        AssignCommand(oActorGormstadd, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorGormstadd, SpeakString("You know nothing of strength! Lord Bane, grant me the power to smite this infidel!"));
        AssignCommand(oPC, PlaySound("vs_gormstadd_004"));

        CutsceneNext(52.0);
    }
    else if (fTime == 52.0)
    {
        AssignCommand(oActorGormstadd, ActionCastFakeSpellAtObject(SPELL_CALL_LIGHTNING, oActorMystMage, PROJECTILE_PATH_TYPE_DEFAULT));

        CutsceneNext(54.0);
    }
    else if (fTime == 54.0)
    {
        // Helper Placeables (Spell Targets)
        object oPlcInvis1 = GetObjectInArea(PLC_TAG_INVIS_1, oPC);
        object oPlcInvis2 = GetObjectInArea(PLC_TAG_INVIS_2, oPC);
        object oPlcInvis3 = GetObjectInArea(PLC_TAG_INVIS_3, oPC);

        AssignCommand(oActorMystMage, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 1.5));

        DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY), oActorMystMage, 1.0));
        DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), oPlcInvis1));

        effect eVFXBeam = EffectBeam(VFX_BEAM_LIGHTNING, oActorMystMage, BODY_NODE_CHEST);
        DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFXBeam, oPlcInvis2, 1.0));
        DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFXBeam, oPlcInvis3, 1.0));

        CutsceneNext(56.0);
    }
    else if (fTime == 56.0)
    {
        AssignCommand(oActorMystMage, SpeakString("You fools never learn."));
        AssignCommand(oPC, PlaySound("vs_maganus_099"));

        CutsceneNext(59.0);
    }
    else if (fTime == 59.0)
    {
        AssignCommand(oActorGormstadd, SpeakString("What? How..."));
        AssignCommand(oPC, PlaySound("vs_gormstadd_005"));

        CutsceneNext(63.0);
    }
    else if (fTime == 63.0)
    {
        AssignCommand(oActorMystMage, ActionCastFakeSpellAtObject(SPELL_SUNBURST, oActorGormstadd, PROJECTILE_PATH_TYPE_DEFAULT));

        CutsceneNext(65.0);
    }
    else if (fTime == 65.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUNBEAM), oActorGormstadd);

        CutsceneNext(66.0);
    }
    else if (fTime == 66.0)
    {
        AssignCommand(oPC, PlaySound("vs_ngnbarm3_dead"));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_INFERNO), oActorGormstadd, 7.0);
        DelayCommand(0.5, AssignCommand(oActorGormstadd, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 7.0)));

        CutsceneNext(68.0);
    }
    else if (fTime == 68.0)
    {
        FadeToBlack(oPC, FADE_SPEED_MEDIUM);
        SetCreatureAppearanceType(oActorGormstadd, APPEARANCE_TYPE_SKELETON_COMMON);

        CutsceneNext(71.0);
    }
    else if (fTime == 71.0)
    {
        // Setup during black screen

        // Match camera setup to old system (camera behind PC)
        // cs_CameraUseCameraWaypoint(0.1, 4, FALSE, OBJECT_SELF, 1);
        oCameraWP = GetObjectInArea("cs_camera_pos_4", oPC);
        BlackScreen(oPC);
        AssignCommand(oPC, JumpToLocation(GetLocation(oCameraWP)));
        DelayCommand(0.2, StopFade(oPC));
        CutsceneCameraSetup(1.0, GetFacing(oCameraWP), 5.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);

        renderVisible(oPC);
        CutsceneNext(73.0);
    }
    else if (fTime == 73.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(74.0);
    }
    else if (fTime >= 74.0)
    {
        SetPlotFlag(oActorGormstadd, FALSE);
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorGormstadd));

        CutsceneNextShot();
    }
}


// Shot 2: Zaccharus is to deal with the PC
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMystMage = CutsceneGetActor(NPC_TAG_MYSTMAGE);
    object oActorZacharus = CutsceneGetActor(NPC_TAG_ZACHARUS);
    //Waypoints
    object oPlayerFinalWP = GetWaypointByTag(WP_TAG_PLAYER_3);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionMoveToObject(oPlayerFinalWP, TRUE));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oActorMystMage, SetFacingPoint(GetPosition(oActorZacharus)));
        AssignCommand(oActorMystMage, SpeakString("Zacharus, take care of this one and finish razing the town. I've wasted enough time here already."));
        AssignCommand(oPC, PlaySound("vs_maganus_100"));

        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oActorMystMage, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActorMystMage, PROJECTILE_PATH_TYPE_DEFAULT));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActorMystMage);
        DestroyObject(oActorMystMage);

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
        SendMessageToPC(GetFirstPC(), "Error: Invalid custscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}

