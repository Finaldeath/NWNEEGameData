// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// PC has neglected father's head. Only an evil person would do such a thing!

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nGrave";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<3) //once only
    {

    //Alignment consequences of action
    AligXP("AligXP90", oPC, "EVIL", 75, 2);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,8);                                    //Just sets variable
    AddJournalQuestEntry("nGrave",90,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,0,0,0,0,1,2,3,4,5);            //Who gets alignment points for this
    }
}


