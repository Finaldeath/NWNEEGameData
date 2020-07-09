// April 2004
// B W-Husey
// PC struck a deal with Salvatori. Update variable nPiracy to 5, journal & xp.

#include "cu_functions"
#include "cu_magicspecific"

void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "q5"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

   //Alignment consequences of action
    AligXP("AligXPs3q5", oPC, "EVIL", 150, 2);        //Shift/reward any alignment
    AligXP("AligXPs3q5b", oPC, "CHAOTIC", 50, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nPiracy",oPC,5);                                    //Just sets variable
    PartyGotEntry(sName,oPC,250,"XP Gain - quest furthered");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Piracy",40,oPC,TRUE);                      //Update the journal
    }
    ActionMoveToObject(GetWaypointByTag("WP_Salv3leave"));
    DelayCommand(3.0,ActionMoveAwayFromObject(oPC,TRUE,60.0));
    DestroyObject(OBJECT_SELF,20.0);
}


