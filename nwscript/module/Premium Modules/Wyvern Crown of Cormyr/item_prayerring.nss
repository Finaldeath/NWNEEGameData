// Tag-Based Item Script
// September 2005
// B W-Husey
// This item ahs a different power dependant on the deity of the user.
//:://////////////////////////////////////////////////////
// Prayer rings are the same as prayer amulets, except the bonus is better (and therefore they are more powerful)
#include "x2_inc_switches"

int GetTagBasedItemEventNumber()
{ int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   return (nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT"));
}

void SetTagBasedScriptExitBehavior( int nEndContinue)
{ DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
   DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT");
   SetExecutedScriptReturnValue( nEndContinue);
}


void main()
{ switch( GetTagBasedItemEventNumber())
   {     case X2_ITEM_EVENT_ACTIVATE:
         {
             // Get the PC, first.
    object oPC = GetItemActivator();
    int nLength = GetHitDice(oPC); //The effect length and power is dependant on hit dice, with a bonus for religious types.
    int nBonus = 0;
    nBonus += (GetLevelByClass(CLASS_TYPE_CLERIC,oPC));
    nBonus += (GetLevelByClass(CLASS_TYPE_PALADIN,oPC)/2);
    nBonus += (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)/2);
    nLength=nLength + nBonus;
    if (nLength>10) nLength = 10; //Maximum is 10

    effect eVFX1 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eVFX2 = EffectVisualEffect(VFX_DUR_IOUNSTONE_YELLOW);
    // The effect is dependant on deity
    effect eMilil = EffectConcealment(5*nLength,MISS_CHANCE_TYPE_NORMAL);
    effect eLathander = EffectSavingThrowIncrease(SAVING_THROW_ALL,1+nLength/2);
    effect eHelm = EffectSavingThrowIncrease(SAVING_THROW_ALL,1+nLength/2);
    effect eTempus = EffectAttackIncrease(1+nLength/3);
    effect eMalar =  EffectDamageReduction(nLength,DAMAGE_POWER_PLUS_ONE,50);
    effect eSilvanus = EffectTemporaryHitpoints(nLength*3);
    effect eTyr = EffectSpellResistanceIncrease(nLength*5);
    effect eChauntea =  EffectTemporaryHitpoints(nLength*3);
    effect eCoream = EffectAbilityIncrease(ABILITY_STRENGTH,1+nLength/3);
    effect eLliira = EffectSkillIncrease(SKILL_LORE,nLength*2);
    effect eTymora = EffectMovementSpeedIncrease(nLength*7);
    effect eDeneir = EffectDamageReduction(nLength,DAMAGE_POWER_PLUS_ONE,50);
    effect eSelune = EffectTrueSeeing();
    string sGod = GetDeity(oPC);
        //Now apply the effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX1, oPC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX2, oPC,nLength*6.0);
        if (sGod == "Milil") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMilil , oPC, nLength*6.0);
        if (sGod == "Lathander") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLathander , oPC, nLength*6.0);
        if (sGod == "Helm") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHelm , oPC, nLength*6.0);
        if (sGod == "Tempus") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTempus , oPC, nLength*6.0);
        if (sGod == "Malar") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMalar , oPC, nLength*6.0);
        if (sGod == "Silvanus") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilvanus , oPC, nLength*6.0);
        if (sGod == "Tyr") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTyr , oPC, nLength*6.0);
        if (sGod == "Chauntea") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChauntea , oPC, nLength*6.0);
        if (sGod == "Selune") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSelune , oPC, nLength*6.0);
        if (sGod == "Coream") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCoream , oPC, nLength*6.0);
        if (sGod == "Lliira") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLliira , oPC, nLength*6.0);
        if (sGod == "Tymora") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTymora , oPC, nLength*6.0);
        if (sGod == "Deneir") ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeneir , oPC, nLength*6.0);
        FloatingTextStringOnCreature("Your god bestows a special blessing upon you for "+IntToString(nLength*6)+" seconds",oPC,FALSE);
    }

         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


