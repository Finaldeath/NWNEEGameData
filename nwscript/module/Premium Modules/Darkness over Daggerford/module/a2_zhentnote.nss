//a2_zhentnote
//This is the onacquire script for the zhentarim notes found in the blackstone inn.
//and will update the journal entry for the 'the_blackstone_inn' quest
//Author: Phil Mitchell (Baron of Gateford)
#include "x2_inc_switches"

void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
      {
       object oItem = GetModuleItemAcquired();
       object oPC = GetItemPossessor(oItem);
       object oLostBy = GetModuleItemAcquiredFrom();
       string sTag = GetTag(oItem);

      if (GetLocalInt(oItem,"String_spoke")== 0)
          {
           FloatingTextStringOnCreature("This note looks important", oPC, FALSE);
           SetLocalInt(oItem,"String_spoke",1);
           }
       int iJournal = GetLocalInt(GetModule(),"the_blackstone_inn");
       if (iJournal == 1)
           {
            AddJournalQuestEntry ("the_blackstone_inn", 2, oPC, TRUE);
            SetLocalInt(GetModule(),"the_blackstone_inn",2);
           }
      }
}
