//con_lathander5
//This is an adaptation of Bioware's bless spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Lathander
//  in exchange for a donation to the temple. 5 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 8, 2005

void ahcApplyEffects(object oTarget,effect eVis,effect eLink, effect eImpact, float fDuration)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oTarget));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
}

void ahcApplyToAssociates(object oPC,effect eVis,effect eLink, effect eImpact, float fDuration)
{
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    if(oAnimal != OBJECT_INVALID)
    {
        ahcApplyEffects(oAnimal, eVis, eLink, eImpact, fDuration);
    }
    if(oDominated != OBJECT_INVALID)
    {
        ahcApplyEffects(oDominated, eVis, eLink, eImpact, fDuration);
    }
    if(oFamiliar != OBJECT_INVALID)
    {
        ahcApplyEffects(oFamiliar, eVis, eLink, eImpact, fDuration);
    }
    if(oSummoned != OBJECT_INVALID)
    {
        ahcApplyEffects(oSummoned, eVis, eLink, eImpact, fDuration);
    }
        int i = 1;
    object oHench = GetHenchman(oPC, i);
    while(oHench != OBJECT_INVALID)
    {
        ahcApplyEffects(oHench, eVis, eLink, eImpact, fDuration);
        i++;
        oHench = GetHenchman(oPC, i);
    }
}

void main()
{
    //Declare major variables
    object oTarget = GetPCSpeaker();
    float fDuration = 2880.0;//24 hours of game time
    float fDelay = 0.6;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);

    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);

    //Caster "casts spell"
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(5,oTarget);

    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(oTarget));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
    ahcApplyToAssociates(oTarget, eVis, eLink, eImpact, fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_lathander5",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_lathander5",0));
}
