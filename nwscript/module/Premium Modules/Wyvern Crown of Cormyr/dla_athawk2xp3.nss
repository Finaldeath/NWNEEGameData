// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// Standard reward script for reporting the Witch Lord's news to Hawklin on return
// from Polter's Fort.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,1000,"XP Gain - Hawklin's 2nd task completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("MainPlot",70,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


