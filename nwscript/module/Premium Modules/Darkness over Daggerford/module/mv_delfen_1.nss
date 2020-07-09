#include "hf_in_plot"
#include "hf_in_cutscene"
#include "nw_i0_spells"

void CreateSujit(location lLocation)
{
    CreateObject(OBJECT_TYPE_CREATURE,"pm_sujit", lLocation);
}

void FreeSujit()
{
    object oChest = GetObjectByTag("pm_impchest");
    effect eEffect = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eEffect2 = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);

    ActionMoveAwayFromObject(oChest, FALSE, 1.0);
    ActionCastFakeSpellAtLocation(SPELL_BALAGARNSIRONHORN,GetLocation(oChest));
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oChest));
    ActionWait(1.0);
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect2,oChest));
    ActionDoCommand(CreateSujit(GetLocation(oChest)));
    ActionDoCommand(DestroyObject(oChest));
    ActionWait(2.0);
    ActionMoveToObject(GetWaypointByTag("POST_pm_delfen"));
    ActionDoCommand(SetFacing(GetFacingFromLocation(GetLocation(GetWaypointByTag("POST_pm_delfen")))));
}

// just start the scene
void start()
{
    CutsceneStart(FALSE, TRUE, "CS_PC_DELFEN_START", FALSE);
}

// Delfen release Sujit from the chest
void next0(float fTime)
{
    object oDelfen = GetObjectByTag("pm_delfen");
    object oPC = GetFirstPC();
    object oRylett = GetObjectByTag("pm_rylett");

    effect eFreeze = EffectCutsceneParalyze();
    effect eGhost = EffectCutsceneGhost();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    if (fTime == 0.0)
    {
        // give some time for the camera to settle down
        CutMoveAssociatesTo(oPC, "CS_PARTY_DELFEN_START");
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        FreezeAssociates(oPC, TRUE);
        AssignCommand(oDelfen, SetFacingPoint(GetPosition(GetWaypointByTag("CS_DELFEN"))));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oRylett);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oRylett);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oRylett);
        CutsceneCameraSetup(-1.0, 240.0, 15.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oPC, StoreCameraFacing());
        CutsceneNext(5.5);
    }
    else if (fTime == 5.5)
    {
        object oChest = GetItemPossessedBy(oPC, "a2_pm_impchest");
        DestroyObject(oChest);
        AssignCommand(oDelfen, ActionPauseConversation());
        AssignCommand(oDelfen, ActionMoveToObject(GetWaypointByTag("CS_DELFEN")));

        CutsceneNext(9.0);
    }
    else if (fTime == 9.0)
    {
         AssignCommand(oDelfen, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
         CutsceneNext(9.5);
    }
    else if (fTime == 9.5)
    {
         CreateObject(OBJECT_TYPE_PLACEABLE, "pm_impchest", GetLocation(GetWaypointByTag("CS_DELFEN")));
         CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        AssignCommand(oDelfen, ActionDoCommand(FreeSujit()));
        CutsceneNext(22.0);
    }
    else if (fTime == 22.0)
    {
        AssignCommand(oPC, ActionMoveToObject(GetWaypointByTag("CS_PC_DELFEN_END"), TRUE));
        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        PlotLevelSet("pm_delfen", 2);
        RemoveSpecificEffect(EFFECT_TYPE_CUTSCENE_PARALYZE, oRylett);
        RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEGHOST, oRylett);
        RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oRylett);
        CutsceneEnd();
    }
}

void end()
{
    object oDelfen = GetObjectByTag("pm_delfen");
    object oPC = GetFirstPC();

    AssignCommand(oDelfen,SetFacingPoint(GetPosition(oPC)));
    AssignCommand(oDelfen, ActionResumeConversation());
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
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        //CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
