// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Got a guardian journal entry (xp for all three uses the same variable - only get it once)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "G2"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    if (GetLocalInt(oPC,"GXP")==0)
    {
        AllParty("GXP",oPC,1);                                    //Just sets variable
        PartyGotEntry("Dud",oPC,100,"XP Gain - Guardians information");
    }
    //Set variable for PC or partywide
    AllParty(sName,oPC,1);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Guardian2",10,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}

