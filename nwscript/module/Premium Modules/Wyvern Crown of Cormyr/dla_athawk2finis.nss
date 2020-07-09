// January 2006
// B W-Husey
// The PC has reported back to Hawklin the destruction of Wyvernwater Castle.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nHawklinFin6";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    object oItem = GetItemPossessedBy(oPC,"barrowmap");
    AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    DestroyObject(oItem);
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,1000,"XP Gain - Wyvernvapor defeated");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("MainPlot",95,oPC,TRUE);                      //Update the journal
//    ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


