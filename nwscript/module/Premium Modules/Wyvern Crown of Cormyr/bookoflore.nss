// B W-Husey
// Tag-Based Item Script (activate only)
// Books and vials add permanent non-stacking bonuses to the creature props of the PC.

#include "x2_inc_itemprop"
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
    object oPC = GetItemActivator();
    object oTarget = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if (GetIsObjectValid(oTarget))
        {
           FloatingTextStringOnCreature("Permanent 2 point bonus to lore",oPC,TRUE);
           IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(SKILL_LORE,2));
        }
    }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
   return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


