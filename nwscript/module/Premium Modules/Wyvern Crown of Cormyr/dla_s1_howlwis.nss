//::///////////////////////////////////////////////
//:: Howl: Wisdom Damage
//:: dla_s1_HowlWis
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    A howl emanates from the creature, affecting all
    non-outsiders that hear it within 20 ft,
    doing 1 point of temporary Wisdom damage,
    unless they make a save
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Feb 19, 2006
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "dla_i0_const"

void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eHowl = EffectAbilityDecrease(ABILITY_WISDOM, 1);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);

    effect eLink = EffectLinkEffects(eHowl, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    float fDelay;
    int nHD = GetHitDice(OBJECT_SELF);
    int nDC = 12;
    int nDuration = 1 + (nHD/4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);

    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && !GetIsFriend(oTarget) && oTarget != OBJECT_SELF && GetRacialType(oTarget) != RACIAL_TYPE_OUTSIDER)
        {
            nDuration = GetScaledDuration(nDuration , oTarget);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_WISDOMDAMAGE));
            fDelay = GetDistanceToObject(oTarget)/10;
            //Make a saving throw check
            if(!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


