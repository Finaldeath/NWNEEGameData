//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_phlctpth
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the phylactery path puzzle. This puzzle consists of
    a random number of phylactery placeables. The goal is to establish a path
    between each of the phylacteries that never touches a single one more than
    once. In order to to accomplish this the phylacteries can be rotated between
    the 8 cardinal directions and facing them directly towards any other
    phylactery will present a visual effect display of the path between the two.
    Since the path must be established in order the puzzle is initiated by
    activating any one of the phylacteries afterwhich only the currently
    negotiated phylactery in the path will be active.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 28, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_general"
#include "inc_id1_puzzle"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/
// Placeble ResRef constants
const string S_PHYLACTERY_RESREF = "phylactery_plc";

// Placeable tag constants
const string S_PHYLACTERY_TAG_PRFX = "phylactery_plc_";
const string S_SWITCH_TAG = "phl_switch_plc";

// Local variable names
const string S_LOCAL_DISTANCE_INT = "N_LOCAL_DISTANCE";
const string S_LOCAL_COL_INT      = "N_LOCAL_COL";
const string S_LOCAL_ROW_INT      = "N_LOCAL_ROW";
const string S_LOCAL_TARGET_OBJ   = "O_LOCAL_TARGET";
const string S_LOCAL_SOURCE_OBJ   = "O_LOCAL_SOURCE";
const string S_LOCAL_ACTIVE_BOOL  = "B_LOCAL_ACTIVE";
const string S_LOCAL_SOURCE_BOOL  = "B_LOCAL_SOURCE";

const string S_ACTIVE_PHYLACTERIES_COUNTER = "N_ACTIVE";
const string S_TOTAL_PHYLACTERIES_COUNTER  = "N_TOTAL";

const string S_ORIGIN_PHYLACTERY_OBJ = "O_ORIGIN";

// Swtich state constants.
const string S_SWITCH_STATE = "N_SWITCH";

const int N_SWITCH_STATE_ACTIVATE = 1;
const int N_SWITCH_STATE_ROTATE = 0;

// Boundary constants
const int N_MAX_ROW = 8;
const int N_MAX_COL = 8;

// Directional constants
const int N_EAST       = 1;
const int N_NORTH_EAST = 2;
const int N_NORTH      = 3;
const int N_NORTH_WEST = 4;
const int N_WEST       = 5;
const int N_SOUTH_WEST = 6;
const int N_SOUTH      = 7;
const int N_SOUTH_EAST = 8;

// The number of nodes in the puzzle determines the difficulty
const int N_MAX_RANDOM_PHYLS = 4;

// Delay between tracer effects being fired.
const float F_TRACER_DELAY = 0.3;

// Hint tome resref
const string HINT_PLC_RESREF = "id1_phlctpth_hnt";

/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_phlctpth
//
// Creates the placeables involved in the puzzle, which consist of a random
// number of phylacterys. The phylacterys must be created in a path by creating
// one randomly first then establishing a random cardinal direction and
// distance, which must be within the bounds of the 10x10 grid space, where
// a second is created and so on, always ensuring that there is a path from the
// first to the most recently created.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();

// Name: Trace Line
//
// Defined in: inc_puz_phlctpth
//
// Traces a line, either a row, column or diagonal, along the invisible grid
// which holds the phylacteries that form the puzzle. If any phylactery is
// encountered along the line that object is returned.
//
// Parameters:
// nStartRow  - The row from which the trace should start.
// nStartCol  - The column from which the trace should start.
// nDirection - The direction in which to trace, one of the directional
//              constants: N_EAST, N_NORTH_EAST, N_NORTH, N_NORTH_WEST, N_WEST,
//              N_SOUTH_WEST, N_SOUTH, or N_SOUTH_EAST.
//
// Return:
// A Phylactery placeable object if one is encountered or OBJECT_INVALID if not.
object TraceLine(int nStartRow, int nStartCol, int nDirection);

// Name: Activate Phylactery
//
// Defined in: inc_puz_phlctpth
//
// Activates oPhylactery by setting a local boolean, B_LOCAL_ACTIVE, to TRUE.
// Active phylacteries fire a 'tracer' effect every few seconds in order to
// provide the player feedback on the puzzle's state.
//
// Parameters:
// oPhylactery - The phylactery to be activated.
//
// Return:
// NONE
void ActivatePhylactery(object oPhylactery);

// Name: Deactivate Phylactery
//
// Defined in: inc_puz_phlctpth
//
// Deactivates oPhylactery and target phylactery recursively via unsetting
// the local active variable: B_LOCAL_ACTIVE.
//
// Parameters:
// oPhylactery - The phylactery to be deactivated.
//
// Return:
// NONE
void DeactivatePhylactery(object oPhylactery);

// Name: Reset Phylacteries
//
// Defined in: inc_puz_phlctpth
//
// Resets the puzzle by Deactivating all the phylacteries and unsetting the
// the variable indicating that the puzzle is in a 'firing' state.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ResetPhylacteries();

// Name: RotatePhylactery
//
// Defined in: inc_puz_phlctpth
//
// Rotates oPhylactery by 45 degrees. This function will also notify
// oPhylactery's current target, if there is one, that it should not longer be
// flagged as active.
//
// Parameters:
// oPhylactery - The pyhlactery object to be rotated.
//
// Return:
// NONE
void RotatePhylactery(object oPhylactery);

// Name: Fire Tracer
//
// Defined in: inc_puc_phlctpth
//
// This function fires a 'tracer' effect at oPhylactery's target. The target is
// determined by the local integers N_TARGET_ROW and N_TARGET_COL. If there is
// no current target the 'tracer' will be fired at the edge of the puzzle
// space. Additionally the function will call back to itself after a delay set
// by the constant F_TRACER_DELAY and checks to ensure that oPhylactery is still
// active at each call.
//
// Parameters:
// oPhylactery - The phylactery object to fire the tracer.
//
// Return:
// NONE
void FireTracer(object oPhylactery);

// Name: Acquire Target
//
// Defined in: inc_puc_phlctpth
//
// Finds a target for oPhylactery based on the placeable's row, column and
// facing. The location of the target is returned. This is accomplished by using
// the TraceLine method to find any other phylacteries along the diagonal that
// oPhylactery is facing. If none can be found the returned location is the
// end of the diagonal.
//
// Parameters:
// oPhylactery - The phylactery placeable for which a target should be found.
//
// Return:
// A target location, either another phylactery or the edge of the grid.
location AcquireTarget(object oPhylactery);

// Name: End Puzzle
//
// Defined in: inc_puz_phlctpth
//
// Wraps up the puzzle, once solved, by destroying all the phylacteries and
// signaling user defined event 5000 on the area to indictate the puzzle's
// completion.
//
// Parameters:
// oSolver - The player that solved the puzzle; the last person to use one of
//           the placeable objects that make up the puzzle.
//
// Return:
// NONE
void EndPuzzle(object oSolver);

/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:July 28, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    // LOCAL VARIABLES
    object oCreateWP, oArea, oPhyl, oObstruct;
    int nRow, nCol, nPhyls, nRandPhyls, nDir, nPrvDr, nDist, nMaxDist, nDiff, i;
    int bValid; // For establishing valid directions.
    float fX1, fY1, fX, fY, fZ;
    string sTag, sRow, sCol;
    vector vPosition;
    location lCreation;

    // LOCAL CONSTANTS
    // Variance between the puzzle waypoint location and the 'upper-left' corner
    float fXVar = -7.0;                                                         // <<<
    float fYVar = 7.0;                                                          // <<<

    // Establish the waypoint and location to create the puzzle elements.
    oCreateWP = OBJECT_SELF;
    oArea = GetArea(oCreateWP);

    vPosition = GetPosition(oCreateWP);

    fX1 = vPosition.x + fXVar;
    fY1 = vPosition.y + fYVar;
    fZ = vPosition.z;

    // Number of possible random phylacteries is scewed by difficulty.
    nDiff = GetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY);

    switch (nDiff)
    {
        case ID1_PUZZLE_DIFFICULTY_EASY:
        {
            nRandPhyls = 2;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_NORMAL:
        {
            nRandPhyls = 6;
            break;
        }
        case ID1_PUZZLE_DIFFICULTY_HARD:
        {
            nRandPhyls = 10;
            break;
        }
        default:
        {
            DebugMessage("inc_puz_phlctpth::main() switch(nDiff) -> default:");
            nRandPhyls = 6;
            break;
        }
    }

    // Generate a random number of phylacteries and store the number on the
    // waypoint in order to check for end conditions.
    nPhyls = Random(N_MAX_RANDOM_PHYLS) + nRandPhyls;

    SetLocalInt(oCreateWP, S_TOTAL_PHYLACTERIES_COUNTER, (nPhyls + 1));

    // Create the first phylactery from which the path will be established.
    nRow = Random(N_MAX_ROW) + 1;
    nCol = Random(N_MAX_COL) + 1;

    sRow = IntToString(nRow);
    sCol = IntToString(nCol);

    sTag = S_PHYLACTERY_TAG_PRFX + sRow + "_" + sCol;

    DebugMessage("Creating: " + sTag);

    fX = fX1 + ((nCol - 1) * 1.5);                                              // <<<
    fY = fY1 - ((nRow - 1) * 1.5);                                              // <<<

    vPosition = Vector(fX, fY, fZ);
    lCreation = Location(oArea, vPosition, 0.0);

    oPhyl = CreateObject(OBJECT_TYPE_PLACEABLE, S_PHYLACTERY_RESREF, lCreation, FALSE, sTag);

    if (oPhyl == OBJECT_INVALID) // Error checking.
    {
        DebugMessage("inc_puz_phlctpth::CreatePuzzle: " + sTag + " created invalid.");
    }
    else
    {
        // Set local varaiables.
        SetLocalInt(oPhyl, S_LOCAL_ROW_INT, nRow);
        SetLocalInt(oPhyl, S_LOCAL_COL_INT, nCol);
    }

    nDir = 9; // Previous direction of the first phylactery is invalid.


    // Create new phylacteries along a path to ensure that the puzzle is solvable.
    for (i = 0; i < nPhyls; ++i)
    {
        bValid = FALSE;
        nPrvDr = nDir;

        // Max distance between two phylacteries should be the number of columns
        // or rows, whichever is lesser, initially for each new phylactery.
        if (N_MAX_ROW < N_MAX_COL)
        {
            nMaxDist = N_MAX_ROW;
        }
        else
        {
            nMaxDist = N_MAX_COL;
        }

        // Generate random directions until a valid one is determined.
        while (bValid == FALSE)
        {
            bValid = TRUE;

            // Generate a random directon to place the next phylactery.
            nDir = Random(8) + 1;

            DebugMessage("Direction Generated: " + IntToString(nDir));

            // Always switch directions; never generate along a single axis.
            if (nDir == nPrvDr || nDir == (nPrvDr + 4) || nDir == (nPrvDr - 4))
            {
                bValid = FALSE;
                continue;
            }

            // Determine if this direction is valid.
            if (nCol == 1) // West most column.
            {
                if (nDir >= N_NORTH_WEST && nDir <= N_SOUTH_WEST)
                {
                    bValid = FALSE;
                    continue;
                }
            }
            else if (nCol == N_MAX_COL) // East most column.
            {
                if (nDir == N_SOUTH_EAST || nDir == N_EAST || nDir == N_NORTH_EAST)
                {
                    bValid = FALSE;
                    continue;
                }
            }
            if (nRow == 1) // North most row.
            {
                if (nDir <= N_NORTH_WEST && nDir >= N_NORTH_EAST)
                {
                    bValid = FALSE;
                    continue;
                }
            }
            else if (nRow == N_MAX_ROW) // South most row.
            {
                if (nDir <= N_SOUTH_EAST && nDir >= N_SOUTH_WEST)
                {
                    bValid = FALSE;
                    continue;
                }
            }
        } // End while

        // Trace the diagonal along the established direction to check for
        // obstructions and place a boundary on the distance accordingly.
        oObstruct = TraceLine(nRow, nCol, nDir);

        if (oObstruct != OBJECT_INVALID) // Obstruction found.
        {
            nMaxDist = GetLocalInt(oObstruct, S_LOCAL_DISTANCE_INT);

            DebugMessage("nMaxDist = " + IntToString(nMaxDist));
        }

        // Based on the direction find an increment/decrement for the row/col.
        switch (nDir)
        {
            ////////////////////////////////////////////////////////////////////
            case N_EAST: // East
            {
                nDist = Random(N_MAX_COL - nCol) + 1; // 1 to 10 - the current column.

                if (nDist > nMaxDist) nDist = nMaxDist;

                nCol += nDist; // New column is nCol + 1 to 10.

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_NORTH_EAST: // Northeast
            {
                // If there are more col's than rows available.
                if ((N_MAX_COL - nCol) > (nRow - 1))
                {
                    nDist = Random(nRow - 1) + 1; // 1 to (nRow - 1).
                }
                else
                {
                    nDist = Random(N_MAX_COL - nCol) + 1; // 1 to 10 - the current col.
                }

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow -= nDist;
                nCol += nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_NORTH: // North
            {
                nDist = Random(nRow - 1) + 1; // 1 to (nRow -1)

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow -= nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_NORTH_WEST: // Northwest
            {
                // If there are more col's than rows available.
                if (nCol > nRow)
                {
                    nDist = Random(nRow - 1) + 1; // 1 to (nRow - 1).
                }
                else
                {
                    nDist = Random(nCol - 1) + 1; // 1 to (nCol - 1).
                }

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow -= nDist;
                nCol -= nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_WEST: // West
            {
                nDist = Random(nCol - 1) + 1; // 1 to (nCol -1)

                if (nDist > nMaxDist) nDist = nMaxDist;

                nCol -= nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_SOUTH_WEST: // Southwest
            {
                // If there are more col's than rows available.
                if ((nCol - 1) > (N_MAX_ROW - nRow))
                {
                    nDist = Random(N_MAX_ROW - nRow) + 1; // 1 to (10 - nRow)
                }
                else
                {
                    nDist = Random(nCol - 1) + 1; // 1 to (nCol - 1)
                }

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow += nDist;
                nCol -= nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_SOUTH: // South
            {
                nDist = Random(N_MAX_ROW - nRow) + 1; // 1 to (10 - nRow).

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow += nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
            case N_SOUTH_EAST: // Southeast
            {
                // If there are more col's than rows available.
                if ((N_MAX_COL - nCol) > (N_MAX_ROW - nRow))
                {
                    nDist = Random(N_MAX_ROW - nRow) + 1; // 1 to (10 - nRow)
                }
                else
                {
                    nDist = Random(N_MAX_COL - nCol) + 1; // 1 to (10 - nCol)
                }

                if (nDist > nMaxDist) nDist = nMaxDist;

                nRow += nDist;
                nCol += nDist;

                break;
            }
            ////////////////////////////////////////////////////////////////////
        } // End switch

        sRow = IntToString(nRow);
        sCol = IntToString(nCol);

        sTag = S_PHYLACTERY_TAG_PRFX + sRow + "_" + sCol;

        // Double check to ensure that the phylactery about to be created
        // doesn't already exist.
        oPhyl = GetObjectByTag(sTag);

        if (oPhyl != OBJECT_INVALID) // About to create a duplicate.
        {
            i--;
            continue; // Redo the entire process.
        }

        DebugMessage("Creating: " + sTag);

        fX = fX1 + ((nCol - 1) * 1.5);                                          // <<<
        fY = fY1 - ((nRow - 1) * 1.5);                                          // <<<

        vPosition = Vector(fX, fY, fZ);
        lCreation = Location(oArea, vPosition, 0.0);

        oPhyl = CreateObject(OBJECT_TYPE_PLACEABLE, S_PHYLACTERY_RESREF,
            lCreation, FALSE, sTag);

        if (oPhyl == OBJECT_INVALID) // Error checking.
        {
            DebugMessage("inc_puz_phlctpth::CreatePuzzle: " + sTag + " created invalid.");
        }
        else
        {
            // Set location variables.
            SetLocalInt(oPhyl, S_LOCAL_ROW_INT, nRow);
            SetLocalInt(oPhyl, S_LOCAL_COL_INT, nCol);
        }
    } // End for

    // Oct 14, 2005: Create the state switch.
    fX = fX1 + 12.0;
    fY = fY1 - 12.0;

    vPosition = Vector(fX, fY, fZ);
    lCreation = Location(oArea, vPosition, 0.0);

    DB_CreateObject(OBJECT_TYPE_PLACEABLE, S_SWITCH_TAG, lCreation);

    // Jan, 2006: Create the hint tome.
    fX = fX1 + 14.0;
    fY = fY1 - 14.0;

    vPosition = Vector(fX, fY, fZ);
    lCreation = Location(oArea, vPosition, 315.0);

    DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lCreation);
}

//::////////////////////////////////////////////////////////////////////////////
//:: TraceLine
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 29, 2005
//::////////////////////////////////////////////////////////////////////////////
object TraceLine(int nStartRow, int nStartCol, int nDirection)
{
    // VARIABLES
    object oFound;
    int nRow, nCol, nDist, nRowInc, nColInc;
    string sRow, sCol, sTag;

    oFound = OBJECT_INVALID;

    // Establish the increment that will be applied to the row and column as
    // the line is searched based on the direction.
    switch (nDirection)
    {
        case N_EAST:
        {
            nColInc = 1;
            nRowInc = 0;

            break;
        }
        case N_NORTH_EAST:
        {
            nColInc = 1;
            nRowInc = -1;

            break;
        }
        case N_NORTH:
        {
            nColInc = 0;
            nRowInc = -1;

            break;
        }
        case N_NORTH_WEST:
        {
            nColInc = -1;
            nRowInc = -1;

            break;
        }
        case N_WEST:
        {
            nColInc = -1;
            nRowInc = 0;

            break;
        }
        case N_SOUTH_WEST:
        {
            nColInc = -1;
            nRowInc = 1;

            break;
        }
        case N_SOUTH:
        {
            nColInc = 0;
            nRowInc = 1;

            break;
        }
        case N_SOUTH_EAST:
        {
            nColInc = 1;
            nRowInc = 1;

            break;
        }
    } // End switch

    nRow = nStartRow;
    nCol = nStartCol;

    nDist = 1;

    do
    {
        // Increment the row and column
        nRow += nRowInc;
        nCol += nColInc;

        // Translate the tag.
        sRow = IntToString(nRow);
        sCol = IntToString(nCol);

        sTag = S_PHYLACTERY_TAG_PRFX + sRow + "_" + sCol;

        // Determine if there is a phylactery at the location via Tag.
        oFound = GetObjectByTag(sTag);

        if (oFound != OBJECT_INVALID)
        {
            break;
        }

        nDist++;
    }
    while (nRow <= N_MAX_ROW && nRow > 0 && nCol <= N_MAX_COL && nCol > 0);

    // If an object has been discovered along the line set the distance between
    // the two objects on the found object for reference.
    if (oFound != OBJECT_INVALID)
    {
        SetLocalInt(oFound, S_LOCAL_DISTANCE_INT, nDist);
    }

    return oFound;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActivatePhylactery
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: August 2, 2005
//::////////////////////////////////////////////////////////////////////////////
void ActivatePhylactery(object oPhylactery)
{
    // Avoid infinite loop of activations.
    if (GetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL))
    {
        return;
    }

    object oPuzzleWP, oTarget;
    int nActive, nTotal;
    float fFacing;

    // Set the local 'source' variable to indicate there is an active phylactery
    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);

    if (!GetLocalInt(oPuzzleWP, S_LOCAL_SOURCE_BOOL))
    {
        SetLocalInt(oPuzzleWP, S_LOCAL_SOURCE_BOOL, TRUE);
        SetLocalObject(oPuzzleWP, S_ORIGIN_PHYLACTERY_OBJ, oPhylactery);
    }

    // Play an activate animation.
    AssignCommand(oPhylactery, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

    // Update the counter of active phylacteries.
    nActive = GetLocalInt(oPuzzleWP, S_ACTIVE_PHYLACTERIES_COUNTER);
    nTotal  = GetLocalInt(oPuzzleWP, S_TOTAL_PHYLACTERIES_COUNTER);

    nActive++;

    // If all the phylacteries are active the puzzle is solved.
    if (nActive == nTotal)
    {
        object oSolver = GetLastUsedBy();
        object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
        DelayCommand(2.0, AssignCommand(oInvis, EndPuzzle(oSolver)));
        return;
    }

    SetLocalInt(oPuzzleWP, S_ACTIVE_PHYLACTERIES_COUNTER, nActive);

    // Set a local variable to indicate activity and start firing 'tracers'.
    SetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL, TRUE);

    FireTracer(oPhylactery);

    oTarget = GetLocalObject(oPhylactery, S_LOCAL_TARGET_OBJ);

    // If a target was established to fire a tracer at the target should now be
    // active as well.
    if (oTarget != OBJECT_INVALID)
    {
        DelayCommand(1.0, ActivatePhylactery(oTarget));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: DeactivatePhylactery
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 2, 2005
//::////////////////////////////////////////////////////////////////////////////
void DeactivatePhylactery(object oPhylactery)
{
    // DEBUG
    DebugMessage("inc_puz_phlctpth::DeactivatePhylactery("
        + GetTag(oPhylactery) + ")");

    object oTarget, oSource, oPuzzleWP;
    int bActive, bSource, nActive;

    bActive = GetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL);

    // If deactivating a phylactery that is currently active
    // Decrement the counter of active phylacteries.
    if (bActive)
    {
        oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
        nActive = GetLocalInt(oPuzzleWP, S_ACTIVE_PHYLACTERIES_COUNTER);

        nActive--;

        SetLocalInt(oPuzzleWP, S_ACTIVE_PHYLACTERIES_COUNTER, nActive);
    }

    // Shut down the phylactery and show the visual animation.
    SetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL, FALSE);
    AssignCommand(oPhylactery, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    oTarget = GetLocalObject(oPhylactery, S_LOCAL_TARGET_OBJ);
    oSource = GetLocalObject(oPhylactery, S_LOCAL_SOURCE_OBJ);
    bActive = GetLocalInt(oTarget, S_LOCAL_ACTIVE_BOOL);

    // If the target is not invalid and active deactivate it.
    if (oTarget != OBJECT_INVALID && bActive)
    {
        oSource = GetLocalObject(oPuzzleWP, S_ORIGIN_PHYLACTERY_OBJ);
        bSource = FALSE;

        // Cycle through the path of phylacteries and ensure that the one about
        // to be deactivated is not a source to the one deactivating it.
        while (oSource != OBJECT_INVALID)
        {
            if (oTarget == oSource)
            {
                bSource = TRUE;
                break;
            }

            // Trace only up to the current phylactery in the path.
            if (oSource == oPhylactery)
            {
                break;
            }

            oSource = GetLocalObject(oSource, S_LOCAL_TARGET_OBJ);
        }

        if (!bSource)
        {
            DeactivatePhylactery(oTarget);
        }
    }

    // Set the stored source and target to invalid.
    SetLocalObject(oPhylactery, S_LOCAL_TARGET_OBJ, OBJECT_INVALID);
    SetLocalObject(oPhylactery, S_LOCAL_SOURCE_OBJ, OBJECT_INVALID);
}

//::////////////////////////////////////////////////////////////////////////////
//:: ResetPhylacteries
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 3, 2005
//::////////////////////////////////////////////////////////////////////////////
void ResetPhylacteries()
{
    // DEBUG
    DebugMessage("inc_puz_phlctpth::ResetPhylacteries()");

    object oPhyl, oPuzzleWP;
    int i, j;
    string sTag;

    // Set the local variable indicating activity amongst the phylacteries.
    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);

    SetLocalInt(oPuzzleWP, S_LOCAL_SOURCE_BOOL, FALSE);

    /*
    oPhyl = GetLocalObject(oPuzzleWP, S_ORIGIN_PHYLACTERY_OBJ);

    while (oPhyl != OBJECT_INVALID)
    {
        DeactivatePhylactery(oPhyl);

        oPhyl = GetLocalObject(oPhyl, S_LOCAL_TARGET_OBJ);
    }
    */

    // Cycle through the 'grid' and deactivate any valid phylacteries.
    for (i = 1; i < 11; ++i)
    {
        for (j = 1; j < 11; ++j)
        {
            sTag = S_PHYLACTERY_TAG_PRFX + IntToString(i) + "_" + IntToString(j);

            oPhyl = GetObjectByTag(sTag);

            if (oPhyl != OBJECT_INVALID)
            {
                DeactivatePhylactery(oPhyl);
            }
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: RotatePhylactery
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 2, 2005
//::////////////////////////////////////////////////////////////////////////////
void RotatePhylactery(object oPhylactery)
{
    int bActive;
    float fFacing;

    // If the phylactery is currently active it should be deactivated before
    // rotating it along with any phylacteries it is sourcing.
    bActive = GetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL);

    DebugMessage("Clearing actions. Point 16.");
    AssignCommand(oPhylactery, ClearAllActions(TRUE));

    /*
    if (bActive)
    {
        DeactivatePhylactery(oPhylactery);
    }
    */

    DeactivatePhylactery(oPhylactery);

    // Increment the current facing by 45 degrees and re-set it.
    fFacing = GetFacing(oPhylactery);

    fFacing += 45.0;

    if (fFacing == 360.0)
    {
        fFacing = 0.0;
    }

    AssignCommand(oPhylactery, PlaySound("as_dr_x2ttu6op"));
    AssignCommand(oPhylactery, SetFacing(fFacing));

    // If the phylactery was active prior to being rotated it should now be
    // re-activated in the new position.
    /*
    if (bActive)
    {
        DelayCommand((F_TRACER_DELAY + 1.0), ActivatePhylactery(oPhylactery));
    }
    */
}

//::////////////////////////////////////////////////////////////////////////////
//:: FireTracer
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 2, 2005
//::////////////////////////////////////////////////////////////////////////////
void FireTracer(object oPhylactery)
{
    if (GetLocalInt(oPhylactery, S_LOCAL_ACTIVE_BOOL) == FALSE)
    {
        return;
    }

    int nRow, nCol;
    float fX, fY, fFacing;
    vector vPos; // Vector for establishing a location in the absence of target.
    location lLoc; // Target location.
    object oTarget, oArea;

    // Determine target location
    lLoc = AcquireTarget(oPhylactery);

    AssignCommand(oPhylactery,
        ActionCastFakeSpellAtLocation(SPELL_FIREBALL, lLoc));

    //DelayCommand(F_TRACER_DELAY, FireTracer(oPhylactery));
}

//::////////////////////////////////////////////////////////////////////////////
//:: AcquireTarget
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 3, 2005
//::////////////////////////////////////////////////////////////////////////////
location AcquireTarget(object oPhylactery)
{
    // VARIABLES
    int nRow, nCol;
    float fFacing, fX, fY;
    vector vPos;
    location lLoc;
    object oTarget, oSource, oArea;

    oArea = GetArea(oPhylactery);
    oSource = GetLocalObject(oPhylactery, S_LOCAL_SOURCE_OBJ);
    vPos = GetPosition(oPhylactery);

    fX = vPos.x;
    fY = vPos.y;

    // Determine the phylactery's facing, adjusted by 180 degrees to make the
    // placeable fire from the front.
    fFacing = GetFacing(oPhylactery);

    fFacing += 180.0;

    if (fFacing >= 360.0)
    {
        fFacing = fFacing - 360.0;
    }

    nRow = GetLocalInt(oPhylactery, S_LOCAL_ROW_INT);
    nCol = GetLocalInt(oPhylactery, S_LOCAL_COL_INT);

    // Check along the phylacteries facing for other phylacteries.
    ////////////////////////////////////////////////////////////////////////////
    if (fFacing == F_EAST) // Facing east.
    {
        oTarget = TraceLine(nRow, nCol, N_EAST);
        fX += 2.0 * (10 - nCol);
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_NORTH_EAST) // Facing north east.
    {
        oTarget = TraceLine(nRow, nCol, N_NORTH_EAST);

        if ((10 - nCol) > (nRow - 1)) // More room to the east than north.
        {
            fX += 2.0 * (nRow - 1);
            fY += 2.0 * (nRow - 1);
        }
        else // More room to the north than east.
        {
            fX += 2.0 * (10 - nCol);
            fY += 2.0 * (10 - nCol);
        }
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_NORTH) // Facing North.
    {
        oTarget = TraceLine(nRow, nCol, N_NORTH);
        fY += 2.0 * (nRow - 1);
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_NORTH_WEST) // Facing North West
    {
        oTarget = TraceLine(nRow, nCol, N_NORTH_WEST);

        if ((nCol - 1) > (nRow - 1)) // More room to the west than north.
        {
            fX -= 2.0 * (nRow - 1);
            fY += 2.0 * (nRow - 1);
        }
        else // More room to the north than west.
        {
            fX -= 2.0 * (nCol - 1);
            fY += 2.0 * (nCol - 1);
        }
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_WEST) // Facing West
    {
        oTarget = TraceLine(nRow, nCol, N_WEST);
        fX -= 2.0 * (nCol - 1);
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_SOUTH_WEST)
    {
        oTarget = TraceLine(nRow, nCol, N_SOUTH_WEST);

        if ((nCol - 1) > (10 - nRow)) // More room to the west than south.
        {
            fX -= 2.0 * (10 - nRow);
            fY -= 2.0 * (10 - nRow);
        }
        else // More room to the south than west.
        {
            fX -= 2.0 * (nCol - 1);
            fY -= 2.0 * (nCol - 1);
        }
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_SOUTH) // Facing South
    {
        oTarget = TraceLine(nRow, nCol, N_SOUTH);
        fY -= 2.0 * (10 - nRow);
    }
    ////////////////////////////////////////////////////////////////////////////
    else if (fFacing == F_SOUTH_EAST) // Facing South East
    {
        oTarget = TraceLine(nRow, nCol, N_SOUTH_EAST);

        if ((10 - nCol) > (10 - nRow)) // More room to the east than south.
        {
            fX += 2.0 * (10 - nRow);
            fY -= 2.0 * (10 - nRow);
        }
        else // More room to the south than east.
        {
            fX += 2.0 * (10 - nCol);
            fX -= 2.0 * (10 - nCol);
        }
    }
    ////////////////////////////////////////////////////////////////////////////

    if (oTarget != OBJECT_INVALID)  // Valid target found.
    {
        vPos = GetPosition(oTarget);

        SetLocalObject(oTarget, S_LOCAL_SOURCE_OBJ, oPhylactery);
    }
    else // Determine a location at the edge of the puzzle grid.
    {
        vPos = Vector(fX, fY, 0.0);
    }

    // Establish return location and store the target object for reference.
    vPos = Vector(vPos.x, vPos.y, 1.0);
    lLoc = Location(oArea, vPos, 0.0);

    SetLocalObject(oPhylactery, S_LOCAL_TARGET_OBJ, oTarget);

    return lLoc;
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 4, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle(object oSolver)
{
    // VARIABLES
    effect eVFX, eDamage;
    object oPhyl, oPuzzleWP, oArea, oPC;
    float fDelay;

    // INITIALIZATIONS
    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
    oArea = GetArea(oPuzzleWP);
    eVFX = EffectVisualEffect(VFX_IMP_FLAME_M);
    eDamage = EffectDamage(1000);
    fDelay = 0.0;

    // Clean up the puzzle waypoint.
    DeleteLocalInt(oPuzzleWP, S_LOCAL_SOURCE_BOOL);
    DeleteLocalObject(oPuzzleWP, S_ORIGIN_PHYLACTERY_OBJ);

    // Loop through all the possible phylacteries and destroy and that are
    // discovered.
    int nRow = 1;
    int nCol = 1;
    string sRow, sCol, sTag;

    DebugMessage("Pre-Loop: nRow = " + IntToString(nRow) + ", nCol = " + IntToString(nCol) + ".");
    DebugMessage("Pre_Loop: N_MAX_ROW = " + IntToString(N_MAX_ROW) + ", N_MAX_COL = " + IntToString(N_MAX_COL) + ".");

    while (nRow <= N_MAX_ROW) // Start with Row 1.
    {
        sRow = IntToString(nRow);

        DebugMessage("while (" + sRow + " <= " + IntToString(N_MAX_ROW) + ")");

        while (nCol <= N_MAX_COL) // Iterate each of the columns in this row.
        {
            sCol = IntToString(nCol);
            DebugMessage("while (" + sCol + " <= " + IntToString(N_MAX_COL) + ")");
            sTag = S_PHYLACTERY_TAG_PRFX + sRow + "_" + sCol;

            DebugMessage("Checking " + sTag);

            oPhyl = DB_GetObjectByTag(sTag);

            if (GetIsObjectValid(oPhyl)) // Valid phylactery discovered.
            {
                DebugMessage("Valid phylactery encountered.");

                SetPlotFlag(oPhyl, FALSE);

                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPhyl);
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPhyl));
            }

            nCol++;
        }

        nRow++;
        nCol = 1;
    }

    // Destroy the state switch and its light.
    object oSwitch = DB_GetObjectByTag(S_SWITCH_TAG);
    object oLight = GetLocalObject(oSwitch, "oLight");

    DestroyObject(oLight);

    SetPlotFlag(oSwitch, FALSE);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oSwitch);
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oSwitch));

    // Set the completion indicator on the dungeon object.
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");
    string sVar = sVarPrfx + B_PUZZLE_COMPLETED;

    // If the puzzle is not already flagged as completed it should reward.
    if (!GetLocalInt(oDungeon, sVar))
    {
        // Award the puzzle's solver some points.
        AwardPuzzleSolvedPoints(oSolver);

        // reward the player for completing the puzzle
        GeneratePuzzleReward(oPuzzleWP, oSolver);
    }

    SetLocalInt(oDungeon, sVar, TRUE);

    // DEBUG
    DebugMessage("");
    DebugMessage("inc_puz_phlctpth::EndPuzzle");
    DebugMessage("Setting " + sVarPrfx + B_PUZZLE_COMPLETED + " TRUE.");
    DebugMessage("");

    // Signal the area with the 'puzzle solved' event.
//    SignalEvent(oArea, EventUserDefined(5000));

    // Delete residual variables on the puzzle waypoint.
    DeleteLocalObject(oPuzzleWP, O_PUZZLE_SOLVER);
    DeleteLocalObject(oPuzzleWP, S_ORIGIN_PHYLACTERY_OBJ);
}
