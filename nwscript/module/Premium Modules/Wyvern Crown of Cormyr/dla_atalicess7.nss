// November 2005
// B W-Husey
// NPC rewards template to be used after an action
// Had Hawklin's assistance in To be a Spy sidequest and reported back. Update and reward accordingly.
// Alignment-wise, taking the quest and talking to Hawklin is more good, but everyone benefits
// This opens the next section - identifying the client in 'To catch a Spy'

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
    AllParty(sName,oPC,7);                                    //Just sets variable
    PartyGotEntry("Null",oPC,100,"XP Gain - quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Spy",60,oPC,TRUE);                      //Update the journal
    AddJournalQuestEntry("Catch",10,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,5,5,5,5,5,5,5,4,3);            //Who gets alignment points for this
    }

}


