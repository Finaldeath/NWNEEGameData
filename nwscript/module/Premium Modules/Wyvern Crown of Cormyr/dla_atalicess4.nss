// April 2004
// B W-Husey
// To be a spy update, variable to 4 (told Hawklin) and journal
//  This is set in hawklin1 & 2 dialogue (i.e. not on Alice)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSpy";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<4) //once only
    {

    AligXP("AligXPss1", oPC, "GOOD", 75, 1);        //Shift/reward any alignment
    AligXP("AligXPss1b", oPC, "LAWFUL", 50, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,4);          //told Hawklin
    AddJournalQuestEntry("Spy",30,oPC,TRUE);                      //Update the journal
    }

}


