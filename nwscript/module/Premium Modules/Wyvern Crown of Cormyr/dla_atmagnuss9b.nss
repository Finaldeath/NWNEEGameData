// October 2005
// B W-Husey
// Sidequest script used on Magnus for the Poltergeist of Polter's Fort sidequest
// Variable is nPoltergeist, journal tag is Poltergeist
// Variable states:
// 1 = Heard of the poltergeist and offered solution
// 2 = Got the Holy Water
// 5 = Sprinkled holy water on the blade
// 6 = Took the weapon
// 9 = As 5 but told Magnus the priest
// This script differs from s9 as the PC also got told to reforge the blade.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nPoltergeist";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<9) //once only
    {

//Alignment consequences of action
// This is the 'correct' option for evil characters.
    AligXP("PolterAXP", oPC, "GOOD", 50, 1);        //Shift/reward any alignment

    ScoreAlign(oPC,3,3,3,3,3,3,2,1,1,0);            //Who gets alignment points for this - set in script s9 or s6
    //Set variable for PC or partywide
    AddJournalQuestEntry("Poltergeist",24,oPC,TRUE);                      //Update the journal
    AllParty("nPoltergeist",oPC,9);  //set the variable (PartyGotEntry sets it to 1 by default)
    GiveKnightReputation(oPC,"the Devout");
   }

}




