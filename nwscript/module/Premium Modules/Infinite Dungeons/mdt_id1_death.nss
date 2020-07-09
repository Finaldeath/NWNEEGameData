#include "inc_id1_flags"
#include "inc_id1_score"

void main()
{
    // get dead player
    object oPC = GetLastPlayerDied();

    // record statistics
    IncrementDeathCounter(oPC);

    // determine if there is a respawn button
    int nFlag = GetModuleFlag(ID1_FLAG_DEATH_PLAYER);
    int bRespawn = TRUE;
    string sMessage = "You have died.";
    if (nFlag == ID1_DEATH_PLAYER_PERMANENT)
    {
        bRespawn = FALSE;
        sMessage += " Your death is permanent unless raised.";
    } else
    {
        if (nFlag == ID1_DEATH_PLAYER_RESPAWN_INSTANT)
        {
            sMessage += " You will respawn where you died.";
        } else if (nFlag == ID1_DEATH_PLAYER_RESPAWN_AREA)
        {
            sMessage += " You will respawn at the entrance to the current area.";
        } else if (nFlag == ID1_DEATH_PLAYER_RESPAWN_LEVEL)
        {
            sMessage += " You will respawn at the stairs to the current level.";
        } else if (nFlag == ID1_DEATH_PLAYER_RESPAWN_DUNGEON)
        {
            sMessage += " You will respawn in the Warehouse.";
        }

        // get display message based on flags
        nFlag = GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY);
        int nValue = GetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY);
        if ((nFlag == ID1_DEATH_RESPAWN_PENALTY_NONE) || (nValue <= 0))
        {
            sMessage += " There is no penalty for respawning.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_GOLD)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of your gold when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of your experience when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_INVENTORY)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of the items in your inventory when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_GOLD_EXPERIENCE)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of your gold and experience when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_GOLD_INVENTORY)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of the items in your inventory and your gold when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE_INVENTORY)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of the items in your inventory and your experience when you respawn.";
        } else if (nFlag == ID1_DEATH_RESPAWN_PENALTY_ALL)
        {
            sMessage += " You will lose " + IntToString(nValue) + "% of the items in your inventory, your gold and your experience when you respawn.";
        }
    }

    // display popup
    PopUpDeathGUIPanel(oPC, bRespawn, TRUE, 0, sMessage);
}

