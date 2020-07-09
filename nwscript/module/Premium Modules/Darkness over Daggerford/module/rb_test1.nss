#include "rb_treasure_inc"

/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/

// Add the specified condition flag to the behavior state of the caller
void SetState(int nCondition, int bValid = TRUE);

// Returns TRUE if the specified behavior flag is set on the caller
int GetState(int nCondition);

void main()
{
    /*SetState(RB_WIZARD, TRUE);
    int i = GetState(RB_WIZARD);
    SendMessageToPC(GetFirstPC(), IntToString(i));

    i = GetState(RB_BARBARIAN);
    SendMessageToPC(GetFirstPC(), IntToString(i));  */

    GenerateLoot(GetFirstPC(), OBJECT_SELF);
}

/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// Add the specified condition flag to the behavior state of the caller
void SetState(int nCondition, int bValid = TRUE)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER", nPlot);
    }
}

// Returns TRUE if the specified behavior flag is set on the caller
int GetState(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_BEHAVIOR_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

