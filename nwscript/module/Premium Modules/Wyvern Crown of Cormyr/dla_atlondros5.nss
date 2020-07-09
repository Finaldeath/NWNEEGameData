// B W-Husey
// September 2005
// Londro Sidequest variable set to 5. Set on Matron conversation.
// Matron has given a written doc that must be witnessed by Mander.
// Journal state set to 26 (this script is actually on the Matron)
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("LondroSide",oPC,5);
    AddJournalQuestEntry("TheApprenticeSlave",26,oPC,TRUE);
    CreateItemOnObject("witnessdoc",oPC);
}
