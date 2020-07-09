// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
//
#include "x2_inc_itemprop"
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
// Get the PC, first.
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    if (GetIsObjectValid(oTarget))
    {

        int nRand = Random(6);
        int nSkillGive = SkillCheck();
        if (GetSkillRank(SKILL_CRAFT_WEAPON,oPC)>0 || GetSkillRank(SKILL_CRAFT_ARMOR,oPC)>0){
            FloatingTextStringOnCreature("XP Gain - weapon/armour craft skill bonus",oPC,TRUE);
            nRand = nRand+2;
            GiveXPToCreature(oPC,30);
        }

       if (nRand<2)       IPSafeAddItemProperty(oTarget, ItemPropertyDecreaseSkill(nSkillGive,1));
       if (nRand<5 && nRand>1)       IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(nSkillGive,1),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
       if (nRand<6 && nRand>4)       IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(nSkillGive,2),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
       if (nRand<7 && nRand>5)       IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(nSkillGive,3),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
       if (nRand>6)       IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(nSkillGive,4),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
    }         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


