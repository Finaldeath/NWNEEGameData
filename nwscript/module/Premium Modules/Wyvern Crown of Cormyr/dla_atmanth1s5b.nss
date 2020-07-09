// B W-Husey
// October 2005
// PC has reported back to Manthia a failure on the Ride like a Centaur quest, but with suspicions.

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();
AllParty("nManthia1Side",oPC,5);
AddJournalQuestEntry("Centaur",53,oPC);
PartyGotEntry("Null",oPC,100,"XP Gain - reported news back to Manthis");
}

