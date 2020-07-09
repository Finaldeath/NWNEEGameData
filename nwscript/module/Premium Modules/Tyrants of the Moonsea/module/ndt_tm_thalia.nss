// sidequest: shadovar search party:
// thalia is dead; update the quest
// .. note that the journal update overrides because you can choose to kill her after taking the quest

#include "hf_in_plot"

void main()
{
    object oPC = GetFirstPC();

    // update the journal, overriding higher entries because she's dead
    AddJournalQuestEntry("ShadovarSearchParty", 40, oPC, TRUE, FALSE, TRUE);
    if (PlotLevelGet("Thalia") == 2)
    {
        int nXP = GetJournalQuestExperience("ShadovarSearchParty");
        GiveXPToCreature(oPC, nXP);
    }

    // the usual shadovar death puff vfx
    location lLoc = GetLocation(OBJECT_SELF);
    effect eSmoke = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lLoc);
}
