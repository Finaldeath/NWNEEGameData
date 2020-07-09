// B W-Husey
// Tag-Based Item Script (activate only)
// Enchanting Stone - temporarily enhance a weapon.

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
// Get the PC, first.
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    int nBonus = 0;
    if (GetIsObjectValid(oTarget))
        {

        if (GetSkillRank(SKILL_CRAFT_WEAPON,oPC)>0){
            FloatingTextStringOnCreature("XP Gain - weapon craft skill bonus",oPC,TRUE);
            nBonus = GetSkillRank(SKILL_CRAFT_WEAPON,oPC)/3;
            GiveXPToCreature(oPC,30);
            }
        if (nBonus>5)
            {
            IPSafeAddItemProperty(oTarget, ItemPropertyEnhancementBonus(1+(nBonus-5)/2));
            }
        else
            {
            IPSafeAddItemProperty(oTarget, ItemPropertyEnhancementBonus(1+nBonus),240.0);
            }
        }
    }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
   return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


