// this is the cutscene where drath confronts the player in illefarn

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "X0_I0_PARTYWIDE"
#include "hf_in_util"

// spawn drath and all of his zhent friends
void SpawnZhents(object oPC)
{
    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);

    // spawn drath
    object oWP = GetWaypointByTag("WP_AR2504_CUT1_DRATH");
    object oDrath = CreateObject(OBJECT_TYPE_CREATURE, "bw_capt_drath", GetLocation(oWP));
    ChangeToStandardFaction(oDrath, STANDARD_FACTION_COMMONER);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oDrath);
    CutsceneAddActor("bw_capt_drath", oDrath);

    // spawn zhents and griffons
    int i = 1;
    oWP = GetObjectByTag("WP_AR2504_CUT1_SPAWN_ZHENT", i);
    while (GetIsObjectValid(oWP))
    {
        string sTag = GetLocalString(oWP, "HF_SPAWN_TAG");
        object o = CreateObject(OBJECT_TYPE_CREATURE, sTag, GetLocation(oWP), FALSE, "_ar2504_zhent");
        ChangeToStandardFaction(o, STANDARD_FACTION_COMMONER);
        SetLocalInt(o, "HF_DISABLE_AM", 1);
        oWP = GetObjectByTag("WP_AR2504_CUT1_SPAWN_ZHENT", ++i);
    }
}

void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(TRUE, FALSE, "WP_AR2504_CUT1_START", FALSE);
    SpawnZhents(oPC);
}

// spawn the creatures
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);
        CutsceneCameraSetup(-1.0, 30.0, 1.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        CutsceneNextShot();
    }
}

// drath taunts the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oDrath = CutsceneGetActor("bw_capt_drath");
    object oZhen1 = GetObjectInArea("_ar2504_zhent", oPC, 1);
    object oZhen2 = GetObjectInArea("_ar2504_zhent", oPC, 2);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        AssignCommand(oDrath, ActionDoCommand(PlaySound("vs_drathar_063")));
        AssignCommand(oDrath, ActionSpeakString(q+"What! How did you get in here?"+q));
        AssignCommand(oZhen1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oDrath, PlaySound("vs_drathar_064"));
        AssignCommand(oDrath, SpeakString(q+"Bah! It matters not! I shall deal with you myself!"+q));
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        AssignCommand(oZhen2, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oDrath, PlaySound("vs_drathar_065"));
        AssignCommand(oDrath, SpeakString(q+"Have you met my Griffons? Or should I call them...Zhentarim?"+q));
        AssignCommand(oDrath, ActionWait(4.0));
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0));
        AssignCommand(oZhen1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        AssignCommand(oZhen2, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oDrath, PlaySound("vs_drathar_066"));
        AssignCommand(oDrath, SpeakString(q+"You, " + GetName(oPC) + ", have the unfortunate habit of remaining alive."+q));
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 4.0));
        AssignCommand(oZhen1, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        AssignCommand(oDrath, PlaySound("vs_drathar_067"));
        AssignCommand(oDrath, SpeakString(q+"That is a habit which I am about to break!"+q));
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        AssignCommand(oZhen2, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
        CutsceneNext(34.0);
    }
    else if (fTime == 34.0)
    {
        CutsceneNextShot();
    }
}

// drath draws his sword and calls for battle!
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oDrath = CutsceneGetActor("bw_capt_drath");
    object oZhen1 = GetObjectInArea("_ar2504_zhent", oPC, 1);
    object oZhen2 = GetObjectInArea("_ar2504_zhent", oPC, 2);

    if (fTime == 0.0)
    {
        object oArea = GetArea(oPC);
        MusicBattleChange(oArea, TRACK_HOTU_BATTLE_LARGE);
        MusicBattlePlay(oArea);
        PlayVoiceChat(VOICE_CHAT_BATTLECRY2, oDrath);
        AssignCommand(oDrath, ActionEquipMostDamagingMelee(oPC));
        AssignCommand(oDrath, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 2.0));
        AssignCommand(oZhen1, ActionEquipMostDamagingMelee(oPC));
        AssignCommand(oZhen2, ActionEquipMostDamagingMelee(oPC));
        AssignCommand(oZhen1, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        AssignCommand(oZhen2, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneEnd();
    }
}

// the delay here just gives the PC a chance to teleport away
// from the cutscene before being attacked by the bad guys
void AttackPC(string sTag, object oPC)
{
    int i = 1;
    object oZhent = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oZhent))
    {
        ChangeToStandardFaction(oZhent, STANDARD_FACTION_HOSTILE);
        DelayCommand(4.0, AssignCommand(oZhent, ActionAttack(oPC)));
        oZhent = GetObjectInArea(sTag, oPC, ++i);
    }
}

void end()
{
    object oPC = GetFirstPC();

    // add journal entry
    AddJournalQuestEntry("j16", 10, oPC);
    TeleportToWaypoint(oPC, "WP_AR2504_CUT1_END", FALSE);

    // zhents attack
    AttackPC("bw_capt_drath", oPC);
    AttackPC("_ar2504_zhent", oPC);
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
