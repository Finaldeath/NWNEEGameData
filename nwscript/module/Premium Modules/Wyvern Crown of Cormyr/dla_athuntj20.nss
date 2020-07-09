// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j20"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain - information");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("WStag",20,oPC,TRUE);                      //Update the journal
    }

}


