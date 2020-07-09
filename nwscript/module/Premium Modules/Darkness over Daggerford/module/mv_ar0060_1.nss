// this is the cutscene where the "cheese bandits" attack the player

#include "hf_in_cutscene"
#include "hf_in_npc"
#include "hf_in_spawn"
#include "hf_in_util"
#include "NW_I0_GENERIC"

// silly bandit sayings
string GetRandSaying()
{
    int n = d6();
    if (n == 1) return "You dead meat!";
    if (n == 2) return "Argh!";
    if (n == 3) return "Kill 'em!";
    if (n == 4) return "Get 'em!";
    if (n == 5) return "Attack!";
    if (n == 6) return "Yeah!";
    return "Yes, Boss!";
}

// bandits cheer their leader
void BanditsCheer(object oPC)
{
    // bandits cheer
    int i = 1;
    object oBandit = GetObjectInArea("ks_chez_band", oPC, i);
    while (GetIsObjectValid(oBandit))
    {
        int nAnim;
        int n = d3();
        if (n == 1) nAnim = ANIMATION_FIREFORGET_VICTORY1;
        if (n == 2) nAnim = ANIMATION_FIREFORGET_VICTORY2;
        if (n == 3) nAnim = ANIMATION_FIREFORGET_TAUNT;
        AssignCommand(oBandit, PlaySound("as_pl_laughingm"+IntToString(2+n)));
        AssignCommand(oBandit, PlayAnimation(nAnim));
        AssignCommand(oBandit, SpeakString(GetRandSaying()));
        oBandit = GetObjectInArea("ks_chez_band", oPC, ++i);
    }

    // leader cheers
    object oLeader = GetObjectInArea("ac_banditleader", oPC);
    AssignCommand(oLeader, ClearAllActions());
    AssignCommand(oLeader, PlaySound("vs_nlusgrm1_attk"));
    AssignCommand(oLeader, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
}

// spawn the bandits
void SpawnBandits(object oPC)
{
    // spawn leader
    object oWP = GetWaypointByTag("WP_AR0060_CUT1_BANDIT_LEADER");
    object oBandit = CreateObject(OBJECT_TYPE_CREATURE, "ac_banditleader", GetLocation(oWP));
    CutsceneAddActor("ac_banditleader", oBandit);

    // spawn his buddies
    int nLevels = SpawnGetPartyCR(oPC, 20);
    int i = 0;
    oWP = GetObjectByTag("WP_AR0060_CUT1_BANDIT", i);
    while (GetIsObjectValid(oWP))
    {
        object oBandit = CreateObject(OBJECT_TYPE_CREATURE, "ks_chez_band", GetLocation(oWP));
        SpawnLevelupCreature(oBandit, nLevels);
        oWP = GetObjectByTag("WP_AR0060_CUT1_BANDIT", ++i);
    }
}

// spawn porto
void SpawnNPCs(object oPC)
{
    object oWP = GetWaypointByTag("WP_AR0060_CUT1_PORTO");
    object oPorto = CreateObject(OBJECT_TYPE_CREATURE, "ac_porto2", GetLocation(oWP));
    object oTorch = CreateItemOnObject("NW_IT_TORCH001", oPorto, 1);
    AssignCommand(oPorto, ActionEquipItem(oTorch, INVENTORY_SLOT_LEFTHAND));
    CutsceneAddActor("ac_porto2", oPorto);
}

// move the camera into position
void start()
{
    object oPC = GetFirstPC();
    DayToNight(oPC);
    TeleportToWaypoint(oPC, "WP_AR0060_CUT1_START", FALSE);
    DelayCommand(1.0, CutsceneStart(FALSE, FALSE));
    SpawnNPCs(oPC);
    SpawnBandits(oPC);
}

// porto speaks to player
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oPorto = CutsceneGetActor("ac_porto2");

    if (fTime == 0.0)
    {
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 120.0, 3.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // bandits in the bushes!
        AssignCommand(oPC, PlaySound("as_na_bushmove2"));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, ActionStartConversation(oPorto, "ks_ar0060_porto", FALSE, FALSE));
    }
}

// bandits run towards player and porto flees
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oPorto = CutsceneGetActor("ac_porto2");
    object oBandit = CutsceneGetActor("ac_banditleader");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // camera spins around to face the bandits behind
        AssignCommand(oPC, SetFacingPoint(GetPosition(oBandit)));
        AssignCommand(oPorto, SetFacingPoint(GetPosition(oBandit)));
        CutsceneCameraSetup(-1.0, 220.0, 5.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oBandit, PlaySound("vs_nlusgrm1_hi")); // "what?"
        AssignCommand(oBandit, ActionSpeakString(q+"What? We weren't expecting no guards!"+q));
        AssignCommand(oBandit, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        AssignCommand(oPorto, PlaySound("vs_nhalflm1_hit3"));
        AssignCommand(oPorto, ActionSpeakString(q+"Uh oh! I'm getting out of here!"+q));
        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        // porto runs away
        object oExit = GetWaypointByTag("WP_AR0060_CUT1_PORTO_EXIT");
        AssignCommand(oPorto, ActionMoveToObject(oExit, TRUE, 0.5));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        // bandits threaten player
        string sHimOrHer = "her";
        if (GetGender(oPC) == GENDER_MALE)
        {
            sHimOrHer = "him";
        }
        AssignCommand(oBandit, PlaySound("vs_nlusgrm1_haha"));
        AssignCommand(oBandit, ActionSpeakString(q+"Ha! Never mind that little one! Kill "+sHimOrHer+" instead!"+q));
        AssignCommand(oBandit, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 7.0));
        CutsceneNext(25.0);
    }
    else if (fTime == 25.0)
    {
        BanditsCheer(oPC);
        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        CutsceneEnd();
    }
}

// makes all creatures with matching tag hostile
void GoHostile(string sTag, object oPC)
{
    int i = 1;
    object o = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(o))
    {
        SetPlotFlag(o, FALSE);
        SetImmortal(o, FALSE);
        ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
        o = GetObjectInArea(sTag, oPC, ++i);
    }
}

// bandits are hostile; porto is gone
void end()
{
    object oPC = GetFirstPC();
    object oPorto = GetObjectInArea("ac_porto2", oPC);

    // porto has run away
    DestroyObject(oPorto);

    // bandits are hostile now
    GoHostile("ks_chez_band", oPC);
    GoHostile("ac_banditleader", oPC);
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
