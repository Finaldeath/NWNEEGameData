// this cutscene fires when the player enters AR1110 (Nine Hells)

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_spawn"
#include "nw_i0_generic"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;
    int nLevels30 = SpawnGetPartyCR(oPC, 30);
    int nLevels70 = SpawnGetPartyCR(oPC, 70);

    oWP = GetWaypointByTag("WP_AR1110_CUT1_ABATORRU");
    object oDevil = CreateObject(OBJECT_TYPE_CREATURE, "ks_abatorru", GetLocation(oWP));
    SpawnLevelupCreature(oDevil, nLevels70);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oDevil);
    CutsceneAddActor("ks_abatorru", oDevil);

    oWP = GetWaypointByTag("WP_AR1110_CUT1_EDALSEYE");
    object oMage = CreateObject(OBJECT_TYPE_CREATURE, "ks_edalseye", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(585), oMage); // silver eyes
    CutsceneAddActor("ks_edalseye", oMage);

    int i;
    for (i=1; i<=4; i++)
    {
        oWP = GetWaypointByTag("WP_AR1110_CUT1_VROCK_" + IntToString(i));
        string sTag = "_vrock"+IntToString(i);
        object oVrock = CreateObject(OBJECT_TYPE_CREATURE, "ks_vrock", GetLocation(oWP), FALSE, sTag);
        SpawnLevelupCreature(oVrock, nLevels30);
        CutsceneAddActor(sTag, oVrock);
    }
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    spawnActors(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1110_CUT1_START", FALSE);
}

// vrocks are busy
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oVrock1 = CutsceneGetActor("_vrock1");
    object oVrock2 = CutsceneGetActor("_vrock2");
    object oVrock3 = CutsceneGetActor("_vrock3");
    object oVrock4 = CutsceneGetActor("_vrock4");

    if (fTime == 0.0)
    {
        // allow some time for vrocks to spawn and camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 115.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // vrocks are getting busy
        AssignCommand(oVrock1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oVrock2, PlaySound("c_vrock_slct"));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // vrocks turn to face player
        AssignCommand(oVrock1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oVrock2, SetFacingPoint(GetPosition(oPC)));
        CutsceneNext(7.5);
    }
    else if (fTime == 7.5)
    {
        // vrocks are getting angry
        AssignCommand(oVrock1, PlaySound("c_vrock_atk1"));
        AssignCommand(oVrock2, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // vrocks are getting angry
        AssignCommand(oVrock1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oVrock2, PlaySound("c_vrock_atk2"));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        CutsceneNextShot();
    }
}

// abatorru talks to the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oDevil  = CutsceneGetActor("ks_abatorru");
    object oVrock1 = CutsceneGetActor("_vrock1");
    object oVrock2 = CutsceneGetActor("_vrock2");
    object oVrock3 = CutsceneGetActor("_vrock3");
    object oVrock4 = CutsceneGetActor("_vrock4");

    if (fTime == 0.0)
    {
        RemoveAssociateEffects(oPC);
        CutsceneMoveTo("WP_AR1110_CUT1_CAM1");
        CutsceneCameraSetup(-1.0, 70.0, 13.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // vrocks slink into position
        object oWP1 = GetWaypointByTag("WP_AR1110_CUT1_VROCK_1_MOVE");
        AssignCommand(oVrock1, ActionMoveToObject(oWP1));
        object oWP2 = GetWaypointByTag("WP_AR1110_CUT1_VROCK_2_MOVE");
        AssignCommand(oVrock2, ActionMoveToObject(oWP2));
        object oWP3 = GetWaypointByTag("WP_AR1110_CUT1_VROCK_3_MOVE");
        AssignCommand(oVrock3, ActionMoveToObject(oWP3));
        object oWP4 = GetWaypointByTag("WP_AR1110_CUT1_VROCK_4_MOVE");
        AssignCommand(oVrock4, ActionMoveToObject(oWP4));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oDevil);
        AssignCommand(oDevil, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // devil talks to player (this dialog triggers end of cutscene)
        AssignCommand(oDevil, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next2(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        MusicBattlePlay(GetArea(oPC));
        CutsceneEnd();
    }
}

// the vrocks attack the player and the portal home is created
void end()
{
    object oPC = GetFirstPC();

    // abatorru has finished speaking with the player
    PlotLevelSet("ks_abatorru", 1);
    PlotLevelSet("ks_edalseye", 1);
    AddJournalQuestEntry("j83", 10, oPC);

    // vrocks go hostile and attack the player
    int i;
    for (i=1; i<=4; i++)
    {
        string sTag = "_vrock"+IntToString(i);
        object oVrock = CutsceneGetActor(sTag);
        ChangeToStandardFaction(oVrock, STANDARD_FACTION_HOSTILE);
        AssignCommand(oVrock, DetermineCombatRound());
    }

    // create the portal which allows the player to return home
    object oWP = GetWaypointByTag("WP_AR1110_PORTAL");
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal3", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    SetLocalString(oPortal, "DESTINATION_UP", "WP_AR1109_PORTAL_EXIT");
    SetLocalInt(oPortal, "NOFADE", 1); // because we jump into a cutscene
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
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
