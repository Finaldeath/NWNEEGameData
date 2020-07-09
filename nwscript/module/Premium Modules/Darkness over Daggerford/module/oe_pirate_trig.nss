void main()
{
    //this floor trigger handles pirate related spawns once the
    //missing farmers plot has been activated
    //it spawns two boats
    //and three pirates in the vicinity of the drop off cave

    object oPC = GetEnteringObject();
    location lVessel = GetLocation(GetWaypointByTag("wp_create_ship"));
    location lRow = GetLocation(GetWaypointByTag("wp_create_row"));
    location lBoss = GetLocation(GetWaypointByTag("wp_orcboss"));
    location lP1 = GetLocation(GetWaypointByTag("wp_pirate1"));
    location lP2 = GetLocation(GetWaypointByTag("wp_pirate2"));

    //check plot state
    if(GetIsPC(oPC) && GetLocalInt(GetModule(), "hevesar_plot") ==5)
    {
        //do it only once
        if(!GetLocalInt(OBJECT_SELF, "fired") ==1)
        {
            CreateObject(OBJECT_TYPE_PLACEABLE, "pirate_vessel", lVessel);
            CreateObject(OBJECT_TYPE_PLACEABLE, "tnorowboat", lRow);
            CreateObject(OBJECT_TYPE_CREATURE, "db_firstmate", lBoss);
            CreateObject(OBJECT_TYPE_CREATURE, "db_barracudarog", lP1);
            CreateObject(OBJECT_TYPE_CREATURE, "db_barracudacleric", lP2);
            SetLocalInt(OBJECT_SELF, "fired", 1);
        }
    }
}
