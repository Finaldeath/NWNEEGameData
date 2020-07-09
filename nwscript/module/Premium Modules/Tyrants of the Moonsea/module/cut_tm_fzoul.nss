//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_fzoul
// DATE: February 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene for Fzoul/Maganus/Orcus dialog in Temple of Black Lord
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_friend"
#include "hf_in_plot"
#include "hf_in_util"

const string NPC_RESREF_MAGANUS = "elventreemagn001";
const string NPC_TAG_MAGANUS = "StrongholdMaganus";
const string WP_TAG_MAGANUS_INIT = "WP_ZKTEM_CS_MAGANUS_SPAWN";

const string NPC_TAG_FZOUL = "Fzoul";
const string NPC_TAG_ORCUS = "OrcusDemonPrinceoftheUndead";

const string NPC_TAG_SCYLLUA = "Scyllua";

const string PLC_TAG_DIRECTOR = "FinaleDirector";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_MAGANUS, oPC);
    CutsceneAddActor(NPC_TAG_MAGANUS, oActor);

    oActor = GetObjectInArea(NPC_TAG_ORCUS, oPC);
    CutsceneAddActor(NPC_TAG_ORCUS, oActor);
    oActor = GetObjectInArea(NPC_TAG_FZOUL, oPC);
    CutsceneAddActor(NPC_TAG_FZOUL, oActor);
    oActor = GetObjectInArea(NPC_TAG_SCYLLUA, oPC);
    CutsceneAddActor(NPC_TAG_SCYLLUA, oActor);
    oActor = GetObjectInArea(PLC_TAG_DIRECTOR, oPC);
    CutsceneAddActor(PLC_TAG_DIRECTOR, oActor);
}

//Fzoul guards assist PC against demons
void ChangeFzoulAlliesFaction(object oPC)
{
    object oArea = GetArea(oPC);
    object oGuard;
    object oScyllua = GetNearestObjectByTag("Scyllua", oPC);

    ChangeToStandardFaction(oScyllua, STANDARD_FACTION_DEFENDER);
    AssignCommand(oScyllua, DetermineCombatRound(GetNearestEnemy()));

    oGuard = GetFirstObjectInArea(oArea);
    while(oGuard != OBJECT_INVALID)
    {
        if(GetTag(oGuard) == "FzoulGuard" &&
           GetObjectType(oGuard) == OBJECT_TYPE_CREATURE)
        {
            ChangeToStandardFaction(oGuard, STANDARD_FACTION_DEFENDER);
            SetIsTemporaryFriend(oPC, oGuard);
            AssignCommand(oGuard, DetermineCombatRound(GetNearestEnemy()));
        }
        oGuard = GetNextObjectInArea(oArea);
    }
}

//Orcus allies turn hostile
void ChangeOrcusAlliesFaction(object oPC)
{
    object oArea = GetArea(oPC);
    object oDemon;

    oDemon = GetFirstObjectInArea(oArea);
    while(oDemon != OBJECT_INVALID)
    {
        if((GetTag(oDemon) == "OrcusAlly" || GetTag(oDemon) == "OrcusLieutenant") &&
           GetObjectType(oDemon) == OBJECT_TYPE_CREATURE)
        {
            ChangeToStandardFaction(oDemon, STANDARD_FACTION_HOSTILE);
            DelayCommand(0.3, AssignCommand(oDemon, DetermineCombatRound(GetNearestEnemy())));
        }
        oDemon = GetNextObjectInArea(oArea);
    }
}

//Orcus teleports to PC and attacks
void OrcusAttack(object oPC)
{
     object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
     object oWP = GetWaypointByTag("WP_ZKTEM_ORCUS_JUMP");

     ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                           EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE),
                           GetLocation(oWP));
     ActionJumpToLocation(GetLocation(oWP));
     ActionDoCommand(ChangeToStandardFaction(oOrcus, STANDARD_FACTION_HOSTILE));
     ActionDoCommand(DetermineCombatRound(oPC));
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_ZKTEM_CS_PC_START", FALSE);
    SetupActors(oPC);
}

// Speak with Fzoul
void next0(float fTime)
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 25.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    //Converse with Fzoul
    else if (fTime == 4.0)
    {
        //CutsceneNextShot called from Fzoul dialog
        AssignCommand(oFzoul, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

void next1(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        BlackScreen(oPC);
        CutsceneEnd();
    }
}

//Ensure actors are set-up, and dialog aborted
void abort()
{
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    //Abort any ongoing dialog
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oFzoul = CutsceneGetActor(NPC_TAG_FZOUL);
    object oMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oOrcus = CutsceneGetActor(NPC_TAG_ORCUS);
    object oScyllua = CutsceneGetActor(NPC_TAG_SCYLLUA);
    object oPC = CutsceneGetPC();
    object oTempleDoor = GetNearestObjectByTag("ZhentTemple_Zhent2", oPC);

    effect eVFX;

    AssignCommand(oPC, SetCameraFacing(270.0, 25.0, 50.0));
    AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTEM_CS_PC_END"))));

    //Close and lock temple door
    AssignCommand(oTempleDoor, ActionCloseDoor(oTempleDoor));
    SetLocked(oTempleDoor, TRUE);

    //Make Scyllua a friend of the PC to ensure she falls unconscious at 1hp
    FriendSetMaster(oPC, oScyllua);

    //Scyllua summons and rides her Nightmare
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2), oScyllua);
    SetPhenoType(3, oScyllua);
    SetCreatureTailType(67, oScyllua);

    //Position Fzoul and Maganus for post-cutscene
    AssignCommand(oFzoul, ClearAllActions(TRUE));
    AssignCommand(oMaganus, ClearAllActions(TRUE));
    AssignCommand(oFzoul,
       JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTEM_CS_FZOUL_BATTLE"))));
    AssignCommand(oMaganus,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_ZKTEM_CS_MAGANUS_BATTLE"))));

    eVFX = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oFzoul);
    eVFX = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oMaganus);

    //Don't allow Orcus, Fzoul, or Maganus to be conversed with during battle
    SetLocalInt(oFzoul, "nBusy", 1);
    SetLocalInt(oMaganus, "nBusy", 1);
    SetLocalInt(oOrcus, "nBusy", 1);

    //Switch on the director to manage Fzoul and Maganus actions
    PlotLevelSet(PLC_TAG_DIRECTOR, 1);

    //Demons turn hostile, Fzoul guards assist PC
    AssignCommand(oOrcus, OrcusAttack(oPC));
    ChangeOrcusAlliesFaction(oPC);
    ChangeFzoulAlliesFaction(oPC);

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
