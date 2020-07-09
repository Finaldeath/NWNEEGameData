// February 2006
// B W-Husey
// Get rid of the gnome. Update journal

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "GnomeGo";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
        if (GetLocalInt(oPC,"nGnomeknow")==1 && GetLocalInt(oPC,"nRevenge")>0) AddJournalQuestEntry("Revenge",15,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,1,1,1,1,1,1,1,0,0,0);            //Who gets alignment points for this
    }

    ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_GExitPoint")));
    DelayCommand(4.0,ActionMoveAwayFromObject(oPC,FALSE,60.0));
    DestroyObject(OBJECT_SELF,12.0);
}
