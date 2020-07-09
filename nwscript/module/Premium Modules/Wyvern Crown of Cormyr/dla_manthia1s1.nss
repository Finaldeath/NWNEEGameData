// B W-Husey
// October 2005
// Manthia the centaur tells the PC about the hunting of the Forest Folk and promises a reward for stopping it.

#include "cu_functions"

void main()
{
object oPC = GetPCSpeaker();
AllParty("nManthia1Side",oPC,1);
AddJournalQuestEntry("Centaur",10,oPC);

}

