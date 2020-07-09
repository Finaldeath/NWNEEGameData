//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_general
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    General include file for constants and functions universal to all puzzles.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 28, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_score"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Temporary variables; to be moved to inc_id1_flags.
//const string ID1_FLAG_PUZZLE_DIFFICULTY = "nFlagPuzzleDifficulty";
//const int ID1_PUZZLE_DIFFICULTY_EASY = 10;
//const int ID1_PUZZLE_DIFFICULTY_NORMAL = 20;
//const int ID1_PUZZLE_DIFFICULTY_HARD = 30;

// Dungeon variables.
const string DUNGEON_OBJ     = "oCurrentDungeon";

// Puzzle Cataloging constants.
const string PUZZLE_2DA = "puzzles";
const string PUZZLE_TYPE = "PuzzleType";
const string PUZZLE_SCPT = "PuzzleScript";
const string PUZ_CTLG_ID = "nPuzzleIdentifierScript";
const string PUZ_CTLG_SFX = "PuzzleNum";
const string PUZ_CTLG_PRFX_HRD = "nPuzzleCatalogHard";
const string PUZ_CTLG_PRFX_ESY = "nPuzzleCatalogEasy";
const string PUZ_CTLG_PRFX_NRL = "nPuzzleCatalogNormal";
const string PUZ_CTLG_N_HRD = "nHardPuzzles";
const string PUZ_CTLG_N_ESY = "nEasyPuzzles";
const string PUZ_CTLG_N_NRL = "nNormalPuzzles";
const string PUZ_B_HRD_VER = "bHardVersion";
const string PUZ_B_ESY_VER = "bEasyVersion";
const string PUZ_B_NRL_VER = "bNormalVersion";

// Waypoint on which puzzles will be created.
const string CREATE_WP_TAG = "ID1_STATIC_WP_PUZZLE";

// Local puzzle state counter, stored on area.
const string N_PUZZLE_STATE = "nPuzzleState";

// Puzzle states.
const int PUZ_UNSPAWNED = 0;
const int PUZ_ACTIVATED = 1;
const int PUZ_FAILED    = 2;
const int PUZ_COMPLETED = 3;

// Placeable Facings
const float F_NORTH      = 90.0;
const float F_NORTH_WEST = 135.0;
const float F_WEST       = 180.0;
const float F_SOUTH_WEST = 225.0;
const float F_SOUTH      = 270.0;
const float F_SOUTH_EAST = 315.0;
const float F_EAST       = 0.0;
const float F_NORTH_EAST = 45.0;

// Variable names
const string N_AREA_PUZZLE_WPS = "nWaypointPuzzle";
const string O_AREA_PUZZLE_WP  = "oWaypointPuzzle";
const string B_PUZZLE_COMPLETED = "Completed";
const string O_PUZZLE_SOLVER = "oPuzzleSolver";



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/




// Name: Get Next Circle X
//
// Defined in: inc_puz_general
//
// This function returns the X variant, in terms of the circle's center, of the
// next point on the edge of a circle where the circle's radius is fRadius and
// point fPoint of fNumPoints along the circle is being determined.
// Return value is dteremined using the equation x = r * cos( t * 360/ pts )
// where r is the radius of the circle, t is the target point and pts is the
// total number of points.
//
// Parameters:
// fRadius - The radius of the circle on which points are being determined.
// fPoint  - The point in sequence that is being negotiated.
// fNumPts - The total number of points being established on the circle.
//
// Return:
// The X value of the point in position fPoint of the sequence.
float GetNextCircleX(float fRadius, int nPoint, int nNumPts);

// Name: Get Next Circle y
//
// Defined in: inc_puz_general
//
// This function returns the Y variant, in terms of the circle's center, of the
// next point on the edge of a circle where the circle's radius is fRadius and
// point fPoint of fNumPoints along the circle is being determined.
// Return value is dteremined using the equation y = r * sin( t * 360/ pts )
// where r is the radius of the circle, t is the target point and pts is the
// total number of points.
//
// Parameters:
// fRadius - The radius of the circle on which points are being determined.
// fPoint  - The point in sequence that is being negotiated.
// fNumPts - The total number of points being established on the circle.
//
// Return:
// The Y value of the point in position fPoint of the sequence.
float GetNextCircleY(float fRadius, int nPoint, int nNumPoints);

// Name: Get Waypoint Number
//
// Defined in: inc_puz_general
//
// Returns the oWaypoint's waypoint number. This is the number, X, that
// corresponds to the waypoint's variable name stored on the area: oWaypointX.
//
// Parameters:
// oWaypoint - The waypoint whose number is to be retreived.
//
// Return:
// The waypoint's number in terms of the area or -1 on error.
int GetWaypointNumber(object oWaypoint);

// Name: Get Variable Name Prefix
//
// Defined in: inc_puz_general
//
// This function retreives the variable name prefix that should be used when
// storing puzzle state on the dungeon object based on the puzzle waypoint that
// the puzzle is being generated on.
//
// Parameters:
// oWaypoint - The puzzle waypoint where the puzzle is being generated.
// sDataType - A prefix representing the data type that the variable is
//             referencing - n for integers, b for booleans, s for strings etc.
//
// Return:
// The prefix to use in variable names for storing the puzzle's state.
string GetVariableNamePrefix(object oWaypoint, string sDataType = "n");

// Name: Read Puzzles
//
// Defined in: inc_puz_general
//
// This is a recursive function to read puzzle entries from the puzzle 2da in
// sequence. As puzzles are read they are cataloged on the module for later
// reference.
//
// Parameters:
// fDelay - A delay passed through each function call in order to allow time
//          for subsequent calls to Get2DAString.
// s2DA - The 2da file from which the puzzles will be read.
// nRow - The row to be read, updated with each recursive call.
//
// Return:
// NONE
void ReadPuzzles(float fDelay, string s2DA, int nRow);

// Name: Catalog Puzzles
//
// Defined in: inc_puz_general
//
// Reads in the puzzles from 2da and stores them on the module, catagorized
// by difficulty.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CatalogPuzzles();

// Temporary placeholder for the function in inc_id1_flags.
//int GetModuleFlag(string sFlag);

// Name: Generate Puzzle
//
// Defined in: inc_puz_general
//
// Generates a random puzzle based on the the current difficulty flag of the
// dungeon. The puzzle generated is recorded on the dungeon and then spawned
// by calling the appropriate script.
//
// Parameters:
// sWaypointVarName - The variable name on the dungeon object used to record
//                    information about the waypoint, in this case the puzzle
//                    type.
//
// Return:
// NONE
void GeneratePuzzle(string sWaypointVarName);



/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: GetNextCircleX
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 22, 2005
//::////////////////////////////////////////////////////////////////////////////
float GetNextCircleX(float fRadius, int nPoint, int nNumPts)
{
    float fX1, fX2, fX3;

    fX1 = nPoint * 360.0;
    fX2 = fX1 / nNumPts;
    fX3 = cos(fX2);

    return fX3 * fRadius;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetNextCircleY
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 22, 2005
//::////////////////////////////////////////////////////////////////////////////
float GetNextCircleY(float fRadius, int nPoint, int nNumPts)
{
    float fY1, fY2, fY3;

    fY1 = nPoint * 360.0;
    fY2 = fY1 / nNumPts;
    fY3 = sin(fY2);

    return fY3 * fRadius;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetWaypointNumber
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 07, 2005
//::////////////////////////////////////////////////////////////////////////////
int GetWaypointNumber(object oWaypoint)
{
    object oArea, oWP;
    int nWPs, i;

    DebugMessage("inc_puz_general::GetWaypointNumber() Tag of the waypoint is "
        + GetTag(oWaypoint));

    oArea = GetArea(oWaypoint);

    DebugMessage("inc_puz_general::GetWaypointNumber() Tag of the area is "
        + GetTag(oArea));

    // Determine the number of puzzle waypoints in the area.
    nWPs = GetLocalInt(oArea, "nWaypointPuzzle");

    DebugMessage("inc_puz_general::GetWaypointNumber() "
        + IntToString(nWPs) + " puzzle waypoints on the area.");

    // Loop through each of the puzzle waypoints comparing them to the target.
    for (i = 1; i <= nWPs; i++)
    {
        oWP = GetLocalObject(oArea, O_AREA_PUZZLE_WP + IntToString(i));

        // EDIT: testing
        DebugMessage("Getting " + O_AREA_PUZZLE_WP + IntToString(i));

        // If a match is found return its index.
        if (oWP == oWaypoint)
        {
            return i;
        }
    }

    // If no match was found return -1, to represent an error.
    return -1;
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetVariableNamePrefix
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sept 09, 2005
//::////////////////////////////////////////////////////////////////////////////
string GetVariableNamePrefix(object oWaypoint, string sDataType = "n")
{
    // Gather all the information to construct the variables.
    int nAreaId, nIdArea, nLevel, nWP;
    string sVarPrfx;
    object oArea, oModule, oDungeon;

    oArea = GetArea(oWaypoint);
    oModule = GetModule();
    oDungeon = GetCurrentDungeon();

    // Area identification
    nAreaId = GetLocalInt(oArea, AREA_IDENTIFIER);
    nIdArea = GetLocalInt(oDungeon, "nIdentifier" + IntToString(nAreaId)
        + "Area");

    // Level identification
    nLevel = GetLocalInt(oModule, MODULE_LEVEL);

    // Waypoint identification
    nWP = GetWaypointNumber(oWaypoint);

    if (nWP == -1) // -1 returned from GetWaypointNumber on error.
    {
        DebugMessage("GetVariablePrefix::Could not match physical"
            + " waypoint to waypoint stored on area.");
    }

    sVarPrfx = sDataType + "Area" + IntToString(nIdArea) + "WaypointPuzzle"
        + IntToString(nWP) + "Level" + IntToString(nLevel);

    return sVarPrfx;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ReadPuzzles
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 13, 2005
//::////////////////////////////////////////////////////////////////////////////
void ReadPuzzles(float fDelay, string s2DA, int nRow)
{
    object oModule;
    string sCol, sScript, sEntry;
    int nPzzls;

    oModule = GetModule();

    // Retreive the spawn in script name.
    sCol = "SpawnScript";
    sScript = Get2DAString(s2DA, sCol, nRow);

    // An empty spawn script entry indicates the end of the 2da.
    if (sScript == "")
    {
        return;
    }

    // Associate the script with the puzzles ID on the module.
    SetLocalString(oModule, PUZ_CTLG_ID + IntToString(nRow), sScript);

    // Detemine if there is an 'easy' version of the puzzle.
    sCol = "Easy";
    sEntry = Get2DAString(s2DA, sCol, nRow);

    // If the entry is not empty it is assumed there is an easy version.
    if (sEntry != "")
    {
        // Get the number of easy puzzles cataloged so far.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_ESY);

        // Set the puzzle's spawn script as the next in the easy puzzle list.
        SetLocalInt(oModule, PUZ_CTLG_PRFX_ESY + PUZ_CTLG_SFX
            + IntToString(nPzzls), nRow);

        // Update the number of easy puzzles on the module.
        nPzzls++;
        SetLocalInt(oModule, PUZ_CTLG_N_ESY, nPzzls);
    }

    // Determine if there is a 'normal' version of the puzzle.
    sCol = "Normal";
    sEntry = Get2DAString(s2DA, sCol, nRow);

    // If the entry is not empty it is assumed there is a normal version.
    if (sEntry != "")
    {
        // Get the number of normal puzzles cataloged so far.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_NRL);

        // Set the puzzle's spawn script as the next in the normal puzzles list.
        SetLocalInt(oModule, PUZ_CTLG_PRFX_NRL + PUZ_CTLG_SFX
            + IntToString(nPzzls), nRow);

        // Update the number of normal puzzles on the module.
        nPzzls++;
        SetLocalInt(oModule, PUZ_CTLG_N_NRL, nPzzls);
    }

    // Determine if there is a 'hard' version of the puzzle.
    sCol = "Hard";
    sEntry = Get2DAString(s2DA, sCol, nRow);

    // If the entry is not empty ir is assumed there is a hard version.
    if (sEntry != "")
    {
        // Get the number of normal puzzles cataloged so far.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_HRD);

        // Set the puzzles spawn script as thenext in the hard puzzles list.
        SetLocalInt(oModule, PUZ_CTLG_PRFX_HRD + PUZ_CTLG_SFX
            + IntToString(nPzzls), nRow);

        // Update the number of hard puzzles on the module.
        nPzzls++;
        SetLocalInt(oModule, PUZ_CTLG_N_HRD, nPzzls);
    }

    fDelay += 0.01;
    nRow++;
    ReadPuzzles(fDelay, s2DA, nRow);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CatalogPuzzles
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sept 12, 2005
//::////////////////////////////////////////////////////////////////////////////
void CatalogPuzzles()
{
    DebugMessage("Reading puzzles 2DA.");

    string s2DA, sCol, sEntry;
    int nRow;

    sCol = "SpawnScript";
    nRow = 0;

    ReadPuzzles(0.0, PUZZLE_2DA, nRow);
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetModuleFlag (TEMPORARY)
//::////////////////////////////////////////////////////////////////////////////
//:: Temporary placeholder for the function in inc_id1_flags.
//::////////////////////////////////////////////////////////////////////////////
//int GetModuleFlag(string sFlag)
//{
//    return ID1_PUZZLE_DIFFICULTY_NORMAL;
//}

//::////////////////////////////////////////////////////////////////////////////
//:: GeneratePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 13, 2005
//::////////////////////////////////////////////////////////////////////////////
void GeneratePuzzle(string sWaypointVarName)
{
    object oModule, oDungeon;
    string sScript, sDiffPrfx;
    int nDiff, nPID, nPzzls, nRand;

    oModule = GetModule();

    // Determine the difficulty of the puzzle to be generated.
    nDiff = GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY);

    sScript = "";

    // Based on the difficulty determine the puzzle id and spawn script.
    if (nDiff == ID1_PUZZLE_DIFFICULTY_HARD)
    {
        // The number of hard puzzles.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_HRD);

        // If there are 0 hard puzzles break.
        if (!nPzzls)
        {
            nDiff = ID1_PUZZLE_DIFFICULTY_NORMAL;
        }
        else
        {
            sDiffPrfx = PUZ_CTLG_PRFX_HRD;
        }
    }

    if (nDiff == ID1_PUZZLE_DIFFICULTY_EASY)
    {
        // Retreive the number of easy puzzles.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_ESY);

        // If there are 0 easy puzzles break.
        if (!nPzzls)
        {
            nDiff = ID1_PUZZLE_DIFFICULTY_NORMAL;
        }
        else
        {
            sDiffPrfx = PUZ_CTLG_PRFX_ESY;
        }
    }

    if (nDiff == ID1_PUZZLE_DIFFICULTY_NORMAL)
    {
        // Retreive the number of normal puzzles.
        nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_NRL);

        // If there are 0 normal puzzles break.
        if (!nPzzls)
        {
            nPzzls = GetLocalInt(oModule, PUZ_CTLG_N_ESY);

            if (!nPzzls)
            {
               sDiffPrfx = "";
            }

            sDiffPrfx = PUZ_CTLG_PRFX_ESY;
        }
        else
        {
            sDiffPrfx = PUZ_CTLG_PRFX_NRL;
        }
    }

    // If there were no puzzles at all detected on the module return;
    if (sDiffPrfx == "")
    {
        DebugMessage("GeneratePuzzle failed. No puzzles available.");
        return;
    }

    // Ranomly choose a puzzle ID from those available.
    nRand = Random(nPzzls);
    nPID = GetLocalInt(oModule, sDiffPrfx + PUZ_CTLG_SFX
        + IntToString(nRand));

    sScript = GetLocalString(oModule, PUZ_CTLG_ID + IntToString(nPID));

    // If the puzzle's spawn script is not valid return.
    if (sScript == "")
    {
        DebugMessage("GeneratePuzzle failed. Could not retrieve puzzle script.");
        return;
    }

    oDungeon = GetCurrentDungeon();

    // Associate the puzzle id with the waypoint on the module. The puzzle's
    // specific spawn script can now be retrieved via:
    // GetLocalString(oModule, PUZ_CTLG_ID + IntToString(nPID))
    SetLocalInt(oDungeon, sWaypointVarName + PUZZLE_TYPE, nPID);
    SetLocalString(oDungeon, sWaypointVarName + PUZZLE_SCPT, sScript);
    // Additional code may be needed to record the booleans indicating the
    // existence of hard, easy and normal versions of the puzzle.
}
