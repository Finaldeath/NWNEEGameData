// B W-Husey
// October 2005
// Tag-Based Item Script for the Crystal ball (destroying it).

// NOTE: the aqcuire script fires section 6 of the main plot (Modularisation)

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
   {      case X2_ITEM_EVENT_ACTIVATE:   //How to destroy the ball
         {
            object oItem = GetItemActivated();
            object oPC = GetItemActivator();
            PartyGotEntry("Null",oPC,100,"XP Gain - Ball destroyed");
            AddJournalQuestEntry("Mythallar",70,oPC);
            AllParty("nMyth",oPC,4);
            SetItemCursedFlag(oItem,FALSE);
            SetPlotFlag(oItem,FALSE);
            DestroyObject(oItem,0.5);
         }
         case X2_ITEM_EVENT_ACQUIRE:
         { // This is where you would process item acquired - sets journal
         //Acquiring this item closes off/updates several plots, including the main one to 6.
          object oPC = GetModuleItemAcquiredBy();
          object oItem = GetModuleItemAcquired();
          object oPed = GetObjectByTag("CrystalPedestal");
            if (GetLocalInt(oPC,"nCBGot")<1) //once only
            {
                AddJournalQuestEntry("Mythallar",50,oPC);
                AddJournalQuestEntry("MainPlot",80,oPC);
                PartyGotEntry("Null",oPC,1000,"XP Gain - Ball recovered");
                AllParty("nCBGot",oPC,1);
                AllParty("nMyth",oPC,2); //Update the Mythallar quest variable
                AllParty("nMainPlot",oPC,6); //Update the Main plot variable
                SetItemCursedFlag(oItem,TRUE);  //stop this from being dropped
                SetPlotFlag(oPed,FALSE);     //Get rid of the pedestal
                DestroyObject(oPed,0.5);
            }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

