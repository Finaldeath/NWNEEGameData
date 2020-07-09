//con_chauntea100
//This is an adaptation of Bioware's "one with the land" spell which causes
//  it to last 24 hours (2880 seconds). This is a boon from Chauntea
//  in exchange for a donation to the temple. 100 gold is taken from PC.
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

    float fDuration = 2880.0; // Duration 24 hours

    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eSkillAnimal = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 4);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, 4);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 4);
    effect eSearch = EffectSkillIncrease(SKILL_SET_TRAP, 4);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSkillAnimal, eMove);

    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eSearch);
    eLink = EffectLinkEffects(eLink, eDur);

    //Caster does conjure animation
    ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,3.0);

    //Take gold
    TakeGoldFromCreature(100, oTarget);

    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ahcApplyToAssociates(oTarget,eVis,eLink,fDuration);

    //Set duration variable
    SetLocalInt(oTarget,"ahc_chauntea100",1);
    DelayCommand(fDuration,SetLocalInt(oTarget,"ahc_chauntea100",0));
}
