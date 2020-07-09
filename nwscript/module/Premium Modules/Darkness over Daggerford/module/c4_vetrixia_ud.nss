#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void main()
{
    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        // need to be raisable for the altar
        SetIsDestroyable(TRUE, TRUE, TRUE);
    }
}
