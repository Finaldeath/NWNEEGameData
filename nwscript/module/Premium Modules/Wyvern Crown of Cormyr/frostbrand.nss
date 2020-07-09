// B W-Husey
// September 2004
// Tag-Based Item Script (activate only)
//

#include "x2_inc_switches"

void Safety(object oPC,object oItem)
{

       if (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC))!="Frostbrand")
       {
       AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));
       }
}


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
int iSpell;
switch( GetTagBasedItemEventNumber())
   { case X2_ITEM_EVENT_EQUIP:
         { // This is where you would process item equipping.
        oItem = GetPCItemLastEquipped();
        SetItemCursedFlag(oItem,TRUE);
        }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
     case X2_ITEM_EVENT_UNEQUIP:
         { // This is where you would process item un-equipping.
      oPC = GetPCItemLastUnequippedBy();
      oItem = GetPCItemLastUnequipped();
//        Safety(oPC, oItem);
        AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

     case X2_ITEM_EVENT_ACQUIRE:
         { // This is where you would process item acquired.
      oPC = GetModuleItemAcquiredBy();
      oItem = GetModuleItemAcquired();

        SetIdentified(oItem,TRUE);
        Safety(oPC, oItem);
        SetItemCursedFlag(oItem,TRUE);
        DelayCommand(0.5,SetDroppableFlag(oItem,FALSE));
        AddJournalQuestEntry("Cursed",1,oPC,TRUE,FALSE,TRUE);
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;

/*     case X2_ITEM_EVENT_UNACQUIRE:
        { // This is where you would process item un-acquired.
            oPC = GetModuleItemLostBy();            // The player who dropped the item
            oItem  = GetModuleItemLost();
        DelayCommand(3.0,AssignCommand(oPC,SetCommandable (TRUE)));
        AssignCommand(oPC,ActionPickUpItem(oItem));
        AssignCommand(oPC,SetCommandable(FALSE));
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END);
         return;
*/
      case X2_ITEM_EVENT_SPELLCAST_AT:
         { // This is where you would process Spell Cast At from an item.
            oPC = OBJECT_SELF;                          // The player who cast the spell
            oItem  = GetSpellTargetObject();        // The item targeted by the spell
            iSpell = GetSpellId();


         if (iSpell==SPELL_REMOVE_CURSE || iSpell==SPELL_BLESS_WEAPON || iSpell==SPELL_DISPEL_MAGIC || SPELL_GREATER_DISPELLING || SPELL_LESSER_DISPEL)
         {
          GiveXPToCreature (oPC, 100);
          FloatingTextStringOnCreature("XP Gained - curse removed",oPC);
          SetPlotFlag(oItem,FALSE);
        AddJournalQuestEntry("Cursed",2,oPC,TRUE);
        DestroyObject(oItem);
         }
         }
         SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
         return;
   }
   SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE);
}


