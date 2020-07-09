// B W-Husey
// October 2005
// Tag-Based Item Script for the Bag of Beans, which creates a bean each time it is used with a random power
// Acquiring the bag sets the number of beans (charges).

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
{ switch( GetTagBasedItemEventNumber())
   {      case X2_ITEM_EVENT_ACTIVATE:
         {
            object oItem = GetItemActivated();
            object oPC = GetItemActivator();
            string sResRef;
            itemproperty iProp;
            SetItemCharges(oItem,GetItemCharges(oItem)-1);
            effect e1 = EffectVisualEffect(VFX_IMP_BREACH);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oPC);
            int rand = Random(4);  //We don't want all beans to look the same, so give a random appearance.
            if (rand ==1) sResRef = "MagicBean";
            else if (rand ==2) sResRef = "MagicBean2";
            else if (rand ==3) sResRef = "MagicBean3";
            else sResRef = "MagicBean4";
            object oNew = CreateItemOnObject(sResRef,oPC);  //make the 'bean'
            int rand2 = Random (10);   //Now find a random property for the bean
            switch (rand2)
            {
                case 0:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_HASTE_5,1);
                break;
                case 1:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_BARKSKIN_6,1);
                break;
                case 2:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_BLADE_BARRIER_15,1);
                break;
                case 3:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_CATS_GRACE_15,1);
                break;
                case 4:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_7,1);
                break;
                case 5:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_DRAGON_BREATH_WEAKEN_10,1);
                break;
                case 6:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_7,1);
                break;
                case 7:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_PRAYER_5,1);
                break;
                case 8:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_QUILLFIRE_8,1);
                break;
                case 9:
                iProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5,1);
                break;
            }
            IPSafeAddItemProperty(oNew,iProp);  //add the magic power
         }
         case X2_ITEM_EVENT_ACQUIRE:
         { // This is where you would process item acquired - sets number of beans (charges)
          object oPC = GetModuleItemAcquiredBy();
          object oItem = GetModuleItemAcquired();
          if (GetItemCharges(oItem)<1) SetItemCharges(oItem,5*d4()); //FIrst use set number of beans
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}

