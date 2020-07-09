// February 2006
// B W-Husey
// Get rid of the prisoner

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "SPFree";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    GiveXPToCreature (GetPCSpeaker(), 50);
    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    }
    ActionMoveToObject(GetWaypointByTag("WP_SatRunP"));
    DelayCommand(3.0,ActionMoveAwayFromObject(oPC,FALSE,60.0));
    DestroyObject(OBJECT_SELF,10.0);
}
