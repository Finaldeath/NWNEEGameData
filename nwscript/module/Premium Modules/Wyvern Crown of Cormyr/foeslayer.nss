// B W-Husey
// October 2005
// Tag-Based Item Script (Equip only) for items with deity powers. These items become undroppable while
// they have a deity power on them.

#include "x2_inc_switches"
#include "x2_inc_itemprop"

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
{
object oPC;
object oItem;
switch( GetTagBasedItemEventNumber())
   { case X2_ITEM_EVENT_EQUIP:  //Equip event for Deity Specific powers.
         {
            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            if (GetDeity(oPC)=="Tempus") //check for a matching deity on the PC
            {
            //Deity Specific items generally give 2 or more powers, a 2/day power, and a temporary effect.
            itemproperty eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_AID_3,9);
            itemproperty eProp2 = ItemPropertyEnhancementBonus(2);

                IPSafeAddItemProperty(oItem,eProp,300.0);  //add the 'blessing' for 5 minutes
                IPSafeAddItemProperty(oItem,eProp2,300.0);  //add the 'blessing' for 5 minutes
                AddJournalQuestEntry("Gods",1,oPC,TRUE);   //add the journal entry with notes
                SetItemCursedFlag(oItem,TRUE); //Prevent this item being sold or dropped while in the blessed state
                DelayCommand(301.0,SetItemCursedFlag(oItem,FALSE)); //Remove the undroppable effect when the blessing wears out
            }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


