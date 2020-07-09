#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    // If oPC has successfully completed this plot phase return
    if (GetLocalInt(oPC, "nHawklinPlot1")>2) return;

    //plot integration, when pc wins two or more jousts
    AllParty("nHawklinPlot1", GetPCSpeaker(), -1); //fail
}
