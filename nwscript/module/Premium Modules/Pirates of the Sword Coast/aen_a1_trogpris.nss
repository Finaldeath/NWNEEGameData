//::///////////////////////////////////////////////
//:: aen_a1_trogpris
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Update the troglodyte prison as the safe
    Spawn waypoint.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "inc_global"

void main()
{
    object oEnter = GetEnteringObject();

    cs_AreaOnEnter_Poly(oEnter);

    ExploreAreaForPlayer(OBJECT_SELF, oEnter);
    UpdateSafePoint();
}
