



void RemoveNegativeEffects(object oTarget)
{ // PURPOSE: remove negative effects
    effect eDisarmTrap = SupernaturalEffect(EffectSkillDecrease(SKILL_DISABLE_TRAP , 50));
    effect eOpenLock   = SupernaturalEffect(EffectSkillDecrease(SKILL_OPEN_LOCK    , 50));
    effect eHide       = SupernaturalEffect(EffectSkillDecrease(SKILL_HIDE         , 50));
    effect eMove       = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY, 50));
    effect ePickPocket = SupernaturalEffect(EffectSkillDecrease(SKILL_PICK_POCKET  , 50));
    effect eSetTrap    = SupernaturalEffect(EffectSkillDecrease(SKILL_SET_TRAP     , 50));
    effect eTumble     = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE       , 50));
    effect eTraverse=GetFirstEffect(oTarget);
    while(GetIsEffectValid(eTraverse))
    { // check all effects
        if (eTraverse==eDisarmTrap) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==eOpenLock) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==eHide) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==eMove) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==ePickPocket) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==eSetTrap) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        else if (eTraverse==eTumble) DelayCommand(0.5,RemoveEffect(oTarget,eTraverse));
        eTraverse=GetNextEffect(oTarget);
    } // check all effects

} // RemoveNegativeEffects()




void main()
{
    object oPC=GetFirstPC();
    object oTarget;
    int nN=1;
    RemoveNegativeEffects(oPC);
    oTarget=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    while(GetIsObjectValid(oTarget))
    { // remove
        DelayCommand(IntToFloat(nN),RemoveNegativeEffects(oTarget));
        nN++;
        oTarget=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,nN);
    } // remove
}
