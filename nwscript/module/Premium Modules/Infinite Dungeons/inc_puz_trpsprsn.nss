//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_trpsprsn
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Master include file for the 'Trip's Prison' puzzle. This puzzle consists of
    a ring of 16 pedestals topped with crystal balls and an inner circle of 8
    braziers all of which must be manipulated through 3 states. Firstly ringing
    a gong will highlight a variable number of random braziers which must be lit
    in order to advance the puzzle state. A variable number of braziers start
    lit and using any of the braziers cycles the states of all the braziers,
    that is they all move their current state the next brazier and take their
    new state from the previous. Completing this summons an imp who carries
    some colored gems. A variable number of pedestals start in a lit state and
    all must be lit by placing gems in the crystals. Different colored gems
    have different effects, purple ones, for example, alter the state of the
    pedestal directly opposite the crystal they are placed in and green alter
    the state of the pedestal directly opposite and at a right angle from the
    line between the crystal and the pedestal directly opposite. Once all the
    pillars are made active the braziers must be re-solved and the gong rung
    once more to complete the entire puzzle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 08, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_general"
#include "inc_id1_puzzle"

// DEBUG
// void main() {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/

// Placeable ResRef constants
const string S_PEDESTAL_RESREF  = "pedastel_plc";
const string S_CRYSTAL_RESREF   = "crystal_plc";
const string S_BRAZIER_RESREF   = "brazier_plc";
const string S_SWITCH_RESREF    = "switch_plc";
const string S_GONG_RESREF      = "gong_plc";
const string S_GEM_RESREF       = "gem_it";
const string S_INVIS_OBJ_RESREF = "invisobj_plc";
const string S_IMP_RESREF       = "puz_imp";
const string S_LIGHT_RESREF     = "whitesol_plc";

const string HINT_PLC_RESREF = "id1_trpsprsn_hnt";

// Placeable Tag prefix constants
const string S_PEDESTAL_TAG_PRFX = "pedestal_plc_";
const string S_CRYSTAL_TAG_PRFX = "crystal_plc_";
const string S_BRAZIER_TAG_PRFX = "brazier_plc_";
const string S_BRAZIER_TAG = "brazier_plc";
const string S_GONG_TAG = "gong_plc";

// Variable name constants.
const string S_STATE_INT    = "nState";
const string S_CRYSTAL_NUM  = "nCrystal";
const string S_RAND_BOOL    = "bRandomized"; // TRUE if the placeable has been randomized.
const string S_TARGET_BOOL  = "bTarget"; // TRUE on placeables that must be activated.
const string S_SUMMONED_BOOL= "bSummoned"; // TRUE if the Imp has already been summoned.
const string S_COMPLETE_BOOL= "bComplete"; // TRUE if the puzzle is warpping up.
const string S_LIGHT_OBJ    = "oLight";

// Placeable circle radius.
const float F_PEDESTAL_CRICLE_RADIUS = 8.0;
const float F_BRAZIER_CIRCLE_RADIUS  = 5.0;

// Number of placeable in the circle.
const int N_CIRCLE_PEDESTALS = 16;
const int N_CIRCLE_BRAZIERS  = 8;

// State constants.
const int N_ACTIVE_STATE  = 1;
const int N_DORMANT_STATE = 0;

/*------------------------------------------------------------------------------
    FUNCTION TEMPLATES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_trpsprsn
//
// Creates all the placeable objects involved in the puzzle. This consists of a
// ring of 16 pedestals topped with Sonance Crystals surrounding a ring of 8
// braziers.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();

// Name: Randomize Crystal Puzzle
//
// Defined in: inc_puz_trpsprsn
//
// This function randomly generates a number of crystals that must be activated
// in order for the puzzle to be solved. Random crystals, to the order of the
// previously generated random number, are then chosen and flagged as 'target'
// crystals.
//
// Parameters:
// NONE
//
// Return:
// NONE
void RandomizeCrystalPuzzle();

// Name: Randomize Brazier Puzzle
//
// Defined in: inc_puz_trpsprsn
//
// This function generates the goal state and initial state for the Brazier
// placeables. A random number of Braziers are selected to be 'Target' Braziers
// and an equal number of Braziers are randomly choosen to be activated.
//
// Parameters:
// NONE
//
// Return:
// NONE
void RandomizeBrazierPuzzle();

// Name: Check Pedestal State
//
// Defined in: inc_puz_trpsprsn
//
// Checks the state of all 16 placeable objects involved in the puzzle for the
// N_STATE_ACTIVE state. If any of the 16 placeables which have the target
// variable set does not have this variable set the function will return FALSE.
// This funciton also highlights all the target placeables.
//
// Parameters:
// NONE
//
// Return:
// TRUE if all the proper placeables are active.
// FALSE otherwise.
int CheckPedestalState();

// Name: Check Brazier State
//
// Defined in: inc_puz_trpsprsn
//
// Checks the state of the 8 braziers involved in the puzzles. If any brazier
// that is flagged as a target (by having the nTarget local variable set as
// true) but is not active (local variable nState is not N_STATE_ACTIVE) the
// function will return FALSE. This function also highlights all the target
// placeables.
//
// Parameters:
// NONE
//
// Return:
// TRUE If the brazier placeables are all of the correct state.
// FALSE otherwise.
int CheckBrazierState();

// Name: Toggle State
//
// Defined in: inc_puz_trpsprsn
//
// Toggles the state of oPedestal. If the pedestal was active it will be
// deactivated and vice versa.
//
// Parameters:
// oPedestal - The pedestal placeables whose state is to be reversed.
//
// Return:
// NONE
void ToggleState(object oPedestal);

// Name: Add Glow
//
// Defined in: inc_puz_trpsprsn
//
// Creates a white shaft of light placeable at the same location as oPedestal in
// order to represent an active state.
//
// Parameters:
// oPedestal - The pedestal placeable to be activated.
//
// Return:
// NONE
void AddGlow(object oPedestal);

// Name: Remove Glow
//
// Defined in: inc_puz_trpsprsn
//
// Removes the white shaft of light placeable associated with oPedestal.
//
// Parameters:
// oPedestal - The pedestal placeable that is having its 'glow' removed.
//
// Return:
// NONE
void RemoveGlow(object oPedestal);

// Name: Place Gem
//
// Defined in: inc_puz_trsprsn
//
// Function to handle the placing of a gem. Determines and applies the
// consequences of placing oGem in oCrystal. Generally this will toggle the
// state of a number of pedestals, based on oGem, associated with oCrystal and
// the function can therefore be used when a gem is either removed or added
// to oCrystal's inventory.
//
// Parameters:
// oCrystal - The sonance crystal placeable into which the gem is being place.
// oGem - The ressonance gem item being added or removed.
//
// Return:
// NONE
void PlaceGem(object oCrystal, object oGem);

// Name: Rotate Braziers
//
// Defined in: inc_puz_trpsprsn
//
// Rotates the states of the Braziers all once to the left. This means an
// inactive brazier with an active brazier to its right will now become active
// and the formerly active brazier will take on the state of the brazier to its
// right.
//
// Parameters:
// NONE
//
// Return:
// NONE
void RotateBraziers();

// Name: Swap Braziers
//
// Defined in: inc_puz_trpsprsn
//
// This function swaps the state of the Brazier closest to the 'switch' Brazier
// with the state of the 'switch' Brazier itself.
//
// Parameters:
// NONE
//
// Return:
// NONE
void SwapBraziers();

// Name: Deactivate Pedetals.
//
// Defined in: inc_puz_trpsprsn
//
// Zeros all the nTarget variables on the pedestal placeables. This is done in
// order to re-randomize the puzzle from a fresh state.
//
// Parameters:
// bDelete - If this is set to TRUE local variabels will be deleted as part of
//           the puzzle wrap-up.
//
//
// Return:
//
void DeactivatePedestals(int bDelete = FALSE);

// Name: Deactivate Braziers
//
// Defined in: inc_puz_trpsprsn
//
// Deactivates all the Brazier placeables involved in the puzzle. This amounts
// to zeroing the nTarget and nState variables.
//
// Parameters:
// bDelete - If this is set to TRUE local variabels will be deleted as part of
//           the puzzle wrap-up.
//
// Return:
// NONE
void DeactivateBraziers(int bDelete = FALSE);

// Name: Destroy Gems
//
// Defined in: inc_puz_trpsprsn
//
// Destroys all the gems with the tag gem_it, or those gems involved in the
// 'Trip's Prison' puzzle, in the possession of oCarrier.
//
// Parameters:
// oCarrier - The creature or placeable who should have all their gems destroyed.
//
// Return:
// NONE
void DestroyGems(object oCarrier);

// Name: inc_puz_trpsprsn
//
// Defined in: inc_puz_trpsprsn
//
// This function Wraps up the puzzle by deleting all the variables involved
// displaying some 'you win' type feedback and singalling user degined event
// 5000 on the area.
//
// Parameters:
// object oSolver - The player who has solved the puzzle.
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
//:: Created On: Aug 08, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    //
    DebugMessage("inc_puz_trpsprsn::CreatePuzzle()");
    //

    object oPuzzleWP, oArea, oPedestal, oCrystal, oBrazier, oGong, oInvis;
    vector vPos; // Position to establish location of next placeable.
    location lLoc; // Location to create next placeable.
    float fX1, fY1, fZ1; // X, Y and Z reference from the creation waypoint.
    float fX, fY, fZ, fFcng; // Establish for the next point to create.
    int i; // Loop invariant.
    string sTag, sResref;

    oPuzzleWP = OBJECT_SELF;

    // Check the puzzle waypoint to ensure it's valid.
    if (oPuzzleWP == OBJECT_INVALID)
    {
        DebugMessage("Could not establish valid creation waypoint.");
        return;
    }

    oArea = GetArea(oPuzzleWP);

    vPos = GetPosition(oPuzzleWP);

    fX1 = vPos.x;
    fY1 = vPos.y;
    fZ1 = vPos.z;

    fFcng = -22.5;
    fZ = fZ1;

    // Create the pedestals with the crystals atop.
    for (i = 0; i < N_CIRCLE_PEDESTALS; ++i)
    {
        // Increment the facing so that all placeables face towards the center.
        fFcng += 22.5;

        // Establish X and Y coordinates for the next creation point.
        fX = fX1 + GetNextCircleX(F_PEDESTAL_CRICLE_RADIUS, i, N_CIRCLE_PEDESTALS);
        fY = fY1 + GetNextCircleY(F_PEDESTAL_CRICLE_RADIUS, i, N_CIRCLE_PEDESTALS);

        // Create a vector from X and Y coords and a location from the vector.
        vPos = Vector(fX, fY, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        // Establish tag and ResRef for pedestal and create.
        sTag = S_PEDESTAL_TAG_PRFX + IntToString(i);

        oPedestal = CreateObject(OBJECT_TYPE_PLACEABLE, S_PEDESTAL_RESREF, lLoc, FALSE, sTag);

        // Ensure the pedestal's validity
        if (oPedestal == OBJECT_INVALID)
        {
            DebugMessage(sTag + " INVALID at creation.");
        }

        // Establish a position for the crystal directly above the pedestal to
        // give the appearance that it is resting on top.
        vPos = Vector(fX, fY, fZ + 1.4);
        lLoc = Location(oArea, vPos, fFcng);

        // Establish tag and ResRef for crystal and create.
        sTag = S_CRYSTAL_TAG_PRFX + IntToString(i);

        oCrystal = CreateObject(OBJECT_TYPE_PLACEABLE, S_CRYSTAL_RESREF, lLoc, FALSE, sTag);

        // Ensure the crystal's validity.
        if (oCrystal == OBJECT_INVALID)
        {
            DebugMessage(sTag + " INVALID at creation.");
        }
        else
        {
            SetLocalInt(oCrystal, S_CRYSTAL_NUM, i);
            AssignCommand(oCrystal, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        }
    } // end for.

    fFcng = 0.0;

    // Create the braziers.
    for (i = 0; i < N_CIRCLE_BRAZIERS; ++i)
    {
        // Increment the facing to face all placeables towards the center.
        fFcng += 45.0;

        // Establish X and Y coordinates for the next creation point.
        fX = fX1 + GetNextCircleX(F_BRAZIER_CIRCLE_RADIUS, i, N_CIRCLE_BRAZIERS);
        fY = fY1 + GetNextCircleY(F_BRAZIER_CIRCLE_RADIUS, i, N_CIRCLE_BRAZIERS);

        // Create a vector from X and Y coords and a location from the vector.
        vPos = Vector(fX, fY, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        // Establish the tag and ResRef for the brazier and create it.
        sTag = S_BRAZIER_TAG_PRFX + IntToString(i);

        oBrazier = CreateObject(OBJECT_TYPE_PLACEABLE, S_BRAZIER_RESREF, lLoc, FALSE, sTag);

        // Ensure the brazier's validity
        if (oBrazier == OBJECT_INVALID)
        {
            DebugMessage(sTag + " INVALID at creation.");
        }
    }

    // Create the gong placeable.
    fFcng = 0.0;
    fX = fX1 + 4.0;
    fY = fY1;
    vPos = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vPos, fFcng);

    oGong = CreateObject(OBJECT_TYPE_PLACEABLE, S_GONG_RESREF, lLoc);

    if (oGong == OBJECT_INVALID)
    {
        DebugMessage(S_GONG_RESREF + " INVALID at creation.");
    }

    // Create the hint tome.
    fFcng = 180.0;
    fX = fX1 - 4.0;
    fY = fY1;
    vPos = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vPos, fFcng);

    DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lLoc);

    // Create the extra, 'switch-out' brazier placeable.
    fX = fX1 - 6.5;
    vPos = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vPos, fFcng);

    oBrazier = CreateObject(OBJECT_TYPE_PLACEABLE, S_SWITCH_RESREF, lLoc);

    if (oBrazier == OBJECT_INVALID)
    {
        DebugMessage(S_BRAZIER_RESREF + " INVALID at creation.");
    }

    // Create an invisible object to store the gems for solving the puzzle.
    lLoc = GetLocation(oPuzzleWP);

    oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, S_INVIS_OBJ_RESREF, lLoc);

    if (oInvis == OBJECT_INVALID)
    {
        DebugMessage(S_INVIS_OBJ_RESREF + " INVALID at creation.");
    }

    // Randomize the state of the outer circle of Crystals.
    RandomizeCrystalPuzzle();

    // Randomize the state of the inner circle of Braziers.
    RandomizeBrazierPuzzle();
}

//::////////////////////////////////////////////////////////////////////////////
//:: RandomizeCrystalPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 09, 2005
//::////////////////////////////////////////////////////////////////////////////
void RandomizeCrystalPuzzle()
{
    // DEBUG
    DebugMessage("inc_puz_trpsprsn::RandomizeCrystalPuzzle()");
    //

    object oPlc, oGem, oStore;
    effect eVFX;
    int i, j, bRand, nGems, nRand;
    string sTag;

    nGems = Random(8) + 6; // 6 - 14 Crsytals must be active.
    oStore = GetObjectByTag(S_INVIS_OBJ_RESREF);
    eVFX = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);

    if (oStore == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retreived: " + S_INVIS_OBJ_RESREF);
    }

    // For each of the gems necessary to solve the puzzle determine a random
    // target pedestal.
    for (i = 0; i < nGems; ++i)
    {
        // Gerenate a random pedestal.
        nRand = Random(16) + 1;
        bRand = TRUE;

        // While the pedestal selected has already been set as a target explore
        // the pedestals incrementally until an un-targetted pedestal is
        // established.
        while (bRand)
        {
            sTag = S_PEDESTAL_TAG_PRFX + IntToString(nRand);
            oPlc = GetObjectByTag(sTag);

            if (oPlc == OBJECT_INVALID)
            {
                DebugMessage("INVALID object retrieved: " + sTag);
            }
            else
            {
                bRand = GetLocalInt(oPlc, S_TARGET_BOOL);
            }

            // Increment the pedestal being evaluated.
            nRand++;

            // Handle overflow.
            if (nRand > 15)
            {
                nRand = 0;
            }

        } // End while

        // Set the target variable on the placeable, now that it is determined
        // to be one that has not already been targetted.
        SetLocalInt(oPlc, S_TARGET_BOOL, TRUE);

        // Apply a temporary visual effect to show the player what needs to be done.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPlc, 5.0);

        oGem = CreateItemOnObject(S_GEM_RESREF, oStore);

        if (oGem == OBJECT_INVALID)
        {
            DebugMessage("# # # # # " + S_GEM_RESREF + " INVALID at creation.");
        }
    } // End for
}

//::////////////////////////////////////////////////////////////////////////////
//:: RandomizeBrazierPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 10, 2005
//::////////////////////////////////////////////////////////////////////////////
void RandomizeBrazierPuzzle()
{
    object oBrazier;
    int i, nState, nTargets, nRand, bTarget;
    string sTag;

    // Up to 3/4 of the braziers could be targets and at least 1/4 should be.
    // nTargets = Random(N_CIRCLE_BRAZIERS/2) + N_CIRCLE_BRAZIERS/4;
    // Hard code the math for now.
    nTargets = Random(4) + 2;

    DebugMessage("nTargets: " + IntToString(nTargets));

    // Iterate nTarget times selecting random target Braziers.
    // If a selected Brazier is already a target try the next in sequence until
    // on is found.
    for (i = 0; i < nTargets; ++i)
    {
        nRand = Random(8);
        bTarget = TRUE;

        // While the randomly selected Brazier is already a target.
        while (bTarget == TRUE)
        {
            // Determine the Brazier
            sTag = S_BRAZIER_TAG_PRFX + IntToString(nRand);
            oBrazier = GetObjectByTag(sTag);

            if (oBrazier == OBJECT_INVALID)
            {
                DebugMessage("INVALID object retrieved: " + sTag);
            }

            // Determine if it is already set as a target.
            bTarget = GetLocalInt(oBrazier, S_TARGET_BOOL);

            // Increment the focused Brazier.
            nRand++;

            // Handle overflow.
            if (nRand > 7)
            {
                nRand = 0;
            }
        } // End while

        // Now that a non-target Brazier is established set it as a target.
        SetLocalInt(oBrazier, S_TARGET_BOOL, TRUE);
    } // End for

    // Iterate nTarget times once again selecting random Braziers to be active.
    for (i = 0; i < nTargets; ++i)
    {
        nState = N_ACTIVE_STATE;
        // Ensure an already active Brazier is not being activated.
        while (nState == N_ACTIVE_STATE)
        {
            // Determine Brazier.
            sTag = S_BRAZIER_TAG_PRFX + IntToString(nRand);
            oBrazier = GetObjectByTag(sTag);

            if (oBrazier == OBJECT_INVALID)
            {
                DebugMessage("INVALID object retrieved: " + sTag);
            }

            nState = GetLocalInt(oBrazier, S_STATE_INT);

            // Increment the focused Brazier.
            nRand++;

            // Handle overflow.
            if (nRand > 7)
            {
                nRand = 0;
            }
        } // End while

        // Now that a non-active Brazier is established activate it.
        SetLocalInt(oBrazier, S_STATE_INT, N_ACTIVE_STATE);

        AssignCommand(oBrazier, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    } // End for
}

//::////////////////////////////////////////////////////////////////////////////
//:: CheckPedestalState
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 09, 2005
//::////////////////////////////////////////////////////////////////////////////
int CheckPedestalState()
{
    object oPlc; // Placeeable to be checked.
    effect eVFX;
    string sTag;
    int i, bState, bTarget, bComplete;

    eVFX = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    bComplete = TRUE;

    // Cycle the placeables updating bState to be the local state variable.
    for (i = 0; i < N_CIRCLE_PEDESTALS; i++)
    {
        sTag = S_PEDESTAL_TAG_PRFX + IntToString(i);
        oPlc = GetObjectByTag(sTag);

        // If the placeable is invalid for some reason do not retrieve the state
        if (oPlc == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retreived: " + sTag);
        }
        else
        {
            bState = GetLocalInt(oPlc, S_STATE_INT);
            bTarget = GetLocalInt(oPlc, S_TARGET_BOOL);

            // If the pedestal is a target
            if (bTarget)
            {
                // Should have been active since it was a target.
                if (bState == N_DORMANT_STATE)
                {
                    bComplete = FALSE;
                }

                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPlc, 5.0);
            }
            else
            {
                // Not a target and therefore should not have been active.
                if (bState == N_ACTIVE_STATE)
                {
                    bComplete = FALSE;
                }
            }
        }
    }

    // Return the completed boolean; will have been updated to FALSE if unsolved
    return bComplete;
}


//::////////////////////////////////////////////////////////////////////////////
//:: CheckBrazierState
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////
int CheckBrazierState()
{
    object oBrazier;
    effect eVFX;
    string sTag;
    int i, bComplete;

    eVFX = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    bComplete = TRUE;

    // Loop through all the braziers.
    for (i = 0; i < N_CIRCLE_BRAZIERS; ++i)
    {
        // Next Brazier in sequence.
        sTag = S_BRAZIER_TAG_PRFX + IntToString(i);
        oBrazier = GetObjectByTag(sTag);

        // Ensure the brazier's validity.
        if (oBrazier == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retrieved: " + sTag);
        }

        // If the brazier is flagged as a target.
        if (GetLocalInt(oBrazier, S_TARGET_BOOL))
        {
            if (GetLocalInt(oBrazier, S_STATE_INT) != N_ACTIVE_STATE)
            {
                bComplete = FALSE;
            }

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oBrazier, 5.0);
        }
    }

    return bComplete;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ToggleState
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 09, 2005
//::////////////////////////////////////////////////////////////////////////////
void ToggleState(object oPedestal)
{
    int nState;
    effect eVFX;

    nState = GetLocalInt(oPedestal, S_STATE_INT);

    if (nState == N_ACTIVE_STATE) // The pedestal is currently active.
    {
        RemoveGlow(oPedestal);
    }
    else // The pedestal is currently dormant.
    {
        AddGlow(oPedestal);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: AddGlow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////
void AddGlow(object oPedestal)
{
    object oLight;
    location lLoc;

    oLight = GetLocalObject(oPedestal, S_LIGHT_OBJ);

    // If there is already a light associated with this pedestal don't create another.
    //if (oLight != OBJECT_INVALID)
    //{
        //return;
    //}

    lLoc = GetLocation(oPedestal);
    oLight = CreateObject(OBJECT_TYPE_PLACEABLE, S_LIGHT_RESREF, lLoc);

    if (oLight == OBJECT_INVALID)
    {
        DebugMessage(S_LIGHT_RESREF + " INVALID at creation.");
    }
    else
    {
        SetLocalObject(oPedestal, S_LIGHT_OBJ, oLight);
    }

    // Flag the pedestal's state as active.
    SetLocalInt(oPedestal, S_STATE_INT, N_ACTIVE_STATE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: RemoveGlow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void RemoveGlow(object oPedestal)
{
    object oLight;

    oLight = GetLocalObject(oPedestal, S_LIGHT_OBJ);

    if (oLight == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retreived from: " + GetTag(oPedestal));
    }
    else
    {
        DestroyObject(oLight);
    }

    SetLocalInt(oPedestal, S_STATE_INT, N_DORMANT_STATE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: PlaceGem
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 09, 2005
//::////////////////////////////////////////////////////////////////////////////
void PlaceGem(object oCrystal, object oGem)
{
    object oPlc;
    string sTag;
    int nCrystal;

    nCrystal = GetLocalInt(oCrystal, S_CRYSTAL_NUM);

    sTag = S_PEDESTAL_TAG_PRFX + IntToString(nCrystal);
    oPlc = GetObjectByTag(sTag);

    if (oPlc == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retreived: " + sTag);
    }
    else
    {
        ToggleState(oPlc);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: RotateBraziers
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 10, 2005
//::////////////////////////////////////////////////////////////////////////////
void RotateBraziers()
{
    object oBrazier;
    int i, nState, nStore;
    string sTag;

    // Start by gathering the state of the last Brazier
    nState = -1;
    sTag = S_BRAZIER_TAG_PRFX + "7";
    oBrazier = GetObjectByTag(sTag);

    if (oBrazier == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag);
    }
    else
    {
        // Initial state to switch to is that of the last; first takes last's state.
        nState = GetLocalInt(oBrazier, S_STATE_INT);
    }

    // Cycle the Braziers moving the state variables up.
    for (i = 0; i < N_CIRCLE_BRAZIERS; ++i)
    {
        // Gather the Brazier
        sTag = S_BRAZIER_TAG_PRFX + IntToString(i);

        oBrazier = GetObjectByTag(sTag);

        if (oBrazier == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retrieved: " + sTag);
        }
        else
        {
            // Swap out the state and apply the new one.
            nStore = GetLocalInt(oBrazier, S_STATE_INT);

            SetLocalInt(oBrazier, S_STATE_INT, nState);

            // Play an appropriate animation if necissary.
            if (nStore == N_ACTIVE_STATE && nState == N_DORMANT_STATE)
            {
                // Shut down the Brazier.
                AssignCommand(oBrazier, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            }

            if (nStore == N_DORMANT_STATE && nState == N_ACTIVE_STATE)
            {
                // Light up the Brazier.
                AssignCommand(oBrazier, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            }

            // For the next placeable.
            nState = nStore;
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SwapBraziers
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 10, 2005
//::////////////////////////////////////////////////////////////////////////////
void SwapBraziers()
{
    DebugMessage("SwapBraziers");

    object oBrazier1, oBrazier2;
    int nState1, nState2;
    string sTag1, sTag2;

    // Collect the switch brazier and the fourth brazier
    sTag1 = S_BRAZIER_RESREF;
    sTag2 = S_BRAZIER_TAG_PRFX + "4";

    oBrazier1 = GetObjectByTag(sTag1);
    oBrazier2 = GetObjectByTag(sTag2);

    // Ensure that both are valid.
    if (oBrazier1 == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag1);
    }

    if (oBrazier2 == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag2);
    }

    // Swap their states.
    nState1 = GetLocalInt(oBrazier1, S_STATE_INT);
    nState2 = GetLocalInt(oBrazier2, S_STATE_INT);

    SetLocalInt(oBrazier1, S_STATE_INT, nState2);
    SetLocalInt(oBrazier2, S_STATE_INT, nState1);

    // If an animation change is warrated play it.
    if (nState1 == N_ACTIVE_STATE && nState2 == N_DORMANT_STATE)
    {
        AssignCommand(oBrazier1, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        AssignCommand(oBrazier2, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }

    if (nState1 == N_DORMANT_STATE && nState2 == N_ACTIVE_STATE)
    {
        AssignCommand(oBrazier1, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        AssignCommand(oBrazier2, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: DeactivatePedestals
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////
void DeactivatePedestals(int bDelete = FALSE)
{
    object oPedestal;
    int i, nState;
    string sTag;

    // Cycle the pedestals zeroing there local state variables.
    for (i = 0; i < N_CIRCLE_PEDESTALS; ++i)
    {
        sTag = S_PEDESTAL_TAG_PRFX + IntToString(i);
        oPedestal = GetObjectByTag(sTag);

        if (oPedestal == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retreived: " + sTag);
        }

        nState = GetLocalInt(oPedestal, S_STATE_INT);

        // If the pedestal is active shut it down.
        if (nState == N_ACTIVE_STATE)
        {
            RemoveGlow(oPedestal);
        }

        // If its time to delete the old variables.
        if (bDelete)
        {
            DeleteLocalInt(oPedestal, S_STATE_INT);
            DeleteLocalInt(oPedestal, S_TARGET_BOOL);
        }
        else // Flag the Pedestal as inactive.
        {
            SetLocalInt(oPedestal, S_TARGET_BOOL, FALSE);
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: DeactivateBraziers
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 11, 2005
//::////////////////////////////////////////////////////////////////////////////
void DeactivateBraziers(int bDelete)
{
    object oBrazier;
    int i, nState;
    string sTag;

    effect eDMG = EffectDamage(5000);

    // Cycle the braziers zeroing there local state variables.
    for (i = 0; i < N_CIRCLE_BRAZIERS; ++i)
    {
        sTag = S_BRAZIER_TAG_PRFX + IntToString(i);
        oBrazier = GetObjectByTag(sTag);

        if (oBrazier == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retreived: " + sTag);
        }

        // Update March 28, 2006.
        // Rather than playing with the state etc. the braziers will now simply
        // be destroyed outright.
        SetPlotFlag(oBrazier, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oBrazier);

        /*
        nState = GetLocalInt(oBrazier, S_STATE_INT);

        // If the brazier is active shut it down.
        if (nState == N_ACTIVE_STATE)
        {
            AssignCommand(oBrazier, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            SetLocalInt(oBrazier, S_STATE_INT, N_DORMANT_STATE);
        }

        // If its time to delete the old variables.
        if (bDelete)
        {
            DeleteLocalInt(oBrazier, S_STATE_INT);
            DeleteLocalInt(oBrazier, S_TARGET_BOOL);
        }
        else // Flag the brazier as inactive.
        {
            SetLocalInt(oBrazier, S_TARGET_BOOL, FALSE);
        }
        */
    }

    // Explicitly Destroy the 'switch' brazier.
    oBrazier = GetObjectByTag(S_BRAZIER_TAG);

    SetPlotFlag(oBrazier, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oBrazier);

    // Explicitly Destroy the gong.
    oBrazier = GetObjectByTag(S_GONG_TAG);

    SetPlotFlag(oBrazier, FALSE);
    DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oBrazier));
}

//::////////////////////////////////////////////////////////////////////////////
//:: DestroyGems
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 11, 2005
//::////////////////////////////////////////////////////////////////////////////
void DestroyGems(object oCarrier)
{
    object oGem;
    string sTag;

    // Cycle the object's inventory looking for gems.
    oGem = GetFirstItemInInventory(oCarrier);

    while (oGem != OBJECT_INVALID)
    {
        sTag = GetTag(oGem);

        // If an object with a gem tag is discovered destroy it.
        if (sTag == S_GEM_RESREF)
        {
            DestroyObject(oGem);
        }

        oGem = GetNextItemInInventory(oCarrier);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 11, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle(object oSolver)
{
    object oPC, oCrystal, oPedestal, oBrazier, oPuzzleWP, oRewardWP, oArea;
    int i;
    string sTag;
    effect eDMG, eVFX;
    location lLoc;

    eDMG = EffectDamage(500);
    eVFX = EffectVisualEffect(VFX_FNF_PWKILL);
    oPC = GetFirstPC();
    oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);
    lLoc = GetLocation(oPuzzleWP);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);

    // DEBUG
    //FloatingTextStringOnCreature("Winner!", oPC);

    // All the gem items involved in the puzzle should be destoyed.
    // Start with any player characters.
    while (oPC != OBJECT_INVALID)
    {
        DestroyGems(oPC);
        oPC = GetNextPC();
    }
    // Next destroy all the gems inside of the crystal placeables. After a short
    // delay destroy the crystals themselves.

    eVFX = EffectVisualEffect(VFX_COM_SPARKS_PARRY);

    for (i = 0; i < N_CIRCLE_PEDESTALS; ++i)
    {
        sTag = S_CRYSTAL_TAG_PRFX + IntToString(i);
        oCrystal = GetObjectByTag(sTag);

        if (oCrystal == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retrieved: " + sTag);
        }
        else
        {
            DestroyGems(oCrystal);
            SetPlotFlag (oCrystal, FALSE);

            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oCrystal));
            DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oCrystal));
        }
    }

    // Remove the glow effects from all the pedestal placeables and delete locals.
    for (i = 0; i < N_CIRCLE_PEDESTALS; ++i)
    {
        sTag = S_PEDESTAL_TAG_PRFX + IntToString(i);
        oPedestal = GetObjectByTag(sTag);

        if (oPedestal == OBJECT_INVALID)
        {
            DebugMessage("INVALID object retreived: " + sTag);
        }

        RemoveGlow(oPedestal);
        DeleteLocalInt(oPedestal, S_STATE_INT);
    }

    // Deactivate the braziers and delete their locals.
    DeactivateBraziers(TRUE);

    // Deactivate the pedestals and delete their locals.
    DeactivatePedestals(TRUE);

    // Delete all the local variables stored on the various placeables.
    DeleteLocalInt(oPuzzleWP, S_SUMMONED_BOOL);

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
    DebugMessage("inc_puz_trpsprsn::EndPuzzle");
    DebugMessage("Setting " + sVarPrfx + B_PUZZLE_COMPLETED + " TRUE.");
    DebugMessage("");

    ///SetLocalObject(oRewardWP, O_PUZZLE_SOLVER, oSolver);

    // Signal the 'puzzle completed' event on the area.
    oArea = GetArea(oPuzzleWP);
//    SignalEvent(oArea, EventUserDefined(5000));
}
