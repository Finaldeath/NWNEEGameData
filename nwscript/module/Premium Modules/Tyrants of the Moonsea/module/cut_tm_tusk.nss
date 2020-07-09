//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_tusk
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue on meeting Elf's brother, Tusk, in Scarred Lands
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_TAG_ELF = "Elf";

const string NPC_RESREF_SLINK = "slink";
const string NPC_TAG_SLINK = "Slink";
const string WP_TAG_SLINK_SPAWN = "WP_TH_SCL_SLINK_SPAWN";

const string NPC_RESREF_TUSK = "tusk";
const string NPC_TAG_TUSK = "Tusk";
const string WP_TAG_TUSK_SPAWN = "WP_TH_SCL_TUSK_SPAWN";

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_ELF, oPC);
    CutsceneAddActor(NPC_TAG_ELF, oActor);

    if(CutsceneGetActor(NPC_TAG_TUSK) == OBJECT_INVALID)
    {
        oActor = CutsceneSpawnActor(NPC_RESREF_TUSK, NPC_TAG_TUSK, WP_TAG_TUSK_SPAWN);
        CutsceneAddActor(NPC_TAG_TUSK, oActor);
    }

    if(CutsceneGetActor(NPC_TAG_SLINK) == OBJECT_INVALID)
    {
        oActor = CutsceneSpawnActor(NPC_RESREF_SLINK, NPC_TAG_SLINK, WP_TAG_SLINK_SPAWN);
        CutsceneAddActor(NPC_TAG_SLINK, oActor);
    }
}

//Turn Tusk and his tribe hostile
void TurnOrcsHostile(object oPC)
{
    int i = 1;

    object oOrc;
    object oTusk = CutsceneGetActor(NPC_TAG_TUSK);

    location lLoc = GetLocation(oTusk);

    ChangeToStandardFaction(oTusk, STANDARD_FACTION_HOSTILE);
    AssignCommand(oTusk, DetermineCombatRound());

    oOrc = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    while(oOrc != OBJECT_INVALID)
    {
        if(GetTag(oOrc) == "TuskOrc")
        {
            ChangeToStandardFaction(oOrc, STANDARD_FACTION_HOSTILE);
            AssignCommand(oOrc, DetermineCombatRound(oPC));
        }
        oOrc = GetNextObjectInShape(SHAPE_SPHERE, 25.0, lLoc, FALSE, OBJECT_TYPE_CREATURE);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions());
    BlackScreen(oPC);
    CutsceneStart(FALSE, FALSE, "", FALSE);
    SetupActors(oPC);
}

// Tusk talks to player
void next0(float fTime)
{
    object oActor;
    object oElf = CutsceneGetActor(NPC_TAG_ELF);
    object oSlink = CutsceneGetActor(NPC_TAG_SLINK);
    object oTusk = CutsceneGetActor(NPC_TAG_TUSK);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(1.8, 90.0, 15.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oPC,
                JumpToLocation(GetLocation(GetWaypointByTag("WP_TH_SCL_CS_PC_START"))));
        //position Elf if present
        if(GetIsObjectValid(oElf))
        {
            SetLocalInt(oElf, "nCutsceneMode", 1);
            AssignCommand(oElf, ClearAllActions(TRUE));
            AssignCommand(oElf,
                JumpToLocation(GetLocation(GetWaypointByTag("WP_TH_SCL_CS_ELF"))));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneImmobilize(), oElf);
        }
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        oActor = CutsceneSpawnActor(NPC_RESREF_TUSK, NPC_TAG_TUSK, WP_TAG_TUSK_SPAWN);
        CutsceneAddActor(NPC_TAG_TUSK, oActor);
        oActor = CutsceneSpawnActor(NPC_RESREF_SLINK, NPC_TAG_SLINK, WP_TAG_SLINK_SPAWN);
        CutsceneAddActor(NPC_TAG_SLINK, oActor);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oSlink, ActionForceFollowObject(oTusk, 2.0));
        //CutsceneNextShot() invoked from Tusk conversation
        AssignCommand(oTusk, ActionStartConversation(oPC, "", FALSE, FALSE));
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

//Ensure Officer dialog aborted
void abort()
{
    object oPC = CutsceneGetPC();

    SetupActors(oPC);
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oElf = CutsceneGetActor(NPC_TAG_ELF);
    object oSlink = CutsceneGetActor(NPC_TAG_SLINK);
    object oTusk = CutsceneGetActor(NPC_TAG_TUSK);
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(90.0, 25.0, 50.0));

    //Slink escapes to alert Kur-Tharsu
    SetLocalInt(oSlink, "HF_EXIT_RUN", 1);
    ExecuteScript("hf_cs_exit", oSlink);

    //Indicate PC has met Tusk
    PlotLevelSet(NPC_TAG_TUSK, 1);
    if(GetIsObjectValid(oElf))
    {
        PlotLevelSet(NPC_TAG_ELF, 14);
        //Award xp for Elf being present when Tusk reveals his true nature
        GiveXPToCreature(oPC, 250);
        //Elf is no longer cutscene frozen
        RemoveAssociateEffects(oElf);
        //Elf attacks Tusk
        DelayCommand(3.5, AssignCommand(oElf, DetermineCombatRound(oTusk)));
        DelayCommand(4.0, SetLocalInt(oElf, "nCutsceneMode", 0));
    }

    DelayCommand(3.0, TurnOrcsHostile(oPC));

    CutMoveAssociatesTo(oPC, "WP_TH_SCL_CS_PC_START");

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
