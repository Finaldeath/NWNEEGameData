// B W-Husey
// September 2005
// Londro Sidequest variable set to 1. Heard of his troubles and the Matron. Not taken yet.
// The point of the setting 1, is so you can research the Matron before taking the quest.
// Londro will continue to offer it in this state.
// The journal is also set to state 5.

#include "cu_functions"

void main()
{
    AllParty("LondroSide",GetPCSpeaker(),1);
    AddJournalQuestEntry("TheApprenticeSlave",5,GetPCSpeaker(),TRUE);
}
