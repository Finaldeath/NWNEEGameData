// October 2005
// B W-Husey
// This action taken script of Manthia's allows overland travel to the Barrows.
// It is set in his conversation after releasing the messenger bird, or failing that, in Hawklin2 dialogue.
#include "cu_functions"
void main()
{
    object oTrans = GetNearestObjectByTag("HFWest");
    if (GetIsObjectValid(oTrans)==FALSE)  //i.e. talking to Hawklin
    {
        oTrans = GetObjectByTag("HFWest");
        AddJournalQuestEntry("Manthia1",26,GetPCSpeaker(),TRUE);
        AllParty("nManthiaPlot1",GetPCSpeaker(),2);     // Update the plot variable for Raids
    }
    else AddJournalQuestEntry("Manthia1",25,GetPCSpeaker(),TRUE);//talking to Manthis
    SetLocalInt(oTrans,"TRAVEL_HFBE",1);

}

