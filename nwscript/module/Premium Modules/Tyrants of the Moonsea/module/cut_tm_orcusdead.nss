//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_orcusdead
// DATE: February 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene for defeat of Orcus
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_spells"

#include "hf_in_cutscene"
#include "hf_in_friend"
#include "hf_in_plot"
#include "hf_in_util"

#include "inc_zkwar"

const string NPC_RESREF_MAGANUS = "elventreemagn001";
const string NPC_TAG_MAGANUS = "StrongholdMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_ZKTEM_CS_MAGANUS_SPAWN";

const string NPC_TAG_FZOUL = "Fzoul";

const string NPC_RESREF_ORCUS = "creature005";
const string NPC_TAG_ORCUS = "OrcusDemonPrinceoftheUndead";
const string WP_TAG_ORCUS_INIT = "WP_ZKTEM_CS_ORCUS_SPAWN";

const string WP_TAG_PC_INIT = "WP_ZKTEM_CS_PC_START2";

const string PLC_TAG_DIRECTOR = "FinaleDirector";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_MAGANUS, oPC);
    CutsceneAddActor(NPC_TAG_MAGANUS, oActor);
    oActor = GetObjectInArea(NPC_TAG_ORCUS, oPC);
    CutsceneAddActor(NPC_TAG_ORCUS, oActor);
    oActor = GetObjectInArea(NPC_TAG_FZOUL, oPC);
    CutsceneAddActor(NPC_TAG_FZOUL, oActor);
    oActor = GetObjectInArea(PLC_TAG_DIRECTOR, oPC);
    CutsceneAddActor(PLC_TAG_DIRECTOR, oActor);
}

//Remove any lingering AOE spells and summonees from the cutscene location
void RemoveOrcusEffects(object oOrcus)
{
    object oAOE;
    object oSummon;

    location lLoc = GetLocation(GetWaypointByTag(WP_TAG_PC_INIT));

    oAOE = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    while(oAOE != OBJECT_INVALID)
    {
        DestroyObject(oAOE);
        oAOE = GetNextObjectInShape(SHAPE_SPHERE, 25.0, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    }

    //Remove any summoned creature
    oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oOrcus);
    if(oSummon != OBJECT_INVALID)
    {
        DestroyObject(oSummon);
    }
}

//Perform a ClearActions(TRUE) on all PC party members
void ClearPartyActions(object oPC)
{
    object oFacMem = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oFacMem))
    {
        AssignCommand(oFacMem, ClearAllActions(TRUE));
        oFacMem = GetNextFactionMember(oPC, FALSE);
    }
}

 //Clear party members feelings towards guard, and vice versa
 void ClearPartyReputation(object oPC, object oCreature)
{
    object oFacMem = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oFacMem))
    {
        ClearPersonalReputation(oFacMem, oCreature);
        ClearPersonalReputation(oCreature, oFacMem);

        oFacMem = GetNextFactionMember(oPC, FALSE);
    }
}

//Send a Fzoul guard to starting position and clear reputation with PC and own faction
void SendGuardHome()
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oPC = CutsceneGetPC();

    ClearAllActions(TRUE);
    SetPlotFlag(OBJECT_SELF, TRUE);

    //Clear party reputation towards me
    ClearPartyReputation(oPC, OBJECT_SELF);

    //Change how my current faction (DEFENDER) feels about me
    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 70, OBJECT_SELF);

    //Change how Independent faction feels about me
    AdjustReputation(OBJECT_SELF, oFzoul, 70);

    //Return to the Independent faction
    ChangeFaction(OBJECT_SELF, oFzoul);

    //Remove combat effects
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, OBJECT_SELF);
    CutsceneRemoveNegativeEffects(OBJECT_SELF);

    //Go to start location
    JumpToLocation(GetLocalLocation(OBJECT_SELF, "lHome"));
}

//Recreate Sycllua in original form and fully rested
void SendScylluaHome()
{
    object oNewScyllua;
    object oPC = CutsceneGetPC();
    object oScyllua = GetNearestObjectByTag("Scyllua", oPC);

    location lSpawn = GetLocalLocation(oScyllua, "lHome");

    FriendSetMaster(OBJECT_INVALID, oScyllua);
    AssignCommand(oScyllua, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject(oScyllua);

    oNewScyllua = CreateObject(OBJECT_TYPE_CREATURE, "scyllua", lSpawn);
    SetPlotFlag(oNewScyllua, TRUE);
}

//Reset Fzoul guards faction and return to starting position
void SendFzoulAlliesHome(object oPC)
{
    object oArea = GetArea(oPC);
    object oGuard;
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);

    //Move Scyllua to starting position
    SendScylluaHome();

    //Move Guards to starting position
    oGuard = GetFirstObjectInArea(oArea);
    while(oGuard != OBJECT_INVALID)
    {
        if(GetTag(oGuard) == "FzoulGuard" &&
           GetObjectType(oGuard) == OBJECT_TYPE_CREATURE &&
           !GetIsDead(oGuard))
        {
            AssignCommand(oGuard, SendGuardHome());
        }
        oGuard = GetNextObjectInArea(oArea);
    }
}

//Remove any Orcus allies from the area
void DestroyOrcusAllies(object oPC)
{
    object oArea = GetArea(oPC);
    object oDemon;
    object oSummon;

    oDemon = GetFirstObjectInArea(oArea);
    while(oDemon != OBJECT_INVALID)
    {
        if(GetTag(oDemon) == "OrcusAlly" &&
           GetObjectType(oDemon) == OBJECT_TYPE_CREATURE &&
           !GetIsDead(oDemon))
        {
            //Remove any summoned creature
            oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oDemon);
            if(oSummon != OBJECT_INVALID)
            {
                DestroyObject(oSummon);
            }
            DestroyObject(oDemon);
        }
        oDemon = GetNextObjectInArea(oArea);
    }
}

//Remove any Orcus allies from the area
void DestroyOrcusLieutenants(object oPC)
{
    object oArea = GetArea(oPC);
    object oDemon;
    object oSummon;

    oDemon = GetFirstObjectInArea(oArea);
    while(oDemon != OBJECT_INVALID)
    {
        if(GetTag(oDemon) == "OrcusLieutenant" &&
           GetObjectType(oDemon) == OBJECT_TYPE_CREATURE &&
           !GetIsDead(oDemon))
        {
            //Remove any summoned creature
            oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oDemon);
            if(oSummon != OBJECT_INVALID)
            {
                DestroyObject(oSummon);
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oDemon);
        }
        oDemon = GetNextObjectInArea(oArea);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, WP_TAG_PC_INIT, TRUE);
    SetupActors(oPC);
}

// Speak with Orcus
void next0(float fTime)
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        MusicBattleStop(GetArea(oPC));
        MusicBackgroundStop(GetArea(oPC));
        //Switch off the director to stop Fzoul and Maganus actions
        PlotLevelSet(PLC_TAG_DIRECTOR, 0);

        //Remove AOE effects and any Orcus summoned creature from the vicinity
        RemoveOrcusEffects(oOrcus);

        //Destroy any remaining Orcus allies
        DestroyOrcusAllies(oPC);
        DestroyOrcusLieutenants(oPC);

        //Return Fzoul guards to original position and reset their faction
        SendFzoulAlliesHome(oPC);

        //Destroy Orcus and create new one for dialog
        DestroyObject(oOrcus);
        AssignCommand(oFzoul, ClearAllActions(TRUE));
        AssignCommand(oMaganus, ClearAllActions(TRUE));

        // some time for the camera to settle down
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 10.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oFzoul);
        RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oMaganus);

        oOrcus = CutsceneSpawnActor(NPC_RESREF_ORCUS, NPC_TAG_ORCUS, WP_TAG_ORCUS_INIT);
        CutsceneAddActor(NPC_TAG_ORCUS, oOrcus);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        effect eVFX = EffectVisualEffect(VFX_DUR_GLYPH_OF_WARDING);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oOrcus);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oOrcus, ClearAllActions(TRUE));
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    //Converse with Orcus and try to ensure dialog plays if PC marked as in combat
    else if (fTime == 4.0)
    {
        AssignCommand(oMaganus, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 32767.0));
        //CutsceneNextShot called from Orcus dialog
        if(GetIsInCombat(oPC))
        {
             AssignCommand(oOrcus, ActionStartConversation(oOrcus, "", FALSE, FALSE));
        }
        else
        {
            AssignCommand(oOrcus, ActionStartConversation(oPC, "", FALSE, FALSE));
        }
    }
}

//Destroy Orcus
void next1(float fTime)
{
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oPC = CutsceneGetPC();

    location lOrcus = GetLocation(GetWaypointByTag(WP_TAG_ORCUS_INIT));

    effect eVFX;

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 20.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oOrcus, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        eVFX = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oOrcus, 8.0);
        eVFX = EffectVisualEffect(VFX_FNF_PWKILL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOrcus);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oOrcus, ClearAllActions());
        AssignCommand(oOrcus, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        eVFX = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oOrcus);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lOrcus);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oOrcus, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.0));
        AssignCommand(oOrcus, PlayVoiceChat(VOICE_CHAT_DEATH));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lOrcus);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        DestroyObject(oOrcus);
        eVFX = EffectVisualEffect(VFX_FNF_SUMMONDRAGON);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lOrcus);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneEnd();
    }
}

//Ensure actors are set-up, and dialog aborted
void abort()
{
    object oOrcus;
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);

    //Destroy any remaining Orcus allies
    DestroyOrcusAllies(oPC);
    DestroyOrcusLieutenants(oPC);

    //Return Fzoul guards to original position and reset their faction
    SendFzoulAlliesHome(oPC);

    //Remove AOE effects and any Orcus summoned creature from the vicinity
    RemoveOrcusEffects(oOrcus);

    //Abort any ongoing dialog
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    int nXP;

    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(270.0, 25.0, 50.0));

    MusicBackgroundPlay(GetArea(oPC));

    //Ensure Orcus is destroyed
    DestroyObject(oOrcus);

    //Switch off the director to stop Fzoul and Maganus actions
    PlotLevelSet(PLC_TAG_DIRECTOR, 0);

    //Position Fzoul and Maganus for post-cutscene
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oFzoul);
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oMaganus);
    AssignCommand(oFzoul, ClearAllActions(TRUE));
    AssignCommand(oMaganus, ClearAllActions(TRUE));
    AssignCommand(oFzoul,
       JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTEM_CS_FZOUL_JUMP"))));
    AssignCommand(oMaganus,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTEM_CS_MAGANUS_BATTLE"))));
    AssignCommand(oMaganus, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 32767.0));

    //Ensure Maganus and Fzoul can be conversed with post-cutscene and set appropriate plot states
    SetLocalInt(oFzoul, "nBusy", 0);
    SetLocalInt(oMaganus, "nBusy", 0);
    PlotLevelSet(NPC_TAG_FZOUL, 1);
    PlotLevelSet(NPC_TAG_MAGANUS, 5);

    //Remove any negative effects on henchmen
    RemoveHenchmenNegativeEffects(oPC);

    //Update journal and award quest completion xp
    AddJournalQuestEntry("SoHighAPrice", 40, oPC);
    nXP = GetJournalQuestExperience("SoHighAPrice");
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
