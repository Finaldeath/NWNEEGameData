//::///////////////////////////////////////////////
//:: FileName ac_lorujournal
//:: Set variable to indicate PC has found Loru's journal
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb. 25, 2006
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void main()
{
  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
  {
      object oPC = GetModuleItemAcquiredBy();
      SetLocalInt(oPC, "ac_loru_diary", 1);
      AddJournalQuestEntry("j59",5,oPC);
  }
}
