// October 2005
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "Squire"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    // Give the speaker the items
    // reward gold
    GiveGoldToCreature(oPC,150);
    PartyGotEntry(sName,oPC,500, "XP gain - Squiredom achieved");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    AddJournalQuestEntry("Hawklin1",50,oPC,TRUE);
    }

}







