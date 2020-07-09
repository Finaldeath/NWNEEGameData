//::///////////////////////////////////////////////
//:: Name Module PC Respawn Script
//:: FileName mrp_id_respawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Handles the effects of hittingthe respawn button.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Aug 25, 2005
//:://////////////////////////////////////////////
#include "inc_id_misctools"
#include "inc_id1_utility"
#include "inc_id1_flags"
#include "inc_id1_debug"


// Constants to be added
string RESPAWN_DOOR = "ptr_id1_door";

// ---------------------------- END TEMP -------------------------------------


void main()
{
    object oMod = GetModule();
    object oPC = GetLastRespawnButtonPresser();
    location lRespawn = GetLocation(oPC); // Defaulted for ID1_DEATH_PLAYER_RESPAWN_INSTANT
    int nPenalty = GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY);
    int nPenaltyValue = GetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY);
    DebugMessage("Respawn penalty is " + IntToString(nPenalty));
    int nRespawn = GetLocalInt(oMod, ID1_FLAG_DEATH_PLAYER);
    int nGold,nXP,nInven,nHD,nMin,iCurrentLevel;
    int bGold, bXP, bInven;
    string sTemp;
    object oDoor;
    effect eEffect;

    // Determine the penalties.
    switch (nPenalty)
    {
        case ID1_DEATH_RESPAWN_PENALTY_GOLD:
        {
            bGold = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE:
        {
            bXP = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_INVENTORY:
        {
            bInven = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_GOLD_EXPERIENCE:
        {
            bGold = TRUE;
            bXP = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_GOLD_INVENTORY:
        {
            bGold = TRUE;
            bInven = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE_INVENTORY:
        {
            bXP = TRUE;
            bInven = TRUE;
            break;
        }
        case ID1_DEATH_RESPAWN_PENALTY_ALL:
        {
            bGold = TRUE;
            bXP = TRUE;
            bInven = TRUE;
            break;
        }
    }
    DebugMessage("Respawn choices are gold = " + IntToString(bGold) + ", xp = " + IntToString(bXP) + ", items = " + IntToString(bInven));

    DebugMessage("PC has name " + GetName(oPC));

    // Apply the penalties.
    // Gold penalty
    if (bGold == TRUE)
    {
        nGold = FloatToInt((GetGold(oPC) * nPenaltyValue) / 100.0);
        DebugMessage("Should lose " + IntToString(nGold) + " gold.");
        AssignCommand(oPC, TakeGoldFromCreature(nGold, oPC, TRUE));
    }

    // XP Penalty
    if (bXP == TRUE)
    {
        // Calc XP penalty
        nXP = FloatToInt((GetXP(oPC) * nPenaltyValue) / 100.0);
        DebugMessage("Should lose " + IntToString(nXP) + " xp.");

        // Prevent level loss
        nHD = GetHitDice(oPC);
        nMin = ((nHD * (nHD - 1)) / 2) * 1000;
        DebugMessage("Min is " + IntToString(nMin) + " xp.");

        if (nXP < nMin)
        {
            nXP = nMin;
        }

        // Set the PC XP to reflect XP loss.
        SetXP(oPC, nXP);
    }

    //Inventory Penalty
    if (bInven == TRUE)
    {
        int nSlot;
        object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            if (d100() <= nPenaltyValue)
            {
                DestroyObject(oItem);
            }

            oItem = GetNextItemInInventory(oPC);
        }

        // Some folks might consider this rude. Might consider dropping.
        for (nSlot = 0; nSlot <= 14; nSlot++)
        {
            oItem = GetItemInSlot(nSlot, oPC);
            if (GetIsObjectValid(oItem))
            {
                if (d100() <= nPenaltyValue)
                {
                    DestroyObject(oItem);
                }
            }
        }
    }

    // Set the respawn location
    switch (nRespawn)
    {
        case ID1_DEATH_PLAYER_RESPAWN_AREA:
        {
            // Make sure to set this in ptr_id1_door.
            // Not set as of Aug 25.
            lRespawn = GetLocation(GetLocalObject(oPC,RESPAWN_DOOR));
            break;
        }
        case ID1_DEATH_PLAYER_RESPAWN_DUNGEON:
        {
            // Due to the headache this can cause in multiplayer this option will
            // default to ID1_DEATH_PLAYER_RESPAWN_LEVEL if a multiplayer game.
            if (GetNumberInParty(oPC, TRUE) == 1)
            {
                SetLocalInt(oMod, "nCurrentLevel", 0);
                lRespawn = GetStartingLocation();

                // search for plotgiver henchmen and remove
                int nHenchman = 1;
                object oHenchman = GetHenchman(oPC, nHenchman);
                while (oHenchman != OBJECT_INVALID)
                {
                    if (GetLocalString(oHenchman, "sConversation") == "id1_plotgiver")
                    {
                        // EDIT: return to original location?
                        DebugMessage("    Is a plot giver. Deleting.");
                        RemoveHenchman(oPC, oHenchman);
                        DestroyObject(oHenchman);
                    } else
                    {
                        nHenchman++;
                    }
                    oHenchman = GetHenchman(oPC, nHenchman);
                }
                break;
            }
        }
        case ID1_DEATH_PLAYER_RESPAWN_LEVEL:
        {
            // Update Oct. 25, 2005 - Grant
            // Find the stairs up for the level and move the respawning player
            // there.
            object oDungeon = GetCurrentDungeon();
            object oModule = GetModule();

            int nLevel = GetLocalInt(oModule, "nCurrentLevel");
            int nAreaNum = GetLocalInt(oDungeon, "nLevel" + IntToString(nLevel) + "StairsUp1");
            int nAreaID = GetLocalInt(oDungeon, "nArea" + IntToString(nAreaNum) + "Identifier");

            // DEBUG
            DebugMessage("mrp_id_respawn::main()");
            DebugMessage("^nLevel = " + IntToString(nLevel));
            DebugMessage("^nAreaNum = " + IntToString(nAreaNum));
            DebugMessage("^nAreaID = " + IntToString(nAreaID));

            object oArea = GetLocalObject(oModule, "oAreaIdentifier" + IntToString(nAreaID));
            object oStairs = GetLocalObject(oArea, "oStairsUp");

            lRespawn = GetLocation(oStairs);
        }
    }

    // Remove all effects from PC.
    eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oPC,eEffect);
        eEffect = GetNextEffect(oPC);
    }

    // Move the PC to the spawn location.
    if (nRespawn != ID1_DEATH_PLAYER_RESPAWN_INSTANT)
    {
        // EDIT: check to see if that area is active or not
        // EDIT: if not activate and have player heal and teleport afterwards

        DebugMessage("Clearing actions. Point 21.");
        AssignCommand(oPC,ClearAllActions(TRUE));
        AssignCommand(oPC,JumpToLocation(lRespawn));
    }

    // Resurrect the PC.
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);

    // Depending on certan module flags the player should respawn with some
    // or all of their hitpoints and/or rested.
    int nMaxHitpoints = GetMaxHitPoints(oPC);
    int nPercent = GetModuleFlagValue(ID1_FLAG_PLAYER_RESPAWN_HEALTH);
    DebugMessage("Max hitpoints are " + IntToString(nMaxHitpoints) + " and percent is " + IntToString(nPercent));
    int nHP = FloatToInt(nMaxHitpoints * (nPercent / 100.0)) - 1;
    DebugMessage("Should be healed to " + IntToString(nHP + 1));
    effect eRestore = EffectHeal(nHP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRestore, oPC);

    // When the revive rested flag is set players should revive from death
    // with full spells and daily abilities.
    int nFlag = GetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED);
    if (nFlag == ID1_ACTIVE)
    {
        ForceRest(oPC);
    }

    // March 29, 2006 - Grant.
    // If the player has used Antoine's totem reapply the speed boost.
    if (GetLocalInt(oPC, "bUsedAntoineTotem"))
    {
        effect eSpeed = EffectMovementSpeedIncrease(50);
        eSpeed = SupernaturalEffect(eSpeed);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oPC);
    }
}

