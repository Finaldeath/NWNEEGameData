// B W-Husey
// October 2005
// Hawklin's plot variable used in section 1 of the module (see plot variable doc) is set to 1
// The PC has received their offer to enter in the joust. They have not yet succeeded in the joust.

#include "cu_functions"

void main()
{
    AllParty("nHawklinPlot1",GetPCSpeaker(),1);
    AllParty("nHawkTalk",GetPCSpeaker(),1);   //variable added to denote Hawklin asked about quest as one above started being used for other stuff too.
    AddJournalQuestEntry("Hawklin1",5,GetPCSpeaker(),TRUE);
}
