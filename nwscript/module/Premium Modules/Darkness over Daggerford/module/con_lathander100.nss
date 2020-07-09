//con_lathander100
//This is an adaptation of Bioware's elemental shield spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Lathander
//  in exchange for a donation to the temple. 100 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 08, 2005

#include "x0_i0_spells"
void ahcApplyEffects(object oTarget,effect eVis,effect eLink, float fDuration)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
}

void ahcApplyToAssociates(object oPC,effect eVis,effect eLink, float fDuration)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
    {
        ahcApplyEffects(oAnimal, eVis, eLink, fDuration);
    }
    if(oDominated != OBJECT_INVALID)
    {
        ahcApplyEffects(oDominated, eVis, eLink, fDuration);
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        ahcApplyEffects(oFamiliar, eVis, eLink, fDuration);
    }
    if(oSummoned != OBJECT_INVALID)
    {
        ahcApplyEffects(oSummoned, eVis, eLink, fDuration);
    }
        int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        ahcApplyEffects(oHench, eVis, eLink, fDuration);
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
    //Declare major variables
    object oTarget = GetPCSpeaker();
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    float fDuration = 2880.0;
    int nDuration = 2880;
    effect eShield = EffectDamageShield(1, DAMAGE_BONUS_1d6, DAMAGE_TYPE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 50);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 50);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eCold);
    eLink = EffectLinkEffects(eLink, eFire);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //  *GZ: No longer stack this spell
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
         RemoveSpellEffects(GetSpellId(), oTarget, oTarget);
    }

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(100,oTarget);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ahcApplyToAssociates(oTarget,eVis,eLink,fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_lathander100",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_lathander100",0));
}
