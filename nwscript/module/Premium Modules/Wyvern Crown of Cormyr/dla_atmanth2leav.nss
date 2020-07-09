//January 2006
// B W-Husey
// Get rid of Manthis2

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
    ActionMoveToObject(GetWaypointByTag("WP_PFASouth"));
    DelayCommand(3.0,ActionMoveAwayFromObject(oPC,FALSE,60.0));
    DestroyObject(OBJECT_SELF,10.0);
}
