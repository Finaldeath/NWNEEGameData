// B W-Husey
// August 2005
// Tag-Based Item Script (activate only)
// Mindstar - on a succesful concentration check, the wearer gains a bonus to search, spot and listen
// equal to their concentration skill rank.

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
            object oPC = GetItemActivator();
            int nBonus = GetSkillRank(SKILL_CONCENTRATION,oPC);
            if (GetIsSkillSuccessful(oPC,SKILL_CONCENTRATION,15))
            { //Concentration skill check succesful
                effect e1 = EffectSkillIncrease(SKILL_LISTEN, nBonus);
                effect e2 = EffectSkillIncrease(SKILL_SPOT, nBonus);
                effect e3 = EffectSkillIncrease(SKILL_SEARCH, nBonus);
                effect e4 = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
                effect eLink1 = EffectLinkEffects(e1,e4);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink1,oPC, 300.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2,oPC, 300.0);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e3,oPC, 300.0);
            }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

