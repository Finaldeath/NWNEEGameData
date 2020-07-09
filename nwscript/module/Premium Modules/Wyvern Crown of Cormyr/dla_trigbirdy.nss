// January 2006
// B W-Husey
// Makes a bird to demonstrate the beams are lethal
#include "cu_functions"

#include "x0_i0_anims"
void main()
{
    object oPC = GetEnteringObject();
    location lLoc = GetLocation(GetWaypointByTag("WP_Birdy"));
    if (GetIsDefPC(oPC))
    {
    object oBirdy = CreateObject(OBJECT_TYPE_CREATURE,"birdy",lLoc,TRUE,"Birdy");
    AssignCommand(oBirdy,WalkWayPoints());
    DestroyObject(OBJECT_SELF);
    }
}
