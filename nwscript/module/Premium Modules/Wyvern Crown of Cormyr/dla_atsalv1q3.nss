// B W-HUsey
// October 2005
// PC accepts the caravan duty sideuqest. Update the variable nSalvatori1Side to 3, and set the journal.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("nSalvatori1Side",oPC,3);
    AddJournalQuestEntry("MainPlot",15,oPC,TRUE);
}
