// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Reward for refusing To be a Spy sidequest. Mainly alignment scores. No one gets punished by this
// option

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP1"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP(sName, oPC, "GOOD", 100, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AddJournalQuestEntry("Spy",10,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,5,5,5,5,5,3,3,2,2);            //Who gets alignment points for this
    }

}


