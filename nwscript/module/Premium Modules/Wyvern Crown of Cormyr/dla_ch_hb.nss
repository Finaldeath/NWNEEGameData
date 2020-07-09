#include "dla_inc_ride"

void main()
{
    if (DLA_GetIsMounted(OBJECT_SELF))
        DLA_DoRideChecks(OBJECT_SELF);

    ExecuteScript("nw_ch_ac1", OBJECT_SELF);

}
