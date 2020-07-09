//January 2006
// B W-Husey
// Sets the main plot variable to 5. PC enters Wyvernwater Castle for the 1st time. Set plot variable and journal
// Modularised section 5 is everything that happens in WC. Only other accessible areas are Thunderstone areas
// and Lake Wyvernwater.

#include "cu_functions"
void main()
{
object oPC = GetEnteringObject();

//Pick Variable Type and rename

string sName = "MP5"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetIsPC(oPC) && GetLocalInt(oPC,sName)<1) //once only
    {
    // Give the speaker the items

    //XP reward (non-alignment based) - quest, skill, class, ability use
    //Set variable for PC or partywide
    AllParty("nMainPlot",oPC,5);
    AddJournalQuestEntry("MainPlot",75,oPC,TRUE);
//    PartyGotEntry(sName,oPC,500, "XP gain - plot furthered");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }

}







