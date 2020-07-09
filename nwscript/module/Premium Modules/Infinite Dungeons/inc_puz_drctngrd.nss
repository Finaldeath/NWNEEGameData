//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_drctngrd
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the Direction Grid puzzle. This puzzle consists of a
    7x7 grid of arrows. On three sides of the grid there are spheres and the
    other a flaming statue. The spheres will fire a globe of bouncing light that
    will bounce along the arrows, following the directions they point. The
    arrows start in a random state and can be manipulated via changing the
    direction of the row or column by 45 degrees. The objective of the puzzle is
    to organize the arrows in such a way that the bouncing lights hit the
    flaming statue.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 26, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_general"
#include "inc_id1_puzzle"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/

// Blueprint ResRefs
const string S_ARROW_RESREF    = "arrow_plc";
const string S_INTERACT_RESREF = "interact_plc";
const string S_NODE_RESREF     = "node_plc";
const string S_STATUE_RESREF   = "statue_plc";
const string S_SPHERE_RESREF   = "sphere_plc";

const string HINT_PLC_RESREF = "id1_drctngrd_hnt";

// Placeable Tag Prefixes
const string S_ARROW_TAG_PRFX = "arrow_plc_";
const string S_NODE_TAG_PRFX  = "node_plc_";
const string S_SPHERE_TAG_PRFX= "sphere_plc_";

// Placeable Tags
const string S_STATUE_TAG       = "arrow_plc_8_4";
const string S_NORTH_SPHERE_TAG = "sphere_plc_0_4";
const string S_WEST_SPHERE_TAG  = "sphere_plc_4_0";
const string S_EAST_SPHERE_TAG  = "sphere_plc_4_8";

// Area variable name constants.
const string S_PUZZLE_FIRING_BOOL    = "B_PUZZLE_FIRING";
        // True while the puzzle is animating.

// Local variable name constants.
const string S_LOCAL_DIRECTION_FLT = "F_LOCAL_DIRECTION";
const string S_LOCAL_ARROW_OBJ     = "O_LOCAL_ARROW";
const string S_WEST_SPHERE_OBJ     = "O_WEST_SPHERE";
const string S_EAST_SPHERE_OBJ     = "O_EAST_SPHERE";
const string S_NORTH_SPHERE_OBJ_1  = "O_NORTH_SPHERE_1";
const string S_NORTH_SPHERE_OBJ_2  = "O_NORTH_SPHERE_2";
const string S_STATUE_HIT_NUM      = "N_STATUE_HITS";

// Row versus column conditional constants.
const int N_ROW = 0;
const int N_COL = 1;
const int N_SEQUENCE_LIMIT = 30;

/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_drctngrd
//
// This function creates all the placeable elements of the puzzle. An 8x8 grid
// is established with the center 7x7 cells being occupied by arrow placeables
// which are bordered by node placeables. Around the north, east and west sides
// Crystal placeables are created and in the bottom center the Flaming Statue.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();

// Name: Create Arrow
//
// Defined in: inc_puz_drctngrd
//
// Creates an arrow on the interactable placeable, oPlaceable, according to the
// local directional variable, F_LOCAL_DIRECTION, one of the directional
// constants: F_NORTH, F_NORTH_WEST, F_WEST, F_SOUTH_WEST, F_SOUTH,
// F_SOUTH_EAST, F_EAST, or F_NORTH_EAST.
//
// Parameters:
// oPlc - The placeable on which the arrow is to be created.
//
// Return:
// NONE
void CreateArrow(object oPlaceable);

// Name: Rotate Row
//
// Defined in: inc_puz_drctngrd
//
// Rotates the direction of all the arrows in a single row or column.
// Specifically, increments the local directional variable, F_LOCAL_DIRECTION,
// by 45 degrees on each of the interactable placeables in the row or column
// and then calls the CreateArrow function on each of them.
//
// Parameters:
// oInteract - The placeable whose row or column should be rotated.
// nSection - Indication that the row, if the argument is N_ROW, or column, if
//            the argument is N_COL, should be rotated.
//
// Return:
// NONE
void RotateSection(object oInteract, int nSection);

// Name: Activate Spheres
//
// Defined in: inc_puz_drctngrd
//
// This funciton causes the four spheres to fire the globes of bouncing light.
// Using any of the globes causes all three to activate and fire.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActivateSpheres();

// Name: Fire Projectile
//
// Defined in: inc _puz_drctngrd
//
// Causes oLauncher to launch one of the bouncing light projectiles. The
// pojectile is launched at a target based on the launcher's type (Spheres
// always fire straight forward) or the local direction variable (Arrows fire
// in the direction they are pointing. This function also tracks the number of
// times it has been called in order to provide an upper limit on the number
// of times a globe can bounce before disappearing.
//
// Parameters:
// oLauncher - The placeable that will do the launching.
// nSequence - A tracker on the number of times a particular projectile has been
//             fired or the number of projectiles fired in series representing
//             a single bouncing globe.
//
// Return:
// NONE
void FireProjectile(object oLauncher, int nSequence);

// Name: End Puzzle
//
// Defined in: inc_puz_drctngrd
//
// Wraps up the puzzle. Displays some fireworks and disables or destroys all
// placeables that are now obsolete. Fires User Defined Event 5000 on the area.
//
// Parameters:
// NONE
//
// Return:
// NONE
void EndPuzzle();

/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    // LOCAL VARIABLES
    object oPuzzleWP, oArea, oPlaceable;
    vector vPosition; // Position of the next cell in the gird.
    location lCreation; // Location to create the next placeable.
    float fX, fY, fZ, fOrnt; // X and Y coords for location, directional orientation
    int nRow, nCol; // Row and Column for tracking and naming purposes.
    string sResRef, sTag; // Blueprint ResRef/Tag of the placeable to be created

    // LOCAL CONSTANTS
    float fXVar = -8.0; // The variance in the X coordinate of the top right.
    float fYVar = 8.0; // The variance in the Y coordinate of the top right.
    float fInc = 2.0; // The increment space between cells in the grid.

    float fRowLength = 18.0;

    int nSphrCol1 = Random(7) + 1; // Column of the first northern sphere.
    int nSphrCol2 = Random(7) + 1; // Column of the second northern sphere.
    int nSphrRow1 = Random(7) + 1; // Row of the western sphere.
    int nSphrRow2 = Random(7) + 1; // Row of the eastern sphere.

    // Ensure the two northern spheres aren't in the same column.
    if (nSphrCol1 == nSphrCol2)
    {
        nSphrCol1++;

        // Ensure the increment leaves the sphere in a valid location.
        if (nSphrCol1 > 7)
        {
            nSphrCol1 = 1;
        }
    }

    // Establish the area to create the puzzle.
    oPuzzleWP = OBJECT_SELF;
    oArea = GetArea(oPuzzleWP);

    vPosition = GetPosition(oPuzzleWP);

    fX = vPosition.x + fXVar;
    fY = vPosition.y + fYVar;
    fZ = vPosition.z;

    nRow = 0;
    nCol = 0;

    // Create the 9 rows and columns representing the puzzle board.
    while (nRow < 9)
    {
        while (nCol < 9)
        {
            // Establish the ResRef to be used in the placeable creation.
            if (nRow == nSphrRow1 && nCol == 0) // Western sphere.
            {
                sResRef = S_SPHERE_RESREF;
                fOrnt = F_EAST; // Must fire east.
            }
            else if (nRow == nSphrRow2 && nCol == 8) // Eastern sphere.
            {
                sResRef = S_SPHERE_RESREF;
                fOrnt = F_WEST; // Must fire west.
            }
            else if (nRow == 0 && nCol == nSphrCol1 ||
                     nRow == 0 && nCol == nSphrCol2) // Northern spheres.
            {
                sResRef = S_SPHERE_RESREF;
                fOrnt = F_SOUTH; // Must fire south.
            }
            else if (nRow == 8 && nCol == 4) // The Flaming Statue
            {
                sResRef = S_STATUE_RESREF;
                fOrnt += 270.0;
            }
            else if (nRow == 0 || nRow == 8 || nCol == 0 || nCol == 8) // Nodes
            {
                sResRef = S_NODE_RESREF;
            }
            else // Arrow interactables
            {
                sResRef = S_INTERACT_RESREF;
            }

            sTag = S_ARROW_TAG_PRFX + IntToString(nRow) + "_" + IntToString(nCol);

            // Establish location and create the object.
            vPosition = Vector(fX, fY, fZ);
            lCreation = Location(oArea, vPosition, fOrnt);

            oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lCreation, FALSE, sTag);

            if (oPlaceable == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_drctgrd::CreatePuzzle: " + sTag + " INVALID.");
            }
            else
            {
                // If the placeable is an arrow interactable assign it a
                // direction and create an arrow placeable on it.
                if (sResRef == S_INTERACT_RESREF)
                {
                    fOrnt = Random(8) * 45.0;

                    SetLocalFloat(oPlaceable, S_LOCAL_DIRECTION_FLT, fOrnt);
                    CreateArrow(oPlaceable);
                }

                // If the placeable is a sphere deactivate it.
                if (sResRef == S_SPHERE_RESREF)
                {
                    AssignCommand(oPlaceable,
                        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                    SetLocalFloat(oPlaceable, S_LOCAL_DIRECTION_FLT, fOrnt);

                    // Store the spheres on the puzzle waypoint for later use.
                    if (fOrnt == F_EAST) // The western sphere.
                    {
                        SetLocalObject(oPuzzleWP, S_WEST_SPHERE_OBJ, oPlaceable);
                    }
                    else if (fOrnt == F_WEST) // The eastern sphere.
                    {
                        SetLocalObject(oPuzzleWP, S_EAST_SPHERE_OBJ, oPlaceable);
                    }
                    else if (fOrnt == F_SOUTH) // A northern sphere.
                    {
                        // If the first northern sphere.
                        if (GetLocalObject(oPuzzleWP, S_NORTH_SPHERE_OBJ_1) == OBJECT_INVALID)
                        {
                            SetLocalObject(oPuzzleWP, S_NORTH_SPHERE_OBJ_1, oPlaceable);
                        }
                        else // Else the second northern sphere.
                        {
                            SetLocalObject(oPuzzleWP, S_NORTH_SPHERE_OBJ_2, oPlaceable);
                        }
                    }
                } // if (sResRef == S_SPHERE_RESREF)
            }

            // In the upper right corner create the hint tome.
            if (nRow == 0 && nCol == 8)
            {
                fOrnt = 45.0;
                lCreation = Location(oArea, vPosition, fOrnt);

                DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lCreation);
            }

            // Increment the column and X value.
            nCol++;
            fX += fInc;

            fOrnt = 0.0;
        }

        // Increment the row and Y value.
        nRow++;
        fY -= fInc;

        // Reset the column and X value for the next row.
        nCol = 0;
        fX -= fRowLength;
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateArrow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateArrow(object oPlaceable)
{
    // LOCAL VARIABLES
    object oArrow, oArea; // Arrow to be created in area oArea.
    vector vPosition; // Position of the interactable placeable.
    location lCreation; // Location for the arrow to be created.
    float fOrientation; // Arrow's direction.

    // Destroy the old arrow, if there was one.
    oArrow = GetLocalObject(oPlaceable, S_LOCAL_ARROW_OBJ);

    if (oArrow != OBJECT_INVALID)
    {
        DestroyObject(oArrow);
    }

    // Establish the location to create the arrow.
    oArea = GetArea(oPlaceable);
    vPosition = GetPosition(oPlaceable);
    fOrientation = GetLocalFloat(oPlaceable, S_LOCAL_DIRECTION_FLT);
    lCreation = Location(oArea, vPosition, fOrientation);

    // Create the arrow.
    oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, S_ARROW_RESREF, lCreation);

    // Error Checking.
    if (oArrow == OBJECT_INVALID)
    {
        DebugMessage("inc_puz_drctgrd::CreateArrow: Arrow INVALID.");
    }
    else
    {
        // Set the arrow as a local object on the placeable.
        SetLocalObject(oPlaceable, S_LOCAL_ARROW_OBJ, oArrow);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: RotateRow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void RotateSection(object oInteract, int nSection)
{
    // LOCAL VARIABLES
    object oArrow; // Placeables representing the arrows.
    string sRow, sCol, sTag;
    float fDirection;
    int i;

    sTag = GetTag(oInteract);

    DebugMessage(sTag);

    // Based on oInteract's tag determine its row and column.
    sRow = GetSubString(sTag, 10, 1);
    sCol = GetSubString(sTag, 12, 1);

    DebugMessage(sRow + "," + sCol);

    // Iterate the placeables in the row and change the local directions
    for(i = 1; i < 8; ++i)
    {
        if (nSection == N_ROW)
        {
            sCol = IntToString(i);
        }
        else if (nSection == N_COL)
        {
            sRow = IntToString(i);
        }
        else
        {
            DebugMessage("inc_puz_drctngrd::RotateRow: invalid nSection argument.");
        }

        sTag = S_ARROW_TAG_PRFX + sRow + "_" + sCol;

        oArrow = GetObjectByTag(sTag);

        if (oArrow == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_drctngrd::RotateRow: " + sTag + " INVALID.");
        }
        else
        {
            // Get the current direction and increment it by 45 degrees.
            fDirection = GetLocalFloat(oArrow, S_LOCAL_DIRECTION_FLT);

            fDirection += 45.0;

            if (fDirection == 360.0)
            {
                fDirection = 0.0;
            }

            SetLocalFloat(oArrow, S_LOCAL_DIRECTION_FLT, fDirection);

            // Re-create the arrow.
            CreateArrow(oArrow);
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActivateSpheres
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void ActivateSpheres()
{
    object oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);
    object oArea = GetArea(oPuzzleWP);
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");

    // If the puzzle is already in the animating state return.
    if (GetLocalInt(oPuzzleWP, S_PUZZLE_FIRING_BOOL))
    {
        SpeakString("The spheres have been fired too recently, you must give "
            + "them some time to recharge.");
        return;
    }

    // If the puzzle has been completed.                                         // TBD
    if (GetLocalInt(oDungeon, sVarPrfx + B_PUZZLE_COMPLETED))
    {
        SpeakString("The spheres seem to have gone dormant.");
        return;
    }

    // Set a local variable to indicate the animation is in progress.
    SetLocalInt(oPuzzleWP, S_PUZZLE_FIRING_BOOL, TRUE);

    // Retreive the four spheres stored on the puzzle creation waypoint.
    object oSphere1 = GetLocalObject(oPuzzleWP, S_WEST_SPHERE_OBJ);
    object oSphere2 = GetLocalObject(oPuzzleWP, S_EAST_SPHERE_OBJ);
    object oSphere3 = GetLocalObject(oPuzzleWP, S_NORTH_SPHERE_OBJ_1);
    object oSphere4 = GetLocalObject(oPuzzleWP, S_NORTH_SPHERE_OBJ_2);

    // Debug information.
    if (!GetIsObjectValid(oSphere1))
    {
        DebugMessage("inc_puz_drctngrd::ActivateSpheres() Sphere 1 invalid.");
    }

    if (!GetIsObjectValid(oSphere2))
    {
        DebugMessage("inc_puz_drctngrd::ActivateSpheres() Sphere 2 invalid.");
    }

    if (!GetIsObjectValid(oSphere3))
    {
        DebugMessage("inc_puz_drctngrd::ActivateSpheres() Sphere 3 invalid.");
    }

    if (!GetIsObjectValid(oSphere4))
    {
        DebugMessage("inc_puz_drctngrd::ActivateSpheres() Sphere 4 invalid.");
    }

    // Make the three spheres play an activation animation then fire a projectil
    AssignCommand(oSphere1, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oSphere2, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oSphere3, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oSphere4, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

    DelayCommand(2.0, FireProjectile(oSphere1, 0));
    DelayCommand(2.0, FireProjectile(oSphere2, 0));
    DelayCommand(2.0, FireProjectile(oSphere3, 0));
    DelayCommand(2.0, FireProjectile(oSphere4, 0));

    DelayCommand(3.0,
        AssignCommand(oSphere1,
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));

    DelayCommand(3.0,
        AssignCommand(oSphere2,
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));

    DelayCommand(3.0,
        AssignCommand(oSphere3,
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));

    DelayCommand(3.0,
        AssignCommand(oSphere4,
            ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)));

    DelayCommand(20.0, SetLocalInt(oPuzzleWP, S_PUZZLE_FIRING_BOOL, FALSE));
    DelayCommand(20.0, SetLocalInt(oPuzzleWP, S_STATUE_HIT_NUM, 0));
}

//::////////////////////////////////////////////////////////////////////////////
//:: FireProjectile
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void FireProjectile(object oLauncher, int nSequence)
{
    if (nSequence == N_SEQUENCE_LIMIT) return;

    float fDirection, fDelay;
    int nHits, nRow, nCol;
    object oTarget, oPuzzleWP;
    string sTag, sRow, sCol;
    effect eVFX;

    oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);

    sTag = GetTag(oLauncher);
    fDirection = GetLocalFloat(oLauncher, S_LOCAL_DIRECTION_FLT);

    // Establish the row and column of the launcher from the tag.
    sRow = GetSubString(sTag, 10, 1);
    sCol = GetSubString(sTag, 12, 1);

    nRow = StringToInt(sRow);
    nCol = StringToInt(sCol);

    // The statue should increment the number of time it has been 'hit'.
    if (nRow == 8 && nCol == 4)
    {
        // Apply a visual effect for feedback.
        eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oLauncher);

        nHits = GetLocalInt(oPuzzleWP, S_STATUE_HIT_NUM);

        nHits++;

        if (nHits == 4) // All four globes have hit the statue.
        {
            object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
            AssignCommand(oInvis, EndPuzzle());

            return;
        }

        SetLocalInt(oPuzzleWP, S_STATUE_HIT_NUM, nHits);
    }

    // end nodes around the edge of the puzzle should not fire.
    if (nRow == 0 || nCol == 0 || nRow == 8 || nCol == 8)
    {
        if (nSequence > 0) return;
    }

    // Establish the next target based on the firing direction and row/column
    if (fDirection == F_NORTH) // Firing north; up one row.
    {
        nRow--;
    }
    else if (fDirection == F_NORTH_WEST) // Firing north-west; row -1, col -1.
    {
        nRow--;
        nCol--;
    }
    else if (fDirection == F_WEST) // Firing west; col - 1.
    {
        nCol--;
    }
    else if (fDirection == F_SOUTH_WEST) // Firing south-west; row + 1, col -1.
    {
        nRow++;
        nCol--;
    }
    else if (fDirection == F_SOUTH) // Firing south; down one row.
    {
        nRow++;
    }
    else if (fDirection == F_SOUTH_EAST) // Firing south-east; row + 1, col +1.
    {
        nRow++;
        nCol++;
    }
    else if (fDirection == F_EAST) // Firing East; one column left.
    {
        nCol++;
    }
    else if (fDirection == F_NORTH_EAST) // Firing north-east; row -1, col + 1.
    {
        nRow--;
        nCol++;
    }

    sTag = S_ARROW_TAG_PRFX + IntToString(nRow) + "_" + IntToString(nCol);

    DebugMessage("inc_puz_drctngrd::FireProjectile() Target is " + sTag);

    oTarget = GetObjectByTag(sTag);

    nSequence += 1;

    // If a valid target is acquired fire away.
    if (oTarget != OBJECT_INVALID)
    {
        // 0.215
        fDelay = (GetDistanceBetween(oTarget, oLauncher) * 0.089) + 0.415;
        DelayCommand(fDelay, FireProjectile(oTarget, nSequence));

        AssignCommand(oLauncher,
                ActionCastFakeSpellAtLocation(SPELL_SCINTILLATING_SPHERE,
                    GetLocation(oTarget), PROJECTILE_PATH_TYPE_BALLISTIC));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle()
{
    // Debug feedback.
    DebugMessage("Puzzle Completed.");

    // Variables
    object oStatue, oArea, oArrow, oPuzzleWP, oPC;
    effect eVFX, eDMG;
    location lLoc;
    int i,j;
    string sRow, sCol, sTag;

    // Initializatons
    oStatue = GetObjectByTag(S_STATUE_TAG);
    oArea = GetArea(oStatue);
    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
    eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);
    eDMG = EffectDamage(1000);
    lLoc = GetLocation(oStatue);

    SetPlotFlag(oStatue, FALSE);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oStatue));

    for (i = 1; i < 8; ++i)
    {
        sRow = IntToString(i);

        for (j = 1; j < 8; ++j)
        {
            sCol = IntToString(j);

            sTag = S_ARROW_TAG_PRFX + sRow + "_" + sCol;

            oArrow = GetObjectByTag(sTag);

            if (oArrow == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_drctngrd::EndPuzzle: Arrow " + sTag + " invalid.");
                continue;
            }

            DestroyObject(oArrow);
        }
    }

    // The puzzle's solver, for future rewards.
    oPC = GetLocalObject(oPuzzleWP, O_PUZZLE_SOLVER);

    // Signal the 'puzzle solved' event on the area.
//    SignalEvent(oArea, EventUserDefined(5000));

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
    DebugMessage("inc_puz_drctngrd::EndPuzzle");
    DebugMessage("Setting " + sVarPrfx + B_PUZZLE_COMPLETED + " TRUE.");
    DebugMessage("");

    // Delete all variables stored on the puzzle waypoint.
    DeleteLocalObject(oPuzzleWP, O_PUZZLE_SOLVER);
    DeleteLocalInt(oPuzzleWP, S_PUZZLE_FIRING_BOOL);
    DeleteLocalInt(oPuzzleWP, S_STATUE_HIT_NUM);
}
