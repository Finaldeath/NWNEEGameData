#include "dla_i0_joust"

int StartingConditional()
{
    if (GetTag(OBJECT_SELF) != "Black_Knight")
        return FALSE;

    if (!DLA_GetOutcome(GetPCSpeaker(), DLA_OUTCOME_MISS))
        return FALSE;

    return (GetLocalInt(OBJECT_SELF, "nJoustRemarkIndex")==TRUE);
}
