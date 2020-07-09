//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_mirror
// DATE: March 18, 2006.
// AUTH: Luke Scull
// NOTE: Turn copy of player hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "nw_i0_generic"
void main()
{
object oCopy = GetObjectByTag("PlayerCopy");

object oPC = GetFirstPC();

TakeGoldFromCreature(GetGold(oCopy), oCopy, TRUE);

SetLootable(oCopy, FALSE);

object oItem = GetFirstItemInInventory(oCopy);

while(GetIsObjectValid(oItem))
   {
      SetDroppableFlag(oItem, FALSE);
      oItem = GetNextItemInInventory(oCopy);
   }
   int i;
   for(i = 0; i < NUM_INVENTORY_SLOTS; i++)
   {
        oItem = GetItemInSlot(i, oCopy);
        if(GetIsObjectValid(oItem))
        {
           SetDroppableFlag(oItem, FALSE);
        }
}

ChangeToStandardFaction(oCopy, STANDARD_FACTION_HOSTILE);

AssignCommand(oCopy, DetermineCombatRound());

AssignCommand(oCopy, ActionAttack(oPC));
}
