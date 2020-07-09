
// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Jenny hands out the White Stag (Love of a lord ) quest.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nWStag";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    AllParty(sName,oPC,1);                                    //Just sets variable
//    PartyGotEntry(sName,oPC,100,"XP Gain - Oath extracted");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("WStag",10,oPC,TRUE);                      //Update the journal
    }

}


