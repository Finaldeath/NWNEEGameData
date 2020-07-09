// January 2006
// B W-Husey
// PC takes Eleanor back to Furniture's Fate.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nAbduct";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<5) //once only
    {
    //Set variable for PC or partywide
    AllParty(sName,oPC,5);                                    //Just sets variable
    AddJournalQuestEntry("Abduct",40,oPC,TRUE);                      //Update the journal
    }

}


