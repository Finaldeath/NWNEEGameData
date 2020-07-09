//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_salazar
// DATE: October 29, 2005
// AUTH: Luke Scull
// NOTE: Cutscene and dialogue with Zalazar.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"


const string DOOR_TAG_INN_DOOR = "Elventree_To_Swaying";

const string PLC_TAG_TOWN_DAMAGE0 = "cut_tm_zalazar_fire_0";

const string PLC_RESREF_ZALAZAR_VOICE = "zalazarvoice";
const string PLC_TAG_ZALAZAR_VOICE = "ZalazarVoice";
const string WP_TAG_ZALAZAR_VOICE_SPAWN = "WP_cut_zalazar_zalavoice_init";

const string NPC_RESREF_ZALAZAR = "zalazar";
const string NPC_TAG_ZALAZAR = "ZalazarTheHellspellOram";
const string WP_TAG_ZALAZAR_SPAWN = "WP_cut_zalazar_zala_init";

const string WP_TAG_PLAYER_INIT = "WP_cut_zalazar_pc_init";
const string WP_TAG_PLAYER_DEFENSE = "WP_cut_zalazar_pc_defense";

const string NPC_RESREF_SHARALYN = "sharalynelventre";
const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_zalazar_sharalyn_init";
const string WP_TAG_SHARALYN_DEFENSE = "WP_cut_zalazar_sharalyn_defense";

const string NPC_RESREF_HILRAD  = "hilradthepatient";
const string NPC_TAG_HILRAD = "HilradthePatient";
const string WP_TAG_HILRAD_INIT = "WP_cut_zalazar_hilrad_init";
const string WP_TAG_HILRAD_DEFENSE = "WP_cut_zalazar_hilrad_defense";

const string LVAR_QUEST_UPDATE_DONCE = "cut_zalazar_donce";


void updateQuestEnd(object oPC)
{
    if (GetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE) < 1)
    {
        SetLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE, 1);

        SetLocalInt(oPC, "elventreeattacked", 2);

        AddJournalQuestEntry( "TheElvenHamlet", 60, oPC);
        MusicBattlePlay(GetArea(oPC));

        SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup1"));
        SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup2"));
        SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup3"));
        SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup4"));
        SetEncounterActive(TRUE, GetObjectByTag("ElventreeZhentarimGroup5"));

        // Close and lock the Door to the swaying bough inn
        object oDoor = GetObjectByTag(DOOR_TAG_INN_DOOR);
        AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
        SetLocked(oDoor, TRUE);
        SetLockKeyRequired(oDoor, TRUE);
    }
}


// Activate all placeables with the supplied tag
void activatePlaceables(string sPlcTag)
{
    int i = 0;
    object oPlc = GetObjectByTag(sPlcTag, i);
    while (GetIsObjectValid(oPlc))
    {
        //AssignCommand(oPlc, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_INFERNO), oPlc);
        i++;
        oPlc = GetObjectByTag(sPlcTag, i);
    }
}


void setupActors(object oPC)
{
    object oActor = OBJECT_INVALID;
    object oDoor = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    activatePlaceables(PLC_TAG_TOWN_DAMAGE0);

    // Close doors
    oDoor = GetObjectByTag("Elventree_To_Swaying");
    AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    DelayCommand(1.0f, SetLocked(oDoor, TRUE));

    CutsceneSpawnActor(NPC_RESREF_ZALAZAR, NPC_TAG_ZALAZAR, WP_TAG_ZALAZAR_SPAWN);

    // Zalazar Voice Placeable
    oActor = GetNearestObjectByTag(PLC_TAG_ZALAZAR_VOICE, oPC);
    if (!GetIsObjectValid(oActor))
    {
        oWaypoint = GetWaypointByTag(WP_TAG_ZALAZAR_VOICE_SPAWN);
        oActor = CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_ZALAZAR_VOICE, GetLocation(oWaypoint), FALSE, PLC_TAG_ZALAZAR_VOICE);
        CutsceneAddActor(PLC_TAG_ZALAZAR_VOICE, oActor);
    }

    // Add Hilrad
    CutsceneSpawnActor(NPC_RESREF_HILRAD, NPC_TAG_HILRAD, WP_TAG_HILRAD_INIT);

    // Add Sharalyn
    CutsceneSpawnActor(NPC_RESREF_SHARALYN, NPC_TAG_SHARALYN, WP_TAG_SHARALYN_INIT);

}


void CheckAssociateLocations(object oPC, object oTargetObj)
{
    effect eEffect;
    object oEffectCreator = CutsceneGetScene();

    object oAssociate = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oAssociate))
    {
        eEffect = GetFirstEffect(oAssociate);
        while (GetIsEffectValid(eEffect))
        {
            if (GetEffectCreator(eEffect) == oEffectCreator)
            {
                RemoveEffect(oAssociate, eEffect);
            }
            eEffect = GetNextEffect(oAssociate);
        }
        AssignCommand(oAssociate, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oAssociate, JumpToLocation(GetLocation(oTargetObj))));

        oAssociate = GetNextFactionMember(oPC, FALSE);
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

    BlackScreen(oPC);
    setupActors(oPC);

    // Zalar teleported away
    object oZalazar = CutsceneGetActor(NPC_TAG_ZALAZAR);
    if (GetIsObjectValid(oZalazar))
        DestroyObject(oZalazar);

    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oSharalynWP = GetWaypointByTag(WP_TAG_SHARALYN_DEFENSE);
    AssignCommand(oSharalyn, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oSharalyn, JumpToLocation(GetLocation(oSharalynWP))));

    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    object oHilradWP = GetWaypointByTag(WP_TAG_HILRAD_DEFENSE);
    AssignCommand(oHilrad, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oHilrad, JumpToLocation(GetLocation(oHilradWP))));

    object oPlayerWP = GetWaypointByTag(WP_TAG_PLAYER_DEFENSE);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oPlayerWP))));
}


void end()
{
    object oPC = CutsceneGetPC();
    object oActor= OBJECT_INVALID;

    updateQuestEnd(oPC);

    oActor = CutsceneGetActor(PLC_TAG_ZALAZAR_VOICE);
    DestroyObject(oActor);

    object oJumpTarget = GetWaypointByTag(WP_TAG_PLAYER_DEFENSE);
    DelayCommand(2.0f, CheckAssociateLocations(GetFirstPC(), oJumpTarget));

    DelayCommand(1.0f, DoSinglePlayerAutoSave());

    DeleteLocalInt(oPC, LVAR_QUEST_UPDATE_DONCE);
}


// Shot 0: Initiate Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorZalazar = CutsceneGetActor(NPC_TAG_ZALAZAR);
    object oActorZalazarVoice = CutsceneGetActor(PLC_TAG_ZALAZAR_VOICE);
    // Waypoints
    object oWpPlayerInit = GetWaypointByTag(WP_TAG_PLAYER_INIT);

    if (fTime == 0.0)
    {
        BlackScreen(oPC);

        CutsceneNext(1.0);
    }
    else if (fTime == 1.0)
    {
        setupActors(oPC);

        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToLocation(GetLocation(oWpPlayerInit)));
        CutsceneCameraSetup(2.0, 225.0, 6.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        CutsceneCameraSetup(2.0, 225.0, 12.0, 60.0, CAMERA_TRANSITION_TYPE_SLOW);

        CutsceneNext(8.0);
    }
    else if (fTime >= 8.0)
    {
        AssignCommand(oActorZalazarVoice, ActionStartConversation(oPC, "", FALSE, FALSE));

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 1: Zalazar teleports away
void next1(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorZalazar = CutsceneGetActor(NPC_TAG_ZALAZAR);

    if (fTime == 0.0)
    {
        AssignCommand(oPC, ActionPauseConversation());
        AssignCommand(oActorZalazar, ActionCastFakeSpellAtObject(SPELL_CURE_MINOR_WOUNDS, oActorZalazar));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oActorZalazar);
        DestroyObject(oActorZalazar, 0.5);

        CutsceneNext(4.0);
    }
    else if (fTime >= 4.0)
    {
        AssignCommand(oPC, ActionResumeConversation());

        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 2: Jump everyone to Defense WPs
void next2(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    // Waypoints
    object oWpPlayerDefense = GetWaypointByTag(WP_TAG_PLAYER_DEFENSE);
    object oWpSharalynDefense = GetWaypointByTag(WP_TAG_SHARALYN_DEFENSE);
    object oWpHilradDefense = GetWaypointByTag(WP_TAG_HILRAD_DEFENSE);

    if (fTime == 0.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FAST);

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSharalyn, JumpToLocation(GetLocation(oWpSharalynDefense))));

        AssignCommand(oActorHilrad, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorHilrad, JumpToLocation(GetLocation(oWpHilradDefense))));

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerDefense))));

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        CutsceneNextShot();
    }
}


// Shot 3: Sharalyn initiates Dialog
void next3(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oActorHilrad = CutsceneGetActor(NPC_TAG_HILRAD);

    if (fTime == 0.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, ActionStartConversation(oPC, "INVALID", FALSE, FALSE)));

        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSharalyn, ActionStartConversation(oActorSharalyn, "INVALID", FALSE, FALSE)));

        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oActorSharalyn, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oActorSharalyn, ActionStartConversation(oPC, "", FALSE, FALSE)));

        CutsceneNext(3.0);
    }
    else if (fTime >= 3.0)
    {
        // Called from conversation
        //CutsceneNextShot();
    }
}


// Shot 4: Ends cutscene
void next4(float fTime)
{
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
