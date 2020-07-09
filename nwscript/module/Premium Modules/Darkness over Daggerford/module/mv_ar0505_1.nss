// this is the cutscene where ilkor talks to the player in daggerford

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_npc"
#include "hf_in_util"
#include "nw_i0_generic"

// spawn the scene actors
void spawnNPCs(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR0505_CUT1_ILKOR");
    object oIlkor = CreateObject(OBJECT_TYPE_CREATURE, "ac_ilkor", GetLocation(oWP));
    CutsceneAddActor("ac_ilkor", oIlkor);
    SetLocalInt(oIlkor, "HF_SP_LIMIT_LEVELUP_MAX", 16);
    SpawnLevelupCreature(oIlkor, SpawnGetPartyCR(oPC, 50));

    object oCreech = GetObjectInArea("ac_creech", oPC);
    CutsceneAddActor("ac_creech", oCreech);
}

// spawn a skeleton friend
void summonSkeleton(object oPC)
{
    object oSkel = GetObjectInArea("NW_SKELWARR01", oPC);
    if(!GetIsObjectValid(oSkel))
    {
        object oWP = GetWaypointByTag("WP_AR0505_CUT1_SKEL");
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), GetLocation(oWP));
        oSkel = CreateObject(OBJECT_TYPE_CREATURE, "nw_skelwarr01", GetLocation(oWP));
        ChangeToStandardFaction(oSkel, STANDARD_FACTION_COMMONER);
        CutsceneAddActor("ac_skel", oSkel);
        SpawnLevelupCreature(oSkel, SpawnGetPartyCR(oPC, 50));
    }
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR0505_CUT1_START");
    CutsceneMusic(TRACK_BATTLE_CITY1);
    spawnNPCs(oPC);
}

// ilkor is busy reading a book, but his imp creech spots the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oIlkor = CutsceneGetActor("ac_ilkor");
    object oCreech = CutsceneGetActor("ac_creech");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 245.0, 6.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 245.0, 2.0, 80.0, CAMERA_TRANSITION_TYPE_SLOW);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oCreech, PlaySound("c_mephit_bat1"));
        AssignCommand(oCreech, ActionSpeakString("*skree!*"));
        AssignCommand(oCreech, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        // ilkor hears the player
        AssignCommand(oIlkor, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        AssignCommand(oIlkor, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // ilkor confronts the player
        AssignCommand(oIlkor, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// ilkor will summon help and fight depending on what the player said
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oIlkor = CutsceneGetActor("ac_ilkor");
    object oSkel  = CutsceneGetActor("ac_skel");

    if (fTime == 0.0)
    {
        if (GetLocalInt(oIlkor, "HF_ARG") == 1)
        {
            // summon a skeleton friend
            AssignCommand(oIlkor, PlaySound("vs_chant_necr_lm"));
            AssignCommand(oIlkor, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oIlkor);
            CutsceneNext(3.0);
        }
        else
        {
            CutsceneEnd();
        }
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 200.0, 2.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        summonSkeleton(oPC);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oSkel, PlaySound("c_skeltwar_bat1"));
        AssignCommand(oSkel, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_EVIL), oSkel);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CutsceneEnd();
    }
}

// ilkor will fight depending on what the player said to him
void end()
{
    object oPC = GetFirstPC();
    object oIlkor = CutsceneGetActor("ac_ilkor");
    object oCreech = CutsceneGetActor("ac_creech");

    if (GetLocalInt(oIlkor, "HF_ARG") == 1)
    {
        summonSkeleton(oPC);
        object oSkel = CutsceneGetActor("ac_skel");
        // ilkor and friends go hostile
        DelayCommand(5.0,ChangeToStandardFaction(oIlkor, STANDARD_FACTION_HOSTILE));
        DelayCommand(5.0,ChangeToStandardFaction(oSkel, STANDARD_FACTION_HOSTILE));
        DelayCommand(5.0,ChangeToStandardFaction(oCreech, STANDARD_FACTION_HOSTILE));
        DelayCommand(5.5,AssignCommand(oIlkor, DetermineCombatRound(oPC)));
        DelayCommand(5.5,AssignCommand(oSkel, ActionAttack(oPC)));
        DelayCommand(5.5,AssignCommand(oCreech, ActionAttack(oPC)));
    }
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
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
