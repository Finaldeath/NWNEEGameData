// January 2006
// B W-Husey
// PC wraps up Imelda's Revenge quest, taking Imelda to the Crown Office where Hurim arrests her.
// Jumps PC, destroys Imelda and makes a new one in the CO.
#include "cu_functions"
#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(GetWaypointByTag("TP_ImArrest2"));
    CreateObject(OBJECT_TYPE_CREATURE,"merchantimelda",lLoc,FALSE,"ImeldaEnd");
    SetCutsceneMode(oPC,TRUE);
    SetCameraFacing(70.0,7.0,60.0,CAMERA_TRANSITION_TYPE_MEDIUM);
    if (DLA_GetIsMounted(oPC))
        DLA_Dismount(oPC,FALSE);
    DLA_RemoveAllHenchmenHorses(oPC, GetObjectByTag("SpecialCrownHitch"));
    DelayCommand(0.1,AssignCommand(oPC,JumpToObject(GetWaypointByTag("TP_ImArrest"))));
    AssignCommand(GetObjectByTag("Hurim"),DelayCommand(1.5,ActionStartConversation(oPC,"thiodorarrest",FALSE,FALSE)));
    AssignCommand(OBJECT_SELF,SetIsDestroyable(TRUE,FALSE,FALSE));
    SetPlotFlag(OBJECT_SELF,FALSE);
    DestroyObject(OBJECT_SELF,3.0);
}
