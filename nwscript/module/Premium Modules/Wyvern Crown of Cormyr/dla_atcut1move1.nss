// January 2006
// B W-Husey
// Bring Salvatori into the picture.

#include "cu_cameras"

void main()
{
    object oSalvatori = GetNearestObjectByTag("SalvatoriCut1");
    AssignCommand(oSalvatori,ActionMoveToLocation(GetLocation(GetWaypointByTag("CP_Cut3"))));
    WCCameraMove(1.0,330.0,6.0,65.0,0.0,5.0,80.0,5.0,80.0,GetPCSpeaker(),0);
}
