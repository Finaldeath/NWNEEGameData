//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_sublair
// DATE: December 23, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue with Maganus and Eremuth
//       in Elmwood : Subterranean Lair
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_RESREF_EREMUTH = "eremuthrat";
const string NPC_TAG_EREMUTH = "EremuthRat";
const string WP_TAG_EREMUTH_INIT = "WP_EWSUB_CS_EREMUTH_SPAWN";

const string NPC_RESREF_MAGANUS = "sublairmaganus";
const string NPC_TAG_MAGANUS = "SubLairMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_EWSUB_CS_MAGANUS_SPAWN";

void SetupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_MAGANUS, NPC_TAG_MAGANUS, WP_TAG_MAGANUS_INIT);
    CutsceneSpawnActor(NPC_RESREF_EREMUTH, NPC_TAG_EREMUTH, WP_TAG_EREMUTH_INIT);
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "", FALSE);
    SetupActors(oPC);
}

// Ezril talks to player
void next0(float fTime)
{
    object oChest = GetObjectByTag("ElmwoodLairChest");
    object oEremuth = CutsceneGetActor(NPC_TAG_EREMUTH);
    object oMaganus =CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(1.0);
    }
    else if(fTime == 1.0)
    {
        AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_EWSUB_CS_PC_START"))));
        CutsceneNext(2.0);
    }
    else if(fTime == 2.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(1.5, 270.0, 6.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);

        //Set Maganus plot variable to ensure correct dialog is spoken
        PlotLevelSet(NPC_TAG_MAGANUS, 1);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oMaganus, ActionCastFakeSpellAtObject(SPELL_KNOCK, oChest));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oChest);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oEremuth, ActionMoveToObject(oMaganus, FALSE, 7.0));
        AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oPC, ActionJumpToObject(GetWaypointByTag("WP_EWSUB_CS_PC_JUMP")));
        AssignCommand(oPC, ActionDoCommand(SetFacing(0.0)));
        CutsceneNext(16.0);
    }
    //Maganus takes Dominion from chest
    else if (fTime == 16.0)
    {
        AssignCommand(oMaganus, ActionTakeItem(GetItemPossessedBy(oChest, "FakeDominion"), oChest));
        AssignCommand(oMaganus, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0));
        CutsceneNext(21.0);
    }
    //Maganus celebrates acquiring Dominion
    else if (fTime == 21.0)
    {
        AssignCommand(oMaganus, ClearAllActions());
        AssignCommand(oMaganus, ActionDoCommand(SetFacing(180.0)));
        AssignCommand(oMaganus, ActionMoveToObject(GetWaypointByTag(WP_TAG_MAGANUS_INIT)));
        AssignCommand(oMaganus,
            ActionEquipItem(GetItemPossessedBy(oMaganus, "FakeDominion"), INVENTORY_SLOT_RIGHTHAND));
        AssignCommand(oMaganus, ActionWait(2.0));
        AssignCommand(oMaganus, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        AssignCommand(oMaganus, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        //CutsceneNextShot() invoked from Maganus conversation
        AssignCommand(oMaganus, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// Eremuth polymorphs from rat to malaugrym
void next1(float fTime)
{
    object oEremuth = CutsceneGetActor(NPC_TAG_EREMUTH);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    float fScale = 0.0;

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 10.0, 70.0, CAMERA_TRANSITION_TYPE_FAST);
        PlotLevelSet(NPC_TAG_MAGANUS, 2);
        AssignCommand(oEremuth, ActionMoveToObject(oMaganus, FALSE, 3.0));
        CutsceneNext(3.0);
    }
    //Eremuth changes from rat to malaugrym
    else if (fTime == 3.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_DUR_AURA_PULSE_GREEN_YELLOW),
                            oEremuth, 6.0);
        AssignCommand(oMaganus, SetFacingPoint(GetPosition(oEremuth)));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        fScale = GetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE);
        fScale = fScale + 0.5;
        SetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE, fScale);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        fScale = GetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE);
        fScale = fScale + 0.5;
        SetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE, fScale);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        fScale = GetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE);
        fScale = fScale + 0.5;
        SetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE, fScale);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        fScale = GetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE);
        fScale = fScale + 0.5;
        SetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE, fScale);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        SetName(oEremuth, "Eremuth");
        SetPortraitResRef(oEremuth, "po_malaugrym_");

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(EFFECT_TYPE_POLYMORPH),
                              GetLocation(oEremuth));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),
                            oEremuth, 0.75);

        SetObjectVisualTransform(oEremuth, OBJECT_VISUAL_TRANSFORM_SCALE, 1.0);
        SetCreatureAppearanceType(oEremuth, 15036); // Malaugrym appearance
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        //CutsceneNextShot() invoked from Maganus conversation
        AssignCommand(oMaganus, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

//Maganus teleports away
void next2(float fTime)
{
    object oEremuth = CutsceneGetActor(NPC_TAG_EREMUTH);
    object oMaganus =CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        AssignCommand(oMaganus,
            ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.5));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1),
                            oMaganus);
         CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(VFX_IMP_HARM),
                              GetLocation(oMaganus));
        DestroyObject(oMaganus);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 315.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
        //CutsceneNextShot() invoked from Eremuth conversation
        AssignCommand(oEremuth, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

//Eremuth flees
void next3(float fTime)
{
    object oEremuth = CutsceneGetActor(NPC_TAG_EREMUTH);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        AssignCommand(oEremuth, ClearAllActions());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(EFFECT_TYPE_POLYMORPH),
                            oEremuth);
        SetCreatureAppearanceType(oEremuth, APPEARANCE_TYPE_RAT);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
       // position the camera (height, dir, dist, pitch)
       CutsceneCameraSetup(-1.0, 270.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
       AssignCommand(oEremuth,
           ActionMoveToObject(GetObjectByTag("EremuthEscapeHole"), TRUE, 1.0));
       AssignCommand(oEremuth,
           ActionDoCommand(SetFacing(315.0)));
       AssignCommand(oPC, ActionForceFollowObject(oEremuth));
       CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        AssignCommand(oPC, ClearAllActions());
        DestroyObject(oEremuth);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneEnd();
    }
}

//Ensure dialog aborted, NPCs removed, chest opened, sword removed
void abort()
{
    object oChest = GetObjectByTag("ElmwoodLairChest");
    object oEremuth = CutsceneGetActor(NPC_TAG_EREMUTH);
    object oMaganus =CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    AssignCommand(oEremuth, ClearAllActions());
    AssignCommand(oMaganus, ClearAllActions());
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
    AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));

    DestroyObject(oEremuth);
    DestroyObject(oMaganus);
    DestroyObject(GetObjectByTag("FakeDominion"));
}

void end()
{
    int nXP;
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(0.0, 25.0, 50.0));
    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_EWSUB_CS_PC_END"))));

    //Update relevant journal entries and award quest completion xp
    AddJournalQuestEntry("HuntingTheTraitor", 50, oPC);
    nXP = GetJournalQuestExperience("HuntingTheTraitor");
    GiveXPToCreature(oPC, nXP);

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());
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
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
