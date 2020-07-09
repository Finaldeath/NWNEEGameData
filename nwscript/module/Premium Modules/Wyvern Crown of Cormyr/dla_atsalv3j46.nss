// January 2006
// B W-Husey
// PC refuses a deal with Salvatori3. Update journal & xp.
// Until the castle is dealt with, the alignment scores for this quest are not handed out.
// Summons help for Salvatori

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j46"+GetTag(OBJECT_SELF);                     //Unique tag
location lLoc = GetLocation(GetWaypointByTag("WP_SalvHelp"));

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP("AligXPj46", oPC, "GOOD", 100, 1);        //Shift/reward any alignment
    AligXP("AligXPj46b", oPC, "LAWFUL", 100, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,250,"XP Gain - quest furthered");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Piracy",46,oPC,TRUE);                      //Update the journal
    CreateObject(OBJECT_TYPE_CREATURE,"piratecleric",lLoc,FALSE,"SalvHelp");
    CreateObject(OBJECT_TYPE_CREATURE,"pirateleader",lLoc,FALSE,"SalvHelp");
    CreateObject(OBJECT_TYPE_CREATURE,"pirateleader",lLoc,FALSE,"SalvHelp");
    }

}

