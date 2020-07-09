// October 2005
// B W-Husey
// Sidequest script used on Magnus for the Poltergeist of Polter's Fort sidequest
// Variable is nPoltergeist, journal tag is Poltergeist
// Variable states:
// 1 = Heard of the poltergeist and offered solution

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nPoltergeist";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,150,"XP Gain - Fort researched");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Poltergeist",10,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


