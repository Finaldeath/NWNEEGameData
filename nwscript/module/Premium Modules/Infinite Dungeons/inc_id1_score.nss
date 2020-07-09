//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_score
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Score Keeping functions and constants. Each player has a total score based
    on number of cretures killed, loot acquried, levels gained, areas explored,
    and puzzles solved while in the dungeon. The function below track these
    various activities and keep a running tally of total points on the dungeon
    object.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_flags"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    VARIABLE NAME CONSTANTS
------------------------------------------------------------------------------*/



const string MODULE_LEVEL = "nCurrentLevel";
const string AREA_IDENTIFIER = "nAreaIdentifier";
const string CREATURE_VARIABLE_NAME = "sVariable";

const string CREATURE_BOSS_FLAG = "bBoss";
const string CREATURE_MINIBOSS_FLAG = "bMiniBoss";

const string POINTS = "nStatisticsPoints_";
const string DEATHS = "nStatisticsDeaths_";
const string CREATURES_KILLED = "nStatisticsCreaturesKilled_";
const string LEVELS_GAINED = "nStatisticsLevelsGained_";
const string PUZZLES_SOLVED = "nStatisticsPuzzlesSolved_";
const string AREAS_DISCOVERED = "nStatisticsAreasDiscovered_";
const string DEPTH_ACHIEVED = "nStatisticsMaxDepth_";
const string SECRETS_DISCOVERED = "nStatisticsSecretsDiscovered_";
const string LOCKS_PICKED = "nStatisticsLockPicked_";
const string TRAPS_DISARMED = "nStatisticsTrapsDisarmed_";
const string PLOTS_COMPLETED = "nStatisticsPlotsCompleted_";
const string BOSSES_DEFEATED = "nStatisticsBossesDefeated_";
const string MINIBOSSES_DEFEATED = "nStatisticsMiniBossesDefeated_";



/*------------------------------------------------------------------------------
    MULTIPLIER/AWARD CONSTANTS
------------------------------------------------------------------------------*/


const int AREA_MULTIPLIER = 10;
const int LEVEL_MULTIPLIER = 20;
const int CREATURE_MULTIPLIER = 5;
const int PUZZLE_MULTIPLIER = 15;
const int TREASURE_MULTIPLIER = 7;
const int SECRET_MULTIPLIER = 10;
const int LOCK_MULTIPLIER = 10;
const int TRAP_MULTIPLIER = 10;
const int PLOT_MULTIPLIER = 15;
const int ASSEMBLE_MULTIPLIER = 15;

const int PUZZLE_AWARD_LOW = 1;
const int PUZZLE_AWARD_MED = 2;
const int PUZZLE_AWARD_HGH = 3;

const int TREASURE_AWARD_LOW = 1;
const int TREASURE_AWARD_MED = 2;
const int TREASURE_AWARD_HGH = 3;

const int PLOT_AWARD_LOW = 1;
const int PLOT_AWARD_MED = 2;
const int PLOT_AWARD_HGH = 3;




/*------------------------------------------------------------------------------
    FUNCTION_PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Get PC Identifier
//
// Defined in: inc_id1_score
//
// Establishes a unique identifier for oPC using public CD key and player name
// then returns the identifier as a string.
//
// Parameters:
// oPC - The player whose unique identifier is being established and retreived.
//
// Return:
// NONE

// Name: Award Points
//
// Defined in: inc_id1_score
//
// Awards nPoints to the player with identifier sPCIdentifier. These points
// are recorded on the dungeon object for later retreival. This function is
// mostly for internal system use.
//
// Parameters:
// oDungeon - The dungeon object, on which scores will be recorded.
// sPCIdentifier - A unique identifier for the player character. Consists of a
//                 combination of the player's public CD key and their character
//                 name.
// nPoints - The number of points to be awarded.
//
// Return:
// NONE
void AwardPoints(object oDungeon, string sPCIdentifier, int nPoints, object oPC);

// Name: Display Player Feedback
//
// Defined in: inc_id1_score
//
// Displays some information to the player whenever points are rewarded based
// on module flags. If the corresponding flags are TRUE the player will be
// notified of the number of times they have accomplished the task, the point
// award they are recieving for accomplishing it and their total points.
//
// Parameters:
// oPC - The player who is being rewarded.
// sReward - A string describing the feat that was accomplished.
// sCounter - A string describing the count that is being tallied.
// nPoints - The number of points the player is being awarded for the feat.
// nCounter - The total number of times the player has accomplished this feat.
//
// Return:
//
void DisplayPlayerFeedback(object oPC, string sReward, string sCounter, int nPoints, int nCounter = 0);

// Name: Award Creature Killed Points
//
// Defined in: inc_id1_score
//
// Awards points to oPC for killing oKilled. The point total is based on the
// challenge rating of oKilled with respect to oPC's level. Should be called
// from a creatures On Death event.
//
// Parameters:
// oPC - The player doing the killing and receiving the points.
// oKilled - The creature that was killed.
//
// Return:
// NONE
void AwardCreatureKilledPoints(object oPC, object oKilled = OBJECT_SELF);

// Name: Award Level Up Points
//
// Defined in: inc_id1_score
//
// Awards points to oPC at level up. The total award is the player's level
// multiplied by a constant. This funciton should be called from the module's
// On Player Level Up event.
//
// Update - Oct 6, 2005: No longer awards any points for level up, now this
// function simply tracks the number of levels a player has gained in a given
// dungeon.
//
// Parameters:
// oPC - The player doing the level up.
//
// Return:
// NONE
void AwardLevelUpPoints(object oPC);

// Name: Award Area Discovered Points
//
// Defined in: inc_id1_score
//
// Awards points to oPC when a new area is discovered. This award should only be
// alloted the first time a player enters an area. Should be called from the
// area transition trigger script, before the area is flagged as having been
// visited.
//
// Parameters:
// oPC - The player enetering/disovering the area.
//
// Return:
// NONE
void AwardAreaDiscoveredPoints(object oPC);

// Name: Award Puzzle Solved Points
//
// Defined in: inc_id1_score
//
// Awards points to oPC for solving a puzzle based on the puzzle's difficulty.
// Should be called from Area event 5000 (fired when a puzzle is solved).
//
// *** NOTE: This may require the player solving a puzzle to be stored on the
//           puzzle WP and retreived by the area event or, with change of
//           parameter, by this function.
//
// Parameters:
// oPC - The player that solved the puzzle.
// nDifficulty - The difficulty of the puzzle expressed as one of the constants:
//               PUZZLE_AWARD_LOW, PUZZLE_AWARD_MEDIIUM, or PUZZLE_AWARD_HIGH
//
// Return:
// NONE
void AwardPuzzleSolvedPoints(object oPC, int nDifficulty = PUZZLE_AWARD_LOW);

// Name: Award Treasure Points
//
// Defined in: inc_id1_score
//
// Awards points to oPC for retreiving treasure. Reward is based on the number
// of gold pieces retrieved compared to the 'average' for the character's level.
//
// Parameters:
// oPC - The player to first discover the treasure.
// nGold - The number fof gold pieces acquired.
//
// Return:
// NONE
void AwardTreasurePoints(object oPC, int nGold);

// Name: Award Secret Discovered Points
//
// Defined in: inc_id1_score
//
// Awards point to oPC for discovering a secret area. The difficulty class of
// the search check required to find the area is used with a multiplier to
// determine the points awarded for finding the area. To be called when the
// secret is discovered, in the script which determines the success of the
// search check.
//
// Parameters:
// oPC - The player to first discover the secret area.
// nSearchDC - The difficulty of the Search check involved in finding the
//             secret location.
//
// Return:
// NONE
void AwardSecretDiscoveredPoints(object oPC, int nSearchDC);

// Name: Award Lock Picked Points
//
// Defined in: inc_id1_score
//
// Awards point to oPC for picking a lock. The difficulty class of
// the lockpick check required to pick the lock is used with a multiplier to
// determine the points awarded.
//
// Parameters:
// oPC - The player picking the lock.
// nDC - The difficulty of the lockpicking check involved in opening the lock.
//
// Return:
// NONE
void AwardLockPickedPoints(object oPC, int nDC);

// Name: Award Trap Disarmed Points
//
// Defined in: inc_id1_score
//
// Awards point to oPC for disarming a trap. The difficulty class of
// the disarm traps check required to disarm the trap is used with a multiplier
// to determine the points awarded.
//
// Parameters:
// oPC - The player disarming the trap.
// nDC - The difficulty of the disarm traps check involved in disarming the trap
//
// Return:
// NONE
void AwardTrapDisarmedPoints(object oPC, int nDC);

// Name: Award Plot Completed Points
//
// Defined in: inc_id1_score
//
// Awards points to players for completing a plot. The difficulty of the plot,
// represented as a constant, is used along with a plot multiplier to determine
// the total reward. Should be called from the script which updates the player's
// Journal to a finished state, awards XPs etc.
//
// Parameters:
// nPlotDifficulty - The difficulty of the plot, represented as an award constant.
//
// Return:
// NONE
void AwardPlotCompletedPoints(int nPlotDifficulty = PLOT_AWARD_LOW);

// Name: Award Collectables Assembled Points
//
// Defined in: inc_id1_score
//
// Awards oPC points for assembling one of the collectable artifacts.
//
// Parameters:
// oPC - The player who is to be awarded points for assembling the collectable.
// nPieces - The number of pieces required to construct the collectable.
//
// Return:
// NONE
// void AwardCollectablesAssembledPoints(object oPC, int nPieces);

// Name: Increment Death Counter
//
// Defined in: inc_id1_score
//
// Increments the counter tracking the number of times the player has died in
// the dungeon.
//
// Parameters:
// oPC - The player that has just died.
//
// Return:
// NONE
void IncrementDeathCounter(object oPC);

// Name: Get Total Points
//
// Defined in: inc_id1_score
//
// Returns a counter total with respect to oPC in regards to sTotalType.
//
// Parameters:
// oPC - The player whose coutner is to be checked.
// sTotalType - The counter in question, one of the string constants such as
//              POINTS, CREATURES_KILLED, et cetera.
//
// Return:
// The player's total, based on sTotalType, or -1 on error.
int GetTotal(object oPC, string sTotalType);



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: GetPCIdentifier
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 6, 2005
//::////////////////////////////////////////////////////////////////////////////

//::////////////////////////////////////////////////////////////////////////////
//:: AwardPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardPoints(object oDungeon, string sPCIdentifier, int nPoints, object oPC)
{
    if (nPoints < 0) nPoints = 0;

    // Get the player's current total.
    int nCurrentPoints = GetLocalInt(oDungeon, POINTS + sPCIdentifier);

    nCurrentPoints += nPoints;

    // Check the point total for the upper limit.
    if (nCurrentPoints > 2100000000)
    {
        // A token reward for reaching the upper limit might go here.
        nCurrentPoints = 2100000000;
    }

    // DEBUG: Send the first PC the player's point total/cd key.
    DebugMessage(sPCIdentifier + " point total: " + IntToString(nCurrentPoints));

    // Store the new total.
    SetLocalInt(oDungeon, POINTS + sPCIdentifier, nCurrentPoints);

    // check to see if this fits in the top 10
    int nList = 1;
    int nListValue;
    int nPlace = 0;
    int nPosition = 10;
    string sIdentifier;

    while (nList <= 10)
    {
        nListValue = GetCampaignInt("id_highscore", "nHighScore" + IntToString(nList) + "Score",oDungeon);
        sIdentifier = GetCampaignString("id_highscore", "sHighScore" + IntToString(nList) + "PCIdentifier",oDungeon);
        DebugMessage("Comparing nHighScore" + IntToString(nList) + "Score at " + IntToString(nListValue) + " to " + IntToString(nCurrentPoints));

        if ((nCurrentPoints > nListValue) && (nPlace == 0))
        {
            DebugMessage("  Set place.");
            nPlace = nList;
        }

        if (sIdentifier == sPCIdentifier)
        {
            DebugMessage("  Set position.");
            nPosition = nList;

            if ((nCurrentPoints == nListValue) && (nPlace == 0))
            {
                nPlace = nList;
            }
        }

        nList++;
    }

    // if this score deserves a place on the top 10
    if (nPlace > 0)
    {
        // if player is in the same position
        if (nPlace == nPosition)
        {
            SetCampaignInt("id_highscore", "nHighScore" + IntToString(nPlace) + "Score", nCurrentPoints,oDungeon);
        }
        else // if the position is somewhere else
        {
            // start at new position
            // go from new position up to below old bumping scores up
            // replace score at new position
            string sOldIdentifier;
            string sOldPlayer;
            int nOldScore;

            int nCurrentPlace = nPosition - 1;

            while (nCurrentPlace >= nPlace)
            {
                DebugMessage("Setting score place " + IntToString(nCurrentPlace) + " to " + IntToString(nCurrentPlace + 1));

                sOldIdentifier = GetCampaignString("id_highscore", "sHighScore" + IntToString(nCurrentPlace) + "PCIdentifier",oDungeon);
                sOldPlayer = GetCampaignString("id_highscore", "sHighScore" + IntToString(nCurrentPlace) + "PCName",oDungeon);
                nOldScore = GetCampaignInt("id_highscore", "nHighScore" + IntToString(nCurrentPlace) + "Score",oDungeon);

                SetCampaignString("id_highscore", "sHighScore" + IntToString(nCurrentPlace + 1) + "PCIdentifier", sOldIdentifier,oDungeon);
                SetCampaignString("id_highscore", "sHighScore" + IntToString(nCurrentPlace + 1) + "PCName", sOldPlayer,oDungeon);
                SetCampaignInt("id_highscore", "nHighScore" + IntToString(nCurrentPlace + 1) + "Score", nOldScore,oDungeon);

                nCurrentPlace--;
            }

            SetCampaignString("id_highscore", "sHighScore" + IntToString(nPlace) + "PCIdentifier", sPCIdentifier,oDungeon);
            SetCampaignString("id_highscore", "sHighScore" + IntToString(nPlace) + "PCName", GetName(oPC),oDungeon);
            SetCampaignInt("id_highscore", "nHighScore" + IntToString(nPlace) + "Score", nCurrentPoints,oDungeon);

            DebugMessage("Setting nHighScore" + IntToString(nPlace) + "Score to " + IntToString(nCurrentPoints));
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: DisplayPlayerFeedback
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 24, 2005
//::////////////////////////////////////////////////////////////////////////////
void DisplayPlayerFeedback(object oPC, string sReward, string sCounter, int nPoints, int nCounter = 0)
{
    DebugMessage("DisplayPlayerFeedback");
    DebugMessage("  sReward is " + sReward);
    DebugMessage("  sCounter is " + sCounter);
    DebugMessage("  nPoints is " + IntToString(nPoints));
    DebugMessage("  nCounter is " + IntToString(nCounter));

    // Counter display.
    if (GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_COUNTER) == ID1_ACTIVE)
    {
        if (nCounter != 0)
        {
            SendMessageToPC(oPC, sCounter + ": " + IntToString(nCounter));
        }
    }

    // Point award feedback.
    if (GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD) == ID1_ACTIVE)
    {
        if (nPoints > 0)
        {
            SendMessageToPC(oPC, "(" + sReward + ") Point Award: "
                + IntToString(nPoints));
        }
    }

    // Point total feedback.
    if (GetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_TOTAL) == ID1_ACTIVE)
    {
        SendMessageToPC(oPC, "Point Total: "
            + IntToString(GetTotal(oPC, POINTS)));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardCreatureKilledPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardCreatureKilledPoints(object oPC, object oKilled = OBJECT_SELF)
{
    // If the creature is a non pc award their master if they have one.
    if (!GetIsPC(oPC))
    {
        oPC = GetMaster(oPC);

        if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
        {
            return;
        }
    }

    // Update the player's number of creatures killed.
    string sPCIdentifier = GetPCIdentifier(oPC);
    object oDungeon = GetCurrentDungeon();

    string sCounter;
    int nCounter;

    // If the creature is flagged as a boss count a boss kill.
    if (GetLocalInt(oKilled, CREATURE_BOSS_FLAG))
    {
        int nBosses = GetLocalInt(oDungeon, BOSSES_DEFEATED + sPCIdentifier);

        nBosses++;

        SetLocalInt(oDungeon, BOSSES_DEFEATED + sPCIdentifier, nBosses);

        sCounter = "Bosses Defeated";
        nCounter = nBosses;
    }
    else if (GetLocalInt(oKilled, CREATURE_MINIBOSS_FLAG)) // Mini-boss flagged.
    {
        int nMiniBosses = GetLocalInt(oDungeon, MINIBOSSES_DEFEATED + sPCIdentifier);

        nMiniBosses++;

        SetLocalInt(oDungeon, MINIBOSSES_DEFEATED + sPCIdentifier, nMiniBosses);

        sCounter = "Mini Bosses Defeated";
        nCounter = nMiniBosses;
    }
    else // Normal creature kill.
    {
        int nKills = GetLocalInt(oDungeon, CREATURES_KILLED + sPCIdentifier);

        nKills++;

        SetLocalInt(oDungeon, CREATURES_KILLED + sPCIdentifier, nKills);

        sCounter = "Creatures Killed";
        nCounter = nKills;
    }

    // Determine the challenge rating of the monster that was killed.
    string sVar = GetLocalString(oKilled, CREATURE_VARIABLE_NAME);
    int nChallenge = GetLocalInt(oDungeon, "n" + sVar + "CR") + 5;
    // CR + 5: Characters gain points for killing any creature within 5 levels.

    // Points are a multiple of challenge rating - player level.
    int nLevels = GetHitDice(oPC);
    int nDiffRatio = nChallenge - nLevels;

    // DEBUG
    DebugMessage("inc_id1_score::AwardCreatureKilledPoints()");
    DebugMessage("^Character Level = " + IntToString(nLevels));
    DebugMessage("^Monster CR = " + IntToString(nChallenge - 5));
    DebugMessage("^Difficulty Ratio = " + IntToString(nDiffRatio));

    // If the ratio is less than zero don't remove points.
    if (nDiffRatio < 0) nDiffRatio = 0;

    int nPoints = (nDiffRatio * CREATURE_MULTIPLIER); // + nChallenge;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // Point award feedback.
    DisplayPlayerFeedback(oPC, "Creature Killed", sCounter, nPoints, nCounter);
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardLevelUpPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardLevelUpPoints(object oPC)
{
    string sPCIdentifier = GetPCIdentifier(oPC);
    object oDungeon = GetCurrentDungeon();

    /*
    // Determine the player's total levels and award X points per level.
    int nLevels = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC)
        + GetLevelByPosition(3, oPC);
    int nPoints = nLevels * LEVEL_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints);
    */

    int nLevels = GetLocalInt(oDungeon, LEVELS_GAINED + sPCIdentifier);

    nLevels++;

    DebugMessage("inc_id1_score::AwarLevelUpPoints() nLevels = "
        + IntToString(nLevels));

    SetLocalInt(oDungeon, LEVELS_GAINED + sPCIdentifier, nLevels);
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardAreaDiscoveredPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardAreaDiscoveredPoints(object oPC)
{
    // First ensure the player has not already been awarded points for this area
    object oArea = GetArea(oPC);
    object oModule = GetModule();
    object oDungeon = GetCurrentDungeon();

    string sPCIdentifier = GetPCIdentifier(oPC);
    DebugMessage("Player identifier is " + sPCIdentifier);

    // If this is the greatest depth acheived update the tracker.
    int nLevel = GetLocalInt(oModule, MODULE_LEVEL);
    int nMax = GetLocalInt(oDungeon, DEPTH_ACHIEVED + sPCIdentifier);

    if (nLevel > nMax)
    {
        object oTempPC = GetFirstPC();
        string sTempIdentifier = GetPCIdentifier(oTempPC);

        // The tracker should be updated for each character in the party.
        while (GetIsObjectValid(oTempPC))
        {
            SetLocalInt(oDungeon, DEPTH_ACHIEVED + sTempIdentifier, nLevel);
            oTempPC = GetNextPC();
            sTempIdentifier = GetPCIdentifier(oTempPC);
        }
    }

    int nAreaIdentifier = GetLocalInt(oArea, AREA_IDENTIFIER);
    int nAreaNum = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaIdentifier) + "Area");
//    int bExplored = GetLocalInt(oDungeon, "bPlayer_" + sPCIdentifier + "_Area" + IntToString(nAreaNum)
//        + "Level" + IntToString(nLevel) + "Explored");

//    if (bExplored)
//    {
//        return; // Point have already been awarded for this area.
//    }

    // Update the player's # of areas discovered variable.
    int nAreas = GetLocalInt(oDungeon, AREAS_DISCOVERED + sPCIdentifier);

    nAreas++;

    SetLocalInt(oDungeon, AREAS_DISCOVERED + sPCIdentifier, nAreas);

    // Award the player points.
    // Point award is X points per area discovered.
    int nPoints = AREA_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // PLAYER FEEDBACK
    DisplayPlayerFeedback(oPC, "Area Discovered", "Areas Discovered", nPoints, nAreas);

    // DEBUG
    DebugMessage("inc_id1_score::AwardAreaDiscoveredPoints()");
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardPuzzleSolvedPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 29, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardPuzzleSolvedPoints(object oPC, int nDifficulty = PUZZLE_AWARD_LOW)
{
    // If the creature is a non pc award their master if they have one.
    if (!GetIsPC(oPC))
    {
        oPC = GetMaster(oPC);

        if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
        {
            return;
        }
    }

    // Update the number of puzzles solved.
    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    int nSolved = GetLocalInt(oDungeon, PUZZLES_SOLVED + sPCIdentifier);

    nSolved++;

    SetLocalInt(oDungeon, PUZZLES_SOLVED + sPCIdentifier, nSolved);

    // Determine puzzle difficulty from the module flag.
    int nDiff = GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY);
    int nDiffMult;

    switch (nDiff)
    {
        case ID1_PUZZLE_DIFFICULTY_EASY:
        {
            nDiffMult = PUZZLE_AWARD_LOW;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_NORMAL:
        {
            nDiffMult = PUZZLE_AWARD_MED;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_HARD:
        {
            nDiffMult = PUZZLE_AWARD_HGH;
            break;
        }
    }


    // Point award is puzzle difficulty mulitplied by X, a constant.
    int nPoints = nDiffMult * PUZZLE_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // PLAYER FEEDBACK
    DisplayPlayerFeedback(oPC, "Puzzle Solved", "Puzzles Solved", nPoints, nSolved);

    // DEBUG
    DebugMessage("inc_id1_score::AwardAreaPuzzleSolvedPoints()");
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardTreasurePoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 30, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardTreasurePoints(object oPC, int nGold)
{
    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    int nLevel = GetHitDice(oPC);
    int nRange = (nLevel * nLevel) * 100;
    int nBase = 20;
    int nPoints = ((nGold - nRange) / nRange) * nBase;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // PLAYER FEEDBACK
    DisplayPlayerFeedback(oPC, "Gold Acquired", "", nPoints);

    // DEBUG
    DebugMessage("inc_id1_score::AwardTreasurePoints()");
    DebugMessage("^nLevel = " + IntToString(nLevel));
    DebugMessage("^nRange = " + IntToString(nRange));
    DebugMessage("^nPoints = " + IntToString(nPoints));
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardSecretDiscoveredPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Aug 31, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardSecretDiscoveredPoints(object oPC, int nSearchDC)
{
    // If the creature is a non pc award their master if they have one.
    if (!GetIsPC(oPC))
    {
        oPC = GetMaster(oPC);

        if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
        {
            return;
        }
    }

    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // Update the player's # of secrets discovered.
    int nSecrets = GetLocalInt(oDungeon, SECRETS_DISCOVERED + sPCIdentifier);

    nSecrets++;

    SetLocalInt(oDungeon, SECRETS_DISCOVERED + sPCIdentifier, nSecrets);

    // Award is constant times the search DC compared to player level.
    int nLevel = GetHitDice(oPC);
    int nMulti = (nSearchDC + 5) - (20 + (nLevel/2));
    if (nMulti < 1) nMulti = 1; // Avoid multipliers less than positive one.
    int nPoints = nMulti * SECRET_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // PLAYER FEEDBACK
    DisplayPlayerFeedback(oPC, "Secret Discovered", "Secrets Discovered",
        nPoints, nSecrets);

    // DEBUG
    DebugMessage("inc_id1_score::AwardSecretDiscoveredPoints()");
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardAwardLockPickedPointsPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 8, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardLockPickedPoints(object oPC, int nDC)
{
    // If the creature is a non pc award their master if they have one.
    if (!GetIsPC(oPC))
    {
        oPC = GetMaster(oPC);

        if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
        {
            return;
        }
    }

    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // Update the player's # of secrets discovered.
    int nLocks = GetLocalInt(oDungeon, LOCKS_PICKED + sPCIdentifier);

    nLocks++;

    SetLocalInt(oDungeon, LOCKS_PICKED + sPCIdentifier, nLocks);

    // Award is constant times the lock DC compared to player level.
    int nLevel = GetHitDice(oPC);
    int nMulti = (nDC + 5) - (20 + (nLevel/2));

    if (nMulti < 1) nMulti = 1; // Avoid multipliers less than positive one.

    int nPoints = nMulti * LOCK_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // PLAYER FEEDBACK
    DisplayPlayerFeedback(oPC, "Lock Picked", "Locks Picked", nPoints, nLocks);

    // DEBUG
    DebugMessage("inc_id1_score::AwardAreaLockPickedPoints()");
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardTrapsDisarmedPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 8, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardTrapDisarmedPoints(object oPC, int nDC)
{
    // If the creature is a non pc award their master if they have one.
    if (!GetIsPC(oPC))
    {
        oPC = GetMaster(oPC);

        if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
        {
            return;
        }
    }

    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // Update the player's # of secrets discovered.
    int nTraps = GetLocalInt(oDungeon, TRAPS_DISARMED + sPCIdentifier);

    nTraps++;

    SetLocalInt(oDungeon, TRAPS_DISARMED + sPCIdentifier, nTraps);

    // Award is constant times the search DC compared to player level.
    int nLevel = GetHitDice(oPC);
    int nMulti = (nDC + 5) - (20 + (nLevel/2));

    if (nMulti < 1) nMulti = 1; // Avoid multipliers less than positive one.

    int nPoints = nMulti * TRAP_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

    // Player Feedback.
    DisplayPlayerFeedback(oPC, "Trap Disarmed", "Traps Disarmed", nPoints, nTraps);

    // DEBUG
    DebugMessage("inc_id1_score::AwardTrapDisarmedPoints()");
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardPlotCompletedPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 31, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardPlotCompletedPoints(int nPlotDifficulty = PLOT_AWARD_LOW)
{
    object oDungeon = GetCurrentDungeon();

    // Loop all players in the module awarding points and updating counters.
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC))
    {
        string sPCIdentifier = GetPCIdentifier(oPC);

        // Update the player's # of plots completed.
        int nPlots = GetLocalInt(oDungeon, PLOTS_COMPLETED + sPCIdentifier);

        nPlots++;

        SetLocalInt(oDungeon, PLOTS_COMPLETED + sPCIdentifier, nPlots);

        // Award is constant times difficulty.
        int nPoints = nPlotDifficulty * PLOT_MULTIPLIER;

        AwardPoints(oDungeon, sPCIdentifier, nPoints, oPC);

        oPC = GetNextPC();
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: AwardBossDefeatedPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 31, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardBossDefeatedPoints(object oPC)
{
    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // Update the player's # of bosses defeated.
    int nBosses = GetLocalInt(oDungeon, BOSSES_DEFEATED + sPCIdentifier);

    nBosses++;

    SetLocalInt(oDungeon, BOSSES_DEFEATED + sPCIdentifier, nBosses);
}

/*
//::////////////////////////////////////////////////////////////////////////////
//:: AwardCollectablesAssembledPoints
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Aug 31, 2005
//::////////////////////////////////////////////////////////////////////////////
void AwardCollectablesAssembledPoints(object oPC, int nPieces)
{
    object oDungeon = GetCurrentDungeon();
    string sPublicCDKey = GetPCPublicCDKey(oPC);
    string sPlayerName = GetName(oPC);
    string sPCIdentifier = sPlayerName + sPublicCDKey;

    // Update player's # of artficats assembled.
    int nArtifacts = GetLocalInt(oDungeon, COLLECTABLES_ASSEMBLED + sPCIdentifier);

    nArtifacts++;

    SetLocalInt(oDungeon, COLLECTABLES_ASSEMBLED + sPCIdentifier, nArtifacts);

    // Award is the number of pieces involved in constructing the collectable
    // multiplied by the assembly multiplier and ,CURRENTLY, the player's level.
    // Because of the potential to exploit a different measure of the
    // collectables power (as opposed the the player's level) should be used.
    int nLevels = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC)
        + GetLevelByPosition(3, oPC);
    int nPoints = nLevels * nPieces * ASSEMBLE_MULTIPLIER;

    AwardPoints(oDungeon, sPCIdentifier, nPoints);
}
*/

//::////////////////////////////////////////////////////////////////////////////
//:: IncrementDeathCounter
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Oct 8, 2005
//::////////////////////////////////////////////////////////////////////////////
void IncrementDeathCounter(object oPC)
{
    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // Update death toll
    int nDeaths = GetLocalInt(oDungeon, DEATHS + sPCIdentifier);

    nDeaths++;

    SetLocalInt(oDungeon, DEATHS + sPCIdentifier, nDeaths);

    // Test
    DebugMessage("A player has died. This player has died "
        + IntToString(nDeaths) + " time(s).");
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetTotal
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 1, 2005
//::////////////////////////////////////////////////////////////////////////////
int GetTotal(object oPC, string sTotalType)
{
    object oDungeon = GetCurrentDungeon();
    string sPCIdentifier = GetPCIdentifier(oPC);

    // If the dungeon is invalid an error has occured return the error value.
    if (!GetIsObjectValid(oDungeon))
    {
            return -1;
    }

    return GetLocalInt(oDungeon, sTotalType + sPCIdentifier);
}

//void main(){}

