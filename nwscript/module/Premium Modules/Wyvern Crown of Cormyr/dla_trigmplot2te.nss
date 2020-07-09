// January 2006
// B W-Husey
// Sets the main plot variable to 2. This allows the PC to enter second 'section' of the module.
// This is on a trigger and is for testing purposes only (normally it comes from a
// dialogue just before reaching this areaa: Hullack Forest)

#include "cu_functions"
void main()
{
object oPC = GetEnteringObject();

//Pick Variable Type and rename

string sName = "MP2"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    AllParty("nMainPlot",oPC,2);
    AddJournalQuestEntry("MainPlot",30,oPC,TRUE);
// Next line not used for testing
//    PartyGotEntry(sName,oPC,500, "XP gain - plot furthered");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }

}


