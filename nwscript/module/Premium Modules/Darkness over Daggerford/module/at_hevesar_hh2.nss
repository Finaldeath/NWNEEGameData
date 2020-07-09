#include"nw_i0_generic"
void main()
{
    //ActivateFleeToExit();
    object oHevesar=GetNearestObjectByTag("pm_hevesar");
    DestroyObject(oHevesar,0.2);
    SetLocalInt(GetModule(),"help_hevesar",2);
    location lHevesar = GetLocation(GetWaypointByTag("wp_create_hevesar_2"));
    CreateObject(OBJECT_TYPE_CREATURE,"pm_hevesar",lHevesar,FALSE);
}
