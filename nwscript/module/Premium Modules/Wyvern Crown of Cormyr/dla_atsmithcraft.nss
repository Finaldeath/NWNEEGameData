// October 2005
// B W-Husey
// PC discovers they can get weapons reforged. Update journal and open crafting dialogues. Give xp.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XCraft";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Set variable for PC or partywide
    AllParty(sName,oPC,1);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain - Discovery");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Weapon",8,oPC,TRUE);                      //Update the journal
    }
}


