// B W-Husey
// October 2005
// Tag-Based Item Script for the Plot wand.

#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "cu_functions"

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
            object oItem = GetItemActivated();
            object oPC = GetItemActivator();
            AssignCommand(oPC,ActionStartConversation(oPC,"debug"));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

