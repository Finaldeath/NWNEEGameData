// this is the cutscene where Umgatlik emerges from the portal

#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_npc"
#include "hf_in_graphics"
#include "hf_in_plot"
#include "hf_in_util"

// move to position and start the scene
void start()
{
    object oPC = GetFirstPC();
    CutsceneStart(FALSE, FALSE);
}

// set the camera
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_SOUTH, 7.0, 75.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneNextShot();
    }
}

// umgatlik appears
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oPortal = GetObjectInArea("ks_dig_portal", oPC);
    object oAltar = GetObjectInArea("pl_umgatliks_altar", oPC);
    object oUmgatlik = GetObjectInArea("ks_umgatlik", oPC);
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // the portal is destroyed
        object oWP = GetWaypointByTag("WP_AR2104_CUT1_PORTAL");
        location lLoc = GetLocation(oWP);
        DrawCircle(lLoc, 3.0, VFX_IMP_FLAME_M);
        DrawLineVert(lLoc, VFX_IMP_FLAME_M);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), lLoc);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        // umgatlik appears
        object oWP = GetWaypointByTag("WP_AR2104_CUT1_PORTAL");
        location lLoc = GetLocation(oWP);
        object oUmgatlik = CreateObject(OBJECT_TYPE_CREATURE, "ks_umgatlik", lLoc);
        SpawnLevelupCreature(oUmgatlik, SpawnGetPartyCR(oPC, 75));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oUmgatlik, ActionSpeakString(q+"Free! I am free at last!"+q));
        AssignCommand(oUmgatlik, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oUmgatlik);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oUmgatlik, ActionSpeakString(q+"Never shall I be imprisoned again!"+q));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oUmgatlik);
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oUmgatlik, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oAltar));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // the altar explodes and vanishes
        location lLoc = GetLocation(oAltar);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
        DestroyObject(oAltar);
        DestroyObject(oPortal);
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        CutsceneEnd();
    }
}

// scene is not abortable so nothing special here
// ... altar vanishes, portal vanishes, umgatlik appears and talks
void end()
{
    object oPC = GetFirstPC();
    object oPortal = GetObjectInArea("ks_dig_portal", oPC);
    object oAltar = GetObjectInArea("pl_umgatliks_altar", oPC);
    object oUmgatlik = GetObjectInArea("ks_umgatlik", oPC);

    // destroy altar and portal
    DestroyObject(oAltar);
    DestroyObject(oPortal);

    // make sure umgatliks is around
    if (!GetIsObjectValid(oUmgatlik))
    {
        object oWP = GetWaypointByTag("WP_AR2104_CUT1_PORTAL");
        location lLoc = GetLocation(oWP);
        oUmgatlik = CreateObject(OBJECT_TYPE_CREATURE, "ks_umgatlik", lLoc);
    }

    // umgatlik should talk to PC
    PlotLevelSet("ks_umgatlik", 2);
    AssignCommand(oUmgatlik, ActionStartConversation(oPC, "", FALSE, FALSE));

    // adjust PC alignment and give XP if appropriate
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
        GiveXPToCreature(oPC, 100);
        FloatingTextStringOnCreature("... XP Gain ...", oPC);
    }
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 5);
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
