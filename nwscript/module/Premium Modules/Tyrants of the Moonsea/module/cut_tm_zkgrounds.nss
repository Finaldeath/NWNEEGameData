//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_zkgrounds
// DATE: March 26, 2019
// AUTH: Rich Barker
// NOTE: Temple Grounds Warzone cutscene with Crippled Fang
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_util"

const string WP_TAG_PLAYER_INIT = "WP_ZK_TGW_CS_PC_START";

const string NPC_RESREF_DRACOLICH = "templefang";
const string NPC_TAG_DRACOLICH = "TempleTheCrippledFang";
const string WP_TAG_DRACOLICH_INIT = "WP_ZK_TGW_DRACOLICH_SPAWN";

const string NPC_RESREF_BALOR = "templebalor";
const string NPC_TAG_BALOR = "TempleBalor";
const string WP_TAG_BALOR_INIT = "WP_ZK_TGW_BALOR_SPAWN";

const string PLC_DRAGON_VFX = "ZKDragonVFX";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(PLC_DRAGON_VFX, oPC);
    CutsceneAddActor(PLC_DRAGON_VFX, oActor);
}

void start()
{
    CutsceneStart(TRUE, FALSE, WP_TAG_PLAYER_INIT, FALSE);
}

// Shot 0:
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    object oDracolich = CutsceneGetActor(NPC_TAG_DRACOLICH);
    object oVFX = CutsceneGetActor(PLC_DRAGON_VFX);

    if (fTime == 0.0)
    {
         BlackScreen(oPC);
         SetupActors(oPC);
         CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 270.0, 25.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        StopFade(oPC);
        CutsceneNext(5.0);
    }
    //Display undead dragon visual effect
    else if (fTime == 5.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON),
                            oVFX, 7.0);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        CutsceneSpawnActor(NPC_RESREF_DRACOLICH, NPC_TAG_DRACOLICH, WP_TAG_DRACOLICH_INIT);
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                              EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE),
                              GetLocation(GetWaypointByTag(WP_TAG_BALOR_INIT)));
         CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        CutsceneSpawnActor(NPC_RESREF_BALOR, NPC_TAG_BALOR, WP_TAG_BALOR_INIT);
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        CutsceneEnd();
    }
}

//Ensure Dracolich and Balor are created
void abort()
{
    object oPC = CutsceneGetPC();

    SetupActors(oPC);

    CutsceneSpawnActor(NPC_RESREF_DRACOLICH, NPC_TAG_DRACOLICH, WP_TAG_DRACOLICH_INIT);
    CutsceneSpawnActor(NPC_RESREF_BALOR, NPC_TAG_BALOR, WP_TAG_BALOR_INIT);
}

void end()
{
    object oPC = CutsceneGetPC();
    object oBalor1 = CutsceneGetActor(NPC_TAG_BALOR);
    object oBalor2 = GetNearestObjectByTag("TempleBalor2", oPC);
    object oBalor3 = GetNearestObjectByTag("TempleBalor3", oPC);
    object oDracolich = CutsceneGetActor(NPC_TAG_DRACOLICH);
    object oVFX = CutsceneGetActor(PLC_DRAGON_VFX);

    BlackScreen(oPC);
    DestroyObject(oVFX);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_ZK_TGW_CS_PC_END"))));
    AssignCommand(oPC, SetCameraFacing(270.0, 25.0, 50.0));

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());

    //Balors and Dracolich turn hostile
    GoHostile(oBalor1);
    GoHostile(oBalor2);
    GoHostile(oBalor3);
    GoHostile(oDracolich);

    FadeFromBlack(oPC, FADE_SPEED_FAST);
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
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}
