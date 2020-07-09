// October 2005
// B W-Husey
// Sidequest script used on Magnus for the Poltergeist of Polter's Fort sidequest - this one is set on the poltergeist's dialogue
// Variable is nPoltergeist, journal tag is Poltergeist
// Variable states:
// 1 = Heard of the poltergeist and offered solution
// 2 = Got the Holy Water
// 5 = Sprinkled holy water on the blade
// 6 = Took the weapon


#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "nPoltergeist";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<5) //once only
    {

//Alignment consequences of action
// This is the 'correct' option for evil characters.
    AligXP("PolterAXP", oPC, "EVIL", 100, 2);        //Shift/reward any alignment
    AligXP("PolterAXP", oPC, "CHAOTIC", 25, 0);        //Shift/reward any alignment

    ScoreAlign(oPC,3,0,1,1,1,3,3,3,3,3);            //Who gets alignment points for this - set in script s9 or s6
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,200,"XP Gain - poltergeist vanquished");  //xp for defeat of poltergeist
    AddJournalQuestEntry("Poltergeist",25,oPC,TRUE);                      //Update the journal
    AllParty("nPoltergeist",oPC,6);  //set the variable (PartyGotEntry sets it to 1 by default)
    }

}




