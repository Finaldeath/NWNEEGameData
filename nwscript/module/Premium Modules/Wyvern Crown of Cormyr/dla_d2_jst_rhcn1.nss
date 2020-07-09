#include "dla_i0_joust"

int StartingConditional()
{
    if (!GetLocalInt(OBJECT_SELF, "bJoustRemarkChaotic"))
        return FALSE;

    if (!DLA_GetOutcome(OBJECT_SELF, DLA_OUTCOME_BREAKLANCE | DLA_OUTCOME_HELMKNOCKEDOFF))
        return FALSE;

    return (GetLocalInt(OBJECT_SELF, "nJoustRemarkIndex")==1);
}
