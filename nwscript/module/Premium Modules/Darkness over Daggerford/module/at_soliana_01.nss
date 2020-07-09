// soliana turns into a hawk and flies out the window

#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oWindow = GetNearestObjectByTag("pl_ar2003_window", OBJECT_SELF);
    SetFacingPoint(GetPosition(oWindow));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), OBJECT_SELF);
    SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_FALCON);
    SetLocalInt(GetModule(), "nFandocPrincessDead", 1);
    AddJournalQuestEntry("j85", 10, oPC);
    GiveQuestXPToCreature(oPC, "j85", 50.0);
    PlotLevelSet(GetTag(OBJECT_SELF), 3);
    SetLocalInt(GetModule(), "StrongholdQuest_fighter", 0);
}
