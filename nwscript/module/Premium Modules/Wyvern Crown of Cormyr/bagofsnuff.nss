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
            effect e1 = EffectBlindness();
            effect e2 = EffectDeaf();
            effect e3 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
            effect eLink1 = EffectLinkEffects(e1,e3);
            object oPC = GetItemActivator();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink1,oPC, 12.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e2,oPC, 12.0);
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM)));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM)));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM)));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

