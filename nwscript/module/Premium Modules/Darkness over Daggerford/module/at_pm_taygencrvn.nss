//This needs to be incorperated into the taygen dialogue
//so the placeables and caravan bandits spawn.
//place on the actions taken event of Taygen
//
//Author: Phil Mitchell (Baron of Gateford)
//
//No doubt to be adjusted by Damian :-)


void main()
{
 //Get the location of the caravan raider waypoints
 location lRaider1 = GetLocation(GetObjectByTag("pm_taygen_caravan1"));
 location lRaider2 = GetLocation(GetObjectByTag("pm_taygen_caravan2"));
 location lRaider3 = GetLocation(GetObjectByTag("pm_taygen_caravan3"));
 location lRaider4 = GetLocation(GetObjectByTag("pm_taygen_caravan4"));
 location lRaider5 = GetLocation(GetObjectByTag("pm_taygen_caravan5"));
 location lRaider6 = GetLocation(GetObjectByTag("pm_taygen_caravan6"));

 //get the location of the wagon/caravan waypoints
 location lWagon1 = GetLocation(GetObjectByTag("pm_taygen_wagon1"));
 location lWagon2 = GetLocation(GetObjectByTag("pm_taygen_wagon2"));

 //spawn the raiders at the raider waypoints
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider1);
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider2);
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider3);
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider4);
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider5);
 CreateObject(OBJECT_TYPE_CREATURE,"pm_raider_fgtr",lRaider6);

 //create the wagons at the caravan waypoints
 CreateObject(OBJECT_TYPE_PLACEABLE,"am_wagon1",lWagon1);
 CreateObject(OBJECT_TYPE_PLACEABLE,"am_wagon1",lWagon2);

 //set the variable so the areas where the encounters are will fire its heartbeat
 //so the plotflag can be set
 SetLocalInt(GetModule(),"pm_taygen_caravan",1);







}
