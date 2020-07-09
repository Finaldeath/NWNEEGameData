#include "dla_i0_joust"

int StartingConditional()
{
    if (GetTag(OBJECT_SELF) != "Black_Knight")
        return FALSE;

    if (!DLA_GetOutcome(OBJECT_SELF, DLA_OUTCOME_INJURED))
        return FALSE;

    return (GetLocalInt(OBJECT_SELF, "nJoustRemarkIndex")==TRUE);
}
