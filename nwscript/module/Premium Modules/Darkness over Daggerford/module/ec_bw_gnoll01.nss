#include "NW_I0_GENERIC"

void main()
{
    string sTag = GetTag(OBJECT_SELF);
    if ((GetLocalInt(GetModule(), "nWH_OgresDispatched") == 1) &&
        ((sTag == "bw_gnoll01") || (sTag == "bw_gnoll02"))) // generic gnolls
    {
        ClearAllActions();
        ActionRandomWalk();
    }
    else WalkWayPoints();
}
