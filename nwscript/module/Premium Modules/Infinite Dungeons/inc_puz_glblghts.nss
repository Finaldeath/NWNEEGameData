//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_glblghts
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the globe lights puzzle. This puzzle involves a grid
    of Crystal Globes which can be light or unlit. Toggling the state of any one
    globe toggles the state of the globes directly below, above and to the left
    and right of it. The object of the puzzle is to light all of the globes
    from a randomized starting state.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 5, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_general"
#include "inc_id1_puzzle"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/

// Placeable ReseRefs
const string S_GLOBE_RESREF = "globe_plc";

const string HINT_PLC_RESREF = "id1_glblghts_hnt";

// Placeable Tag prefix
const string S_GLOBE_TAG_PRFX = "globe_plc_";

// Local variables names
const string S_LOCAL_ROW_INT   = "N_LOCAL_ROW";
const string S_LOCAL_COL_INT   = "N_LOCAL_COL";
const string S_LOCAL_STATE_INT = "N_LOCAL_STATE";
const string S_RANDOMIZED_BOOL = "B_RANDOMIZED";

// Dufficulty and size constants
const int N_GRID_SIZE = 7;
// Number of randomizations to apply to initial state; determines difficulty.
const int N_RAND_INIT = 10;

// State constants
const int N_STATE_ACTIVE = 1;
const int N_STATE_INACTIVE = 0;

/*------------------------------------------------------------------------------
    FUNCTION TEMPLATES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_glblghts
//
// This function creates all the placeable objects involved in the globe lights
// puzzle consisting of a 7 X 7 grid of 'Crystal Globe' placeables.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();

// Name: Randomize Grid
//
// Defined in: inc_puz_glblghts
//
// Randmoizes the state of the globe grid by randomly selecting N_RAND_INIT
// globes and toggling their states secuentially.
//
// Parameters:
// oPuzzleWP - The puzzle waypoint for reference.
//
// Return:
// NONE
void RandomizeGrid(object oPuzzleWP);

// Name: Light Globe
//
// Defined in: inc_puz_glblghts
//
// Function called on the On Used event of the crystal globes. This function
// calls the toggle state method on the calling object and the objects directly
// North, South, East and West of the calling object.
//
// Parameters:
// oGlobe - The globe object that has been used.
// oPC - The player lighting the globe.
// oPuzzleWP - Waypoint the puzzle is based on for reference.
//
// Return:
// NONE
void LightGlobe(object oGlobe, object oPC, object oPuzzleWP);

// Name: Toggle State
//
// Defined in: inc_puz_glblghts
//
// Toggles the state of the globe in row nRow and column nCol. If the globe is
// currently active it will be deactivated, both via animation and a local state
// variable (N_LOCAL_STATE; one of N_STATE_ACTIVE or N_STATE_INACTIVE). If the
// globe is currently deactivated it will be activated.
//
// Parameters:
// nRow - The row of the globe whose state is to be modified.
// nCol - The column of the globe whose state is to be modified.
//
// Return:
// NONE
void ToggleState(int nRow, int nCol);

// Name: Check Puzzle
//
// Defined in: inc_puz_glblghts
//
// Checks the puzzle for a win state by cycling through the grid of lights and
// comparing the status of each in tern.
//
// Parameters:
// NONE
//
// Return:
// TRUE if the puzzle is in a completed state; all the globes are active.
// FALSE otherwise.
int CheckPuzzle();

// Name: End Puzzle
//
// Defined in: inc_puz_glblghts
//
// Wraps up the puzzle. Signals user defined event 5000 on the area.
//
// Parameters:
// oPC - The player who solved the puzzle.
//
// Return:
// NONE
void EndPuzzle(object oPC);

/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Aug 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    // VARIABLES
    object oPuzzleWP, oArea, oGlobe;
    vector vPos; // For determining position at which to create.
    location lLoc; // Location for next placeable creation.
    float fX, fY, fOrnt; // Locational variables.
    int nRow, nCol; // Row and column in grid for naming.
    string sTag; // Dynamically established placeable tag.

    // LOCAL CONSTANTS
    float fXVar = - 6.0; // The variance in the X coordinate of the top right.
    float fYVar = 6.0; // The variance in the Y coordinate of the top right.
    float fZ = 0.0; // The Z axis, or height from the ground.
    float fInc = 2.0; // The space between two cells.

    // Establish the area to create the puzzle.
    oPuzzleWP = OBJECT_SELF;
    oArea = GetArea(oPuzzleWP);

    vPos = GetPosition(oPuzzleWP);

    fX = vPos.x + fXVar;
    fY = vPos.y + fYVar;

    nRow = 0;
    nCol = 0;

    // Create the grid.
    while (nRow < N_GRID_SIZE)
    {
        while (nCol < N_GRID_SIZE)
        {
            // Establish the globe's location and tag.
            sTag = S_GLOBE_TAG_PRFX + IntToString(nRow) + "_" + IntToString(nCol);
            vPos = Vector(fX, fY, fZ);
            lLoc = Location(oArea, vPos, fOrnt);

            // Create the globe
            oGlobe = CreateObject(OBJECT_TYPE_PLACEABLE, S_GLOBE_RESREF, lLoc, FALSE, sTag);

            // Error checking
            if (oGlobe == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_glblghts::CreatePuzzle - Globe created invalid.");
            }
            else
            {
                // Light the globe
                AssignCommand(oGlobe, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

                // Set local variables.
                SetLocalInt(oGlobe, S_LOCAL_ROW_INT, nRow);
                SetLocalInt(oGlobe, S_LOCAL_COL_INT, nCol);
                SetLocalInt(oGlobe, S_LOCAL_STATE_INT, N_STATE_ACTIVE);
            }

            // Increment Col and X value.
            nCol++;
            fX += fInc;
        }

        // Increment Row and Y value.
        nRow++;
        fY -= fInc;
        // Reset Column and X value.
        nCol = 0;
        fX -= (N_GRID_SIZE) * 2.0;
    }

    // Create the hint tome.
    fOrnt = 225.0;
    vPos = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vPos, fOrnt);

    DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lLoc);

    // Randomize the starting state
    RandomizeGrid(oPuzzleWP);
}

//::////////////////////////////////////////////////////////////////////////////
//:: RandomizeGrid
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void RandomizeGrid(object oPuzzleWP)
{
    object oGlobe;
    int nRow, nCol, i, nLastRow, nLastCol, nRndLmt, nDiff;
    string sRow, sCol, sTag;

    nLastRow = -1;
    nLastCol = -1;

    // Update Sep 15, 2005
    // The number of randomizations is based on difficulty.
    nDiff = GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY);

    switch (nDiff)
    {
        case ID1_PUZZLE_DIFFICULTY_EASY:
        {
            nRndLmt = 5;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_NORMAL:
        {
            nRndLmt = 10;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_HARD:
        {
            nRndLmt = 20;
            break;
        }
        default:
        {
            nRndLmt = 5;
            break;
        }
    } // end switch.

    // Randomly select a number of globes to 'light'.
    for (i = 0; i < nRndLmt; ++i)
    {
        nRow = Random(N_GRID_SIZE);
        nCol = Random(N_GRID_SIZE);

        // Make sure the row and column aren't the same as generated previously
        if (nRow == nLastRow || nCol == nLastCol)
        {
            // If the same increment the row for a quick simple re-randomization
            nRow ++;

            // Check boundaries.
            if (nRow >= N_GRID_SIZE)
            {
                nRow = 0;
            }
        }

        nLastRow = nRow;
        nLastCol = nCol;

        sRow = IntToString(nRow);
        sCol = IntToString(nCol);

        sTag = S_GLOBE_TAG_PRFX + sRow + "_" + sCol;

        oGlobe = GetObjectByTag(sTag);

        if (oGlobe == OBJECT_INVALID)
        {
            DebugMessage(sTag + " INVALID.");
            continue; // Move on to the next.
        }

        DebugMessage("inc_puz_glblghts::RandomizeGrid - " + sTag);

        LightGlobe(oGlobe, OBJECT_INVALID, oPuzzleWP);
    } // end for.
}

//::////////////////////////////////////////////////////////////////////////////
//:: LightGlobe
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void LightGlobe(object oGlobe, object oPC, object oPuzzleWP)
{
    // Ensure the puzzle has not already been completed.
    //object oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG, oPC);
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");

    int bCompleted = GetLocalInt(oDungeon, sVarPrfx + B_PUZZLE_COMPLETED);

    if (bCompleted)
    {
        return;
    }

    object oGlb;
    int nRow1, nCol1, nRow2, nCol2;

    // Establish the placeable's location in the grid.
    nRow1 = GetLocalInt(oGlobe, S_LOCAL_ROW_INT);
    nCol1 = GetLocalInt(oGlobe, S_LOCAL_COL_INT);

    // Toggle the selected globe's state.
    ToggleState(nRow1, nCol1);

    ////////////////////////////////////////////////////////////////////////////
    // Determine the row/col of the globe directly NORTH of oGlobe and toggle.
    nCol2 = nCol1;
    nRow2 = nRow1 - 1;

    ToggleState(nRow2, nCol2);
    ////////////////////////////////////////////////////////////////////////////
    // Determine the row/col of the globe directly SOUTH of oGlobe and toggle.
    nCol2 = nCol1;
    nRow2 = nRow1 + 1;

    ToggleState(nRow2, nCol2);
    ////////////////////////////////////////////////////////////////////////////
    // Determine the row/col of the globe directly WEST of oGlobe and toggle.
    nCol2 = nCol1 - 1;
    nRow2 = nRow1;

    ToggleState(nRow2, nCol2);
    ////////////////////////////////////////////////////////////////////////////
    // Determine the row/col of the globe directly EAST of oGlobe and toggle.
    nCol2 = nCol1 + 1;
    nRow2 = nRow1;

    ToggleState(nRow2, nCol2);
    ////////////////////////////////////////////////////////////////////////////

    // Check for a win state
    if (CheckPuzzle())
    {
        object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
        AssignCommand(oInvis, EndPuzzle(oPC));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ToggleState
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 5, 2005
//::////////////////////////////////////////////////////////////////////////////
void ToggleState(int nRow, int nCol)
{
    object oGlobe;
    int nState;
    string sRow, sCol, sTag;

    sCol = IntToString(nCol);
    sRow = IntToString(nRow);

    sTag = S_GLOBE_TAG_PRFX + sRow + "_" + sCol;

    // Retrieve the globe and toggle its state.
    oGlobe = GetObjectByTag(sTag);

    // Ensure the globes validity.s
    if (oGlobe == OBJECT_INVALID)
    {
        DebugMessage("inc_puz_glblghts::ToggleState - " + sTag + " INVALID.");
        return;
    }

    nState = GetLocalInt(oGlobe, S_LOCAL_STATE_INT);

    if (nState == N_STATE_ACTIVE) // The globe was 'on'.
    {
        AssignCommand(oGlobe, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
    else // The globe was 'off'.
    {
        AssignCommand(oGlobe, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }

    SetLocalInt(oGlobe, S_LOCAL_STATE_INT, !nState); // Invert the state.
}

//::////////////////////////////////////////////////////////////////////////////
//:: CheckPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 8, 2005
//::////////////////////////////////////////////////////////////////////////////
int CheckPuzzle()
{
    int nState, nRow, nCol;
    object oGlobe;
    string sRow, sCol, sTag;

    nRow = 0;
    nCol = 0;

    // Loop the rows
    while (nRow < N_GRID_SIZE)
    {
        sRow = IntToString(nRow);

        // Loop the columns
        while (nCol < N_GRID_SIZE)
        {
            sCol = IntToString(nCol);
            sTag = S_GLOBE_TAG_PRFX + sRow + "_" + sCol;

            oGlobe = GetObjectByTag(sTag);

            // Ensure the globe's validity
            if (oGlobe == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_glblghts::CheckPuzzle - " + sTag + " INVALID");
            }
            else
            {
                nState = GetLocalInt(oGlobe, S_LOCAL_STATE_INT);

                // If an inactive globe is deiscovered the puzzle is not solved.
                if (nState == N_STATE_INACTIVE)
                {
                    return FALSE;
                }
            }
            nCol++;
        }
        nRow++;
        nCol = 0;
    }

    return TRUE;
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 8, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle(object oPC)
{
    object oArea, oPuzzleWP, oRewardWP, oGlobe;
    effect eVFX;
    int nRow, nCol;
    string sRow, sCol, sTag;

    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
    oArea = GetArea(oPuzzleWP);

    nRow = 0;
    nCol = 0;
    eVFX = EffectVisualEffect(VFX_IMP_HEAD_HOLY);

    // Apply some visuals to indicate success.
    while (nRow < N_GRID_SIZE)
    {
        sRow = IntToString(nRow);

        while (nCol < N_GRID_SIZE)
        {
            sCol = IntToString(nCol);
            sTag = S_GLOBE_TAG_PRFX + sRow + "_" + sCol;

            oGlobe = GetObjectByTag(sTag);

            // Ensure the globe's validity
            if (oGlobe == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_glblghts::CheckPuzzle - " + sTag + " INVALID");
            }
            else
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oGlobe);

                // Delete the, now irrelevant, variables stored on the globe.
                DeleteLocalInt(oGlobe, S_LOCAL_ROW_INT);
                DeleteLocalInt(oGlobe, S_LOCAL_COL_INT);
                DeleteLocalInt(oGlobe, S_LOCAL_STATE_INT);
            }
            nCol++;
        }
        nRow++;
        nCol = 0;
    }

    // Set the completion indicator on the dungeon object.
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");
    string sVar = sVarPrfx + B_PUZZLE_COMPLETED;

    // If the puzzle is not already flagged as completed it should reward.
    if (!GetLocalInt(oDungeon, sVar))
    {
        // Award the puzzle's solver some points.
        AwardPuzzleSolvedPoints(oPC);

        // reward the player for completing the puzzle
        GeneratePuzzleReward(oPuzzleWP, oPC);
    }

    SetLocalInt(oDungeon, sVar, TRUE);

    // DEBUG
    DebugMessage("");
    DebugMessage("inc_puz_glblghts::EndPuzzle");
    DebugMessage("Setting " + sVarPrfx + B_PUZZLE_COMPLETED + " TRUE.");
    DebugMessage("");


    // Signal the area with the 'puzzle solved' event.
//    SignalEvent(oArea, EventUserDefined(5000));
}
