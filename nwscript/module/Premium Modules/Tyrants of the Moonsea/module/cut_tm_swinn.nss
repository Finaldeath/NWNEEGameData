//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_swinn
// DATE: December 11, 2018
// AUTH: Rich Barker
// NOTE: Cutscene and dialogue at end of Murder in Elmwood in Still Water Inn
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "x0_i0_walkway"

#include "hf_in_cutscene"
#include "hf_in_henchman"
#include "hf_in_plot"

const string NPC_TAG_LYRESSA = "Lyressa";
const string NPC_TAG_SHARALYN = "SharalynHenchman";
const string NPC_TAG_THOYANA = "Thoyana";
const string NPC_TAG_PATRON1 = "StillWatersPatron1";
const string NPC_TAG_PATRON2 = "StillWatersPatron2";
const string NPC_TAG_PATRON3 = "StillWatersPatron3";

const string PLOT_DIALOG_SHARALYN = "hench_dialog_sharalyn";

void FreezePatrons()
{
    object oPatron1 = CutsceneGetActor(NPC_TAG_PATRON1);
    object oPatron2 = CutsceneGetActor(NPC_TAG_PATRON2);
    object oPatron3 = CutsceneGetActor(NPC_TAG_PATRON3);

    effect eFreeze = EffectCutsceneParalyze();
    effect eGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    SetLocalInt(oPatron1, "HF_DISABLE_AM", 1);
    AssignCommand(oPatron1, ClearAllActions());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oPatron1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPatron1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPatron1);

    SetLocalInt(oPatron2, "HF_DISABLE_AM", 1);
    AssignCommand(oPatron2, ClearAllActions());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oPatron2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPatron2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPatron2);

    SetLocalInt(oPatron3, "HF_DISABLE_AM", 1);
    AssignCommand(oPatron3, ClearAllActions());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oPatron3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oPatron3);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPatron3);
}

void UnfreezePatrons()
{
    object oPatron1 = CutsceneGetActor(NPC_TAG_PATRON1);
    object oPatron2 = CutsceneGetActor(NPC_TAG_PATRON2);
    object oPatron3 = CutsceneGetActor(NPC_TAG_PATRON3);

    SetLocalInt(oPatron1, "HF_DISABLE_AM", 0);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENE_PARALYZE, oPatron1);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEGHOST, oPatron1);
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oPatron1);

    SetLocalInt(oPatron2, "HF_DISABLE_AM", 0);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENE_PARALYZE, oPatron2);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEGHOST, oPatron2);
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oPatron2);

    SetLocalInt(oPatron3, "HF_DISABLE_AM", 0);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENE_PARALYZE, oPatron3);
    RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEGHOST, oPatron3);
    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oPatron3);
}

void SetupActors(object oPC)
{
    object oActor = GetNearestObjectByTag(NPC_TAG_LYRESSA, oPC);
    if (!GetIsObjectValid(oActor))
        oActor = GetObjectByTag(NPC_TAG_LYRESSA);

    CutsceneAddActor(NPC_TAG_LYRESSA, oActor);

    oActor = GetNearestObjectByTag(NPC_TAG_SHARALYN, oPC);
    if (!GetIsObjectValid(oActor))
        oActor = GetObjectByTag(NPC_TAG_SHARALYN);

    // Set dialog branch for Sharalyn
    PlotLevelSet(PLOT_DIALOG_SHARALYN, 4);
    CutsceneAddActor(NPC_TAG_SHARALYN, oActor);

    oActor = GetObjectByTag(NPC_TAG_THOYANA);
    CutsceneAddActor(NPC_TAG_THOYANA, oActor);

    oActor = GetObjectByTag(NPC_TAG_PATRON1);
    CutsceneAddActor(NPC_TAG_PATRON1, oActor);
    oActor = GetObjectByTag(NPC_TAG_PATRON2);
    CutsceneAddActor(NPC_TAG_PATRON2, oActor);
    oActor = GetObjectByTag(NPC_TAG_PATRON3);
    CutsceneAddActor(NPC_TAG_PATRON3, oActor);
}

void MoveActors()
{
    object oLyressa = CutsceneGetActor(NPC_TAG_LYRESSA);
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oPC = CutsceneGetPC();

    //Move any other companions out of the way as they can jostle henchmen
    //out of position
    object oCompanion = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    if (oCompanion != OBJECT_INVALID)
    {
        RemoveAssociateEffects(oCompanion);
        AssignCommand(oCompanion,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_SWINN_ANIMAL"))));
    }

    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if (oFamiliar != OBJECT_INVALID)
    {
        RemoveAssociateEffects(oFamiliar);
        AssignCommand(oFamiliar,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_SWINN_FAMILIAR"))));
    }

    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if (oSummon != OBJECT_INVALID)
    {
        RemoveAssociateEffects(oSummon);
        AssignCommand(oSummon,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_SWINN_SUMMON"))));
    }

    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    if (oDominated != OBJECT_INVALID)
    {
        RemoveAssociateEffects(oDominated);
        AssignCommand(oDominated,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_SWINN_DOMINATED"))));
    }

    AssignCommand(oLyressa,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_C4_HENCH_HOME_LYRESSA"))));
    AssignCommand(oSharalyn,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_C4_HENCH_HOME_SHARALYN"))));
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();
    AssignCommand(oPC, ClearAllActions());
    SetupActors(oPC);
    FreezePatrons();
    CutsceneStart(FALSE, FALSE, "WP_ELSWI_PC_JUMP", FALSE);
}

// Sharalyn talks to player
void next0(float fTime)
{
    object oLyressa = CutsceneGetActor(NPC_TAG_LYRESSA);
    object oSharalyn = CutsceneGetActor(NPC_TAG_SHARALYN);
    object oThoyana = CutsceneGetActor(NPC_TAG_THOYANA);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        RemoveAssociateEffects(oLyressa);
        RemoveAssociateEffects(oSharalyn);
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);
        // some time for the camera to settle down
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        AssignCommand(oPC, StoreCameraFacing());
        MoveActors();
        AssignCommand(oThoyana, SetFacingPoint(GetPosition(oPC)));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        AssignCommand(oLyressa, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oSharalyn, SetFacingPoint(GetPosition(oPC)));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(6.0);
    }
    else if (fTime == 6.0)
    {
        //CutsceneNextShot() invoked from Sharalyn conversation
        AssignCommand(oSharalyn, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next1(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

//Ensure  dialog aborted
void abort()
{
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    int nXP;

    object oLyressa = GetObjectByTag(NPC_TAG_LYRESSA);
    object oSharalyn = GetObjectByTag(NPC_TAG_SHARALYN);
    object oPC = CutsceneGetPC();
    object oThoyana = CutsceneGetActor(NPC_TAG_THOYANA);

    BlackScreen(oPC);

    //Ensure henchmen at home location
    AssignCommand(oLyressa,
        ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_C4_HENCH_HOME_LYRESSA"))));
    AssignCommand(oSharalyn,
        ActionJumpToLocation(GetLocation(GetWaypointByTag("WP_C4_HENCH_HOME_SHARALYN"))));
    AssignCommand(oLyressa, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));
    AssignCommand(oSharalyn, ActionDoCommand(SetFacingPoint(GetPosition(oPC))));

    //Unfreeze patrons
    UnfreezePatrons();

    //Resume Thoyana's Waypoint Walking
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, TRUE, oThoyana);

    //Update Plot variables
    PlotLevelSet("Enrad", 3);
    PlotLevelSet("Alamarayne", 2);

    if(PlotLevelGet("Valen") > 0)
    {
        PlotLevelSet("Valen", 2);
    }
    else
    {
        PlotLevelSet("Valen", 3);
    }

    //Update journal, award quest completion xp, and give rewards
    AddJournalQuestEntry("MurderInElmwood", 70, oPC);
    nXP = GetJournalQuestExperience("MurderInElmwood");
    GiveXPToCreature(oPC, nXP);
    CreateItemOnObject("x0_maarcl013", oPC);
    CreateItemOnObject("nw_it_mbracer013", oPC);
    CreateItemOnObject("x0_armhe012", oPC);
    CreateItemOnObject("dwarventhrower", oPC);

    //Update other journal entries
    AddJournalQuestEntry("Melvaunt", 10, oPC);
    AddJournalQuestEntry("Mulmaster", 10, oPC);
    AddJournalQuestEntry("Thentia", 10, oPC);
    AddJournalQuestEntry("ZhentilKeep", 10, oPC);

    if(PlotLevelGet("AstarsWidow-Status") < 2)
    {
        PlotLevelSet("AstarsWidow-Status", 2);
        AddJournalQuestEntry("AstarsWidow", 10, oPC);
        CreateItemOnObject("item014", oPC);
    }

    AssignCommand(oPC, RestoreCameraFacing());
    DelayCommand(2.0, FadeFromBlack(oPC, FADE_SPEED_SLOWEST));
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
