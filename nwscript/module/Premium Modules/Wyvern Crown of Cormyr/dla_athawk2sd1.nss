// October 2005
// B W-Husey
// Set up the Payment for the Charter quest. Notation is sd for this sidequest.
// Good characters get xp just for asking.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC,"nHawklinDebt")<1)
    {
        AllParty("nHawklinDebt",GetPCSpeaker(),1);
        AligXP("Debt1AXP",oPC,"Good",25,0);
        AddJournalQuestEntry("Debt",10,oPC,TRUE);
    }
}
