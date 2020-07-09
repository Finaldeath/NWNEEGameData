//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ndt_tm_astdeath
//:: DATE: January 04, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Astar's death cutscene
//:: The trigger for this cutscene is inactive by
//:: default and is activated in "cut_tm_elventree"
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_util"
#include "hf_in_plot"
#include "hf_in_worldmap"


const string NPC_RESREF_ASTAR = "astar";
const string NPC_TAG_ASTAR = "Astar";
const string WP_TAG_ASTAR_FINAL = "WP_Astar_Swaying";

const string NPC_RESREF_DEADASTAR = "deadastar";
const string NPC_TAG_DEADASTAR = "DeadAstar";
const string WP_TAG_DEADASTAR_INIT = "WP_cut_astdeath_astar_init";

const string NPC_RESREF_LYRESSA = "lyressa";
const string NPC_TAG_LYRESSA = "Lyressa";
const string WP_TAG_LYRESSA_INIT = "WP_cut_astdeath_lyressa_init";
const string WP_TAG_LYRESSA_FINAL = "WP_Lyressa_Swaying";

const string NPC_RESREF_SHARALYN = "sharalynelventre";
const string NPC_TAG_SHARALYN = "SharalynElventree";
const string WP_TAG_SHARALYN_INIT = "WP_cut_astdeath_sharalyn_init";

const string NPC_RESREF_HILRAD = "hilradthepatient";
const string NPC_TAG_HILRAD = "HilradthePatient";
const string WP_TAG_HILRAD_INIT = "WP_cut_astdeath_hilrad_init";
const string WP_TAG_HILRAD_FINAL = "WP_Hilrad_Swaying";

const string NPC_RESREF_SENTINEL = "thesentinel";
const string NPC_TAG_SENTINEL = "TheSentinel";
const string WP_TAG_SENTINEL_INIT = "WP_cut_astdeath_sentinel_init";
const string WP_TAG_SENTINEL_FINAL = "WP_cut_astdeath_sentinel_final";

// Blood placeables
const string PLC_RESREF_ASTARBLOOD = "tm_pl_blood0_ns";
const string PLC_TAG_ASTARBLOOD = "PL_cut_astdeath_blood";

//We will remove Eremuth
const string NPC_TAG_EREMUTH = "Eremuth";

const string WP_TAG_PLAYER_INIT = "WP_cut_astdeath_pc_init";
const string WP_TAG_PLAYER_FUNERAL = "WP_cut_astfunera_pc_init";

// Cutscene trigger for Astars funeral cutscene
const string TRG_TAG_ASTARS_FUNREAL = "tr_cut_astfunera";

// Setup correct henchman dialog (= React to Astars death)
const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

const string PLC_RESREF_ASTAR_CHEST = "tm_pl_astarchest";
const string WP_TAG_ASTAR_CHEST = "WP_cut_astdeath_chest";


void SaveAstarsEquipment(object oAstar)
{
    object oContainer = GetObjectByTag(PLC_RESREF_ASTAR_CHEST);
    // Already existing = Already transferred
    if (GetIsObjectValid(oContainer))
        return;
    object oContainerWP = GetWaypointByTag(WP_TAG_ASTAR_CHEST);
    oContainer = CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_ASTAR_CHEST, GetLocation(oContainerWP));

    // Make the chest invisible until the end of cutscene
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oContainer, 600.0f);

    // Copy main inventory
    object oItem = GetFirstItemInInventory(oAstar);
    while (GetIsObjectValid(oItem))
    {
        if (GetLocalInt(oItem, "nocopy") == 0)
        {
            CopyItem(oItem, oContainer, TRUE);
        }
        oItem = GetNextItemInInventory(oAstar);
    }

    // Copy equipped items
    int nSlot = 0;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; ++nSlot)
    {
        oItem = GetItemInSlot(nSlot, oAstar);
        if (GetLocalInt(oItem, "nocopy") == 0)
        {
            CopyItem(oItem, oContainer, TRUE);
        }
    }
}


// Updates quest variable at the start of the cutscene
void updateQuestStart(object oPC)
{
    // Sets up Sentinel Dialog branch
    PlotLevelSet(NPC_TAG_SENTINEL, 3);
}


// Updates quest variable at the end of the cutscene
void updateQuestEnd(object oPC)
{
    // Set Plot level to make Astar's widow quest available
    PlotLevelSet("AstarsWidow-Status", 1);

    // Set henchmen dialog/ reactions
    if (PlotLevelGet(PLOT_HENCH_DIALOG) < 5)
        PlotLevelSet(PLOT_HENCH_DIALOG, 5);

    AddJournalQuestEntry("HenchmenAstar", 11, oPC);
    AddJournalQuestEntry("HenchmenEremuth", 11, oPC);
    //RemoveJournalQuestEntry("HenchmenLyressa", oPC);

    AddJournalQuestEntry("HuntingTheTraitor", 10, oPC);

    // Player can now travel to Elmwood
    PlotLevelSet("ElmwoodOpen", 1);
    UnlockMapLocation("Elmwood");

    // Set Sentinel Dialog in case it was skipped
    PlotLevelSet(NPC_TAG_SENTINEL, 4);
}


void setupActors(object oPC)
{
    int nNth = 0;

    // Add Lyressa
    object oLyressa = CutsceneGetActor(NPC_TAG_LYRESSA);
    object oLyressaSwayingWP = OBJECT_INVALID;
    if (!GetIsObjectValid(oLyressa))
    {
        oLyressaSwayingWP = GetWaypointByTag(WP_TAG_LYRESSA_INIT);
        oLyressa = GetObjectInArea(NPC_TAG_LYRESSA, oLyressaSwayingWP);
        if (!GetIsObjectValid(oLyressa))
        {
            // Lyressa should have been previously jumped (pud_tm_deadcount)
            // If we got here it likely means that she is laying dead somewhere
            oLyressa = GetObjectByTag(NPC_TAG_LYRESSA);
            if (GetIsObjectValid(oLyressa))
            {
                HenchmanRaise(oLyressa, OBJECT_INVALID);
            }
        }

        AssignCommand(oLyressa, ClearAllActions(TRUE));
        DelayCommand(0.7f, AssignCommand(oLyressa, JumpToLocation(GetLocation(oLyressaSwayingWP))));

        CutsceneAddActor(NPC_TAG_LYRESSA, oLyressa);
    }

    // Add Sharalyn
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oSharalynSwayingWP = OBJECT_INVALID;
    if (!GetIsObjectValid(oSharalyn))
    {
        oSharalynSwayingWP = GetWaypointByTag(WP_TAG_SHARALYN_INIT);
        oSharalyn = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SHARALYN, GetLocation(oSharalynSwayingWP));

        CutsceneAddActor(NPC_TAG_SHARALYN, oSharalyn);
    }

    // Add Hilrad
    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    object oHilradSwayingWP = OBJECT_INVALID;
    if (!GetIsObjectValid(oHilrad))
    {
        oHilradSwayingWP = GetWaypointByTag(WP_TAG_HILRAD_INIT);
        oHilrad = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_HILRAD, GetLocation(oHilradSwayingWP));

        CutsceneAddActor(NPC_TAG_HILRAD, oHilrad);
    }

    // Add Sentinel
    object oSentinel = CutsceneGetActor(NPC_TAG_SENTINEL);
    object oSentinelSwayingWP = OBJECT_INVALID;
    if (!GetIsObjectValid(oSentinel))
    {
        oSentinelSwayingWP = GetWaypointByTag(WP_TAG_SENTINEL_INIT);
        oSentinel = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_SENTINEL, GetLocation(oSentinelSwayingWP));

        CutsceneAddActor(NPC_TAG_SENTINEL, oSentinel);
    }

    // Destroy ALL Eremuths
    nNth = 0;
    object oEremuth = GetObjectByTag(NPC_TAG_EREMUTH, nNth);
    while (GetIsObjectValid(oEremuth))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oEremuth);

        AssignCommand(oEremuth, SetIsDestroyable(TRUE, FALSE, FALSE));
        SetPlotFlag(oEremuth, FALSE);
        DestroyObject(oEremuth, 1.0f);

        nNth++;
        oEremuth = GetObjectByTag(NPC_TAG_EREMUTH, nNth);
    }

    // Destroy ALL Astars.
    nNth = 0;
    object oAstar = GetObjectByTag(NPC_TAG_ASTAR, nNth);
    while (GetIsObjectValid(oAstar))
    {
        SaveAstarsEquipment(oAstar);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oAstar);

        AssignCommand(oAstar, SetIsDestroyable(TRUE, FALSE, FALSE));
        SetPlotFlag(oAstar, FALSE);
        DestroyObject(oAstar, 1.0f);

        nNth++;
        oAstar = GetObjectByTag(NPC_TAG_ASTAR, nNth);
    }

    // Create Dead Astar
    object oAstarSwayingWP = GetWaypointByTag(WP_TAG_DEADASTAR_INIT);
    object oDeadAstar = CutsceneGetActor(NPC_TAG_DEADASTAR);
    if (!GetIsObjectValid(oDeadAstar))
    {
        oDeadAstar = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_DEADASTAR, GetLocation(oAstarSwayingWP), FALSE, NPC_TAG_DEADASTAR);
        CutsceneAddActor(NPC_TAG_DEADASTAR, oDeadAstar);

        // Create a blood pool at Astar's location
        CreateObject(OBJECT_TYPE_PLACEABLE, PLC_RESREF_ASTARBLOOD, GetLocation(oAstarSwayingWP), FALSE, PLC_TAG_ASTARBLOOD);
    }
}


void start()
{
    object oPC = CutsceneGetPC();

    updateQuestStart(oPC);

    CutsceneStart(FALSE, FALSE, "", FALSE);
}


void abort()
{
    object oPC = CutsceneGetPC();
    object oActor = OBJECT_INVALID;

    setupActors(oPC);
}


void end()
{
    object oPC = CutsceneGetPC();
    object oPlaceable = OBJECT_INVALID;
    object oWaypoint = OBJECT_INVALID;

    FadeToBlack(oPC, FADE_SPEED_FAST);

    // Remove Invisible from Astars Possessions
    object oContainer = GetObjectByTag(PLC_RESREF_ASTAR_CHEST);
    effect eEffect = GetFirstEffect(oContainer);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oContainer, eEffect);
        eEffect = GetNextEffect(oContainer);
    }

    // Delete Astar's body
    object oAstar = GetObjectByTag(NPC_TAG_DEADASTAR);
    if (GetIsObjectValid(oAstar))
    {
        AssignCommand(oAstar, SetIsDestroyable(TRUE, FALSE, FALSE));
        SetPlotFlag(oAstar, FALSE);
        DestroyObject(oAstar, 1.0f);
    }

    // Get rid of Astars blood paceables
    oPlaceable = GetObjectByTag(PLC_TAG_ASTARBLOOD);
    if (GetIsObjectValid(oPlaceable))
    {
        DestroyObject(oPlaceable, 1.0f);
    }

    // Jump the Sentinel back to his store in Elventree
    object oSentinelWP = GetWaypointByTag(WP_TAG_SENTINEL_FINAL);
    object oSentinel = CutsceneGetActor(NPC_TAG_SENTINEL);
    if (GetIsObjectValid(oSentinel))
    {
        AssignCommand(oSentinel, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oSentinel, JumpToLocation(GetLocation(oSentinelWP))));
    }

    // Jump Hilrad back upstairs
    object oHilradWP = GetWaypointByTag(WP_TAG_HILRAD_FINAL);
    object oHilrad = CutsceneGetActor(NPC_TAG_HILRAD);
    if (GetIsObjectValid(oHilrad))
    {
        AssignCommand(oHilrad, ClearAllActions(TRUE));
        DelayCommand(1.0f, AssignCommand(oHilrad, JumpToLocation(GetLocation(oHilradWP))));
    }

    updateQuestEnd(oPC);

    // Move PC to funeral scene
    oWaypoint = GetWaypointByTag(WP_TAG_PLAYER_FUNERAL);
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(1.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));
}


// Shot 0: Initiate Dialog
void next0(float fTime)
{
    object oPC = CutsceneGetPC();
    // Actors
    object oActorSentinel = CutsceneGetActor(NPC_TAG_SENTINEL);
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

        CutsceneCameraSetup(2.2, 90.0, 8.0, 45.0, CAMERA_TRANSITION_TYPE_SNAP);

        AssignCommand(oPC, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oPC, JumpToLocation(GetLocation(oWpPlayerInit))));

        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_MEDIUM);

        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        CutsceneCameraSetup(2.2, 70.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_MEDIUM);
        CutsceneMusic(49, TRUE);

        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        AssignCommand(oActorSentinel, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oActorSentinel, 3.0f);
        AssignCommand(oActorSentinel, ActionStartConversation(oPC));

        // Called from conversation
        //CutsceneNextShot();
    }

}


// Shot 1: Ends cutscene
void next1(float fTime)
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
        if (nShot >= 1) next1(fTime);
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
