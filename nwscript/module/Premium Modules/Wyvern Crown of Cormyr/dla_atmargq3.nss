// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Latim & Eleanor persuaded to talk it over. Alignment consequences: no one loses

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nLBDud";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 75);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nAbduct",oPC,3);                                    //Just sets variable
    PartyGotEntry("Null",oPC,100,"XP Gain - quest experience");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Abduct",30,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,2,2,2,2,2,2,2,2,2);            //Who gets alignment points for this
    GiveKnightReputation(oPC,"the Wise");
    }

}


