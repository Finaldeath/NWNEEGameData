//This needs to be incorperated into the taygen dialogue
//so the placeables and bandits spawn.
//place on the actions taken event of Taygen
//
//Author: Phil Mitchell (Baron of Gateford)
//
//No doubt to be adjusted by Damian :-)


void main()
{
    if(GetLocalInt(OBJECT_SELF, "iCreatedRaiders") == 0)
    {
         //Get the location of the raider waypoints
         location lRaider1 = GetLocation(GetObjectByTag("pm_taygen_raider1"));
         location lRaider2 = GetLocation(GetObjectByTag("pm_taygen_raider2"));
         location lRaider3 = GetLocation(GetObjectByTag("pm_taygen_raider3"));
         location lRaider4 = GetLocation(GetObjectByTag("pm_taygen_raider4"));
         location lRaider5 = GetLocation(GetObjectByTag("pm_taygen_raider5"));
         location lRaider6 = GetLocation(GetObjectByTag("pm_taygen_raider6"));

         //get the location of the tent waypoints
         location lTent1 = GetLocation(GetObjectByTag("pm_taygen_tent1"));
         location lTent2 = GetLocation(GetObjectByTag("pm_taygen_tent2"));
         location lTent3 = GetLocation(GetObjectByTag("pm_taygen_tent3"));
         location lTent4 = GetLocation(GetObjectByTag("pm_taygen_tent4"));

         //get the location of the campfire waypoints
         location lFire1 = GetLocation(GetObjectByTag("pm_taygen_fire1"));
         location lFire2 = GetLocation(GetObjectByTag("pm_taygen_fire2"));

         //spawn the raiders at the raider waypoints
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider1);
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider2);
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider3);
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider4);
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider5);
         CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider6);

         //create the tents at the tent waypoints
         CreateObject(OBJECT_TYPE_PLACEABLE,"x2_plc_tent_b",lTent1);
         CreateObject(OBJECT_TYPE_PLACEABLE,"x2_plc_tent_b",lTent2);
         CreateObject(OBJECT_TYPE_PLACEABLE,"x2_plc_tent_b",lTent3);
         CreateObject(OBJECT_TYPE_PLACEABLE,"x2_plc_tent_b",lTent4);

         //create campfire at the campfire waypoints
         CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",lFire1);
         CreateObject(OBJECT_TYPE_PLACEABLE,"plc_campfr",lFire2);

         //set the variable so the areas where the encounters are will fire its heartbeat
         //so the plotflag can be set
         SetLocalInt(GetModule(),"pm_taygen_bandits",1);
         SetLocalInt(OBJECT_SELF, "iCreatedRaiders", 1);
    }
}
