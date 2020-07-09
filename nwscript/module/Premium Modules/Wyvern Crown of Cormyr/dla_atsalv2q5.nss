// January 2006
// B W-Husey
// PC drove off bandits. Update Caravan subquest variable and journal.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "QvarB"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty("nSalvatori1Side",oPC,5);                                    //Set plot variable
    PartyGotEntry(sName,oPC,200,"XP Gain - caravan successfully guarded");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Caravan",40,oPC);                      //Update the journal
    }

}


