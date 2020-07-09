// this cutscene fires when the player enters AR1105
// .. skully appears and talks to the player

#include "hf_in_cutscene"
#include "hf_in_graphics"
#include "hf_in_util"

// remove all effects applied to an object
void RemoveAllEffects(object oTarget)
{
    effect eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oTarget, eEffect);
        eEffect = GetNextEffect(oTarget);
    }
}

// skull flames to life
void FlameOn(object oSkull, int nLevel)
{
    location lLoc = GetLocation(oSkull);
    if (nLevel == 0)
    {
        DrawCircle(lLoc, 2.0, VFX_FNF_FIREBALL);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), lLoc);
    } else {
        vector v = GetPositionFromLocation(lLoc);
        v.z += 1.0;
        lLoc = Location(GetArea(oSkull), v, 0.0);
        DrawCircle(lLoc, 2.0, VFX_IMP_FLAME_M);
    }
}

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;

    // giant skull
    oWP = GetWaypointByTag("WP_AR1105_CUT1_SKULL");
    object oSkull = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_bigskull", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_FIRE), oSkull);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oSkull);
    CutsceneAddActor("ks_pl_bigskull", oSkull);

    // skully
    oWP = GetWaypointByTag("WP_AR1105_CUT1_SKULLY");
    object oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
    SetLocalInt(oSkully, "HF_DISABLE_AM", 1);
    CutsceneAddActor("ks_skully", oSkully);

    // portal is disabled until after skully talks to player
    oWP = GetWaypointByTag("WP_AR1105_PORTAL");
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", GetLocation(oWP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    SetLocalString(oPortal, "DESTINATION_UP", "WP_AR1106_PORTAL_EXIT");
    SetLocalInt(oPortal, "DISABLED", 1);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    spawnActors(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR1105_CUT1_START", FALSE);
    CutsceneMusic(66);
}

// flaming skull talks
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oSkully = CutsceneGetActor("ks_skully");
    object oSkull = CutsceneGetActor("ks_pl_bigskull");
    string sQuote = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, DIRECTION_NORTH, 6.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // giant skull flames to life
        FlameOn(oSkull, 0);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        // giant skull flames again
        FlameOn(oSkull, 1);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oSkull, ActionSpeakString(sQuote+"WHO DARES TO ENTER THE TOWER OF EDALSEYE?"+sQuote));
        object oSnd = GetObjectInArea("snd_ar1105_edal", oPC);
        SoundObjectPlay(oSnd);
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        // giant skull flames again
        FlameOn(oSkull, 1);
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        // skull speaks to player
        object oSnd = GetObjectInArea("snd_ar1105_edal", oPC);
        SoundObjectStop(oSnd);
        AssignCommand(oSkull, ActionStartConversation(oPC, "ks_ar1105_skull", FALSE, FALSE));
    }
}

// skully appears and talks to the player
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oSkully = CutsceneGetActor("ks_skully");
    object oSkull = CutsceneGetActor("ks_pl_bigskull");
    string sQuote = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // skully peeks out
        RemoveAllEffects(oSkull);
        CutsceneNext(0.5);
    }
    else if (fTime == 0.5)
    {
        object oDest = GetWaypointByTag("WP_AR1105_CUT1_SKULLY_1");
        AssignCommand(oSkully, ActionMoveToObject(oDest, FALSE, 0.0));
        AssignCommand(oSkully, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oSkully, ActionSpeakString(sQuote+"Yoo Hoo! Hello!"+sQuote));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oSkully, ActionMoveToObject(oPC));
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        CutsceneEnd();
    }
}

// skull is de-flamed and skully talks to the player
void end()
{
    object oPC = GetFirstPC();
    object oSkully = CutsceneGetActor("ks_skully");
    object oSkull = CutsceneGetActor("ks_pl_bigskull");

    // skully talks to the player
    RemoveAllEffects(oSkull);
    AssignCommand(oSkully, ActionStartConversation(oPC, "", FALSE, FALSE));

    // make sure the sound is turned off again
    object oSnd = GetObjectInArea("snd_ar1105_edal", oPC);
    SoundObjectStop(oSnd);
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
