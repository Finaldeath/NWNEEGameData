// October 2005
// B W-Husey
// Gilbert Hawklin makes the PC a knight, rewards xp, sets a variable to pick a horse up from the stable,
// sets the journal
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPKnight"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,2000,"XP Gain - knighted");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("MainPlot",50,oPC,TRUE);                      //Update the journal
    AllParty("nFreeHorse",oPC,1);
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


