//DEBUG ONLY - MODIFY ME FOR USE

// October 2005
// B W-Husey
// Sets the main plot variable to 8.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "MP8"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    // Give the speaker the items

    //XP reward (non-alignment based) - quest, skill, class, ability use
    //Set variable for PC or partywide
    AllParty("nMainPlot",oPC,8);
//    AddJournalQuestEntry("MainPlot",30,oPC,TRUE);
//    PartyGotEntry(sName,oPC,500, "XP gain - plot furthered");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }

}







