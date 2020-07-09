#include"nw_i0_generic"
void main()
{
    //ActivateFleeToExit();
    object oHevesar=GetObjectByTag("db_hevesar_met");
    location lDespawn=GetLocation(GetWaypointByTag("wp_hevesar_despawn"));
    AssignCommand(oHevesar,ActionForceMoveToLocation(lDespawn,TRUE));
    //
}
