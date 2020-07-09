#include "inc_id1_utility"
#include "inc_id_liltimmy"

int StartingConditional()
{
    if (GetTag(OBJECT_SELF) == "DungeonEntranceStairs")
    {
        // check to see if the permanent flag has been set
        if (GetLocalInt(GetModule(), "bLevelsSelectedPermanently") == FALSE)
        {
            // check to see if any player is under level 5
            object oPC = GetFirstPC();
            int bUnderFive = FALSE;
            int nXP;
            while ((oPC != OBJECT_INVALID) && (bUnderFive == FALSE))
            {
                nXP = GetXP(oPC);
                if (nXP < 10000)
                {
                    bUnderFive = TRUE;
                } else
                {
                    oPC = GetNextPC();
                }
            }

            if (bUnderFive == TRUE)
            {
                return TRUE;
            } else
            {
                return FALSE;
            }
        } else
        {
            return FALSE;
        }
    } else
    {
        return FALSE;
    }
}
