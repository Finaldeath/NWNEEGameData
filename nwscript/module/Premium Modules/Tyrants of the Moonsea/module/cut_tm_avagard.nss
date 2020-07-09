//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_avagard
// DATE: February 18, 2019
// AUTH: Rich Barker
// NOTE: Cutscene at end of Naval Battle on Avagard's Ship
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_util"

const string NPC_RESREF_AVAGARD = "avagard";
const string NPC_TAG_AVAGARD = "Avagard";
const string WP_TAG_AVAGARD_INIT = "WP_THKTUF_CS_AVAGARD_SPAWN";

const string NPC_RESREF_ILANDRA = "ilandra";
const string NPC_TAG_ILANDRA = "Ilandra";

const string NPC_RESREF_VERIS = "veris";
const string NPC_TAG_VERIS = "Veris";

const string NPC_RESREF_CAPTAIN1 = "piratecaptain1";
const string NPC_TAG_CAPTAIN1 = "PirateCaptain1";
const string WP_TAG_CAPTAIN1_INIT = "WP_THKTUF_CS_CAPTAIN1_SPAWN";

const string NPC_RESREF_CAPTAIN2 = "piratecaptain2";
const string NPC_TAG_CAPTAIN2 = "PirateCaptain2";
const string WP_TAG_CAPTAIN2_INIT = "WP_THKTUF_CS_CAPTAIN2_SPAWN";

const string NPC_RESREF_CAPTAIN3 = "piratecaptain3";
const string NPC_TAG_CAPTAIN3 = "PirateCaptain3";
const string WP_TAG_CAPTAIN3_INIT = "WP_THKTUF_CS_CAPTAIN3_SPAWN";

const string NPC_TAG_KRAMER = "Kramer";

const string WP_TAG_PC_INIT = "WP_MOBT_CS_PC_PARLAY";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_KRAMER, oPC);
    CutsceneAddActor(NPC_TAG_KRAMER, oActor);

    CutsceneSpawnActor(NPC_RESREF_AVAGARD, NPC_TAG_AVAGARD, WP_TAG_AVAGARD_INIT);
    CutsceneSpawnActor(NPC_RESREF_CAPTAIN1, NPC_TAG_CAPTAIN1, WP_TAG_CAPTAIN1_INIT);

    //If Veris has not been killed, spawn him here, otherwise spawn generic captain
    if(PlotLevelGet("VerisDead") == 0)
    {
        DestroyObject(GetObjectByTag(NPC_TAG_VERIS));
        oActor = CutsceneSpawnActor(NPC_RESREF_VERIS, NPC_TAG_CAPTAIN2, WP_TAG_CAPTAIN2_INIT);
        //If Veris previously gave PC his scimitar, remove it from his inventory
        //Also remove his head, as PC has his ring to use as proof to Dryden
        if(PlotLevelGet("Veris") == 2)
        {
            object oScimitar = GetItemPossessedBy(oActor, "NW_WSWMSC005");
            DestroyObject(oScimitar);
            object oHead = GetItemPossessedBy(oActor, "VerisHead");
            DestroyObject(oHead);
        }
    }
    else
    {
        CutsceneSpawnActor(NPC_RESREF_CAPTAIN2, NPC_TAG_CAPTAIN2, WP_TAG_CAPTAIN2_INIT);
    }

    //If Ilandra has not been killed, spawn her here, otherwise spawn generic captain
    if(PlotLevelGet("IlandraDead") == 0)
    {
        oActor = CutsceneSpawnActor(NPC_RESREF_ILANDRA, NPC_TAG_ILANDRA, WP_TAG_CAPTAIN3_INIT);
        //If Ilandra has been persuaded to leave, or given PC her ring,
        //remove her head from her inventory
        if(PlotLevelGet("IlandraPirate") > 0 && PlotLevelGet("IlandraPirate") != 3)
        {
            object oHead = GetItemPossessedBy(oActor, "IlandrasHead");
            DestroyObject(oHead);
        }
    }
    else
    {
        CutsceneSpawnActor(NPC_RESREF_CAPTAIN3, NPC_TAG_CAPTAIN3, WP_TAG_CAPTAIN3_INIT);
    }
}

//Turn nearby pirates hostile
void TurnPiratesHostile(object oPC)
{
    int i = 1;

    object oArea = GetArea(oPC);
    object oPirate = GetFirstObjectInArea(oArea);

    while(oPirate != OBJECT_INVALID)
    {
        if(GetTag(oPirate) == "PirateAvagard" &&
           GetObjectType(oPirate) == OBJECT_TYPE_CREATURE)
        {
            ChangeToStandardFaction(oPirate, STANDARD_FACTION_HOSTILE);
            AssignCommand(oPirate, DetermineCombatRound(oPC));
        }
        oPirate = GetNextObjectInArea(oArea);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, WP_TAG_PC_INIT, FALSE);
    SetupActors(oPC);
}

// Avagard speaks with PC
void next0(float fTime)
{
    object oAvagard = CutsceneGetActor(NPC_TAG_AVAGARD);
    object oKramer = CutsceneGetActor(NPC_TAG_KRAMER);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        AssignCommand(oKramer,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTUF_CS_KRAMER_JUMP"))));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 15.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        //CutsceneNextShot called from Avagard dialog
        AssignCommand(oAvagard, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

//Clear any dialog and ensure Kramer is present
void abort()
{
    object oKramer;
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    oKramer = CutsceneGetActor(NPC_TAG_KRAMER);
    AssignCommand(oKramer,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_THKTUF_CS_KRAMER_JUMP"))));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oAvagard = CutsceneGetActor(NPC_TAG_AVAGARD);
    object oCaptain1 = CutsceneGetActor(NPC_TAG_CAPTAIN1);
    object oCaptain2 = CutsceneGetActor(NPC_TAG_CAPTAIN2);
    object oCaptain3 = CutsceneGetActor(NPC_TAG_CAPTAIN3);
    object oCaptain4 = CutsceneGetActor(NPC_TAG_ILANDRA);
    object oPC = CutsceneGetPC();

    location lAvagard = GetLocation(GetWaypointByTag(WP_TAG_AVAGARD_INIT));

    effect eVFX = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);

    SetLocalInt(oAvagard, "nBusy", 1);
    SetLocalInt(oCaptain2, "nBusy", 1);
    if(GetIsObjectValid(oCaptain4))
    {
        SetLocalInt(oCaptain4, "nBusy", 1);
    }

    CutMoveAssociatesTo(oPC, "WP_MOBT_CS_HENCH_PARLAY");

    AssignCommand(oPC, SetCameraFacing(0.0, 25.0, 50.0));
    AddJournalQuestEntry("ThePirateKingsBlockade", 40, oPC);

    AssignCommand(oAvagard, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.0));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oAvagard, 3.0));
    DelayCommand(3.0,
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(VFX_FNF_PWSTUN), lAvagard));
    DelayCommand(5.0,
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), lAvagard));
    DelayCommand(5.2, DestroyObject(oAvagard));

    DelayCommand(3.0, GoHostile(oCaptain1));
    DelayCommand(3.1, GoHostile(oCaptain2));

    if(GetIsObjectValid(oCaptain3))
    {
        DelayCommand(3.2, GoHostile(oCaptain3));
    }
    else
    {
        DelayCommand(3.2, GoHostile(oCaptain4));
    }

    DelayCommand(3.3, TurnPiratesHostile(oPC));

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
