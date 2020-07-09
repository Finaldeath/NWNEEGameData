//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_ezril
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue with Ezril(Eremuth)
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"

#include "hf_in_cutscene"
#include "hf_in_plot"

const string NPC_RESREF_EZRIL = "ezrilmalaugrym";
const string NPC_TAG_EZRIL = "EzrilMalaugrym";
const string WP_TAG_EZRIL_INIT = "WP_COLIS_CS_EZRIL_SPAWN";

const string NPC_RESREF_DEVALLE = "devalledopp";
const string NPC_TAG_DEVALLE = "DevalleDopp";
const string WP_TAG_DEVALLE_INIT = "WP_COLIS_CS_DEVALLE_SPAWN";

const string NPC_RESREF_SORIN = "sorindopp";
const string NPC_TAG_SORIN = "SorinDopp";
const string WP_TAG_SORIN_INIT = "WP_COLIS_CS_SORIN_SPAWN";

void SetupActors(object oPC)
{
    CutsceneSpawnActor(NPC_RESREF_EZRIL, NPC_TAG_EZRIL, WP_TAG_EZRIL_INIT);
    CutsceneSpawnActor(NPC_RESREF_DEVALLE, NPC_TAG_DEVALLE, WP_TAG_DEVALLE_INIT);
    CutsceneSpawnActor(NPC_RESREF_SORIN, NPC_TAG_SORIN, WP_TAG_SORIN_INIT);
}

//Ensure rangers have turned into dopplegangers and Ezril into Mountain Giant
void ChangeAppearances()
{
    object oDevalle = CutsceneGetActor(NPC_TAG_DEVALLE);
    object oEzril = CutsceneGetActor(NPC_TAG_EZRIL);
    object oSorin = CutsceneGetActor(NPC_TAG_SORIN);

    if(GetAppearanceType(oEzril) != APPEARANCE_TYPE_GIANT_MOUNTAIN)
    {
        SetPortraitResRef(oEzril, "po_gntmount_");
        SetCreatureAppearanceType(oEzril, APPEARANCE_TYPE_GIANT_MOUNTAIN);
        SetObjectVisualTransform(oEzril, OBJECT_VISUAL_TRANSFORM_SCALE, 2.75);
    }

    if(GetAppearanceType(oDevalle) != APPEARANCE_TYPE_GHAST)
    {
        SetPortraitResRef(oDevalle, "po_bodak_");
        SetCreatureAppearanceType(oDevalle, APPEARANCE_TYPE_GHAST);
    }

    if(GetAppearanceType(oSorin) != APPEARANCE_TYPE_GHAST)
    {
        SetPortraitResRef(oSorin, "po_bodak_");
        SetCreatureAppearanceType(oSorin, APPEARANCE_TYPE_GHAST);
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    CutsceneStart(TRUE, FALSE, "WP_COLIS_CS_PC_START", FALSE);
    SetupActors(oPC);
}

// Ezril talks to player
void next0(float fTime)
{
    object oDevalle = CutsceneGetActor(NPC_TAG_DEVALLE);
    object oEzril = CutsceneGetActor(NPC_TAG_EZRIL);
    object oPC = CutsceneGetPC();
    object oSorin = CutsceneGetActor(NPC_TAG_SORIN);

    if (fTime == 0.0)
    {
        // some time for the camera to settle down
        BlackScreen(oPC);
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);

        //Set Ezril plot variable dependent on whether PC has previously aired suspicions
        if(PlotLevelGet("Ezril") == 2)
        {
            PlotLevelSet(NPC_TAG_EZRIL, 4);
        }
        else
        {
            PlotLevelSet(NPC_TAG_EZRIL, 3);
        }

        CutsceneNext(4.0);
    }
     else if (fTime == 4.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, ActionForceMoveToObject(GetWaypointByTag("WP_COLIS_CS_PC_MOVE"), TRUE, 0.0, 6.0));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        //CutsceneNextShot() invoked from Ezril conversation
        AssignCommand(oEzril, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// Ezril changes into Mountain Giant, and rangers change to dopplegangers
void next1(float fTime)
{
    object oDevalle = CutsceneGetActor(NPC_TAG_DEVALLE);
    object oEzril = CutsceneGetActor(NPC_TAG_EZRIL);
    object oPC = CutsceneGetPC();
    object oSorin = CutsceneGetActor(NPC_TAG_SORIN);

    if (fTime == 0.0)
    {
        CutsceneCameraSetup(-1.0, 0.0, 10.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oEzril, PlaySound("c_malaugrym_sel"));
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        SetPortraitResRef(oDevalle, "po_bodak_");
        SetPortraitResRef(oSorin, "po_bodak_");

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(EFFECT_TYPE_POLYMORPH), oDevalle);
        SetCreatureAppearanceType(oDevalle, APPEARANCE_TYPE_GHAST);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(EFFECT_TYPE_POLYMORPH), oSorin);
        SetCreatureAppearanceType(oSorin, APPEARANCE_TYPE_GHAST);
        CutsceneNext(7.0);
    }
    else if (fTime == 7.0)
    {
        CutsceneCameraSetup(-1.0, 0.0, 20.0, 90.0, CAMERA_TRANSITION_TYPE_SNAP);
        SetPortraitResRef(oEzril, "po_gntmount_");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(EFFECT_TYPE_POLYMORPH), oEzril);
        SetCreatureAppearanceType(oEzril, APPEARANCE_TYPE_GIANT_MOUNTAIN);
        SetObjectVisualTransform(oEzril, OBJECT_VISUAL_TRANSFORM_SCALE, 2.75);

        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        BlackScreen(oPC);
        CutsceneNext(12.0);

    }
    else if (fTime == 12.0)
    {
        CutsceneEnd();
    }
}

//Ensure Ezril dialog aborted, NPCs created, and appearances changed
void abort()
{
    object oEzril = CutsceneGetActor(NPC_TAG_EZRIL);
    object oPC = CutsceneGetPC();

    AssignCommand(oEzril, ClearAllActions());
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));

    SetName(oEzril, "Eremuth");
    SetupActors(oPC);
    ChangeAppearances();
}

void end()
{
    object oDevalle = CutsceneGetActor(NPC_TAG_DEVALLE);
    object oEzril = CutsceneGetActor(NPC_TAG_EZRIL);
    object oPC = CutsceneGetPC();
    object oSorin = CutsceneGetActor(NPC_TAG_SORIN);

    AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("WP_COLIS_CS_PC_END"))));
    AssignCommand(oPC, SetFacingPoint(GetPosition(oEzril)));
    AssignCommand(oPC, SetCameraFacing(60.0, 25.0, 50.0));

    //Update relevant journal entries
    if(PlotLevelGet("Thoyana") == 1)
    {
        AddJournalQuestEntry("HuntingTheTraitor", 30, oPC);
    }
    else
    {
        AddJournalQuestEntry("HuntingTheTraitor", 35, oPC);
    }

    //Eremuth and rangers attack
    PlotLevelSet("Ezril", 5);
    SetLocalInt(OBJECT_SELF, "nBusy", 1);

    //Haste Ezril and dopplegangers (needs two castings possibly due to difference in height locations)
    AssignCommand(oEzril,
        ActionCastSpellAtObject(SPELL_MASS_HASTE, oDevalle, METAMAGIC_ANY, TRUE));
    AssignCommand(oEzril,
        ActionCastSpellAtObject(SPELL_MASS_HASTE, oEzril, METAMAGIC_ANY, TRUE,
                                15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

    DelayCommand(2.2, ChangeToStandardFaction(oDevalle, STANDARD_FACTION_HOSTILE));
    DelayCommand(2.3, ChangeToStandardFaction(oEzril, STANDARD_FACTION_HOSTILE));
    DelayCommand(2.4, ChangeToStandardFaction(oSorin, STANDARD_FACTION_HOSTILE));

    DelayCommand(3.0, AssignCommand(oDevalle, ActionMoveToObject(oPC)));
    DelayCommand(3.1, AssignCommand(oSorin, ActionMoveToObject(oPC)));

    DelayCommand(5.0, AssignCommand(oSorin, DetermineCombatRound(oPC)));
    DelayCommand(5.1, AssignCommand(oDevalle, DetermineCombatRound(oPC)));
    DelayCommand(8.0, AssignCommand(oEzril, DetermineCombatRound(oPC)));

    //Destroy other versions of NPCs in game
    DestroyObject(GetObjectByTag("Devalle"));
    DestroyObject(GetObjectByTag("Ezril"));
    DestroyObject(GetObjectByTag("Sorin"));
    DestroyObject(GetObjectByTag("tr_swinn_up_flavor_text"));
    //Dog stops barking at Ezril's grove
    if(PlotLevelGet("EmpathyDog") == 1)
    {
        PlotLevelSet("EmpathyDog", 3);
    }
    else
    {
        PlotLevelSet("EmpathyDog", 2);
    }

    AssignCommand(oPC, StoreCameraFacing());
    AssignCommand(oPC, RestoreCameraFacing());
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
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
