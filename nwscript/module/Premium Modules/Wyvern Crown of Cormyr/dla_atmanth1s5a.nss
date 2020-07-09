// B W-Husey
// October 2005
// PC has reported back to Manthia a failure on the Ride like a Centaur quest.

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();
AllParty("nManthia1Side",oPC,5);
AddJournalQuestEntry("Centaur",52,oPC);

}

