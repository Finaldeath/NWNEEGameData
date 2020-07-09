//con_chauntea5
//This is an adaptation of Bioware's resistance spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Chauntea
//  in exchange for a donation to the temple. 5 gold is taken from PC.
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

    effect eSave;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    int nBonus = 1; //Saving throw bonus to be applied
    float fDuration = 2880.0; // Seconds

    //Set the bonus save effect
    eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
    effect eLink = EffectLinkEffects(eSave, eDur);

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(5,oTarget);

    //Apply the bonus effect and VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_chauntea5",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_chauntea5",0));
}
