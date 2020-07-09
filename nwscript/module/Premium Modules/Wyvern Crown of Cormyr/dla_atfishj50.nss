// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j50"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {


    //Set variable for PC or partywide
    if (GetLocalInt(oPC,"nWStag")==1)//only update if we have that quest
    {
    PartyGotEntry(sName,oPC,100,"XP Gain - information");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("WStag",50,oPC,TRUE);                      //Update the journal
    }
    }

}


