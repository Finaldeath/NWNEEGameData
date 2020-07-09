// October 2005
// B W-Husey
// PC considers they might repay debt in Payment for the Charter quest. Notation is sd for this sidequest.
// neutral characters get xp for this response. Non evil characters get a minor shift to neutral.
// NOTE: if you want to run a dialogue on this state, use nHawklinDebt = 1 as no other variation
// leaves the variable in this state
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC,"nDebtSpec")<1)
    {
        AllParty("nDebtSpec",oPC,1);
        AligXP("Debt2AXP",oPC,"Neutral",35,0);
        if(GetAlignmentGoodEvil(oPC)!=ALIGNMENT_EVIL) AligXP("Debt2AXPb",oPC,"Neutral",0,1);
        AddJournalQuestEntry("Debt",15,oPC,TRUE);
    }
}
