// this is the cutscene where karragh talks to the player in daggerford

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_npc"
#include "hf_in_util"

// create the blue gate
void CreateBlueGate(object oPC)
{
    object oBlueWP  = GetObjectByTag("wp_ar0807_blue");
    location lBlueWP = GetLocation(oBlueWP);
    object oGate = CreateObject(OBJECT_TYPE_PLACEABLE, "bw_ar0807_portal", lBlueWP);
    CutsceneAddActor("BlueGate", oGate);
}

// make the red gate if it doesn't already exist
void CreateRedGate(object oPC)
{
    object oGate = GetObjectInArea("bw_ar0807_pred", oPC);
    if (!GetIsObjectValid(oGate))
    {
        object oSound = GetObjectInArea("ar0807_sound", oPC);
        SoundObjectSetVolume(oSound, 127);
        SoundObjectPlay(oSound);
        object oRedWP  = GetObjectByTag("wp_ar0807_red");
        location lRedWP = GetLocation(oRedWP);
        oGate = CreateObject(OBJECT_TYPE_PLACEABLE, "bw_ar0807_pred", lRedWP);
    }
}

// summon a beast
void SummonBeast()
{
    object oFallMaster = GetObjectByTag("bw_ar0807_fall");
    SignalEvent(oFallMaster, EventUserDefined(502));
}

// summon some beasties; number based on player's hit dice and what
// .. happened during the convo
void SummonBeasties(object oPC, object oBoonMoppet)
{
    float fDelay = 0.0f;
    if (GetLocalInt(oBoonMoppet, "nBaddyWave") < 3)
    {
        int nBaddies = FloatToInt(IntToFloat(GetHitDice(oPC)) / 5);
        int nCurWave = GetLocalInt(oBoonMoppet, "nBaddyWave");
        int nBonus = (3 - nCurWave);
        nBaddies = nBaddies + nBonus;
        while (nBaddies > 0)
        {
            DelayCommand(fDelay, SummonBeast());
            fDelay += 0.5f;
            nBaddies -= 1;
        }
    }
}

// boonmoppet appears in the hole
void SummonBoonmoppet(location lLoc)
{
    object oImp = CreateObject(OBJECT_TYPE_CREATURE, "bw_boonmoppet", lLoc);
    CutsceneAddActor("bw_boonmoppet", oImp);
    SetPlotFlag(oImp, TRUE);
    SetLocalInt(oImp, "HF_ARG", 3);
}

// the girl appears in the hole
void SummonGirl(object oPC)
{
    object oGirl = GetObjectByTag("ac_boonmoppet");
    CutsceneAddActor("ac_boonmoppet", oGirl);
    object oWP = GetObjectByTag("wp_ar0807_girl");
    SetLocalInt(oGirl, "nGaveChase", 1);
    AssignCommand(oGirl, ClearAllActions(TRUE));
    AssignCommand(oGirl, JumpToLocation(GetLocation(oWP)));
    SetPlotFlag(oGirl, TRUE);
    SetLocalInt(oGirl, "HF_ARG", 2);
    effect eTelep = EffectVisualEffect(VFX_IMP_UNSUMMON);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTelep, GetLocation(oWP));
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE, "wp_ar0807_entry");
    CutsceneMusic(TRACK_HOTU_FIREPLANE);
    CreateBlueGate(oPC);
}

// the girl appears and talks to the player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oGirl = CutsceneGetActor("ac_boonmoppet");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, 70.0, 25.0, 40.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, 70.0, 15.0, 60.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // girl appears
        SummonGirl(oPC);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // girl talks to player
        AssignCommand(oGirl, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// boonmoppet appears and talks to the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oBoonmoppet = CutsceneGetActor("bw_boonmoppet");
    object oGirl = CutsceneGetActor("ac_boonmoppet");

    if (fTime == 0.0)
    {
        // boonmoppet appears
        location lGirl = GetLocation(oGirl);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), lGirl);
        DestroyObject(oGirl);
        DelayCommand(0.5, SummonBoonmoppet(lGirl));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        // boonmoppet talks to the player
        AssignCommand(oBoonmoppet, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// boonmoppet leaves and the scene ends
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oBoonmoppet = CutsceneGetActor("bw_boonmoppet");
    object oGate = CutsceneGetActor("BlueGate");

    if (fTime == 0.0)
    {
        AssignCommand(oBoonmoppet, ClearAllActions(TRUE));
        AssignCommand(oBoonmoppet, ActionMoveToObject(oGate, TRUE));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneEnd();
    }
}

// remove the frozen effect from a creature
void Unfreeze(object oCreature)
{
    effect eEff = GetFirstEffect(oCreature);
    while (GetIsEffectValid(eEff))
    {
        RemoveEffect(oCreature, eEff);
        eEff = GetNextEffect(oCreature);
    }
}

// make all nearby creatures with a certain tag attack the player
void AttackPlayer(object oPC, string sTag)
{
    int i = 1;
    object oNPC = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oNPC))
    {
        Unfreeze(oNPC);
        ChangeToStandardFaction(oNPC, STANDARD_FACTION_HOSTILE);
        AssignCommand(oNPC, ActionAttack(oPC));
        oNPC = GetObjectInArea(sTag, oPC, ++i);
    }
}

// boonmoppet is gone and the beasties attack
void end()
{
    object oPC = GetFirstPC();
    object oBoonmoppet = CutsceneGetActor("bw_boonmoppet");

    // girl is gone
    DestroyObject(GetObjectByTag("ac_boonmoppet"));

    // boonmoppet is now upstairs, waiting to talk to the player
    object oUpstairs = GetWaypointByTag("wp_ar0807_moppet");
    location lUpstairs = GetLocation(oUpstairs);
    if (!GetIsObjectValid(oBoonmoppet))
    {
        oBoonmoppet = CreateObject(OBJECT_TYPE_CREATURE, "bw_boonmoppet", lUpstairs);
    }
    SetLocalInt(oBoonmoppet, "HF_ARG", 4);
    SetPlotFlag(oBoonmoppet, FALSE);
    AssignCommand(oBoonmoppet, ClearAllActions(TRUE));
    AssignCommand(oBoonmoppet, JumpToLocation(lUpstairs));

    // update the player's journal (imp ran away)
    string sJournal ="j99";
    string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);
    int nStatus = 3;
    if (GetLocalInt(oPC, sJournalVar) < nStatus)
    {
        AddJournalQuestEntry(sJournal, nStatus, oPC);
    }

    // create the red gate if it doesn't already exist
    CreateRedGate(oPC);

    // unfreeze any summoned beasties, and allow future summons to not be frozen
    SetLocalInt(GetArea(oPC), "nUnfreeze", 1);
    DelayCommand(3.5, AttackPlayer(oPC, "c_kocrachn"));

    // beasties are summoned and are hostile
    SummonBeasties(oPC, oBoonmoppet);
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
