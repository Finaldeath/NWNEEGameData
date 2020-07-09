// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
//

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
   {      case X2_ITEM_EVENT_ACTIVATE:
         {
            effect e1 = EffectAbilityIncrease(ABILITY_STRENGTH,1);
            effect e2 = EffectAttackDecrease(1);
            effect e3 = EffectSavingThrowIncrease(SAVING_THROW_WILL,2);
            effect e4 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
            effect e5 = EffectSkillDecrease(SKILL_SPOT,3);
            effect eLink1 = EffectLinkEffects(e4,e2);
            effect eLink2 = EffectLinkEffects(e3,e1);
            object oPC = GetItemActivator();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink1,oPC, 120.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2,oPC, 120.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e5,oPC, 150.0);
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

