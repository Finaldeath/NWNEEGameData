#include "inc_id1_utility"

void main()
{
    // get the dungeon to be examined
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    int bFail = FALSE;

    DebugMessage("Skipping area validity check for now.");

    // go through entire area list
        // find an area that matches in all respects
        // if the boss area, search for it by string name

    SetLocalInt(OBJECT_SELF, "bImportFailed", bFail);
}
