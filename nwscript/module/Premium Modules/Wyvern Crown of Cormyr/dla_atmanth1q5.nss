// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Update Raids journal and subplot variable to 5. Complete
// This is in Edgar's dialogues, delivered once Edgar joins party.

#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();

    //Pick Variable Type and rename

    string sName = "EdManth2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    AllParty("nManthiaPlot1",oPC,5);
    SetImmortal(OBJECT_SELF,FALSE);
    SetPlotFlag(OBJECT_SELF,FALSE);
    //Just sets variable
    PartyGotEntry(sName,oPC,500,"XP Gain - Edgar rescued");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Manthia1",40,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


