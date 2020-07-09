//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_fzoulbane
// DATE: February 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene for Fzoul summoning Bane and Maganus fleeing with PC
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_spells"

#include "hf_in_cutscene"
#include "hf_in_plot"

#include "inc_zkwar"

const string NPC_RESREF_MAGANUS = "elventreemagn001";
const string NPC_TAG_MAGANUS = "StrongholdMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_ZKTEM_CS_MAGANUS_JUMP";

const string NPC_RESREF_FZOUL = "fzoul";
const string NPC_TAG_FZOUL = "Fzoul";
const string WP_TAG_FZOUL_INIT = "WP_ZKTEM_CS_FZOUL_JUMP";

const string NPC_RESREF_SCYLLUA = "scyllua";
const string NPC_TAG_SCYLLUA = "Scyllua";
const string WP_TAG_SCYLLUA_INIT = "WP_ZKTEM_CS_SCYLLUA_SPAWN";

const string WP_TAG_PC_INIT = "WP_ZKTEM_CS_PC_START";

const string PLC_TAG_DIRECTOR = "FinaleDirector";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_MAGANUS, oPC);
    CutsceneAddActor(NPC_TAG_MAGANUS, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_FZOUL, oPC);
    CutsceneAddActor(NPC_TAG_FZOUL, oActor);
    oActor = GetNearestObjectByTag(NPC_TAG_SCYLLUA, oPC);
    CutsceneAddActor(NPC_TAG_SCYLLUA, oActor);
}

//Remove any lingering AOE spells and summonees from the cutscene location
void RemoveFzoulEffects(object oFzoul)
{
    object oAOE;
    object oSummon;

    location lLoc = GetLocation(GetWaypointByTag(WP_TAG_PC_INIT));

    oAOE = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    while(oAOE != OBJECT_INVALID)
    {
        DestroyObject(oAOE);
        oAOE = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    }

    //Remove any summoned creature
    oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oFzoul);
    if(oSummon != OBJECT_INVALID)
    {
        DestroyObject(oSummon);
    }
}

//Reset Fzoul allies from cutscene
void RemoveFzoulAllies(object oPC)
{
    object oArea = GetArea(oPC);
    object oGuard;
    object oScyllua = GetNearestObjectByTag("Scyllua", oPC);

    AssignCommand(oScyllua, SetIsDestroyable(TRUE));
    DestroyObject(oScyllua);

    oGuard = GetFirstObjectInArea(oArea);
    while(oGuard != OBJECT_INVALID)
    {
        if(GetTag(oGuard) == "FzoulGuard" &&
           GetObjectType(oGuard) == OBJECT_TYPE_CREATURE &&
           !GetIsDead(oGuard))
        {
            DestroyObject(oGuard);
        }
        oGuard = GetNextObjectInArea(oArea);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

//Fzoul moves to altar and begins summoning Bane
void next0(float fTime)
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oScyllua = CutsceneGetActor(NPC_TAG_SCYLLUA);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        MusicBattleStop(GetArea(oPC));

        //Destroy any remaining Fzoul allies
        RemoveFzoulAllies(oPC);

        //Destroy Fzoul and create new one for dialog
        DestroyObject(oFzoul);

        // some time for the camera to settle down
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 15.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    //Position actors (including an unconscious Scyllua)
    else if (fTime == 2.0)
    {
        AssignCommand(oMaganus,
                        JumpToLocation(GetLocation(GetWaypointByTag(WP_TAG_MAGANUS_INIT))));
        oFzoul = CutsceneSpawnActor(NPC_RESREF_FZOUL, NPC_TAG_FZOUL, WP_TAG_FZOUL_INIT);
        CutsceneAddActor(NPC_TAG_FZOUL, oFzoul);
        oScyllua = CutsceneSpawnActor(NPC_RESREF_SCYLLUA, NPC_TAG_SCYLLUA, WP_TAG_SCYLLUA_INIT);
        CutsceneAddActor(NPC_TAG_SCYLLUA, oScyllua);
        AssignCommand(oScyllua, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 200.0));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    //Fzoul climbs stairs to altar
    else if (fTime == 4.0)
    {
        AssignCommand(oFzoul,
            ActionForceMoveToObject(GetWaypointByTag("WP_ZKTEM_CS_FZOUL_BATTLE"), TRUE, 1.0, 3.0));
        CutsceneNext(7.0);
    }
    //Converse with Fzoul
    else if(fTime == 7.0)
    {
        AssignCommand(oScyllua, SpeakString("Urrrrgghhh..."));
        //CutsceneNextShot called from Fzoul dialog
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionStartConversation(oFzoul, "", FALSE, FALSE));
    }
}

//Maganus and PC flee the temple
void next1(float fTime)
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    effect eVFX;

    //Fzoul begins summoning and VFX play
    if (fTime == 0.0)
    {
        AssignCommand(oFzoul, ActionDoCommand(SetFacing(DIRECTION_NORTH)));
        AssignCommand(oFzoul, ActionWait(2.0));
        AssignCommand(oFzoul, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 20.0));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        eVFX = EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oFzoul, 20.0);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        eVFX = EffectVisualEffect(356);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPC, 10.0);
        eVFX = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX,
                              GetLocation(GetWaypointByTag("WP_ZKTEM_CS_PC_START")));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 20.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oMaganus, ActionMoveToObject(GetWaypointByTag("WP_ZKTEM_CS_EXIT"), TRUE));
        AssignCommand(oPC, ActionMoveToObject(GetWaypointByTag("WP_ZKTEM_CS_EXIT")));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_WORD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oMaganus));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        eVFX = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneEnd();
    }
}

//Ensure actors are set-up, and dialog aborted
void abort()
{
    object oFzoul;
    object oMaganus;
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);

    //Destroy any remaining Fzoul allies
    RemoveFzoulAllies(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oMaganus, ClearAllActions(TRUE));
    AssignCommand(oFzoul, ClearAllActions(TRUE));

    //Abort any ongoing dialog
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(270.0, 25.0, 50.0));

    //Remove any negative effects on henchmen
    RemoveHenchmenNegativeEffects(oPC);

    //Move Maganus and party to Temple Grounds for final dialog to play
    AssignCommand(oMaganus, JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTGR_MAGANUS_END"))));
    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTGR_PC_END"))));

    //Set variables for final Maganus dialog
    PlotLevelSet(NPC_TAG_MAGANUS, 7);
    PlotLevelSet(PLC_TAG_DIRECTOR, 2);

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
