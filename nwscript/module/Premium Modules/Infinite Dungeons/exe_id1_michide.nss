#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"

void main()
{
    object oArea = GetLocalObject(OBJECT_SELF, "oArea");

    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        // hide the area from the player
        ExploreAreaForPlayer(oArea, oPC, FALSE);

        // cycle to next player
        oPC = GetNextPC();
    }

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}
