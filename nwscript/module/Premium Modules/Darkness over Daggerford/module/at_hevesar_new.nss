#include"nw_i0_generic"
void main()
{
    //ActivateFleeToExit();
    object oHevesar=GetObjectByTag("db_hevesar_new");
    location lDespawn=GetLocation(GetWaypointByTag("wp_hevesar_despawn"));
    AssignCommand(oHevesar,ActionForceMoveToLocation(lDespawn,TRUE));
    //DelayCommand(1.5,DestroyObject(oHevesar));
    SetLocalInt(GetModule(),"help_hevesar",2);
    location lHevesar = GetLocation(GetWaypointByTag("wp_create_hevesar_2"));
    CreateObject(OBJECT_TYPE_CREATURE,"pm_hevesar",lHevesar,FALSE);
    //this line may need commenting back in - check during rewrite of Gaslo conv
    //SetLocalInt(GetModule(), "hevesar_quest", 4);
    location lGaslo = GetLocation(GetWaypointByTag("wp_creategaslo"));
    location lWife = GetLocation(GetWaypointByTag("wp_creategaslowife"));
    CreateObject(OBJECT_TYPE_CREATURE,"db_gaslo2",lGaslo);
    CreateObject(OBJECT_TYPE_CREATURE,"db_gasloswife",lWife);
}
