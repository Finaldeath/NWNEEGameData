// B W-Husey
// October 2005
// Tag-Based Item Script (activate only) used for the messenger bird. Either release of the bird is not permitted
// Or the bird is released and the the cutscene fired (bird is destroyed)

#include "x2_inc_switches"
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
         object oPC = GetItemActivator();
         object oItem = GetItemActivated();
         if (GetLocalInt(oPC,"nManthiaPlot1")<1) FloatingTextStringOnCreature("You have no information so it is pointless to release the bird",oPC);
         else if (GetTag(GetArea(oPC))!="HullackForest") FloatingTextStringOnCreature("You should travel first to the meeting point so you can receive Hawklin's reply",oPC);
         else  //PC has spoken to Manthia - ok to release the bird.
         {
            AllParty("nManthiaPlot1",oPC,2);     // Update the plot variable
            ExecuteScript("dla_cutbird",oPC);   // Do the cutscene in a seperate script so you can test without it.
            CreateItemOnObject("message1",oPC);  //give the message to the PC
            AddJournalQuestEntry("MainPlot",35,oPC,TRUE);
            AddJournalQuestEntry("Manthia1",20,oPC,TRUE);
            PartyGotEntry("DudVariable",oPC, 100, "XP Gain - Information sent to Hawklin");
            SetPlotFlag(oItem,FALSE);
            DestroyObject(oItem,1.0);
         }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

