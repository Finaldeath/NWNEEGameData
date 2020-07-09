
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

void ActionCreate(string oCreature,location lLoc, effect eSummon)
{
    object oNew = CreateObject(OBJECT_TYPE_CREATURE,oCreature,lLoc,FALSE);
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon,oNew));
}

void main()
{ switch( GetTagBasedItemEventNumber())
   {      case X2_ITEM_EVENT_ACTIVATE:
         {
            effect e1 = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            effect e2 = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
            effect e3 = EffectVisualEffect(VFX_DUR_CALTROPS);
            object oPC = GetItemActivator();
            location lTarget = GetItemActivatedTargetLocation();
//            if (GetIsPC(oPC)==TRUE)
//            {
            ActionCreate("boneskel",lTarget,e1);
            ActionCreate("boneskel",lTarget,e1);
            ActionCreate("boneskel",lTarget,e1);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,e3,lTarget,3.0);
//            }
/*            else
            {
            ActionCreate("boneskel2",GetLocation(lTarget),e1);
            ActionCreate("boneskel2",GetLocation(lTarget),e1);
            ActionCreate("boneskel2",GetLocation(lTarget),e1);
            }*/
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, e2,lTarget);
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

