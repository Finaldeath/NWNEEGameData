// the hag polymorphs player and gives the quest

#include "hf_in_plot"
#include "inc_polymorph"

void main()
{
    object oPC = GetPCSpeaker();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);

    // update plot and journal
    PlotLevelSet("ks_greenhag", 2);
    AddJournalQuestEntry("j87", 1, oPC);

    // cast the spell
    ActionPauseConversation();
    PlaySound("vs_chant_ench_lf");
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0);
    if(GetHasEffect(EFFECT_TYPE_POLYMORPH, oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        RemoveSpecificEffect(EFFECT_TYPE_POLYMORPH, oPC);
    }
    ActionDoCommand(DoPolymorphParty(oPC));
    ActionResumeConversation();
}
