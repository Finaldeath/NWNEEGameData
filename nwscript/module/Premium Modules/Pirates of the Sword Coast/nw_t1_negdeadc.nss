//::///////////////////////////////////////////////
//:: Deadly Negative Energy Trap
//:: NW_T1_NegDeadC
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does 8d6 negative energy damage and the target
    must make a Fort save or take 1 negative level
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 16, 2001
//:://////////////////////////////////////////////
//:: Modified By: Keith K2 Hayward
//:: Created On: March 2005
//:: ** Updated to support PotSC undead system
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    int nDamage = d6(8);

    effect eNeg = EffectNegativeLevel(1);
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eHeal = EffectHeal(nDamage);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);

    eNeg = SupernaturalEffect(eNeg);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

    if((GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    && (GetLocalInt(oTarget, "IOP_CUST_UNDEAD") != TRUE))
    {
        //Make a saving throw check
        if(!MySavingThrow(SAVING_THROW_FORT,oTarget, 15, SAVING_THROW_TYPE_TRAP))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNeg, oTarget);
        }
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
    }
}
