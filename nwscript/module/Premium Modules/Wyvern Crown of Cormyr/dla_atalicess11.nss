// November 2005
// B W-Husey
// NPC rewards template to be used after an action
// Hawklin requests the PC catch the spy. PC accepts.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nSpy";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)==7) //once only
    {
    AligXP("AligXPss8", oPC, "LAWFUL", 50, 0);        //Shift/reward any alignment
    AligXP("AligXPss8", oPC, "GOOD", 50, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,8);                                    //Just sets variable
    AddJournalQuestEntry("Catch",50,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,0,0,1,0,2,2,2,2,2);            //Who gets alignment points for this
    }

}

