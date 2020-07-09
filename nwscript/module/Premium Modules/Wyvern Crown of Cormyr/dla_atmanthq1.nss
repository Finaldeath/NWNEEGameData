// B W-Husey
// October 2005
// Manthia's plot variable used in section 2 of the module (see plot variable doc) is set to 1
// The PC has received information on the raid origin. They can now use their messenger bird.
// Modified to add status check - April 25th

#include "cu_functions"

void main()
{
    if (GetLocalInt(GetPCSpeaker(),"nManthiaPlot1")<1)
    {
    AllParty("nManthiaPlot1",GetPCSpeaker(),1);
    AddJournalQuestEntry("Manthia1",5,GetPCSpeaker(),TRUE);
    }
}
