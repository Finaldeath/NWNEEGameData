// October 2005
// B W-Husey
// PC confirmed they will repay debt in Payment for the Charter quest. Notation is sd for this sidequest.
// Good/lawful characters get xp just for promising.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC,"nHawklinDebt")<2)
    {
        AllParty("nHawklinDebt",GetPCSpeaker(),5);
        AligXP("Debt2AXP",oPC,"Good",25,0);
        AligXP("Debt2AXP",oPC,"Lawful",25,0);
        AddJournalQuestEntry("Debt",16,oPC,TRUE);
    }
}
