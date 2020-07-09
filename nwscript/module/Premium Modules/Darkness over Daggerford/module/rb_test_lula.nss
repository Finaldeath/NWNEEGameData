void main()
{
    location lLula1=GetLocation(GetWaypointByTag("wp_create_lula"));

     SetLocalInt(GetModule(),"lula_met", 3);
     SetLocalInt(GetModule(),"ar1308_lula",1);

     CreateObject(OBJECT_TYPE_CREATURE,"db_lula",lLula1,FALSE);

}
