// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// The Keeper has told the PC about the crystal ball. Journal entry.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j10"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100,"XP Gain");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Mythallar",10,oPC,TRUE);                      //Update the journal
    }
}

