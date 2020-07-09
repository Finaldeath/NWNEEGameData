// this is the cutscene where gorgomorz monologues to some tanarukks

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "hf_in_npc"
#include "hf_in_util"
#include "nw_i0_generic"

void SpawnTanarukks(object oPC)
{
    object oWP = GetWaypointByTag("WP_ar2201a_CUT1_GORG_0");
    object oGorgo = CreateObject(OBJECT_TYPE_CREATURE, "ks_gorgomorz", GetLocation(oWP));
    CutsceneAddActor("ks_gorgomorz", oGorgo);
    SetPlotFlag(oGorgo, TRUE);

    oWP = GetWaypointByTag("WP_ar2201a_CUT1_ORC0_0");
    CreateObject(OBJECT_TYPE_CREATURE, "ks_lair_general", GetLocation(oWP));

    int i;
    for (i=1; i<=6; i++)
    {
        string sWP = "WP_ar2201a_CUT1_ORC0_";
        object oWP = GetWaypointByTag(sWP+IntToString(i));
        if (i<5)
            CreateObject(OBJECT_TYPE_CREATURE, "ks_lair_tanarukk", GetLocation(oWP), FALSE, "_ar2201a_orc_"+IntToString(i));
        else
        if (i == 5)
            CreateObject(OBJECT_TYPE_CREATURE, "ks_lair_tanwd", GetLocation(oWP), FALSE, "_ar2201a_orc_"+IntToString(i));
        else
            CreateObject(OBJECT_TYPE_CREATURE, "ks_lair_tanarukk", GetLocation(oWP), FALSE, "ks_lair_tanarukk");
    }
}

void TanarukkCheer(string sTag, object oPC)
{
    object oNPC = GetObjectInArea(sTag, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_FIRE), oNPC);
    AssignCommand(oNPC, PlaySound("c_orc_bat1"));
    AssignCommand(oNPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
}

void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_ar2201a_CUT1_START", FALSE);
}

// spawn the creatures
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");

    if (fTime == 0.0)
    {
        SpawnTanarukks(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 24.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oGorg, PlaySound("c_devil_bat2"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        int i;
        for (i=1; i<=5; i++)
        {
            string sTag = "_ar2201a_orc_"+IntToString(i);
            object oOrc = GetObjectByTag(sTag);
            AssignCommand(oOrc, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 10.0));
        }
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneNextShot();
    }
}

// gorgomorz and tanarukk talk
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");

    if (fTime == 0.0)
    {
        AssignCommand(oGorg, ActionStartConversation(oPC, "ks_ar2201a_gorgo", FALSE, FALSE));
        // next event is given by an action taken script in the dialog
    }
}

// gorgomorz disappears through a fire portal
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oGorg = CutsceneGetActor("ks_gorgomorz");

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        MusicBattlePlay(GetArea(oPC));
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 20.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);
        AssignCommand(oGorg, PlaySound("c_devil_bat1"));
        AssignCommand(oGorg, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        TanarukkCheer("ks_lair_tanarukk", oPC);
        int i;
        for (i=1; i<=5; i++)
        {
            string sTag = "_ar2201a_orc_"+IntToString(i);
            TanarukkCheer(sTag, oPC);
        }
        location lLoc = GetLocation(oGorg);
        DrawCircle(GetLocation(oGorg), 3.0, VFX_IMP_FLAME_M);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), lLoc);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        location lLoc = GetLocation(oGorg);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), lLoc);
        DestroyObject(oGorg);
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        CutsceneEnd();
    }
}

// the delay here just gives the PC a chance to teleport away
// from the cutscene before being attacked by the bad guys
void AttackPC(object oPC)
{
    int i;
    for (i=1; i<=5; i++)
    {
        string sTag = "_ar2201a_orc_"+IntToString(i);
        object oNPC = GetObjectByTag(sTag);
        SetPlotFlag(oNPC, FALSE);
        DelayCommand(3.5, ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE));
        DelayCommand(3.75, AssignCommand(oNPC, ClearAllActions(TRUE)));
        if(i == 5)
        {
            DelayCommand(4.0, AssignCommand(oNPC, DetermineCombatRound(oPC)));
        }
        else
        {
            DelayCommand(4.0, AssignCommand(oNPC, ActionAttack(oPC)));
        }
    }

    object oNPC = GetObjectInArea("ks_lair_tanarukk", oPC);
    SetPlotFlag(oNPC, FALSE);
    DelayCommand(3.5, ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE));
    DelayCommand(3.75, AssignCommand(oNPC, ClearAllActions(TRUE)));
    DelayCommand(4.0, AssignCommand(oNPC, DetermineCombatRound(oPC)));
}

void end()
{
    object oPC = GetFirstPC();

    // update plot
    SetLocalInt(oPC, "nGorgomorzAppeared", 1);
    AddJournalQuestEntry("j201", 8, oPC);

    // jump pc to endpoint
    TeleportToWaypoint(oPC, "WP_ar2201a_CUT1_END", TRUE);

    // gorgomorz is gone
    object oGorg = CutsceneGetActor("ks_gorgomorz");
    DestroyObject(oGorg);
    object oGeneral = GetNearestObjectByTag("ks_lair_general", oPC, 1);
    if(!GetIsDead(oGeneral))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oGeneral);
    }

    AssignCommand(oPC, SetCameraFacing(270.0, 20.0, 50.0));
    // tanarukk attack
    AttackPC(oPC);
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
