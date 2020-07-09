// January 2006
// B W-Husey
// PC elects to help in Abduction quest
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nAbduct";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    AligXP("AligXP1Marg", oPC, "GOOD", 50, 0);        //Shift/reward any alignment
    AligXP("AligXP1bMarg", oPC, "LAWFUL", 25, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,1);                                    //Just sets variable
    AddJournalQuestEntry("Abduct",10,oPC,TRUE);                      //Update the journal
    }

}


