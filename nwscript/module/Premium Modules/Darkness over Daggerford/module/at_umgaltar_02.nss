// the player destroys umgatlik's sceptre

#include "hf_in_graphics"
#include "hf_in_plot"
#include "hf_in_xp"

int CountWorkers(object oPC)
{
    int i = 1;
    object oWorker = GetNearestObjectByTag("ks_dig_worker", oPC, i);
    while (GetIsObjectValid(oWorker))
    {
        oWorker = GetNearestObjectByTag("ks_dig_worker", oPC, ++i);
    }
    return(i-1);
}

void main()
{
    object oPC = GetPCSpeaker();

    // the scepter shatters
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), GetLocation(oPC));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CONFUSION_S), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL), OBJECT_SELF);

    // the doors open
    object oDoors = GetNearestObjectByTag("dt_dig_exit", oPC);
    SetLocked(oDoors, FALSE);
    AssignCommand(oDoors, ActionOpenDoor(oDoors));

    // the portal is destroyed
    object oPortal = GetNearestObjectByTag("ks_dig_portal", oPC);
    location lLoc = GetLocation(oPortal);
    DrawLineVert(lLoc, VFX_IMP_FLAME_M);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), lLoc);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD), lLoc);
    DestroyObject(oPortal);

    // the altar is no longer useful
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 1);

    // jared is pleased (if he still lives)
    PlotLevelSet("ks_jared", 6);
    SetLocalInt(GetModule(), "StrongholdQuest_cleric", 0);

    // adjust player's alignment
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {

        GiveXPToCreature(oPC, 100 + 50*CountWorkers(oPC));
        FloatingTextStringOnCreature("... XP Gain ...", oPC);
    }
    AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);

    // update the journal and give XP
    AddJournalQuestEntry("j80", 5, oPC);
    GiveQuestXPToCreature(oPC, "j80");
}
