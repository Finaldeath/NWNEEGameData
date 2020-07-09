#include "dla_i0_joust"

int StartingConditional()
{
    if (!DLA_GetOutcome(GetPCSpeaker(), DLA_OUTCOME_GLANCEOFF))
        return FALSE;

    if (GetLocalInt(OBJECT_SELF, "bJoustRemarkChaotic")) return FALSE;

    return (GetLocalInt(OBJECT_SELF, "nJoustRemarkIndex")==4);
}
