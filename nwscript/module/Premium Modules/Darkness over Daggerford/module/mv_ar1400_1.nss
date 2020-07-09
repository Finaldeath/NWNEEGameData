// the druids' "fowl" curse is lifted via the bloodstone

#include "hf_in_cutscene"
#include "hf_in_xp"
#include "hf_in_util"

// move NPCs into position and disable their ambient animations
void moveNPCs(object oPC)
{
    effect eGlow = EffectVisualEffect(VFX_DUR_LIGHT_RED_5);

    object oParrot = GetObjectInArea("ks_druid_parrot", oPC);
    object oWP1 = GetWaypointByTag("WP_AR1400_CIRCLE_N");
    AssignCommand(oParrot, ClearAllActions());
    AssignCommand(oParrot, ActionJumpToObject(oWP1, FALSE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oParrot);
    SetLocalInt(oParrot, "HF_DISABLE_AM", 1);

    object oPenguin = GetObjectInArea("ks_druid_peng", oPC);
    object oWP2 = GetWaypointByTag("WP_AR1400_CIRCLE_E");
    AssignCommand(oPenguin, ClearAllActions());
    AssignCommand(oPenguin, ActionJumpToObject(oWP2, FALSE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oPenguin);
    SetLocalInt(oPenguin, "HF_DISABLE_AM", 1);

    object oSeagull = GetObjectInArea("ks_druid_gull", oPC);
    object oWP3 = GetWaypointByTag("WP_AR1400_CIRCLE_S");
    AssignCommand(oSeagull, ClearAllActions());
    AssignCommand(oSeagull, ActionJumpToObject(oWP3, FALSE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oSeagull);
    SetLocalInt(oSeagull, "HF_DISABLE_AM", 1);

    object oChicken = GetObjectInArea("ks_druid_chick", oPC);
    SetLocalInt(oChicken, "NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE", 0);
    object oWP4 = GetWaypointByTag("WP_AR1400_CIRCLE_W");
    AssignCommand(oChicken, ClearAllActions());
    AssignCommand(oChicken, ActionJumpToObject(oWP4, FALSE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oChicken);
    SetLocalInt(oChicken, "HF_DISABLE_AM", 1);

    object oWP5 = GetWaypointByTag("WP_AR1400_TATHAM");
    object oStone = CreateObject(OBJECT_TYPE_PLACEABLE, "x2_plc_crystal", GetLocation(oWP5), FALSE, "_bloodstone");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), oStone);
}

// the fowls change back into druids
void liftCurse(object oPC)
{
    object oParrot = GetObjectInArea("ks_druid_parrot", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");
    if (GetIsObjectValid(oParrot))
    {
        location lLoc = GetLocation(oParrot);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), lLoc);
        DestroyObject(oParrot);
        object oWanix = CreateObject(OBJECT_TYPE_CREATURE, "ks_wanix", lLoc);
        SetLocalInt(oWanix, "HF_DISABLE_AM", 1);
        AssignCommand(oWanix, ActionSpeakString(q+"Hooray! It worked!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oWanix, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneAddActor("ks_wanix", oWanix);
    }

    object oPenguin = GetObjectInArea("ks_druid_peng", oPC);
    if (GetIsObjectValid(oPenguin))
    {
        location lLoc = GetLocation(oPenguin);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), lLoc);
        DestroyObject(oPenguin);
        object oUrith = CreateObject(OBJECT_TYPE_CREATURE, "ks_urith", lLoc);
        SetLocalInt(oUrith, "HF_DISABLE_AM", 1);
        AssignCommand(oUrith, ActionSpeakString(q+"Thank Mielikki!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oUrith, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));
        CutsceneAddActor("ks_urith", oUrith);
    }

    object oSeagull = GetObjectInArea("ks_druid_gull", oPC);
    if (GetIsObjectValid(oSeagull))
    {
        location lLoc = GetLocation(oSeagull);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), lLoc);
        DestroyObject(oSeagull);
        object oTatham = CreateObject(OBJECT_TYPE_CREATURE, "ks_tatham", lLoc);
        SetLocalInt(oTatham, "HF_DISABLE_AM", 1);
        AssignCommand(oTatham, ActionSpeakString(q+"The curse is lifted!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oTatham, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
        CutsceneAddActor("ks_tatham", oTatham);
    }

    object oChicken = GetObjectInArea("ks_druid_chick", oPC);
    if (GetIsObjectValid(oChicken))
    {
        location lLoc = GetLocation(oChicken);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), lLoc);
        DestroyObject(oChicken);
        object oJaeda = CreateObject(OBJECT_TYPE_CREATURE, "ks_jaeda", lLoc);
        SetLocalInt(oJaeda, "HF_DISABLE_AM", 1);
        AssignCommand(oJaeda, ActionSpeakString(q+"Yes! No more feathers!"+q, TALKVOLUME_SHOUT));
        AssignCommand(oJaeda, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneAddActor("ks_jaeda", oJaeda);
    }

    object oStone = GetObjectInArea("_bloodstone", oPC);
    if (GetIsObjectValid(oStone))
    {
        DestroyObject(oStone);
    }
}

// move the camera into position and change sound track
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(TRUE, FALSE, "WP_AR1400_CS");
    CutsceneMusic(73);
}

// druids gather into a circle and dispell the curse
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oParrot = GetObjectInArea("ks_druid_parrot", oPC);
    object oPenguin = GetObjectInArea("ks_druid_peng", oPC);
    object oSeagull = GetObjectInArea("ks_druid_gull", oPC);
    object oChicken = GetObjectInArea("ks_druid_chick", oPC);
    object oStone = GetObjectInArea("_bloodstone", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        BlackScreen(oPC);
        moveNPCs(oPC);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        //CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 1.0, 85.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneCameraSetup(1.0, DIRECTION_NORTH, 15.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oParrot, ClearAllActions());
        AssignCommand(oParrot, PlaySound("c_parrot_bat3"));
        AssignCommand(oParrot, ActionSpeakString(q+"By *brwack* earth and land!"+q));
        AssignCommand(oParrot, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        effect eBeam = EffectBeam(VFX_BEAM_FIRE, oParrot, BODY_NODE_CHEST);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oStone, 60.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_NATURE), oParrot);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        //CutsceneCameraSetup(-1.0, DIRECTION_EAST, 1.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        AssignCommand(oPenguin, ClearAllActions());
        AssignCommand(oPenguin, PlaySound("c_penguin_atk1"));
        AssignCommand(oPenguin, ActionSpeakString(q+"Trust Mielikki's *meep* hand!"+q));
        AssignCommand(oPenguin, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        effect eBeam = EffectBeam(VFX_BEAM_FIRE, oPenguin, BODY_NODE_CHEST);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oStone, 60.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_NATURE), oPenguin);
        CutsceneNext(17.0);
    }
    else if (fTime == 17.0)
    {
       // CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 1.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        AssignCommand(oSeagull, ClearAllActions());
        AssignCommand(oSeagull, PlaySound("c_seagull_bat1"));
        AssignCommand(oSeagull, ActionSpeakString(q+"By *aie-aie* word and verse!"+q));
        //DelayCommand(1.0,AssignCommand(GetObjectByTag("FakeSeagull"), ActionSpeakString(q+"By *aie-aie* word and verse!"+q)));
        //AssignCommand(oSeagull, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        effect eBeam = EffectBeam(VFX_BEAM_FIRE, oSeagull, BODY_NODE_CHEST);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oStone, 60.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_NATURE), oSeagull);
        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
       // CutsceneCameraSetup(-1.0, DIRECTION_WEST, 1.0, 85.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        AssignCommand(oChicken, ClearAllActions());
        AssignCommand(oChicken, PlaySound("c_chicken_bat1"));
        AssignCommand(oChicken, ActionSpeakString(q+"What? *Cluck* Oh! ... Lift this fowl curse!"+q));
        AssignCommand(oChicken, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        effect eBeam = EffectBeam(VFX_BEAM_FIRE, oChicken, BODY_NODE_CHEST);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oStone, 60.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_NATURE), oChicken);
        CutsceneNext(33.0);
    }
    else if (fTime == 31.0)
    {
        //CutsceneCameraSetup(1.0, DIRECTION_WEST, 15.0, 45.0, CAMERA_TRANSITION_TYPE_VERY_FAST);
        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE), oStone);
        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), oStone);
        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oStone);
        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        liftCurse(oPC);
        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        CutsceneNextShot();
    }
}

// druids talk after de-polymorph
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oWanix = CutsceneGetActor("ks_wanix");
    object oUrith = CutsceneGetActor("ks_urith");
    object oTatham = CutsceneGetActor("ks_tatham");
    object oJaeda = CutsceneGetActor("ks_jaeda");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oUrith, ActionSpeakString(q+"Being a bird wasn't that bad. Maybe we should all shape-shift?"+q));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oWanix, ActionSpeakString(q+"NO!"+q));
        AssignCommand(oWanix, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        AssignCommand(oTatham, ActionSpeakString(q+"NO!"+q));
        AssignCommand(oTatham, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        AssignCommand(oJaeda, ActionSpeakString(q+"NO!"+q));
        AssignCommand(oJaeda, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        CutsceneEnd();
    }
}

// druids are de-polymorphed and bloodstone is gone; ambient AI active
void end()
{
    object oPC = GetFirstPC();

    // make sure the curse is lifted (this also destroys bloodstone)
    liftCurse(oPC);

    object oWanix = CutsceneGetActor("ks_wanix");
    object oUrith = CutsceneGetActor("ks_urith");
    object oTatham = CutsceneGetActor("ks_tatham");
    object oJaeda = CutsceneGetActor("ks_jaeda");

    // enable ambient AI
    SetLocalInt(oWanix,  "HF_DISABLE_AM", 0);
    SetLocalInt(oUrith,  "HF_DISABLE_AM", 0);
    SetLocalInt(oJaeda,  "HF_DISABLE_AM", 0);
    //SetLocalInt(oTatham, "HF_DISABLE_AM", 0); - don't really want him sleeping

    // update journal
    GiveQuestXPToCreature(oPC, "j86");
    AddJournalQuestEntry("j86", 9, oPC);
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
