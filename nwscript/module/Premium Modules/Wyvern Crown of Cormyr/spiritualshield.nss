// Tag-Based Item Script
// September 2005
// B W-Husey
// Spiritual shield
//:://////////////////////////////////////////////////////

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

    effect eVFX1 = EffectVisualEffect(495);
    effect eVFX2 = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eShield1 = EffectACIncrease(1);
    effect eShield2 = EffectSpellLevelAbsorption(3,9);
    effect eShield3 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eLinked1 = EffectLinkEffects(eVFX1,eShield1);
    effect eLinked2 = EffectLinkEffects(eVFX2,eShield2);

        //Now apply the effect
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinked1, oPC,300.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinked2, oPC,300.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShield3, oPC,300.0);
        }

         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


