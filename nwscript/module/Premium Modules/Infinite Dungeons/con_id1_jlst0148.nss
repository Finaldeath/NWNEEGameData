#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 148)
    {
        string sString = "";
        int nTemp;

        // plot frequency
        if (GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY) == ID1_DEATH_RESPAWN_PENALTY_NONE)
        {
            sString += "There is no penalty for respawning.";
        } else
        {
            nTemp = GetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY);
            sString += "Players will lose " + IntToString(nTemp) + "% of their ";

            int bGold;
            int bExperience;
            int bItem;

            nTemp = GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY);
            if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD)
            {
                bGold = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE)
            {
                bExperience = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_INVENTORY)
            {
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD_EXPERIENCE)
            {
                bGold = TRUE;
                bExperience = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD_INVENTORY)
            {
                bGold = TRUE;
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE_INVENTORY)
            {
                bExperience = TRUE;
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_ALL)
            {
                bGold = TRUE;
                bExperience = TRUE;
                bItem = TRUE;
            }

            if (bGold == TRUE)
            {
                sString += "gold";
                if ((bExperience == TRUE) && (bItem == TRUE))
                {
                    sString += ", ";
                } else if ((bExperience == TRUE) || (bItem == TRUE))
                {
                    sString += " and ";
                }
            }

            if (bExperience == TRUE)
            {
                sString += "experience";
                if (bItem == TRUE)
                {
                    sString += " and ";
                }
            }

            if (bItem == TRUE)
            {
                sString += "items";
            }
            sString += ".";
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
