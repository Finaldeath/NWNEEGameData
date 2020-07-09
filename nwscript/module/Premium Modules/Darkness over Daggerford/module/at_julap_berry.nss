// player consumes one of julap's guloob berries and passes-out

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    float fDur = 6.0;

    ActionPauseConversation();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, fDur);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, fDur));
    DelayCommand(fDur, ActionResumeConversation());

    PlotLevelSet("ks_julap", 1);
}
