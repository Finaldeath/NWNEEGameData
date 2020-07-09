// December 2005
// B W-Husey
// Sets the main plot variable to 4. This allows the PC to enter fourth 'section' of the module.
// PC also gains xp and journal entry.
// This script also kicks off the piracy sidequest along with journal entry.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "MP4"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    // Give the speaker the items

    //XP reward (non-alignment based) - quest, skill, class, ability use
    //Set variable for PC or partywide
    AllParty("nMainPlot",oPC,4);
    AllParty("nPiracy",oPC,1);
    AddJournalQuestEntry("MainPlot",60,oPC,TRUE);
    AddJournalQuestEntry("Piracy",10,oPC,TRUE);
    PartyGotEntry(sName,oPC,1500, "XP gain - plot furthered");  //Reward whole party, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }

}







