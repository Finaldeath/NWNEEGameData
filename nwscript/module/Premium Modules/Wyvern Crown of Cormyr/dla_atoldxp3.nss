// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Used on old man
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain - discovery");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Grave",41,oPC,TRUE);                      //Update the journal
    }

}


