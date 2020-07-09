// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// PC gets the licence and journal entry (variable updated) in Family Grave quest

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nGrave";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {

    // reward goldor items
    CreateItemOnObject("licence",oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);


    //Set variable for PC or partywide
    PartyGotEntry("Dud",oPC,100,"XP Gain - licence gained");  //This comes with XP & message + sets the variable
    AllParty(sName,oPC,2);                                    //Just sets variable
    AddJournalQuestEntry("Grave",20,oPC,TRUE);                      //Update the journal

    }
}


