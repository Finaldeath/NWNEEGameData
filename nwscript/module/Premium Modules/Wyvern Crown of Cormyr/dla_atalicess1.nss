// November 2005
// B W-Husey
// PC accepts the To be a Spy sidequest. Set journal, and plot variable nSpy = 1.
// To be a spy scripts use ss (theft to order use st)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

AllParty("nSpy",oPC,1);
AddJournalQuestEntry("Spy",11,oPC,TRUE);                      //Update the journal

}


