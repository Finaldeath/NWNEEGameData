#include "NW_I0_GENERIC"
void main()
{
    object oTeygan = GetObjectByTag("db_teygan");
    location lDespawn=GetLocation(GetWaypointByTag("wp_teygan_despawn"));
    AssignCommand(oTeygan,ActionForceMoveToLocation(lDespawn,TRUE));
    //ActivateFleeToExit();
}
