//con_lathander25
//This is an adaptation of Bioware's owl's wisdom spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Lathander
//  in exchange for a donation to the temple. 25 gold is taken from PC.
//
//Author: Anya Clancy
//Date: Oct 08, 2005

void ahcApplyEffects(object oTarget, effect eVis, effect eLink, float fDuration)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}

void ahcApplyToAssociates(object oPC, effect eVis, effect eLink, float fDuration)
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
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = d4(1) + 1;
    float fDuration = 2880.0;

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(25,oTarget);

    //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_WISDOM, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ahcApplyToAssociates(oTarget, eVis, eLink, fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_lathander25",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_lathander25",0));

}
