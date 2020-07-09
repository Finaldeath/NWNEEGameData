// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
// Wyvern Necklace

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
        if (GetIsAreaInterior(oPC))
        {
            FloatingTextStringOnCreature("Summon fails",oPC);
        }
        else
        {
            effect ePotion = EffectVisualEffect(VFX_IMP_GOOD_HELP);
            effect e1 = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            location lTarget = GetItemActivatedTargetLocation();
            effect eSummon = EffectSummonCreature("necklacewyvern",VFX_FNF_SUMMON_UNDEAD,1.0);
            AssignCommand(oPC,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSummon,lTarget,1200.0));
//            ActionCreate("necklacewyvern",lTarget,e1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePotion, oPC);

        }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}
