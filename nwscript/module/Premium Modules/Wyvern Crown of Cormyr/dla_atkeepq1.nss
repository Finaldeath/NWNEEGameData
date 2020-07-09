// January 2006
// B W-Husey
// The Keeper has given the PC the important details on how to shut down the Mythallar.
// Update nMyth variable to 1, set journal.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "q1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty("nMyth",oPC,1);                                    //Just sets variable
    PartyGotEntry(sName,oPC,250,"XP Gain");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Mythallar",15,oPC,TRUE);                      //Update the journal
    }

}


