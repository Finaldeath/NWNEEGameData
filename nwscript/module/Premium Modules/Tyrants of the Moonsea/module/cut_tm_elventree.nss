//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cut_tm_elventree
//:: DATE: December 04, 2018
//::////////////////////////////////////////////////////
//:: Cutscene conversation with Zalazar and Maganus
//::////////////////////////////////////////////////////

#include "x0_i0_henchman"

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"

const string DOOR_TAG_INN_DOOR = "Elventree_To_Swaying";

const string PLC_TAG_TOWN_DAMAGE0 = "cut_tm_zalazar_fire_0";
const string WP_TAG_PLAYER_INIT = "WP_cut_elventree_pc_init";


const string NPC_RESREF_SHARALYN = "sharalynelventre";
const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_elventree_sharalyn_init";
const string WP_TAG_SHARALYN_MOVE = "WP_cut_elventree_sharalyn_move";

const string NPC_RESREF_HILRAD = "hilradthepatient";
const string NPC_TAG_HILRAD = "HilradthePatient";
const string WP_TAG_HILRAD_INIT = "WP_cut_elventree_hilrad_init";
const string WP_TAG_HILRAD_MOVE = "WP_cut_elventree_hilrad_move";

const string NPC_RESREF_MAGANUS = "elventreemagnus";
const string NPC_TAG_MAGANUS = "ElventreeMagnus";
const string WP_TAG_MAGANUS_INIT = "WP_cut_elventree_maganus_init";
const string WP_TAG_MAGANUS_MOVE = "WP_cut_elventree_maganus_move";

const string NPC_RESREF_ZALAZAR = "zalazar";
const string NPC_TAG_ZALAZAR = "ZalazarTheHellspellOram";
const string WP_TAG_ZALAZAR_INIT = "WP_cut_elventree_zala_init";

const string NPC_RESREF_MALIK = "malik";
const string NPC_TAG_MALIK = "Malik";
const string WP_TAG_MALIK_INIT = "WP_cut_elventree_malik_init";

const string NPC_RESREF_BEHOLDER = "beholder002";
const string NPC_TAG_BEHOLDER = "ElventreeZhentarimBeholder";
const string WP_TAG_BEHOLDER_INIT = "WP_cut_elventree_beholder_init";

const string NPC_RESREF_LYRESSA = "lyressa";
const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_INIT = "WP_cut_elventree_lyressa_init";

const string LVAR_QUEST_UPDATE_DONCE = "cut_elventree_donce";

const string PLOT_DIALOG_LYRESSA = "hench_dialog_lyressa";


void updateQuestShot2(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 2)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 2);

        SetLocalInt(oPC, "elventreeattacked", 3);
        AddJournalQuestEntry("OrderoftheCrippledFang", 43, oPC);
        GiveXPToCreature(oPC, GetJournalQuestExperience("OrderoftheCrippledFang"));

        AddJournalQuestEntry("TheElvenHamlet", 70, oPC);

        // Set the correct dialog branch for lyressa
        PlotLevelSet(PLOT_DIALOG_LYRESSA, 4);
    }
}


void updateQuestEnd(object oPC)
{
    //Set Maganus Plot to indicate Elventree complete
    PlotLevelSet(NPC_TAG_MAGANUS, 1);

    // Set the correct dialog branch for lyressa
    PlotLevelSet(PLOT_DIALOG_LYRESSA, 2);
}


// Removes all placeables with the supplied tag
void removePlaceables(string sPlcTag)
{
    int i = 0;
    object oPlc = GetObjectByTag(sPlcTag, i);
    while (GetIsObjectValid(oPlc))
    {
        AssignCommand(oPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        DelayCommand(1.0f, DestroyObject(oPlc));

        i++;
        oPlc = GetObjectByTag(sPlcTag, i);
    }
}


void RemoveAllEffects(object oTarget)
{
    effect eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oTarget, eEffect);
        eEffect = GetNextEffect(oTarget);
    }
}


void setupActors(object oPC)
{
    // Spawn in only if nor already present
    CutsceneSpawnActor(NPC_RESREF_MAGANUS, NPC_TAG_MAGANUS, WP_TAG_MAGANUS_INIT);
    CutsceneSpawnActor(NPC_RESREF_ZALAZAR, NPC_TAG_ZALAZAR, WP_TAG_ZALAZAR_INIT);
    CutsceneSpawnActor(NPC_RESREF_MALIK, NPC_TAG_MALIK, WP_TAG_MALIK_INIT);
    CutsceneSpawnActor(NPC_RESREF_BEHOLDER, NPC_TAG_BEHOLDER, WP_TAG_BEHOLDER_INIT);

    // Delete Sharalyn in the current area and create a new one
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    if (!GetIsObjectValid(oSharalyn))
    {
        object oSharalynWP = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
        object oOldSharalyn = GetNearestObjectByTag(NPC_TAG_SHARALYN, oSharalynWP);
        if (GetIsObjectValid(oOldSharalyn))
            DestroyObject(oOldSharalyn);

        oSharalyn = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SHARALYN, GetLocation(oSharalynWP));
        CutsceneAddActor(NPC_TAG_SHARALYN, oSharalyn);
    }

    // Delete Hilrad in the current area and create a new one
    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    if (!GetIsObjectValid(oHilrad))
    {
        object oHilradWP = GetWaypointByTag(WP_TAG_HILRAD_INIT);
        object oOldHilrad = GetNearestObjectByTag(NPC_TAG_HILRAD, oHilradWP);
        if (GetIsObjectValid(oOldHilrad))
            DestroyObject(oOldHilrad);

        oHilrad = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_HILRAD, GetLocation(oHilradWP));
        CutsceneAddActor(NPC_TAG_HILRAD, oHilrad);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    BlackScreen(oPC);
    setupActors(oPC);

    AssignCommand(oPC, ClearAllActions(TRUE));
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    oWaypoint = GetWaypointByTag(WP_TAG_SHARALYN_MOVE);
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    if (!GetIsObjectValid(oSharalyn))
        oSharalyn = GetNearestObjectByTag(NPC_TAG_SHARALYN, oWaypoint);
    AssignCommand(oSharalyn, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oSharalyn, JumpToLocation(GetLocation(oWaypoint))));


    oWaypoint = GetWaypointByTag(WP_TAG_HILRAD_MOVE);
    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    if (!GetIsObjectValid(oSharalyn))
        oSharalyn = GetNearestObjectByTag(NPC_TAG_HILRAD, oWaypoint);
    AssignCommand(oHilrad, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oHilrad, JumpToLocation(GetLocation(oWaypoint))));

    // Remove Maganus, if still existing
    oActor = CutsceneGetActor(NPC_TAG_MAGANUS);
    if (GetIsObjectValid(oActor))
    {
        DestroyObject(oActor);
    }

    // These need to be killed explicitly (not using DestroyObject())
    oActor = CutsceneGetActor(NPC_TAG_MALIK);
    if (GetIsObjectValid(oActor))
    {
        SetPlotFlag(oActor, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActor);
    }
    oActor = CutsceneGetActor(NPC_TAG_BEHOLDER);
    if (GetIsObjectValid(oActor))
    {
        SetPlotFlag(oActor, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActor);
    }
    oActor = CutsceneGetActor(NPC_TAG_ZALAZAR);
    if (GetIsObjectValid(oActor))
    {
        SetPlotFlag(oActor, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActor);
    }

    updateQuestShot2(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oDoor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    updateQuestEnd(oPC);

    MusicBackgroundPlay(GetArea(oPC));

    // Unlock (and open) the door to the swaying Bough inn
    oDoor = GetObjectByTag(DOOR_TAG_INN_DOOR);
    SetLocked(oDoor, FALSE);
    SetLockKeyRequired(oDoor, FALSE);
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));

    // This will trigger the next cutscene when entering swaying bough inn
    SetLocalInt(oPC, "CUT_ASTDEATH_START", 1);

    // Make Lyressa leave
    object oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);
    if (GetIsObjectValid(oLyressa))
    {
        SetLocalInt(oLyressa, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oLyressa);
    }

    // Make Sharalyn leave
    object oSharalyn = GetNearestObjectByTag(NPC_TAG_SHARALYN, oPC);
    if (GetIsObjectValid(oSharalyn))
    {
        SetLocalInt(oSharalyn, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oSharalyn);
    }

    // Make Hilrad leave
    object oHilrad = GetNearestObjectByTag(NPC_TAG_HILRAD, oPC);
    if (GetIsObjectValid(oHilrad))
    {
        RemoveAllEffects(oHilrad);
        SetLocalInt(oHilrad, "HF_EXIT_RUN", 1);
        ExecuteScript("hf_cs_exit", oHilrad);
    }

    // Clean-up from Zalazar cutscene (since attack is over now)
    // Remove placeables
    removePlaceables(PLC_TAG_TOWN_DAMAGE0);

    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Initial Dialog between Zalazar, Sharalyn and Hilrad
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorZalazar = CutsceneGetActor(NPC_TAG_ZALAZAR);
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorMalik = CutsceneGetActor(NPC_TAG_MALIK);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    object oActorMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);
    object oWpHilradInit = GetWaypointByTag(WP_TAG_HILRAD_INIT);
    object oWpSharalynInit = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
    object oWpSharalynMove = GetWaypointByTag(WP_TAG_SHARALYN_MOVE);
    object oWpHilradMove = GetWaypointByTag(WP_TAG_HILRAD_MOVE);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        setupActors(oPC);

        RemoveAllFollowers(oPC, TRUE);
        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit))));

        CutsceneCameraSetup(0.0, 90.0, 12.5, 75.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oActorHilrad, 2.0f);
        AssignCommand(oActorHilrad, ClearAllActions(TRUE));
        RemoveAllEffects(oActorHilrad);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oActorSharalyn, 2.0f);
        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        RemoveAllEffects(oActorSharalyn);

        SetCreatureAppearanceType(oActorMaganus, APPEARANCE_TYPE_HUMAN_NPC_MALE_15);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_SLOW);

        CutsceneCameraSetup(0.0, 115.0, 7.5, 85.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_001"));  // 6s
        AssignCommand(oActorZalazar, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorZalazar, SpeakString("Idiots! Nothing is going to stop us from razing Elventree to the ground!"));

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSharalyn, ActionMoveToObject(oWpSharalynMove, TRUE)));

        CutsceneNext(16.0);
    }
    else if (fTime == 16.0)
    {
        AssignCommand(oActorSharalyn, PlaySound("vs_sharalyn_156")); // 5s
        AssignCommand(oActorSharalyn, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0));
        AssignCommand(oActorSharalyn, SpeakString("Damn you! Why must your kind destroy everything decent folk hold dear?"));

        CutsceneNext(23.0);
    }
    else if (fTime == 23.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_002"));  // 7s
        AssignCommand(oActorZalazar, ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0));
        AssignCommand(oActorZalazar, SpeakString("Because we can. Because what you hold dear has less value than a hole in the ground."));

        CutsceneNext(31.0);
    }
    else if (fTime == 31.0)
    {
        AssignCommand(oActorSharalyn, PlaySound("vs_sharalyn_157")); // 3s
        AssignCommand(oActorSharalyn, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 4.0));
        AssignCommand(oActorSharalyn, SpeakString("Begone from Elventree! Leave us in peace!"));

        CutsceneNext(37.0);
    }
    else if (fTime == 37.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_003"));  // 5s
        AssignCommand(oActorZalazar, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0));
        AssignCommand(oActorZalazar, SpeakString("You're a feisty one. I like a girl with spirit."));

        AssignCommand(oActorHilrad, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorHilrad, ActionMoveToObject(oWpHilradMove, FALSE)));

        CutsceneNext(42.0);
    }
    else if (fTime == 42.0)
    {
        AssignCommand(oActorHilrad, PlaySound("vs_hilrad_089"));  // 3s
        AssignCommand(oActorHilrad, SpeakString("Leave her alone, Zhent."));

        CutsceneNext(47.0);
    }
    else if (fTime == 47.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_004"));  // 11s
        AssignCommand(oActorZalazar, SpeakString("You could have fled, old man. You have the power. Instead, you chose to die like everyone else. And for what? Malik, kill the old fool."));

        CutsceneNext(58.0);
    }
    else if (fTime == 58.0)
    {
        AssignCommand(oActorMalik, SetFacingPoint(GetPosition(oActorHilrad)));

        CutsceneNext(60.0);
    }
    else if (fTime == 60.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBeam(VFX_BEAM_EVIL, oActorMalik, BODY_NODE_CHEST), oActorHilrad, 1.5);
        AssignCommand(oActorHilrad, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.5, 1.5));

        CutsceneNext(62.0);
    }
    else if (fTime == 62.0)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oActorHilrad, 80.0);

        CutsceneNext(64.0);
    }
    else if (fTime == 64.0)
    {
        AssignCommand(oActorSharalyn, PlaySound("vs_sharalyn_158"));
        AssignCommand(oActorSharalyn, SpeakString("No!"));

        CutsceneNext(66.0);
    }
    else if (fTime == 66.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_005"));  // 5s
        AssignCommand(oActorZalazar, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0));
        AssignCommand(oActorZalazar, SpeakString("YES! Time to die, little bird."));

        CutsceneNext(69.0);
    }
    else if (fTime == 69.0)
    {
        AssignCommand(oActorMalik, SetFacingPoint(GetPosition(oActorSharalyn)));

        CutsceneNextShot();
    }
}


// Shot 1: Maganus joins conversation
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorZalazar = CutsceneGetActor(NPC_TAG_ZALAZAR);
    object oActorMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);
    object oActorMalik = CutsceneGetActor(NPC_TAG_MALIK);
    object oActorBeholder = CutsceneGetActor(NPC_TAG_BEHOLDER);
    // Waypoints
    object oWpMaganusMove = GetWaypointByTag(WP_TAG_MAGANUS_MOVE);

    if (fTime == 0.0)
    {
        AssignCommand(oActorMaganus, ActionMoveToObject(oWpMaganusMove, FALSE));

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
       CutsceneCameraSetup(0.0, 40.0, 8.5, 85.0, CAMERA_TRANSITION_TYPE_SLOW);

       CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        AssignCommand(oActorMaganus, PlaySound("vs_maganus_092"));  // 6s
        AssignCommand(oActorMaganus, SpeakString("Zalazar. I see you haven't lost your penchant for cruelty."));

        CutsceneNext(19.0);
    }
    else if (fTime == 19.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_006"));
        AssignCommand(oActorZalazar, SpeakString("What's this? Another Harper?"));

        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        AssignCommand(oActorMaganus, PlaySound("vs_maganus_093"));
        AssignCommand(oActorMaganus, SpeakString("Not quite."));

        CutsceneNext(28.0);
    }
    else if (fTime == 28.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oActorMaganus);

        CutsceneNext(29.0);
    }
    else if (fTime == 29.0)
    {
        SetCreatureAppearanceType(oActorMaganus, APPEARANCE_TYPE_HUMAN);

        CutsceneNext(32.0);
    }
    else if (fTime == 32.0)
    {
        AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_SPELL_MANTLE, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        // AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_GLOBE_OF_INVULNERABILITY, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_ENERGY_BUFFER, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_PREMONITION, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_EPIC_MAGE_ARMOR, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        // AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_DISPLACEMENT, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        // AssignCommand(oActorMaganus, ActionCastSpellAtObject(SPELL_TRUE_SEEING, oActorMaganus, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

        CutsceneNext(35.0);
    }
    else if (fTime == 35.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_007"));  // 3s
        AssignCommand(oActorZalazar, SpeakString("Who in the Nine Hells are you?"));

        CutsceneNext(41.0);
    }
    else if (fTime == 41.0)
    {
        AssignCommand(oActorMaganus, PlaySound("vs_maganus_094"));  // 5s
        AssignCommand(oActorMaganus, SpeakString("You don't remember me? I'm disappointed."));

        CutsceneNext(47.0);
    }
    else if (fTime == 47.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_008"));  // 4s
        AssignCommand(oActorZalazar, SpeakString("Whoever you are, you'll die like the rest of these peasants."));

        CutsceneNext(53.0);
    }
    else if (fTime == 53.0)
    {
        AssignCommand(oActorMaganus, PlaySound("vs_maganus_095"));  // 5s
        AssignCommand(oActorMaganus, SpeakString("No. I will not die here. You had your chance - back in Zhentil Keep."));

        CutsceneNext(59.0);
    }
    else if (fTime == 59.0)
    {
        AssignCommand(oActorZalazar, PlaySound("vs_zalazar_009"));
        AssignCommand(oActorZalazar, SpeakString("M-Maganus?!"));

        CutsceneNext(63.0);
    }
    else if (fTime == 63.0)
    {
        AssignCommand(oActorMaganus, PlaySound("vs_maganus_096"));
        AssignCommand(oActorMaganus, SpeakString("The same. Send my regards to Gormstadd."));

        CutsceneNext(67.0);
    }
    else if (fTime == 67.0)
    {
        AssignCommand(oActorMaganus, ActionCastFakeSpellAtObject(SPELL_POWER_WORD_KILL, oActorBeholder, PROJECTILE_PATH_TYPE_DEFAULT));

        CutsceneNext(69.0);
    }
    else if (fTime == 69.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), oActorBeholder, 1.5);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), oActorMalik, 1.5);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), oActorZalazar, 1.5);
        SetPlotFlag(oActorBeholder, FALSE);
        SetPlotFlag(oActorMalik, FALSE);
        SetPlotFlag(oActorZalazar, FALSE);

        CutsceneNext(70.0);
    }
    else if (fTime == 70.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorBeholder, 0.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorMalik, 0.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oActorZalazar, 0.0);

        CutsceneNext(74.0);
    }
    else if (fTime >= 74.0)
    {
        AssignCommand(oActorMaganus, ActionStartConversation(oPC, "",  FALSE, FALSE));

        // Called from conversation
        //CutsceneNextShot();
    }
}



// Shot 2: Maganus dissappears
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorMaganus = CutsceneGetActor(NPC_TAG_MAGANUS);

    if (fTime == 0.0)
    {
        AssignCommand(oActorMaganus, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActorMaganus));

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActorMaganus);
        DestroyObject(oActorMaganus);

        updateQuestShot2(oPC);

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {

        CutsceneNextShot();
    }
}


// Shot 3: Lyressa comes out of Swaying Bough inn and initiates conversation
void next3(float fTime)
{
    object oPC = CutsceneGetPC();
    object oLyressa = OBJECT_INVALID;
    // Waypoints
    object oWpLyressaInit = GetWaypointByTag(WP_TAG_LYRESSA_INIT);

    if (fTime == 0.0)
    {
        object oDoor = GetObjectByTag(DOOR_TAG_INN_DOOR);
        SetLocked(oDoor, FALSE);
        SetLockKeyRequired(oDoor, FALSE);
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        oLyressa = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_LYRESSA, GetLocation(oWpLyressaInit));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        oLyressa = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);

        AssignCommand(oLyressa, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oLyressa, ActionStartConversation(oPC)));

        CutsceneNext(5.0);
    }
    else if (fTime >= 5.0)
    {
        // Called from conversation
        // CutsceneNextShot();
    }
}

// Shot 4: Ends the cutscene
void next4(float fTime)
{
    object oPC = CutsceneGetPC();

    if (fTime >= 0.0)
    {
        CutsceneEnd();
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
        if (nShot >= 4) next4(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        StopFade(GetFirstPC());
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "Error: Invalid cutscene event (" + IntToString(nEvent) +")");
        // Try to end gracefully
        abort();
        CutsceneEnd();
    }
}
