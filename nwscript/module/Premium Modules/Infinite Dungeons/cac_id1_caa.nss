#include "inc_id1_flags"

void main()
{
    if (GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD) == ID1_ACTIVE)
    {
        SetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD, ID1_INACTIVE);
    } else
    {
        SetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD, ID1_ACTIVE);
    }
}
