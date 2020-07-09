// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// PC gets journal entry for the final battle

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j100"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,500,"XP Gain - Wyvern Crown located.");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("MainPlot",100,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


