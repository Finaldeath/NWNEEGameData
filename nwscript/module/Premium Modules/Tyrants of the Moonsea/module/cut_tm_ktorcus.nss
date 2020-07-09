//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ktorcus
// DATE: January 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene in Kur-Tharsu Summoning Chamber - Orcus summoned
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"

#include "inc_ktgate"

const string NPC_RESREF_MAGANUS = "elventreemagn001";
const string NPC_TAG_MAGANUS = "StrongholdMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_THKTUF_CS_MAGANUS_SPAWN";

const string NPC_RESREF_ORCUS = "creature005";
const string NPC_TAG_ORCUS = "OrcusDemonPrinceoftheUndead";
const string WP_TAG_ORCUS_INIT = "WP_THKTUF_CS_ORCUS_SPAWN";

const string NPC_TAG_OGRE1 = "KTOgreMage1";
const string NPC_TAG_OGRE2 = "KTOgreMage2";
const string NPC_TAG_OGRE3 = "KTOgreMage3";
const string NPC_TAG_OGRE4 = "KTOgreMage4";

const string PLC_TAG_CHEST = "DominionChest";
const string PLC_TAG_DIRECTOR = "KTUFDirector";
const string PLC_TAG_PORTAL = "OrcusPortal";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_OGRE1, oPC);
    CutsceneAddActor(NPC_TAG_OGRE1, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_OGRE2, oPC);
    CutsceneAddActor(NPC_TAG_OGRE2, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_OGRE3, oPC);
    CutsceneAddActor(NPC_TAG_OGRE3, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_OGRE4, oPC);
    CutsceneAddActor(NPC_TAG_OGRE4, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_MAGANUS, oPC);
    CutsceneAddActor(NPC_TAG_MAGANUS, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_ORCUS, oPC);
    CutsceneAddActor(NPC_TAG_ORCUS, oActor);

    oActor = GetNearestObjectByTag(PLC_TAG_CHEST, oPC);
    CutsceneAddActor(PLC_TAG_CHEST, oActor);
    oActor = GetNearestObjectByTag(PLC_TAG_DIRECTOR, oPC);
    CutsceneAddActor(PLC_TAG_DIRECTOR, oActor);
    oActor = GetNearestObjectByTag(PLC_TAG_PORTAL, oPC);
    CutsceneAddActor(PLC_TAG_PORTAL, oActor);
}

void KillOgres()
{
    object oOgre1 = CutsceneGetActor(NPC_TAG_OGRE1);
    object oOgre2 = CutsceneGetActor(NPC_TAG_OGRE2);
    object oOgre3 = CutsceneGetActor(NPC_TAG_OGRE3);
    object oOgre4 = CutsceneGetActor(NPC_TAG_OGRE4);

    effect eDeath = EffectDeath();

    SetPlotFlag(oOgre1, FALSE);
    SetPlotFlag(oOgre2, FALSE);
    SetPlotFlag(oOgre3, FALSE);
    SetPlotFlag(oOgre4, FALSE);

    //Ogre mages die
    if(GetIsObjectValid(oOgre1) && !GetIsDead(oOgre1))
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oOgre1);
    if(GetIsObjectValid(oOgre2) && !GetIsDead(oOgre2))
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oOgre2);
    if(GetIsObjectValid(oOgre3) && !GetIsDead(oOgre3))
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oOgre3);
    if(GetIsObjectValid(oOgre4) && !GetIsDead(oOgre4))
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oOgre4);
}

//Ensure visual effects have been removed
void RemoveVisualEffects()
{
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);
    object oPortal = CutsceneGetActor(PLC_TAG_PORTAL);

    //Remove Glyph effect from portal
    RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oPortal, oDirector);
}

//Remove any lingering AOE spells and summonees from the cutscene location
void RemoveSpellEffects()
{
    object oAOE;
    object oPC = CutsceneGetPC();
    object oBalor = GetNearestObjectByTag("MaganusBalor", oPC);
    object oSummon;

    location lLoc = GetLocation(GetWaypointByTag(WP_TAG_MAGANUS_INIT));

    oAOE = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    while(oAOE != OBJECT_INVALID)
    {
        DestroyObject(oAOE);
        oAOE = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    }

    //Remove gated in Balor and any summonees
    if(GetIsObjectValid(oBalor) && !GetIsDead(oBalor))
    {
        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oBalor);
        DestroyObject(oSummon);
        DestroyObject(oBalor);
    }
}

//Destroy Ilandra's crew in Breakwater Inn
void DestroyIlandraCrew()
{
    object oBreakwaterInn = GetObjectByTag("MelvauntTheBreakwaterInn");
    object oCrew = GetFirstObjectInArea(oBreakwaterInn);

    while(oCrew != OBJECT_INVALID)
    {
        if(GetTag(oCrew) == "IlandraCrew")
        {
            DestroyObject(oCrew);
        }
        oCrew = GetNextObjectInArea(oBreakwaterInn);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_THKTUF_CS2_PC_START", FALSE);
    SetupActors(oPC);
}

// View ogre mages in summoning chamber
void next0(float fTime)
{
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOgre1 = CutsceneGetActor(NPC_TAG_OGRE1);
    object oOgre2 = CutsceneGetActor(NPC_TAG_OGRE2);
    object oOgre3 = CutsceneGetActor(NPC_TAG_OGRE3);
    object oOgre4 = CutsceneGetActor(NPC_TAG_OGRE4);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
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
        MusicBattleStop(GetArea(oPC));

        //Switch off ogre animations in Director heartbeat script
        PlotLevelSet("OgreAnimation", 0);
        AssignCommand(oOgre1, ClearAllActions());
        AssignCommand(oOgre2, ClearAllActions());
        AssignCommand(oOgre3, ClearAllActions());
        AssignCommand(oOgre4, ClearAllActions());

        //Apply armor effect to ogres (any existing effect will be removed)
        SignalEvent(oDirector, EventUserDefined(4602));

        //Remove AOE effects and Maganus gated creature from the vicinity
        RemoveSpellEffects();

        //Delete this instance of Maganus
        DeleteLocalObject(oDirector, "oMaganus");
        DestroyObject(oMaganus);

        //Stop assassins attacking, remove negative effects, and move to home location
        SignalAssassinEvent(4702);

        // some time for the camera to settle down
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(2.0, 90.0, 20.0, 35.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    //The final stages of the summoning begin
    else if (fTime == 4.0)
    {
        //Lightning bolt effects
        eVFX = EffectVisualEffect(VFX_FNF_PWKILL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);

        //Ogres perform conjure animations
        AssignCommand(oOgre1, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 10.0));
        AssignCommand(oOgre2, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 10.0));
        AssignCommand(oOgre3, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 10.0));
        AssignCommand(oOgre4, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 10.0));

        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX , oDirector);
        //Lightning bolt effects
        eVFX = EffectVisualEffect(VFX_FNF_PWKILL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        //Apply bones effect
        eVFX = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        //Lightning effects
        eVFX = EffectVisualEffect(VFX_FNF_PWKILL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(11.0);
    }
     else if (fTime == 11.0)
    {
        //Lightning effects
        eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        //Remove Glyph effect from portal
        RemoveNamedEffectByCreator(EFFECT_TYPE_VISUALEFFECT, oPortal, oDirector);

        //Fiery implosion effect
        eVFX = EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(16.0);
    }
    //Kill the ogre mage summoners
    else if(fTime == 16.0)
    {
        SoundObjectStop(GetNearestObjectByTag("KTOgreSummonChants", oPC));
        KillOgres();
        CutsceneNext(17.0);
    }
    else if(fTime == 17.0)
    {
        //Apply bones effect
        eVFX = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);

        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        //Floating skeleton effect above ogre mages
        eVFX = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOgre1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOgre2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOgre3);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOgre4);

        CutsceneNext(21.0);
    }
    else if (fTime == 21.0)
    {
        //Apply runes effect
        eVFX = EffectVisualEffect(VFX_FNF_WORD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        //Apply bones effect
        eVFX = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        //Apply gate effect
        eVFX = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        //Spawn Orcus and Maganus
        CutsceneSpawnActor(NPC_RESREF_ORCUS, NPC_TAG_ORCUS, WP_TAG_ORCUS_INIT);
        CutsceneSpawnActor(NPC_RESREF_MAGANUS, NPC_TAG_MAGANUS, WP_TAG_MAGANUS_INIT);
        CutsceneNext(26.0);
    }
    else if (fTime == 26.0)
    {
        //Apply vertical fire beam effect
        eVFX = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE );
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPortal);
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oOrcus, PlayVoiceChat(VOICE_CHAT_BATTLECRY2));
        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        BlackScreen(oPC);
        AssignCommand(oOrcus, SpeakString(""));
        AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTUF_CS_PC_MAGANUS"))));
        CutsceneNextShot();
    }
}

//Converse with Maganus and Orcus
void next1(float fTime)
{
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        RemoveAssociateEffects(oPC);
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 45.0, 10.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if(fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        //Set correct plot level for this tag
        PlotLevelSet(NPC_TAG_MAGANUS, 4);
        CutsceneNext(5.0);
    }
    //
    else if (fTime == 5.0)
    {
        //CutsceneNextShot called from Maganus dialog
        AssignCommand(oMaganus, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// Maganus and Orcus teleport away
void next2(float fTime)
{
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oPC = CutsceneGetPC();

    effect eVFX;

    location lMaganus = GetLocation(oMaganus);
    location lOrcus = GetLocation(oOrcus);

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 25.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oMaganus, SetFacingPoint(GetPosition(oOrcus)));
        AssignCommand(oOrcus, SetFacingPoint(GetPosition(oMaganus)));
        AssignCommand(oOrcus, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.5));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOrcus);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oMaganus);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_WORD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOrcus);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        eVFX = EffectVisualEffect(VFX_IMP_HARM);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lOrcus);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMaganus);

        DestroyObject(oMaganus);
        DestroyObject(oOrcus);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        CutsceneEnd();
    }
}

//Ensure actors are set-up, visual effects removed, ogres dead, dialog aborted
void abort()
{
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    //Ensure glyph removed from portal
    RemoveVisualEffects();
    //Remove any AOE effects and gated Balor
    RemoveSpellEffects();
    //Kill Ogre Mages
    SoundObjectStop(GetNearestObjectByTag("KTOgreSummonChants", oPC));
    KillOgres();
    //Stop assassins attacking, remove negative effects, and move to home location
    SignalAssassinEvent(4702);
    //Abort any ongoing dialog
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oChest = CutsceneGetActor(PLC_TAG_CHEST);
    object oDirector = CutsceneGetActor(PLC_TAG_DIRECTOR);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oPC = CutsceneGetPC();

    PlotLevelSet("KTPortal", 1);
    PlotLevelSet("PirateBlockade", 1);
    AddJournalQuestEntry("TheRavenMage", 20, oPC);
    AddJournalQuestEntry("SoHighAPrice", 10, oPC);

    //Revert Battle Music to default and restore background music
    MusicBattleChange(GetArea(oPC), 74);
    MusicBackgroundPlay(GetArea(oPC));

    //Shadovar assassins now seeking sword
    if(PlotLevelGet("ShadovarAssassinKT") > 0)
    {
        PlotLevelSet("ShadovarAssassinKT", 5);
    }

    //Ensure Maganus and Orcus are removed, and destroy Director
    DestroyObject(oMaganus);
    DestroyObject(oOrcus);
    DestroyObject(oDirector, 2.0);

    //Open the chest containing Fake Dominion
    SetLocked(oChest, FALSE);
    AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));

    //Remove Ilandra, her crew, and Blizzard from Breakwater Inn
    //(Ilandra will resurface with Avagard)
    DestroyObject(GetObjectByTag("Ilandra"));
    DestroyObject(GetObjectByTag("Blizzard"));
    DestroyIlandraCrew();

    CutMoveAssociatesTo(oPC, "WP_THKTUF_CS_HENCH_MAGANUS");
    AssignCommand(oPC, SetCameraFacing(90.0, 25.0, 50.0));
    AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTUF_CS_PC_MAGANUS"))));

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
