// January 2006
// B W-Husey
// PC refuses to help in Abduction quest
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nAbduct";                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP("AligXP1Marg", oPC, "EVIL", 25, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,6);                                    //Just sets variable
    AddJournalQuestEntry("Abduct",50,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,0,0,0,0,2,2,1,2,2);            //Who gets alignment points for this
    }

}


