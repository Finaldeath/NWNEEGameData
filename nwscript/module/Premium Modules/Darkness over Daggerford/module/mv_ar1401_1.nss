// this is the cutscene where Teygan talks to some adventurers in his cave

#include "hf_in_cutscene"
#include "hf_in_util"

// remove invis effect
void removeEffects(object oTarget)
{
    effect e = GetFirstEffect(oTarget);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(oTarget, e);
        e = GetNextEffect(oTarget);
    }
}

// spawn the NPCs
void spawnNPCs(object oPC)
{
    object oWP;

    // spawn first adventurer
    oWP = GetWaypointByTag("WP_AR1401_CUT1_BUDDY_1");
    object oAdvent1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_teygan_bud1", GetLocation(oWP));
    CutsceneAddActor("Buddy1", oAdvent1);

    // spawn second adventurer
    oWP = GetWaypointByTag("WP_AR1401_CUT1_BUDDY_2");
    object oAdvent2 = CreateObject(OBJECT_TYPE_CREATURE, "ks_teygan_bud2", GetLocation(oWP));
    CutsceneAddActor("Buddy2", oAdvent2);

    // spawn third adventurer
    oWP = GetWaypointByTag("WP_AR1401_CUT1_BUDDY_3");
    object oAdvent3 = CreateObject(OBJECT_TYPE_CREATURE, "ks_teygan_bud3", GetLocation(oWP));
    CutsceneAddActor("Buddy3", oAdvent3);

    // grab a handle on Teygan
    oWP = GetWaypointByTag("WP_AR1401_CUT1_TEYGAN");
    object oTeygan = GetObjectByTag("Teygan");
    AssignCommand(oTeygan, ClearAllActions());
    AssignCommand(oTeygan, JumpToObject(oWP, 0));
    AssignCommand(oTeygan, SetFacingPoint(GetPosition(oAdvent1)));
    CutsceneAddActor("Teygan", oTeygan);

    // make sure the fake harpers don't wander into the scene
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    object oHarper1 = GetObjectInArea("db_fakeharp01", oTeygan);
    if (GetIsObjectValid(oHarper1))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oHarper1, 60.0);
    }
    object oHarper2 = GetObjectInArea("db_fakeharp2", oTeygan);
    if (GetIsObjectValid(oHarper2))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oHarper2, 60.0);
    }
    object oBird = GetObjectInArea("db_george", oTeygan);
    if (GetIsObjectValid(oBird))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oBird, 60.0);
    }

    // hide the brazier
    object oBrazier = GetObjectInArea("teygans_brazier", oTeygan);
    if (GetIsObjectValid(oBrazier))
    {
        DestroyObject(oBrazier);
    }
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1401_CUT1_START", TRUE);
    CutsceneMusic(TRACK_HOTU_UNDERMOUNTAIN);
    spawnNPCs(oPC);
}

// teygan is talking to his buddies
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oTeygan = CutsceneGetActor("Teygan");
    object oBuddy1 = CutsceneGetActor("Buddy1");
    object oBuddy2 = CutsceneGetActor("Buddy2");
    object oBuddy3 = CutsceneGetActor("Buddy3");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 3.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SLOW);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // mage talks
        AssignCommand(oBuddy1, PlaySound("vs_fzhent1_001"));
        AssignCommand(oBuddy1, ActionSpeakString(q+"My apologies, master. We have explored the tower thoroughly. She is not there."+q));
        AssignCommand(oBuddy1, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // teygan talks
        AssignCommand(oTeygan, PlaySound("vs_teygan_097"));
        AssignCommand(oTeygan, ActionSpeakString(q+"No! She must be there! Search again, and do not disappoint me!"+q));
        AssignCommand(oTeygan, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        // teygan turns to face player
        AssignCommand(oTeygan, ActionDoCommand(SetFacing(DIRECTION_SOUTH)));
        AssignCommand(oTeygan, ActionWait(2.0));
        AssignCommand(oTeygan, ActionDoCommand(PlaySound("vs_teygan_098")));
        AssignCommand(oTeygan, ActionSpeakString(q+"Ah...it's you."+q));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oTeygan, ActionDoCommand(SetFacingPoint(GetPosition(oBuddy1))));
        AssignCommand(oTeygan, ActionDoCommand(PlaySound("vs_teygan_099")));
        AssignCommand(oTeygan, ActionSpeakString(q+"You will excuse me. My friend has returned. You may go."+q));
        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        // teygan casts a spell
        AssignCommand(oTeygan, PlaySound("vs_chant_evoc_hm"));
        AssignCommand(oTeygan, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0));
        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        // buddies vanish
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_GREATER), oTeygan);
        effect ePuff = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePuff, oBuddy1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePuff, oBuddy2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePuff, oBuddy3);
        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        // buddies vanish
        object oBuddy1 = CutsceneGetActor("Buddy1");
        object oBuddy2 = CutsceneGetActor("Buddy2");
        object oBuddy3 = CutsceneGetActor("Buddy3");
        DestroyObject(oBuddy1);
        DestroyObject(oBuddy2);
        DestroyObject(oBuddy3);
        CutsceneNext(43.0);
    }
    else if (fTime == 43.0)
    {
        // teygan faces player
        AssignCommand(oTeygan, SetFacing(DIRECTION_SOUTH));
        CutsceneNext(45.0);
    }
    else if (fTime == 45.0)
    {
        CutsceneEnd();
    }
}

// teygan's buddies are gone
void end()
{
    object oPC = GetFirstPC();
    object oTeygan = CutsceneGetActor("Teygan");

    // remove teygan's buddies
    object oBuddy1 = CutsceneGetActor("Buddy1");
    object oBuddy2 = CutsceneGetActor("Buddy2");
    object oBuddy3 = CutsceneGetActor("Buddy3");
    DestroyObject(oBuddy1);
    DestroyObject(oBuddy2);
    DestroyObject(oBuddy3);

    // unhide the fake harpers
    object oHarper1 = GetObjectInArea("db_fakeharp01", oTeygan);
    if (GetIsObjectValid(oHarper1))
    {
        removeEffects(oHarper1);
    }
    object oHarper2 = GetObjectInArea("db_fakeharp2", oTeygan);
    if (GetIsObjectValid(oHarper2))
    {
        removeEffects(oHarper2);
    }
    object oBird = GetObjectInArea("db_george", oTeygan);
    if (GetIsObjectValid(oBird))
    {
        removeEffects(oBird);
    }

    // teygan faces player
    AssignCommand(oTeygan, SetFacing(DIRECTION_SOUTH));

    // bring back the brazier
    object oWP = GetWaypointByTag("wp_teygan_waits");
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_brazier", GetLocation(oWP), FALSE, "teygans_brazier");
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
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
