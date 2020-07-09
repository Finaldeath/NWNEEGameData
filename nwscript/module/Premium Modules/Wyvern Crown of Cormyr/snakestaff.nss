// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
// Summons a snake summoned associate

/*
//Wrapper function for the summon
void SummonCreature(string sSummonResRef, location lTarget)
{
         effect eSummon = EffectSummonCreature(sSummonResRef,VFX_FNF_SUMMON_UNDEAD,1.0);
         ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSummon,lTarget,1200.0);
}
*/

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
    // Get the PC, first.
    object oPC = GetItemActivator();
    object oRing = GetItemActivated();
    effect ePotion = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect e1 = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            location lTarget = GetItemActivatedTargetLocation();
            ActionCreate("staffsnake",lTarget,e1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePotion, oPC);
//        AssignCommand(oPC, SummonCreature("staffsnake",lTarget));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}
