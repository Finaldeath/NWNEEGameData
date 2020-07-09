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
    // Get the PC, first.
    object oPC = GetItemActivator();
    object oRing = GetItemActivated();
    effect ePotion = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
    int nForm = GetLocalInt(oRing,"Form");
    effect eEffect1;
    if (nForm == 0)
    {
        nForm = Random(4)+1;
    }
    if (nForm == 1)     eEffect1 = EffectPolymorph(POLYMORPH_TYPE_BASILISK);
    if (nForm == 2)    eEffect1 = EffectPolymorph(POLYMORPH_TYPE_FROST_GIANT_FEMALE);
    if (nForm == 3)    eEffect1 = EffectPolymorph(POLYMORPH_TYPE_UMBER_HULK);
    if (nForm == 4)    eEffect1 = EffectPolymorph(POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL);
    SetLocalInt(oRing,"Form",nForm);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePotion, oPC);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect1, oPC, 80.0));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}
