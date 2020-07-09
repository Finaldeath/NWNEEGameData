#include "inc_id1_utility"

void main()
{
    object oContainer = OBJECT_SELF;
    object oDungeon = GetCurrentDungeon();

    // Establish the dungeon variable identifier for the container.
    string sVariable = GetLocalString(oContainer, "sVariable");

    DebugMessage("Treasure chest with sVariable as " + sVariable + " was destroyed.");
    SetLocalInt(oDungeon, "b" + sVariable + "Dead", TRUE);
}
