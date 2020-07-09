// this is the "imp in a box" cutscene

#include "hf_in_cutscene"
#include "hf_in_npc"

// spawn npcs
void spawnNPCs(object oPC)
{
    object oWP1 = GetWaypointByTag("WP_AR0803_CUT1_MOGDOR");
    object oMogdor = CreateObject(OBJECT_TYPE_CREATURE, "pm_mogdor", GetLocation(oWP1));
    CutsceneAddActor("pm_mogdor", oMogdor);

    object oWP2 = GetWaypointByTag("WP_AR0803_CUT1_FIN");
    object oErik = CreateObject(OBJECT_TYPE_CREATURE, "pm_erikthefin", GetLocation(oWP2));
    CutsceneAddActor("pm_erikthefin", oErik);

    object oWP3 = GetWaypointByTag("WP_AR0803_CUT1_CHEST");
    object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_mogdor_chest", GetLocation(oWP3));
    CutsceneAddActor("ks_mogdor_chest", oChest);
}

// move to position and start the scene
void start()
{
    object oPC = GetFirstPC();
    BlackScreen(oPC);
    TeleportToWaypoint(oPC, "WP_AR0803_CUT1_START", FALSE);
    DelayCommand(1.0, CutsceneStart(FALSE, FALSE));
}

// set the camera
void next0(float fTime)
{
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        spawnNPCs(oPC);
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNextShot();
    }
}

// mogdor talks
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oMogdor = CutsceneGetActor("pm_mogdor");

    if (fTime == 0.0)
    {
        AssignCommand(oMogdor, ActionStartConversation(oPC, "ks_ar0803_mogdor", FALSE, FALSE));
        // next shot is given by a dialog event
    }
}

// mogdor opens the box
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oBox = CutsceneGetActor("ks_mogdor_chest");
    object oMogdor = CutsceneGetActor("pm_mogdor");
    object oFin = CutsceneGetActor("pm_erikthefin");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // mogdor faces the chest
        AssignCommand(oMogdor, SetFacingPoint(GetPosition(oBox)));
        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        CutsceneCameraSetup(-1.0, 250.0, 7.0, 75.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oMogdor, ActionSpeakString(q+"At last I have you! I can wait no longer!"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // mogdor casts a spell
        AssignCommand(oMogdor, PlaySound("vs_chant_ench_lm"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_MIND), oMogdor);
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0));
        CutsceneNext(11.0);
    }
    else if (fTime == 11.0)
    {
        // the box glows
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK), oBox);
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // mogdor gloats
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oBox);
        AssignCommand(oMogdor, PlaySound("vs_ndrawlm_haha"));
        AssignCommand(oMogdor, ActionSpeakString(q+"You thought you could escape me, but you were wrong!"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 7.0));
        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        CutsceneNextShot();
    }
}

// an imp comes out of the box
void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oBox = CutsceneGetActor("ks_mogdor_chest");
    object oMogdor = CutsceneGetActor("pm_mogdor");
    object oFin = CutsceneGetActor("pm_erikthefin");
    object oImp = CutsceneGetActor("pm_sujit");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // the box opens
        CutsceneCameraSetup(-1.0, 220.0, 5.0, 75.0, CAMERA_TRANSITION_TYPE_FAST);
        AssignCommand(oBox, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH_L), oBox);
        if (GetLocalInt(GetModule(), "pm_iic_lich") == 0)
        {
            CutsceneNext(1.0);
        } else {
            CutsceneNextShot();
        }
    }
    else if (fTime == 1.0)
    {
        // imp appears
        object oWP = GetWaypointByTag("WP_AR0803_CUT1_IMP");
        location lLoc = GetLocation(oWP);
        object oImp1 = CreateObject(OBJECT_TYPE_CREATURE, "pm_sujit", lLoc);
        CutsceneAddActor("pm_sujit", oImp1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3), lLoc);
        AssignCommand(oImp1, SetFacingPoint(GetPosition(oMogdor)));
        AssignCommand(oMogdor, ActionSpeakString(q+"Ahh, you are now mine, Sujit!"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        // imp begs for its life
        AssignCommand(oImp, PlaySound("c_mephit_slct"));
        AssignCommand(oImp, ActionSpeakString(q+"Please don’t hurt me!"+q));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oMogdor, ActionSpeakString(q+"Please don’t hurt me ‘what?’"+q));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        AssignCommand(oImp, PlaySound("c_mephit_yes"));
        AssignCommand(oImp, ActionSpeakString(q+"Please don't hurt me Master!"+q));
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_MIND), oMogdor);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CHARM), oImp);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED), oImp);
        AssignCommand(oMogdor, ActionSpeakString(q+"No, not unless you are a bad imp, hmm?  This merely ensures that you will not escape again."+q));
        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        AssignCommand(oMogdor, ActionSpeakString(q+"Come, Sujit!  We return to the icy plains of Etabalon!"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
        CutsceneNext(33.0);
    }
    else if (fTime == 33.0)
    {
        AssignCommand(oImp, PlaySound("c_mephit_no"));
        AssignCommand(oImp, ActionSpeakString(q+"Ooooh, I hate ice!"+q));
        AssignCommand(oImp, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(38.0);
    }
    else if (fTime == 38.0)
    {
        AssignCommand(oMogdor, ActionSpeakString(q+"What was that, Sujit?"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        CutsceneNext(43.0);
    }
    else if (fTime == 43.0)
    {
        AssignCommand(oImp, PlaySound("c_mephit_bat1"));
        AssignCommand(oImp, ActionSpeakString(q+"Nothing Master! Coming Master!"+q));
        CutsceneNext(47.0);
    }
    else if (fTime == 47.0)
    {
        // mogdor and imp vanish
        location lLoc1 = GetLocation(oMogdor);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc1);
        DestroyObject(oMogdor);
        location lLoc2 = GetLocation(oImp);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc2);
        DestroyObject(oImp);
        CutsceneNext(52.0);
    }
    else if (fTime == 52.0)
    {
        CutsceneEnd();
    }
}

// a demilich comes out of the box and kills mogdor; fin runs away
void next4(float fTime)
{
    object oPC = GetFirstPC();
    object oBox = CutsceneGetActor("ks_mogdor_chest");
    object oMogdor = CutsceneGetActor("pm_mogdor");
    object oFin = CutsceneGetActor("pm_erikthefin");
    object oLich = CutsceneGetActor("ks_extallimix");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        // demi-lich appears
        object oWP = GetWaypointByTag("WP_AR0803_CUT1_IMP");
        location lLoc = GetLocation(oWP);
        object oLich1 = CreateObject(OBJECT_TYPE_CREATURE, "ks_extallimix", lLoc);
        CutsceneAddActor("ks_extallimix", oLich1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3), lLoc);
        AssignCommand(oMogdor, ActionSpeakString(q+"Ahh, you are...not Sujit! What is the meaning of this?"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 6.0));
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        AssignCommand(oLich, PlaySound("c_demilich_slct"));
        AssignCommand(oLich, ActionSpeakString(q+"Who awakens Extallimix?"+q));
        AssignCommand(oLich, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        // fin runs for his life
        AssignCommand(oFin, ActionSpeakString(q+"Run! Run for your lives!"+q));
        AssignCommand(oFin, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 1.0));
        object oExit = GetWaypointByTag("WP_AR0803_CUT1_EXIT");
        AssignCommand(oFin, ActionMoveToObject(oExit, TRUE, 0.5));
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oMogdor, ActionSpeakString(q+"Umm...wait...I...uhh?"+q));
        AssignCommand(oMogdor, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oLich, PlaySound("c_demilich_bat1"));
        AssignCommand(oLich, ActionSpeakString(q+"Perhaps you are the mortal who imprisoned me in the orb so long ago? It matters little. You shall perish!"+q));
        AssignCommand(oLich, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        // lich casts a spell
        DestroyObject(oFin);
        AssignCommand(oLich, PlaySound("vs_chant_necr_lm"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_MIND), oLich);
        AssignCommand(oLich, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 4.0));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        // mogdor gets killed
        location lLoc = GetLocation(oMogdor);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), lLoc);
        SetPlotFlag(oMogdor, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMogdor);
        CutsceneNext(27.0);
    }
    else if (fTime == 27.0)
    {
        CutsceneEnd();
    }
}

// cleanup and have fin/lich talk to player
void end()
{
    object oPC = GetFirstPC();
    object oBox = CutsceneGetActor("ks_mogdor_chest");
    object oMogdor = CutsceneGetActor("pm_mogdor");
    object oFin = CutsceneGetActor("pm_erikthefin");
    object oLich = CutsceneGetActor("ks_extallimix");
    object oImp = CutsceneGetActor("pm_sujit");

    // the player has given the chest to mogdor
    SetLocalInt(oPC, "ac_gavelich", 1);

    // remove the chest from player's inventory
    object oChest;
    oChest = GetItemPossessedBy(oPC, "a2_pm_impchest2");
    DestroyObject(oChest);
    oChest = GetItemPossessedBy(oPC, "a2_pm_impchest");
    DestroyObject(oChest);

    // cleanup depends on if imp or lich was released
    if (GetLocalInt(GetModule(), "pm_iic_lich") == 0)
    {
        // imp
        // - chest is open
        // - mogdor and imp are gone
        AssignCommand(oBox, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
        DestroyObject(oMogdor);
        DestroyObject(oImp);

        // fin speaks to PC
        SetLocalString(oFin, "HF_EXIT_NAME", "WP_AR0803_CUT1_EXIT");
        SetLocalInt(oFin, "HF_EXIT_RUN", 1);
        SetLocalInt(GetModule(), "nGaveChestToErik", 1);
        AssignCommand(oFin, ActionStartConversation(oPC, "ks_ar0803_eric", FALSE, FALSE));

        // give XP
        AddJournalQuestEntry("j42", 9, oPC);
        GiveXPToCreature(oPC, 200);
    }
    else
    {
        // lich
        // - chest is open
        // - mogdor is dead
        // - lich is spawned
        AssignCommand(oBox, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN, 1.0, 1.0));
        if (!GetIsDead(oMogdor))
        {
            SetPlotFlag(oMogdor, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oMogdor);
        }
        if (!GetIsObjectValid(oLich))
        {
            object oWP = GetWaypointByTag("WP_AR0803_CUT1_IMP");
            location lLoc = GetLocation(oWP);
            oLich = CreateObject(OBJECT_TYPE_CREATURE, "ks_extallimix", lLoc);
        }

        DestroyObject(oFin);

         // lich speaks to PC
        SetLocalString(oLich, "HF_EXIT_NAME", "WP_AR0803_CUT1_LICH_EXIT");
        SetLocalInt(oLich, "HF_EXIT_RUN", 1);
        AssignCommand(oLich, ActionStartConversation(oPC, "ks_ar0803_lich", FALSE, FALSE));

        // give XP
        AddJournalQuestEntry("j42", 17, oPC);
        GiveXPToCreature(oPC, 750);
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
        if (nShot == 2) next2(fTime);
        if (nShot == 3) next3(fTime);
        if (nShot == 4) next4(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        //Allow abort once Mogdor conversation finished
        if(nShot > 1)
            CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
