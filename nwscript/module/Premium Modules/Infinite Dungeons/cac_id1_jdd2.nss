#include "inc_id1_flags"

void main()
{
    // get holder
    int nHolder = GetLocalInt(OBJECT_SELF, "nHolder");

    // EDIT: add offset when worked in

    if (nHolder == 1) // width
    {
        SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X, 2);
    } else if (nHolder == 2) // height
    {
        SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y, 2);
    } else if (nHolder == 3) // depth
    {
        SetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH, 2);
    }
}
