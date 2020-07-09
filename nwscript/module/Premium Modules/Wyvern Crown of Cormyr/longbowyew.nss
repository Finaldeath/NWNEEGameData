// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
//

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
   { case X2_ITEM_EVENT_EQUIP:
         {
            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            int nStrength = GetAbilityScore(oPC,ABILITY_STRENGTH);
            if (nStrength>19) { IPSafeAddItemProperty(oItem,ItemPropertyMaxRangeStrengthMod(3),0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING); }
            if (nStrength>16) { IPSafeAddItemProperty(oItem,ItemPropertyMaxRangeStrengthMod(2),0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING); }
            if (nStrength>13) { IPSafeAddItemProperty(oItem,ItemPropertyMaxRangeStrengthMod(1),0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING); }
            if (nStrength<12) { ActionUnequipItem(oItem); }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

     case X2_ITEM_EVENT_UNEQUIP:
         {
            oPC = GetPCItemLastUnequippedBy();
            oItem = GetPCItemLastUnequipped();
            IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_MIGHTY,DURATION_TYPE_PERMANENT);
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


