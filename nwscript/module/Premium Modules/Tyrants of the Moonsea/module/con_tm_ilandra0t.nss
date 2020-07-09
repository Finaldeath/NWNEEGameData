//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Initial Ilandra Dialog
//::////////////////////////////////////////////////////
//:: This dialog branch appears if the PC has
//:: True Seeing effect and it is the first dialog
//::////////////////////////////////////////////////////

#include "hf_in_plot"

int getHasTrueSeeing(object oTarget)
{
    effect eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_TRUESEEING)
            return TRUE;
        eEffect = GetNextEffect(oTarget);
    }
    return FALSE;
}

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oIlandra = OBJECT_SELF;

    return(PlotLevelCheckEquals(GetTag(oIlandra), 0) && getHasTrueSeeing(oPC));
}
