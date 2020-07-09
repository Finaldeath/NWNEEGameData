//::///////////////////////////////////////////////
//:: FileName ac_banditnote
//:: Tag based triggered event for bandit note - sets variable
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: December 10, 2005
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void main()
{
  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent == X2_ITEM_EVENT_ACQUIRE)
  {
  object oPC = GetModuleItemAcquiredBy();
  SetLocalInt(oPC, "ac_banditnote", 1);
  }
}
