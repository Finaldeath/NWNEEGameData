// October 2005
// B W-Husey
// Sidequest script used on Magnus for the Poltergeist of Polter's Fort sidequest - this one is set on the poltergeist's dialogue
// Variable is nPoltergeist, journal tag is Poltergeist
// Variable states:
// 1 = Heard of the poltergeist and offered solution
// 2 = Got the Holy Water
// 5 = Sprinkled holy water on the blade


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
// This is the 'correct' option for good and lawful characters, though no penalty for others here.
    AligXP("PolterAXP", oPC, "LAWFUL", 25, 1);        //Shift/reward any alignment
    AligXP("PolterAXP", oPC, "GOOD", 25, 0);        //Shift/reward any alignment

//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this - set in script s9 or s6
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,200,"XP Gain - poltergeist vanquished");  //xp for defeat of poltergeist
    AddJournalQuestEntry("Poltergeist",20,oPC,TRUE);                      //Update the journal
    AllParty("nPoltergeist",oPC,5);  //set the variable (PartyGotEntry sets it to 1 by default)

    DestroyObject(GetObjectByTag("SHolyWater"));
    DestroyObject(GetObjectByTag("Polterblade"),0.5);
    CreateItemOnObject("shard2",oPC);

    }

}




