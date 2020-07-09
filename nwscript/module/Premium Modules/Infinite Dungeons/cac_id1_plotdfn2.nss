#include "inc_id1_score"
#include "inc_id1_utility"

void main()
{
    // if quest is not activated
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    object oDungeon = GetCurrentDungeon();

    // EDIT: find plotgiver and destroy if a henchman

    // destroy self
    object oSelf = OBJECT_SELF;
    DestroyObject(oSelf);
}
