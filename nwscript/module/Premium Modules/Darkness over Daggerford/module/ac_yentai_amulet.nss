//::///////////////////////////////////////////////
//:: FileName ac_yentai_amulet
//:: Tag based triggered event for Yentai's amulet - ariable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: December 19, 2005
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void main()
{
  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
  {
      object oPC = GetModuleItemAcquiredBy();
      SetLocalInt(oPC, "ac_cheese_quest", 5);
      AddJournalQuestEntry("j54", 10, oPC, TRUE, FALSE, TRUE);
  }
}
