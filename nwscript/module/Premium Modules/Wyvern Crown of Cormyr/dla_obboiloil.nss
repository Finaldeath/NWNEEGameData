// B W-Husey
// October 2005
// Boiling oil simulation.


#include "x0_i0_projtrap"

void main()
{
    location lLoc1 = GetLocation(GetWaypointByTag("Flame1"));
    location lLoc2 = GetLocation(GetWaypointByTag("Flame2"));
    location lLoc3 = GetLocation(GetWaypointByTag("Flame3"));
    CreateObject(OBJECT_TYPE_PLACEABLE,"bigflame",lLoc1);
    CreateObject(OBJECT_TYPE_PLACEABLE,"bigflame",lLoc2);
    CreateObject(OBJECT_TYPE_PLACEABLE,"bigflame",lLoc3);
    TriggerProjectileTrap(SPELL_FIREBALL, GetEnteringObject(),7);
    ExecuteScript ("dla_miscdraw",GetObjectByTag("PFDrawBridgeIn")); //close and lock the drawbridge
}

