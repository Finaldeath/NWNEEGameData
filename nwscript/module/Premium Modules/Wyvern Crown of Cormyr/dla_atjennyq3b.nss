// AJanuary 2006
// B W-Husey
// NPC rewards template to be used after an action
// JPC brought Jenny the poor hide

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP("AligXP3Jen", oPC, "GOOD", 150, 2);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nWStag",oPC,3);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("WStag",71,oPC,TRUE);                      //Update the journal
    GiveKnightReputation(oPC,"the Swift");
    }

}


