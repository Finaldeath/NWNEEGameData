// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC has convinced Hawklin of Salvatori's involvement in the piracy. Update variable and journal.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPPir"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty("nPiracy",oPC,3);                                    //Plot variable
    PartyGotEntry(sName,oPC,250,"XP Gain - Hawklin learns of betrayal");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Piracy",20,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


