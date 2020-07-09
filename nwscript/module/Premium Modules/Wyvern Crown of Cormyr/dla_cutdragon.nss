// March 2006
// B W-Husey
// Cutscene handling the arrival of Wyvernvapor and his dialogue regarding the Witch Lords.
// This script gets the party in position where the next trigger fires cutscene4

#include "cu_functions"
#include "cu_cameras"
void main()
{
    object oPC = OBJECT_SELF;
    if (GetIsPC(oPC) && GetIsDM(oPC)==FALSE && GetIsDMPossessed(oPC) == FALSE)
    {
    SetCutsceneMode(oPC,TRUE);
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);


    location lLoc1 = GetLocation(GetWaypointByTag("WP_Cut4a"));
    location lLoc2 = GetLocation(GetWaypointByTag("WP_Cut4b"));
    location lLoc3 = GetLocation(GetWaypointByTag("WP_Cut4c"));

    AssignCommand(oPC,SetCameraFacing(0.0));
    AssignCommand(oPC,ActionForceMoveToLocation(lLoc1,TRUE,8.0));
    DelayCommand(1.0,AssignCommand(oHench1,ActionForceMoveToLocation(lLoc1,TRUE,8.0)));
    DelayCommand(1.5,AssignCommand(oHench2,ActionForceMoveToLocation(lLoc1,TRUE,8.0)));

    //WCCameraTrack(0.5,oPC,10.0,70.0,8.0,70.0,8.0,100.0,oPC);
    }
}

