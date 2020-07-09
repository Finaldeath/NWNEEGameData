//con_lathander50
//This is an adaptation of Bioware's prayer spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Lathander
//  in exchange for a donation to the temple. 50 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 08, 2005

void ahcApplyEffects(object oTarget,effect ePosVis,effect ePosLink,effect eImpact, float fDuration)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oTarget));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,fDuration);

}

void ahcApplyToAssociates(object oPC,effect ePosVis,effect ePosLink,effect eImpact, float fDuration)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
    {
        ahcApplyEffects(oAnimal, ePosVis, ePosLink, eImpact, fDuration);
    }
    if(oDominated != OBJECT_INVALID)
    {
        ahcApplyEffects(oDominated, ePosVis, ePosLink, eImpact, fDuration);
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        ahcApplyEffects(oFamiliar, ePosVis, ePosLink, eImpact, fDuration);
    }
    if(oSummoned != OBJECT_INVALID)
    {
        ahcApplyEffects(oSummoned, ePosVis, ePosLink, eImpact, fDuration);
    }
        int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        ahcApplyEffects(oHench, ePosVis, ePosLink, eImpact, fDuration);
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
    //Declare major variables
    object oTarget = GetPCSpeaker();
    effect ePosVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

    int nBonus = 1;
    effect eBonAttack = EffectAttackIncrease(nBonus);
    effect eBonSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
    effect eBonDam = EffectDamageIncrease(DAMAGE_BONUS_1, DAMAGE_TYPE_SLASHING);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
    ePosLink = EffectLinkEffects(ePosLink, eBonDam);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);

    float fDuration = 2880.0; //24 hours game time

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(50,oTarget);

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oTarget));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,fDuration);
    ahcApplyToAssociates(oTarget, ePosVis, ePosLink, eImpact,fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_lathander50",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_lathander50",0));
}
