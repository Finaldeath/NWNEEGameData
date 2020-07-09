// this cutscene fires when the player enters AR1109 after visiting hell
// .. skully and an imp fight it out until edalseye blasts it

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_spawn"
#include "hf_in_util"

// spawn the scene actors
void spawnActors(object oPC)
{
    object oWP;
    int nLevels90 = SpawnGetPartyCR(oPC, 90);

    // skully
    object oSkully = GetObjectInArea("ks_skully", oPC);
    DestroyObject(oSkully);
    oWP = GetWaypointByTag("WP_AR1109_CUT1_SKULLY");
    oSkully = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully", GetLocation(oWP));
    SetLocalInt(oSkully, "HF_DISABLE_AM", 1);
    CutsceneAddActor("ks_skully", oSkully);

    // imp
    oWP = GetWaypointByTag("WP_AR1109_CUT1_IMP");
    object oImp = CreateObject(OBJECT_TYPE_CREATURE, "ks_skully_imp", GetLocation(oWP));
    SetLocalInt(oImp, "HF_DISABLE_AM", 1);
    CutsceneAddActor("ks_skully_imp", oImp);

    // if edalseye is alive, he follows the player up from hell
    object oEdalseye = GetObjectByTag("ks_edalseye");
    if ((PlotLevelGet("ks_edalseye") == 3) ||
        (GetIsObjectValid(oEdalseye) && !GetIsDead(oEdalseye)))
    {
        DestroyObject(oEdalseye);
        oWP = GetWaypointByTag("WP_AR1109_CUT1_EDALSEYE");
        object oEdalseye = CreateObject(OBJECT_TYPE_CREATURE, "ks_edalseye", GetLocation(oWP));
        SpawnLevelupCreature(oEdalseye, nLevels90);
        CutsceneAddActor("ks_edalseye", oEdalseye);
    }
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    spawnActors(oPC);
    CutsceneStart(FALSE, FALSE, "WP_AR1109_CUT1_START", FALSE);
    CutsceneMusic(66);
}

// imp attacks skully
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oImp = CutsceneGetActor("ks_skully_imp");
    object oSkully = CutsceneGetActor("ks_skully");
    object oEdalseye = CutsceneGetActor("ks_edalseye");
    string sQuote = GetLocalString(oSkully, "HF_QUOTE");

    if (fTime == 0.0)
    {
        // allow some time for spawn and camera to settle down
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        CutsceneCameraSetup(-1.0, 50.0, 4.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // imp attacks skully
        AssignCommand(oImp, PlaySound("vs_nebraxxm_bat2"));
        AssignCommand(oImp, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        SetLocalInt(oImp, "HF_DISABLE_AM", 0);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // skully calls for help
        AssignCommand(oSkully, ActionSpeakString(sQuote+"Help! Get this thing away from me!"+sQuote));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // if edalseye is around, we go to the next shot, otherwise we exit
        if (GetIsObjectValid(oEdalseye)&& !GetIsDead(oEdalseye))
        {
            CutsceneNextShot();
        }
        else
        {
            CutsceneNext(15.0);
        }
    }
    else if (fTime == 15.0)
    {
        CutsceneEnd();
    }
}

// edalseye blasts the imp into tiny imp bits
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oImp = CutsceneGetActor("ks_skully_imp");
    object oSkully = CutsceneGetActor("ks_skully");
    object oEdalseye = CutsceneGetActor("ks_edalseye");
    string sQuote = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // edalseye is mad
        AssignCommand(oEdalseye, ActionSpeakString(sQuote+"You dare ask for help after you were the cause of this catastrophe?"+sQuote));
        AssignCommand(oEdalseye, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        // skully begs
        AssignCommand(oSkully, ActionSpeakString(sQuote+"Boss! I didn’t know it would turn out like this. I swear!"+sQuote));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        // edalseye relents
        AssignCommand(oEdalseye, ActionSpeakString(sQuote+"Oh, very well. But I demand a full accounting of your actions!"+sQuote));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        // edalseye casts a spell and the imp dies
        AssignCommand(oEdalseye, ActionCastFakeSpellAtObject(SPELL_FIREBALL, oImp));
        DelayCommand(2.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oImp));
        DelayCommand(2.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oImp));
        SetLocalLocation(GetArea(oImp), "lScorchmark", GetLocation(oImp));
        CutsceneNext(30.0);
    }
    else if (fTime == 30.0)
    {
        CutsceneEnd();
    }
}

// the imp is dead (if edalseye was alive to kill it)
void end()
{
    object oPC = GetFirstPC();
    object oImp = CutsceneGetActor("ks_skully_imp");
    object oSkully = CutsceneGetActor("ks_skully");
    object oEdalseye = CutsceneGetActor("ks_edalseye");

    // advance the NPC's plot levels
    PlotLevelSet("ks_skully", 7);
    PlotLevelSet("ks_edalseye", 4);
    PlotLevelSet("ks_pl_planar_portal", 2);

    // skully can move again, but don't let him wander too far
    DeleteLocalInt(oSkully, "HF_DISABLE_AM");
    SetLocalInt(oSkully, "HF_AT_HOME", 1);

    // the imp is either dead or hostile
    if (GetIsObjectValid(oEdalseye)&& !GetIsDead(oEdalseye))
    {
        location lLoc = GetLocalLocation(GetArea(oPC), "lScorchmark");
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", lLoc);
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", lLoc);
        DestroyObject(oImp);
    }
    else
    {
        ChangeToStandardFaction(oImp, STANDARD_FACTION_HOSTILE);
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
