// November 2005
// B W-Husey
// NPC rewards template to be used after an action
// Failed to find entrance in To be a Spy sidequest. Update and reward accordingly.
// Alignment-wise, taking the quest without talking to Hawklin is more chaotic or evil
// This is the bluff it out option, where the PC lies about finding the entrance and gets away with it

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSpy";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<5) //once only
    {

    //Set variable for PC or partywide
    AllParty(sName,oPC,5);                                    //Just sets variable
    PartyGotEntry("Null",oPC,100,"XP Gain - quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Spy",52,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,0,0,0,1,4,5,3,5,5);            //Who gets alignment points for this
    }

}


