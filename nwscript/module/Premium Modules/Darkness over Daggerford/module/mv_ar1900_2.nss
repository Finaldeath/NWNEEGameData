// this is the cutscene where the Dragon Thuraskulusk kills Lizardfolk Chief Saslick

#include "hf_in_cutscene"

// remove all effects
void removeEffects(object oTarget)
{
    effect e = GetFirstEffect(oTarget);
    while (GetIsEffectValid(e))
    {
        RemoveEffect(oTarget, e);
        e = GetNextEffect(oTarget);
    }
}

// hide the town lizards
void hideNPCs(object oPC)
{
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    effect ePara  = EffectCutsceneParalyze();
    int i = 1;
    object oLiz = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_HUMANOID_REPTILIAN, oPC, i);
    while (GetIsObjectValid(oLiz))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oLiz);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePara,  oLiz);
        //SetLocalInt(oLiz, "HF_DISABLE_AM", 1);
        oLiz = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_HUMANOID_REPTILIAN, oPC, ++i);
    }
}

// unhide the town lizards
void unhideNPCs(object oPC)
{
    int i = 1;
    object oLiz = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_HUMANOID_REPTILIAN, oPC, i);
    while (GetIsObjectValid(oLiz))
    {
        //DeleteLocalInt(oLiz, "HF_DISABLE_AM");
        removeEffects(oLiz);
        oLiz = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_HUMANOID_REPTILIAN, oPC, ++i);
    }
}

// spawn the NPCs used in the cutscene
void spawnNPCs(object oPC)
{
    object oWP;

    // spawn saslick and disable his ambient AI
    oWP = GetWaypointByTag("WP_AR1900_CUT2_CHIEF");
    object oSaslick = CreateObject(OBJECT_TYPE_CREATURE, "ks_lizchief", GetLocation(oWP));
    ChangeToStandardFaction(oSaslick, STANDARD_FACTION_COMMONER);
    SetLocalInt(oSaslick, "HF_DISABLE_AM", 1);
    CutsceneAddActor("ks_lizchief", oSaslick);

    // spawn the dragon at her waypoint (away from the action)
    oWP = GetWaypointByTag("WP_AR1900_DRAGON_START");
    object oDragon = CreateObject(OBJECT_TYPE_CREATURE, "ks_thuraskulusk1", GetLocation(oWP));
    ChangeToStandardFaction(oDragon, STANDARD_FACTION_COMMONER);
    CutsceneAddActor("ks_thuraskulusk1", oDragon);
}

// just start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    CutsceneStart(TRUE, FALSE, "WP_AR1900_CUT2_START");
    hideNPCs(oPC);
    spawnNPCs(oPC);
}

// dragons flies into the scene
void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oChief  = CutsceneGetActor("ks_lizchief");
    object oDragon = CutsceneGetActor("ks_thuraskulusk1");

    if (fTime == 0.0)
    {
        // allow the camera to settle down a bit
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // set camera angle
        CutsceneCameraSetup(-1.0, 255.0, 18.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP);
        FadeFromBlack(oPC);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        // dragon flies into position in the shot
        CutsceneMusic(TRACK_BATTLE_DRAGON);
        object oWP = GetWaypointByTag("WP_AR1900_CUT2_DRAGON");
        location lWP = GetLocation(oWP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(lWP), oDragon, 3.0);
        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        // dragon roars
        AssignCommand(oDragon, PlaySound("c_dragnold_bat1"));
        AssignCommand(oDragon, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNextShot();
    }
}

// dragon talks with chief and kills him
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oChief  = CutsceneGetActor("ks_lizchief");
    object oDragon = CutsceneGetActor("ks_thuraskulusk1");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        AssignCommand(oDragon, PlaySound("c_dragnold_bat2"));
        AssignCommand(oDragon, ActionSpeakString(q+"You wretched worm, Saslick! You betrayed me!"+q));
        AssignCommand(oDragon, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oChief, PlaySound("as_an_lizhiss06"));
        AssignCommand(oChief, ActionSpeakString(q+"Please, great Thuraskulusk, I would never betray you!"+q));
        AssignCommand(oChief, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oDragon, PlaySound("c_dragnold_atk1"));
        AssignCommand(oDragon, ActionSpeakString(q+"A spineless thief stole my eggs. Yet, I smell them now...inside your hut!"+q));
        AssignCommand(oDragon, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        AssignCommand(oChief, PlaySound("as_an_lizhiss09"));
        AssignCommand(oChief, ActionSpeakString(q+"No! There must be some mistake! I am your faithful servant!"+q));
        AssignCommand(oChief, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 11.0));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oDragon, PlaySound("c_dragnold_atk2"));
        AssignCommand(oDragon, ActionSpeakString(q+"I trusted you...that was the only mistake! Now, suffer the consequences, lizard!"+q));
        AssignCommand(oDragon, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(32.0);
    }
    else if (fTime == 32.0)
    {
        AssignCommand(oChief, PlaySound("as_an_lizhiss10"));
        AssignCommand(oChief, ActionSpeakString(q+"Please! Wait! I --"+q));
        AssignCommand(oChief, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 5.0));
        CutsceneNext(36.0);
    }
    else if (fTime == 36.0)
    {
        // dragon kills chief in a puff of smoke
        //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(494), oDragon);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_ACID_L), oChief);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID), oChief);
        AssignCommand(oDragon, ActionCastFakeSpellAtObject(SPELL_MELFS_ACID_ARROW, oChief));
        AssignCommand(oDragon, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID), oChief)));
        AssignCommand(oDragon, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BIGBYS_FORCEFUL_HAND), oChief)));
        AssignCommand(oDragon, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oChief)));
        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        // dragon flies away roaring
        AssignCommand(oPC, PlaySound("c_dragnold_bat1"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), oDragon);
        CutsceneNext(44.0);
    }
    else if (fTime == 44.0)
    {
        CutsceneEnd();
    }
}

// destroy the chief and dragon; unhide lizards in town
void end()
{
    object oPC = GetFirstPC();
    object oChief  = CutsceneGetActor("ks_lizchief");
    object oDragon = CutsceneGetActor("ks_thuraskulusk1");

    // flag that the dragon can't be summoned again
    object oMod = GetModule();
    SetLocalInt(oMod, "nDeadLizardfolkCount", -1);

    // the chief is dead and the dragon is gone
    DestroyObject(oChief);
    DestroyObject(oDragon);

    // destroy the lizard chief in his tent
    oChief = GetObjectByTag("lizchief");
    if (GetIsObjectValid(oChief))
    {
        DestroyObject(oChief);
    }

    // the dragon takes her eggs away
    SetLocalInt(oMod, "nDragonEggsDelivered", 1);
    object oEggs = GetObjectByTag("ks_dragon_eggs");
    DestroyObject(oEggs);

    // unhide the NPCs
    unhideNPCs(oPC);
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
