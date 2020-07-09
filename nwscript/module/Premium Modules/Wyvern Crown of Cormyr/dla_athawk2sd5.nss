// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Reward for repaying Hawklin for the Charter, and remove the gold.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "nHawklinDebt";                     //Unique tag
int nVar = 1; //This variable deals with the score for true neutral characters, which is set by the previous responses
// they've used.
if (GetLocalInt(oPC,"sName")==1) nVar = 3; //True Neutral Character gets full reward as they had not decided one way or the other till they paid.

//Give rewards once only
if (GetLocalInt(oPC,sName)<10) //once only
    {
    // reward gold or items
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0));

    // Remove from the player
    TakeGoldFromCreature(1000, GetPCSpeaker(), FALSE);

    //Alignment consequences of action
    //Should be good or lawful to benefit, so otherwise I must shift.
    if(GetAlignmentLawChaos(oPC)!=ALIGNMENT_LAWFUL && GetAlignmentGoodEvil(oPC)!=ALIGNMENT_GOOD)
            AligXP("Debt4AXPa", oPC, "GOOD", 0, 1);        //Shift/reward any alignment
            AligXP("Debt4AXPb", oPC, "LAWFUL", 0, 1);        //Shift/reward any alignment
    //Now we've dealt with the special case, do the catch-alls
    AligXP("Debt4AXPa", oPC, "GOOD", 50, 0);        //Shift/reward any alignment
    AligXP("Debt4AXPb", oPC, "LAWFUL", 50, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain - charter repaid");  //General xp for such a high gp expense
    AllParty(sName,oPC,10);                                    //Fix the quest variable to the right number
    AddJournalQuestEntry("Debt",20,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,3,3,3,3,3,nVar,0,3,0,0);            //Who gets alignment points for this
    }

}



