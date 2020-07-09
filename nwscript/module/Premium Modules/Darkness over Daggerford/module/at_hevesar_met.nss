#include"nw_i0_generic"
void main()
{
    //ActivateFleeToExit();
    object oHevesar=GetObjectByTag("db_hevesar_met");
    location lDespawn=GetLocation(GetWaypointByTag("wp_hevesar_despawn"));
    AssignCommand(oHevesar,ActionForceMoveToLocation(lDespawn,TRUE));
    //DelayCommand(1.5,DestroyObject(oHevesar));
    SetLocalInt(GetModule(),"help_hevesar",2);
    location lHevesar = GetLocation(GetWaypointByTag("wp_create_hevesar_2"));
    CreateObject(OBJECT_TYPE_CREATURE,"pm_hevesar",lHevesar,FALSE);
}
