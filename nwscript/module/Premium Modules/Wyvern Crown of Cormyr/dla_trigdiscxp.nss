// August 2003
// B W-Husey
// XP for discovery - uses tag of Trigger as identifier - make it Unique!
// This trigger should go in the "landing point" of the discovery.

#include "CU_FUNCTIONS"

void main()
{
   string sString = GetTag(OBJECT_SELF);
   object oPC = GetEnteringObject();
   if (!GetLocalInt(oPC,sString)==1) {
   if (GetIsDefPC(oPC)){
   PartyGotEntry(sString,oPC, 150, "XP Gain - discovery");}}
}

