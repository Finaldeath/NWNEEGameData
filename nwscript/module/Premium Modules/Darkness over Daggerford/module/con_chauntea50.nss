//con_chauntea50
//This is an adaptation of Bioware's barkskin spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Chauntea
//  in exchange for a donation to the temple. 50 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 08, 2005

void ahcApplyEffects(object oTarget,effect eVis,effect eLink,float fDuration)
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

}

void ahcApplyToAssociates(object oPC,effect eVis,effect eLink,float fDuration)
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
    object oCaster = OBJECT_SELF;

    int nBonus = 4;
    float fDuration = 2880.0;

    effect eVis = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eHead = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;

    //Take gold
    TakeGoldFromCreature(50, oTarget);

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Make sure the Armor Bonus is of type Natural
    eAC = EffectACIncrease(nBonus, AC_NATURAL_BONUS);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);

    //Apply effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oTarget);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_chauntea50",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_chauntea50",0));

}
