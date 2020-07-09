// B W-Husey
// September 2005
// Londro Sidequest variable set to 4. Set on Matron conversation.
// Matron has given her word to pay Londro better. Speak to Londro.
// Journal state set to 25 (this script is actually on the Matron)

#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("LondroSide",oPC,4);
    AddJournalQuestEntry("TheApprenticeSlave",25,oPC,TRUE);
}
