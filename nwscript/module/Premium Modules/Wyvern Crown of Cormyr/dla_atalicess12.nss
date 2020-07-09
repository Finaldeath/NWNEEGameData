// November 2005
// B W-Husey
// Completed Catch a Spy sidequest

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSpy";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)==10) //once only
    {
    DestroyObject(GetItemPossessedBy(oPC,"AgentsNote"));
    //Set variable for PC or partywide
    AllParty(sName,oPC,12);                                    //Just sets variable
    PartyGotEntry("Dud",oPC,350,"XP Gain - quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Catch",51,oPC,TRUE);                      //Update the journal
//    ScoreAlign(oPC,2,0,0,1,0,2,2,2,2,2);            //Who gets alignment points for this
    }

}


