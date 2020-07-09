// B W-Husey
// September 2005
// Londro Sidequest variable set to 9. Quest failed and finished. The journal reprts that the PC was unable to
// help Londro, and that Londro was too drunk to care (journal TheApprenticeSlave set to 35).

#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("LondroSide",oPC,9);
    PartyGotEntry("Dud",oPC,100,"XP Gain - quest completed");
    AddJournalQuestEntry("TheApprenticeSlave",35,oPC,TRUE);
}
