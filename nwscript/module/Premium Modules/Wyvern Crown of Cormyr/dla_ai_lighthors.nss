// dla_ai_lighthors.nss
// JUNE 28 2006
// Robert Faber
// Light horses flee any combat.

#include "nw_i0_generic"
#include "x2_inc_switches"
#include "dla_i0_horse"
#include "dla_i0_horseai"
void main()
{

    object oIntruder = GetCreatureOverrideAIScriptTarget();

    //Vulc:  can't attach the VFX to horse (no nodes).  EffectFrightened only.
    //effect eVis = EffectVisualEffect(VFX_DUR_DLA_HORSE_PANIC);
    //effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eFear = EffectFrightened();
    //effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    //effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    //effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    //Link the fear and mind effects
    //effect eLink = EffectLinkEffects(eFear, eMind);
    //eLink = EffectLinkEffects(eLink, eDur);

    ClearCreatureOverrideAIScriptTarget();
    SetCreatureOverrideAIScriptFinished();


    if(GetAssociateState(NW_ASC_IS_BUSY))
    {
        return;
    }

    if(BashDoorCheck(oIntruder)) {return;}

    // * BK: stop fighting if something bizarre that shouldn't happen, happens
    if (bkEvaluationSanityCheck(oIntruder, GetFollowDistance()) == TRUE)
        return;

    if (GetIsObjectValid(oIntruder) == FALSE)
        oIntruder = bkAcquireTarget();

    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetNearestSeenOrHeardEnemy();
    }
    if (GetIsObjectValid(oIntruder) == FALSE)
    {
        oIntruder = GetLastAttacker();
    }
    if (GetIsObjectValid(oIntruder) && GetIsDead(oIntruder) == TRUE)
    {
        return;
    }
    if (__InCombatRound() == TRUE)
    {
        return;
    }

    if(DLA_GetIsTied(OBJECT_SELF))
    {
        return;
    }
    if(!GetHasEffect(EFFECT_TYPE_FRIGHTENED))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, OBJECT_SELF, 12.0);
    }
}
