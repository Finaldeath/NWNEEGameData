// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// Failed to get the horn out of Magnus - set variable and journal
// Trying and failing has no alignment score attached

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nHornFail";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nToOrder",oPC,5);                                    //Plot variable set to failed
    AddJournalQuestEntry("Order",50,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


