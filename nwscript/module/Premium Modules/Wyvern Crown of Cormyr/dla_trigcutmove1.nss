//B W-Husey
//October 2005
// Move the PC to conversation for the arrest cutscene
#include "cu_cameras"
#include "cu_functions"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    //Get the participants
    object oEdgar = GetNearestObjectByTag("Edgar");
    object oFaril = GetNearestObjectByTag("LaheralsonCut1");
    object oSalvatori = GetNearestObjectByTag("SalvatoriCut1");
    //Get the scenary NPCs
    object oSoldier1 = GetNearestObjectByTag("PDBCutArrest1");
    object oSoldier2 = GetNearestObjectByTag("PDBCutArrest2");
    object oSoldier3 = GetNearestObjectByTag("WarWizardCutArrest1");
    //Set up the camera
    AssignCommand(oPC,SetCameraFacing(90.0));
    WCCameraStop(oPC);
    WCCameraMove(4.0, 90.0, 10.0, 50.0, 330.0, 5.0, 65.0, 4.0, 150.0, oPC, 1);
    //Disarm Edgar so he doesn't put a sword through his head when he salutes
    DelayCommand(1.0,AssignCommand(oEdgar,ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND))));
    //Move the protagonists
    AssignCommand(oPC,DelayCommand(5.0,ActionMoveToLocation(GetLocation(GetWaypointByTag("CP_Cut1")))));
    AssignCommand(oEdgar,DelayCommand(6.0,ActionMoveToLocation(GetLocation(GetWaypointByTag("CP_Cut2")))));
    AssignCommand(oPC,DelayCommand(10.0,ActionStartConversation(oFaril,"cut1",FALSE,FALSE)));

    AssignCommand(oFaril,DelayCommand(0.5,ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_LaheralsonCut1")))));
    AssignCommand(oSoldier1,DelayCommand(1.0,ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_PDBCutArrest1")))));
    AssignCommand(oSoldier2,DelayCommand(1.0,ActionMoveToLocation(GetLocation(GetWaypointByTag("WP_PDBCutArrest2")))));
    AssignCommand(oSoldier3,DelayCommand(1.0,ActionForceMoveToLocation(GetLocation(GetWaypointByTag("WP_WarWizardCutArrest1")),FALSE,8.0))); //Force - he talks.
    }
}
