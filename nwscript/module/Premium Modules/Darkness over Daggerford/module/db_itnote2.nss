//db_itnote2
#include "x2_inc_switches"

void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
      {
       object oItem = GetModuleItemAcquired();
       object oPC = GetItemPossessor(oItem);
       object oLostBy = GetModuleItemAcquiredFrom();

       FloatingTextStringOnCreature("This looks important", oPC, FALSE);
       SetDroppableFlag(oItem,FALSE);
       SetItemCursedFlag(oItem, TRUE);
      }
}
