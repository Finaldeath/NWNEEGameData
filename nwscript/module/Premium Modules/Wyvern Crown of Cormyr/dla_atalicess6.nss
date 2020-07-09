// November 2005
// B W-Husey
// NPC rewards template to be used after an action
// Found entrance in To be a Spy sidequest and reported back. Update and reward accordingly.
// Alignment-wise, taking the quest without talking to Hawklin is more chaotic or evil
// Succeeding or failing makes no odds alignment-wise, so this is the same as 5.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSpy";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<5) //once only
    {

    // reward gold or items
    GiveGoldToCreature(oPC,200);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    //Set variable for PC or partywide
    AllParty(sName,oPC,6);                                    //Just sets variable
    PartyGotEntry("Null",oPC,100,"XP Gain - quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Spy",55,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,0,2,3,1,3,5,3,5,5);            //Who gets alignment points for this
    }

}


