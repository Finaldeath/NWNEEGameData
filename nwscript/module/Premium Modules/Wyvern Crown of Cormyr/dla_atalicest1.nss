// November 2005
// B W-Husey
// PC accepts the Theft to Order sidequest. Set journal, and plot variable nOrder = 1.
// Theft to order scripts use st (To be a spy scripts use ss)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

AllParty("nToOrder",oPC,1);
AddJournalQuestEntry("Order",10,oPC,TRUE);                      //Update the journal

}


