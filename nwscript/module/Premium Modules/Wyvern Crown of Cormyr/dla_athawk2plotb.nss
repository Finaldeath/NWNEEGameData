// B W-Husey
// December 2005
// Hawklin's plot variable used in section 4 of the module (see plot variable doc) is set to 1 or 2
// The PC has shared 1 or both vital pieces of information on the Witch Lord.

#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"nHP2Track2",1);

    if (GetLocalInt(oPC,"nHP2Track2")==1 && GetLocalInt(oPC,"nHP2Track1")==1)
    {
        AllParty("nHawklinPlot2",GetPCSpeaker(),2);
        AddJournalQuestEntry("MainPlot",65,GetPCSpeaker(),TRUE);
    }
    else AllParty("nHawklinPlot2",GetPCSpeaker(),1);
}
