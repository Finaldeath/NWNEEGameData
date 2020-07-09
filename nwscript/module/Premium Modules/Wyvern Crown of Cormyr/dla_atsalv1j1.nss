// B W-HUsey
// October 2005
// PC accepts the caravan duty sidequest without pay. Set the journal.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("Caravan",15,oPC,TRUE);
}
