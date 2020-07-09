//con_chauntea25
//This is an adaptation of Bioware's aid spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Chauntea
//  in exchange for a donation to the temple. 25 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 08, 2005

void ahcApplyEffects(object oTarget,effect eVis,effect eLink, effect eHP, float fDuration)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, fDuration);

}

void ahcApplyToAssociates(object oPC,effect eVis,effect eLink, effect eHP, float fDuration)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
    {
        ahcApplyEffects(oAnimal, eVis, eLink, eHP, fDuration);
    }
    if(oDominated != OBJECT_INVALID)
    {
        ahcApplyEffects(oDominated, eVis, eLink, eHP, fDuration);
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        ahcApplyEffects(oFamiliar, eVis, eLink, eHP, fDuration);
    }
    if(oSummoned != OBJECT_INVALID)
    {
        ahcApplyEffects(oSummoned, eVis, eLink, eHP, fDuration);
    }
        int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        ahcApplyEffects(oHench, eVis, eLink, eHP, fDuration);
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
    //Declare major variables
    object oTarget = GetPCSpeaker();
    object oCaster = OBJECT_SELF;

    float fDuration = 2880.0;
    int nBonus = d8(1);
    int nMetaMagic = GetMetaMagicFeat();

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nBonus = 8;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nBonus = nBonus + (nBonus/2); //Damage/Healing is +50%
    }

    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);

    effect eHP = EffectTemporaryHitpoints(nBonus);

    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(25,oTarget);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, fDuration);
    ahcApplyToAssociates(oTarget,eVis,eLink,eHP,fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_chauntea25",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_chauntea25",0));
}
