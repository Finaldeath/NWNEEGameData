#include "inc_id1_text"
#include "inc_id1_utility"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    if (nListType == 149)
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
        sString = AddLineBreak(sString);

        // respawn location
        nTemp = GetModuleFlag(ID1_FLAG_DEATH_PLAYER);
        if (nTemp == ID1_DEATH_PLAYER_PERMANENT)
        {
            sString += "Player death is permanent.";
        } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_INSTANT)
        {
            sString += "Players respawn where they died.";
        } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_AREA)
        {
            sString += "Players respawn at the entrance to the area in which they died.";
        } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_LEVEL)
        {
            sString += "Players respawn at the entrance to the level in which they died.";
        } else if (nTemp == ID1_DEATH_PLAYER_RESPAWN_DUNGEON)
        {
            sString += "Players will respawn in Little Timmy's warehouse.";
        }
        sString = AddLineBreak(sString);

        nTemp = GetModuleFlagValue(ID1_FLAG_PLAYER_RESPAWN_HEALTH);
        sString += "Players who respawn will be restored to " + IntToString(nTemp) + "% of their health.";
        sString = AddLineBreak(sString);

        if (GetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED) == ID1_ACTIVE)
        {
            sString += "Players who respawn will be rested.";
        } else
        {
            sString += "Players who respawn will not be rested.";
        }
        sString = AddLineBreak(sString);

        if (GetModuleFlag(ID1_FLAG_DEATH_PLAYER_HENCHMEN) == ID1_DEATH_PLAYER_HENCHMEN_DIE)
        {
            sString += "A player's henchmen will die when the player dies.";
        } else
        {
            sString += "A player's henchmen will not die when the player dies.";
        }

        SetCustomToken(5100, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
