// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Update Raids journal and subplot variable to 3.
// This is in Edgar's dialogues.

#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();

    //Pick Variable Type and rename

    string sName = "EdManth1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    AllParty("nManthiaPlot1",oPC,3);                                    //Just sets variable
    PartyGotEntry(sName,oPC,500,"XP Gain - Edgar found");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Manthia1",30,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


