#include "dla_i0_joust"

int StartingConditional()
{
    if (!GetLocalInt(OBJECT_SELF, "bJoustRemarkEvil"))
        return FALSE;

    if (!DLA_GetOutcome(OBJECT_SELF, DLA_OUTCOME_MISS))
        return FALSE;

    return (GetLocalInt(OBJECT_SELF, "nJoustRemarkIndex")==2);
}
