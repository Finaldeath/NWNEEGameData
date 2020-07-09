// October 2005
// B W-Husey
// PC refuses to repay debt in Payment for the Charter quest. Notation is sd for this sidequest.
// This is a non good option, with equivalent shifts and score updated accordingly. Journal set.
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC,"nHawklinDebt")<10)
    {
        AllParty("nHawklinDebt",GetPCSpeaker(),11);
        AddJournalQuestEntry("Debt",21,oPC,TRUE);
        ScoreAlign(oPC,3,0,0,0,1,2,3,1,3,3);
        if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL) AligXP("Debt3AXP",oPC,"Neutral",25,1);
        else AligXP("Debt3AXP",oPC,"Evil",50,2);
        GiveKnightReputation(oPC,"the Miser");
    }
}
