//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_rncrcl
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Rune circle main include file. This file contains all the functions used by
    the rune scircle puzzle which consists of a circle of rune stones each of
    which has an associated pillar. Each of the runes and pillars have a
    randomly generated unique color and in between each pair of runes is a
    switch. Pressing the switch exchanges the colors of the two nearest runes
    and all rune colors must be matched to their associated pillar colors in
    order to solve the puzzle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_general"
#include "inc_id1_puzzle"

// DEBUG
// void main () {}

/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/
// Hint placeables resref
const string HINT_PLC_RESREF = "id1_rncrcl_hnt";

// Tag Prefixes
const string S_RUNE_TAG_PRFX = "rune_plc_";
const string S_PLLR_TAG_PRFX = "pillar_plc_";
const string S_STCH_TAG_PRFX = "switch_plc_";
const string S_COLR_TAG_PRFX = "color_plc_";

// Rune placeable tags.
const string S_RUNE_1_TAG = "rune_plc_1";
const string S_RUNE_2_TAG = "rune_plc_2";
const string S_RUNE_3_TAG = "rune_plc_3";
const string S_RUNE_4_TAG = "rune_plc_4";
const string S_RUNE_5_TAG = "rune_plc_5";
const string S_RUNE_6_TAG = "rune_plc_6";
const string S_RUNE_7_TAG = "rune_plc_7";
const string S_RUNE_8_TAG = "rune_plc_8";

// Pillar placeable tags.
const string S_PLLR_1_TAG = "pillar_plc_1";
const string S_PLLR_2_TAG = "pillar_plc_2";
const string S_PLLR_3_TAG = "pillar_plc_3";
const string S_PLLR_4_TAG = "pillar_plc_4";
const string S_PLLR_5_TAG = "pillar_plc_5";
const string S_PLLR_6_TAG = "pillar_plc_6";
const string S_PLLR_7_TAG = "pillar_plc_7";
const string S_PLLR_8_TAG = "pillar_plc_8";

// Switch placeable tags.
const string S_STCH_1_2_TAG = "switch_plc_1_2";
const string S_STCH_2_3_TAG = "switch_plc_2_3";
const string S_STCH_3_4_TAG = "switch_plc_3_4";
const string S_STCH_4_5_TAG = "switch_plc_4_5";
const string S_STCH_5_6_TAG = "switch_plc_5_6";
const string S_STCH_6_7_TAG = "switch_plc_6_7";
const string S_STCH_7_8_TAG = "switch_plc_7_8";
const string S_STCH_8_1_TAG = "switch_plc_8_1";

// Local variable name constants.
const string S_LOCAL_COLOR_INT = "N_LOCAL_COLOR";
const string S_LOCAL_COLOR_OBJ = "O_LOCAL_COLOR";
const string S_LOCAL_PILLAR_OBJ = "O_LOCAL_PILLAR";

const float F_RUNE_RADIUS = 4.5; // Radius of the circle of runes.
const float F_PLLR_RADIUS = 6.5; // Radius of the circle of pillars.

// Color constants.
const int N_COLOR_BLUE   = 1;
const int N_COLOR_CYAN   = 2;
const int N_COLOR_GREEN  = 3;
const int N_COLOR_ORANGE = 4;
const int N_COLOR_PURPLE = 5;
const int N_COLOR_RED    = 6;
const int N_COLOR_WHITE  = 7;
const int N_COLOR_YELLOW = 8;

// Number between 1 and 7 representing the maximum number of pillars that should
// have the same color. Having 8 would start the puzzle solved. Lower maximum
// duplicates make for harder solutions.
const int N_MAX_DUPLICATE_COLORS = 3;

/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_rncrcl
//
// Creates all the placeables involved in the puzzle. These include a circle
// consisting of runes and switches in alternating order surrounded by a circle
// of pillars. Each pillar should correspond to a rune visually. The circles
// are created by establishing points around the center (the WP_Puzzle waypoint)
// using the functions GetNextCircleY and GetNextCircleX as variances to the
// base X and Y value.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();


// Name: Get Glow Effect
//
// Defined in: inc_puz_rncrcl
//
// This functions translates nColor int a colored glow visual effect where
// nColor is one of the color constants: N_COLOR_BLUE, N_COLOR_CYAN,
// N_COLOR_GREEN, N_COLOR_ORANGE, N_COLOR_PURPLE, N_COLOR_RED, N_COLOR_WHITE, or
// N_COLOR_YELLOW.
//
// Parameters:
// nColor - The color constant to be translated into a glow effect.
//
// Return:
// One of the VFX_DUR_GLOW_ effects corresponding to the color argument.
effect GetGlowEffect(int nColor);

// Name: Create Glow
//
// Defined in: inc_puz_rncrcl
//
// Creates a colored glow at the same location as  oRune appropriate to oRune's
// local variable N_LOCAL_COLOR.
//
// Parameters:
// oRune - The rune plate placeable on which the glow will be placed.
// oPC - The player causing a switch, tracked for the purpose of determining
//       the puzzle's solver.
//
// Return:
// NONE
void CreateGlow(object oRune, object oPC);

// Name: Remove Glow
//
// Defined in: inc_puz_rncrcl
//
// Removes all the effects on a given object. This should be used only to remove
// a glow effect from a rune when swapping the colors on two runes.
//
// Parameters:
// oRune - The rune placeable object to have it's visual effects removed.
//
// Return:
// NONE
void RemoveGlow(object oRune);

// Name: Randomize Rune Colors
//
// Defined in: inc_puz_rncrcl
//
// Randomizes the local variables on the rune plate placeables representing the
// colors they will display. This is done by swapping the color of each rune in
// turn with another, randomly generated, rune 3 to 8 times using a different
// random second rune each time.
//
// Parameters:
// NONE
//
// Return:
// NONE
void RandomizeRuneColors();

// Name: Swap Rune Colors
//
// Defined in: inc_puz_rncrcl
//
// This function swaps the colors associated with two rune plate placeables. The
// runes to be swapped are dependent on the oSwitch parameter; those runes
// adjacent to the switch will be swapped. Once the local variable colors are
// swapped the CreateGlow method is called to display the visible feedback.
//
// Parameters:
// oSwitch - The switch pressed as a catalyst to the color swap.
// oPC - The player activating the switch, tracked in order to determine solver.
//
// Return:
// NONE
void SwapRuneColors(object oPC, object oSwitch = OBJECT_SELF);

// Name: Check Puzzle
//
// Defined in: inc_puz_rncrcl
//
// Checks the puzzle for a win state. A win state is defined as all rune plates
// having a glow of the same color as their associated pillar. More specifically
// if all rune plates have the same color local variable as their associated
// pillars the puzzle has been won.
//
// Parameters:
// NONE
//
// Return:
// TRUE - If the puzzle is in a win state
// FALSE otherwise.
int CheckPuzzle();

// Name: End Puzzle
//
// Defined in: inc_puz_rncrcl
//
// Called to wrap up the puzzle once the player has completed it. Makes some
// flashy effects while destroying all the pillars and sparks. Signals User
// defined event 5000 on the area.
//
// Parameters:
// oPC - The player character who solved the puzzle.
//
// Return:
// NONE
void EndPuzzle(object oPC);

/*------------------------------------------------------------------------------
    FUNCTION DEFINITIONS
------------------------------------------------------------------------------*/

//::////////////////////////////////////////////////////////////////////////////
//:: CreatePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 22, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    object oCreateWP, oArea, oRune, oPillar, oSparks;
    string sResRef, sTag;
    vector vPosition;
    location lCreate; // Location to create next puzzle placeable.
    float fX1, fY1; // X and Y reference from the creation waypoint.
    float fX, fY, fZ, fFacing; // establish for the next point to create.
    int i, nRand, nBlue, nCyan, nGreen, nOrange, nPurple, nRed,
        nWhite, nYellow, nColor, bReRand;
    effect eVFX;

    oCreateWP = OBJECT_SELF;
    oArea = GetArea(OBJECT_SELF);

    // Create the hint tome.
    lCreate = GetLocation(oCreateWP);
    DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lCreate);

    // Counters of the number of pillars currently existing of a given color.
    nBlue   = 0;
    nCyan   = 0;
    nGreen  = 0;
    nOrange = 0;
    nPurple = 0;
    nRed    = 0;
    nWhite  = 0;
    nYellow = 0;

    vPosition = GetPosition(oCreateWP);

    fX1 = vPosition.x;
    fY1 = vPosition.y;
    fZ = vPosition.z;

    fFacing = 0.0;

    // Create the runes and switchs. Resrefs with prefix rune_plc_ numbered
    // evenly are runes while those numbered oddly are switchs. For example
    // rune_plc_3 is a switch whereas rune_plc_8 is a rune.
    for (i = 1; i < 17; i++)
    {
        if ((i % 2) == 0) // Every second iteration.
        {
            fFacing += 45.0;
        }

        fX = fX1 + GetNextCircleX(F_RUNE_RADIUS, i, 16);
        fY = fY1 + GetNextCircleY(F_RUNE_RADIUS, i, 16);

        vPosition = Vector(fX, fY, fZ);
        lCreate = Location(oArea, vPosition, fFacing);
        sResRef = S_RUNE_TAG_PRFX + IntToString(i);

        oRune = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lCreate);

        if (oRune == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::CreatePuzzle-CreateObject: Invalid Rune returned");
        }
    }

    fFacing = 0.0;

    // Create the outer circle of pillars. Each pillar will be given a random
    // glow color. At this point the puzzle could potentially be spawned in
    // solved...
    for (i = 1; i < 9; i++)
    {
        fFacing += 45.0;

        fX = fX1 + GetNextCircleX(F_PLLR_RADIUS, i, 8);
        fY = fY1 + GetNextCircleY(F_PLLR_RADIUS, i, 8);

        vPosition = Vector(fX, fY, fZ);
        lCreate = Location(oArea, vPosition, fFacing);

        // Randomly determine a color for the next pillar.
        // Ensure there are not too many pillars of this color already.
        do
        {
            nRand = Random(8) + 1; // Random color from the color constants.

            switch (nRand)
            {
                case N_COLOR_BLUE:
                {
                    nBlue++;
                    nColor = nBlue;
                    break;
                }
                case N_COLOR_CYAN:
                {
                    nCyan++;
                    nColor = nCyan;
                    break;
                }
                case N_COLOR_GREEN:
                {
                    nGreen++;
                    nColor = nGreen;
                    break;
                }
                case N_COLOR_ORANGE:
                {
                    nOrange++;
                    nColor = nOrange;
                    break;
                }
                case N_COLOR_PURPLE:
                {
                    nPurple++;
                    nColor = nPurple;
                    break;
                }
                case N_COLOR_RED:
                {
                    nRed++;
                    nColor = nRed;
                    break;
                }
                case N_COLOR_WHITE:
                {
                    nWhite++;
                    nColor = nWhite;
                    break;
                }
                case N_COLOR_YELLOW:
                {
                    nYellow++;
                    nColor = nYellow;
                    break;
                }
            }
        } while (nColor >= N_MAX_DUPLICATE_COLORS);

        // Create the colored pillar based on the random color established.
        sTag    = S_PLLR_TAG_PRFX + IntToString(i);
        sResRef = S_PLLR_TAG_PRFX + IntToString(nRand);
        eVFX    = GetGlowEffect(nRand);

        oPillar = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lCreate, FALSE, sTag);

        if (oPillar == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::CreatePuzzle-CreateObject: Invalid Pillar returned");
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oPillar);
            oRune = GetNearestObjectByTag(S_RUNE_TAG_PRFX + IntToString(i));

            // Update local variables representing the puzzle's state.
            SetLocalInt(oRune, S_LOCAL_COLOR_INT, nRand);
            SetLocalInt(oPillar, S_LOCAL_COLOR_INT, nRand);

            SetLocalObject(oRune, S_LOCAL_PILLAR_OBJ, oPillar);
        }
    }

    bReRand = TRUE; // While this is true the puzzle needs to be randomized.

    while (bReRand)
    {
        // Randomize the color local variables and create the glow on the runes.
        RandomizeRuneColors();
        // Check for a win state to ensure the puzzle doesn't start in one.
        bReRand = CheckPuzzle();
    }

    // Apply the glow effects to the runes now that the puzzle is properly random
    for(i = 1; i < 9; ++i)
    {
        sTag = S_RUNE_TAG_PRFX + IntToString(i);
        oRune = GetObjectByTag(sTag);

        CreateGlow(oRune, OBJECT_INVALID);
    }

    // Set an indicator for puzzle completion tests.
    SetLocalInt(oCreateWP, N_PUZZLE_STATE, PUZ_ACTIVATED);
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetGlowEffect
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
effect GetGlowEffect(int nColor)
{
    effect eVFX;
    int    nGlow;

    switch (nColor)
    {
        case N_COLOR_BLUE:
        {
            nGlow = VFX_DUR_GLOW_BLUE;
            break;
        }
        case N_COLOR_CYAN:
        {
            nGlow = VFX_DUR_GLOW_LIGHT_BLUE;
            break;
        }
        case N_COLOR_GREEN:
        {
            nGlow = VFX_DUR_GLOW_GREEN;
            break;
        }
        case N_COLOR_ORANGE:
        {
            nGlow = VFX_DUR_GLOW_ORANGE;
            break;
        }
        case N_COLOR_PURPLE:
        {
            nGlow = VFX_DUR_GLOW_PURPLE;
            break;
        }
        case N_COLOR_RED:
        {
            nGlow = VFX_DUR_GLOW_RED;
            break;
        }
        case N_COLOR_WHITE:
        {
            nGlow = VFX_DUR_GLOW_WHITE;
            break;
        }
        case N_COLOR_YELLOW:
        {
            nGlow = VFX_DUR_GLOW_YELLOW;
            break;
        }
    }

    eVFX = EffectVisualEffect(nGlow);

    return eVFX;
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateGlow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateGlow(object oRune, object oPC)
{
    int nColor, nPllrClr, bWin, bActive;
    float fOrnt;
    string sResRef;
    location lLoc;
    vector vPos;
    object oGlow, oOld, oPillar, oArea, oPuzzleWP;
    effect eVFX, eLink;

    // The currently displayed color.
    oOld = GetLocalObject(oRune, S_LOCAL_COLOR_OBJ);
    oPillar = GetLocalObject(oRune, S_LOCAL_PILLAR_OBJ);

    // The color that should be displayed.
    nColor = GetLocalInt(oRune, S_LOCAL_COLOR_INT);

    // Remove the old glow.
    RemoveGlow(oRune);

    // Make the rune glow and drop an invisible placeable with the appropriate name.
    sResRef = S_COLR_TAG_PRFX + IntToString(nColor);
    eVFX = GetGlowEffect(nColor);

    fOrnt = GetFacing(oRune);
    oArea = GetArea(oRune);
    oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);
    vPos  = GetPosition(oRune);

    lLoc = Location(oArea, vPos, fOrnt);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oRune);

    oGlow = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

    // Object creation error checking.
    if (oGlow == OBJECT_INVALID)
    {
        DebugMessage("inc_puz_rncrcl::CreateGlow-CreateObject: Invalid Glow returned");
    }
    else
    {
        SetLocalObject(oRune, S_LOCAL_COLOR_OBJ, oGlow);
    }

    // If the local pillar object is not invalid check it to see if the rune's
    // color now matches.
    if (oPillar == OBJECT_INVALID)
    {
        DebugMessage("inc_puz_rncrcl::CreateGlow-Invalid Pillar encountered");
    }
    else
    {
        nPllrClr = GetLocalInt(oPillar, S_LOCAL_COLOR_INT);

        if (nPllrClr == nColor) // We have a match, make some lights.
        {
            eVFX = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
            lLoc = GetLocation(oPillar);

            DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));
        }
    }

    if (oOld != OBJECT_INVALID)
    {
        DestroyObject(oOld);
    }

    if (!GetIsObjectValid(oPuzzleWP))
    {
        bActive = FALSE;
    }
    else
    {
        bActive = GetLocalInt(oPuzzleWP, N_PUZZLE_STATE) == PUZ_ACTIVATED;
    }
    // If the puzzle is in an active state, that is not being created, check for
    // a win state and wrap things up if this state has been acheived.
    if (bActive)
    {
        DebugMessage("inc_puz_rncrcl::CreateGlow() bActive = TRUE");

        bWin = CheckPuzzle();

        if (bWin)
        {
            object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
            AssignCommand(oInvis, EndPuzzle(oPC));
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: RemoveGlow
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 26, 2005
//::////////////////////////////////////////////////////////////////////////////
void RemoveGlow(object oRune)
{
    effect eVFX;
    int nType;

    // Starting with the first effect cycle the effects, removing them all.

    eVFX = GetFirstEffect(oRune);

    nType = GetEffectType(eVFX);

    while (nType != EFFECT_TYPE_INVALIDEFFECT)
    {
        RemoveEffect(oRune, eVFX);

        eVFX = GetNextEffect(oRune);

        nType = GetEffectType(eVFX);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: RandomizeRuneColors
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
void RandomizeRuneColors()
{
    int nSwaps, nRune1, nRune2, nColor1, nColor2, i, j;
    string sTag1, sTag2;
    object oRune1, oRune2;

    // Iterate the 8 runes and swap the current color with other runes.
    for (i = 1; i < 9; ++i)
    {
        nRune1 = i;

        nSwaps = Random(5) + 3;

        // Each rune should swap 3 to 8 times.
        for (j = 0; j < nSwaps; ++j)
        {
            nRune2 = Random(8) + 1;

            if (nRune1 == nRune2) // If the runes are the same swapping is pointless
            {
                nRune2++; // Increment the second rune to avoid redundancy.

                if (nRune2 > 8) // Make sure it's still a valid rune #; there are 8.
                {
                    nRune2 = 1;
                }
            }

            sTag1 = S_RUNE_TAG_PRFX + IntToString(nRune1);
            sTag2 = S_RUNE_TAG_PRFX + IntToString(nRune2);

            oRune1 = GetObjectByTag(sTag1);
            oRune2 = GetObjectByTag(sTag2);

            if (oRune1 == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_rncrl::RandomizeRuneColors: Rune1 INVALID.");
            }

            if (oRune2 == OBJECT_INVALID)
            {
                DebugMessage("inc_puz_rncrl::RandomizeRuneColors: Rune2 INVALID.");
            }

            // Swap the two rune's colors.
            nColor1 = GetLocalInt(oRune1, S_LOCAL_COLOR_INT);
            nColor2 = GetLocalInt(oRune2, S_LOCAL_COLOR_INT);

            SetLocalInt(oRune1, S_LOCAL_COLOR_INT, nColor2);
            SetLocalInt(oRune2, S_LOCAL_COLOR_INT, nColor1);
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SwapRuneColors
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
void SwapRuneColors(object oPC, object oSwitch = OBJECT_SELF)
{
    // Ensure that the puzzle is still active.
    object oDungeon = GetCurrentDungeon();
    object oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");

    if (GetLocalInt(oDungeon, sVarPrfx + B_PUZZLE_COMPLETED))
    {
        return;
    }

    // If the puzzle has not been solved then the runes should still be active.
    object oRuneA, oRuneB;
    int nColorA, nColorB;
    string sSwitchTag, sRuneTagA, sRuneTagB;
    effect eVFX;

    sSwitchTag = GetTag(oSwitch);

    if (sSwitchTag == S_STCH_1_2_TAG) // The switch between runes 1 and 2.
    {
        sRuneTagA = S_RUNE_1_TAG;
        sRuneTagB = S_RUNE_2_TAG;
    }
    else if (sSwitchTag == S_STCH_2_3_TAG) // The switch between runes 2 and 3.
    {
        sRuneTagA = S_RUNE_2_TAG;
        sRuneTagB = S_RUNE_3_TAG;
    }
    else if (sSwitchTag == S_STCH_3_4_TAG) // The switch between runes 3 and 4.
    {
        sRuneTagA = S_RUNE_3_TAG;
        sRuneTagB = S_RUNE_4_TAG;
    }
    else if (sSwitchTag == S_STCH_4_5_TAG) // The switch between runes 4 and 5.
    {
        sRuneTagA = S_RUNE_4_TAG;
        sRuneTagB = S_RUNE_5_TAG;
    }
    else if (sSwitchTag == S_STCH_5_6_TAG) // The switch between runes 5 and 6.
    {
        sRuneTagA = S_RUNE_5_TAG;
        sRuneTagB = S_RUNE_6_TAG;
    }
    else if (sSwitchTag == S_STCH_6_7_TAG) // The switch between runes 6 and 7.
    {
        sRuneTagA = S_RUNE_6_TAG;
        sRuneTagB = S_RUNE_7_TAG;
    }
    else if (sSwitchTag == S_STCH_7_8_TAG) // The switch between runes 7 and 8.
    {
        sRuneTagA = S_RUNE_7_TAG;
        sRuneTagB = S_RUNE_8_TAG;
    }
    else if (sSwitchTag == S_STCH_8_1_TAG) // The switch between runes 8 and 1.
    {
        sRuneTagA = S_RUNE_8_TAG;
        sRuneTagB = S_RUNE_1_TAG;
    }

    // Simple animation to make things a little more obvious.
    eVFX = EffectVisualEffect(VFX_IMP_DISPEL);

    // Collect the two runes by the tags established above.
    oRuneA = GetObjectByTag(sRuneTagA);
    oRuneB = GetObjectByTag(sRuneTagB);

    // Determine their current colors.
    nColorA = GetLocalInt(oRuneA, S_LOCAL_COLOR_INT);
    nColorB = GetLocalInt(oRuneB, S_LOCAL_COLOR_INT);

    // Switch the colors and re-created the spark representations.
    SetLocalInt(oRuneA, S_LOCAL_COLOR_INT, nColorB);
    SetLocalInt(oRuneB, S_LOCAL_COLOR_INT, nColorA);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oRuneA);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oRuneB);

    CreateGlow(oRuneA, oPC);
    CreateGlow(oRuneB, oPC);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CheckPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
int CheckPuzzle()
{
    int i;
    object oRune, oPllr;
    string sRuneTag, sPllrTag;
    int bWin, nRuneClr, nPllrClr;

    bWin = TRUE;

    // Loop through each rune and pillar comparing colors.
    for (i = 1; i < 9; ++i)
    {
        sRuneTag = S_RUNE_TAG_PRFX + IntToString(i);
        sPllrTag = S_PLLR_TAG_PRFX + IntToString(i);

        oRune = GetObjectByTag(sRuneTag);
        oPllr = GetObjectByTag(sPllrTag);

        if (oRune == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::CheckPuzzle: Rune " + IntToString(i) + " INVALID.");
        }

        if (oPllr == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::CheckPuzzle: Pillar " + IntToString(i) + " INVALID.");
        }

        nRuneClr = GetLocalInt(oRune, S_LOCAL_COLOR_INT);
        nPllrClr = GetLocalInt(oPllr, S_LOCAL_COLOR_INT);

        // If the rune's color doesn't match the pillar's there is no win state.
        if (nRuneClr != nPllrClr)
        {
            bWin = FALSE;
            break;
        }
    }

    return bWin;
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 25, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle(object oPC)
{
    int i;
    float fDelay;
    object oRune, oPllr, oSprk, oArea, oPuzzleWP;
    string sRuneTag, sPllrTag;
    effect eVFX, eDMG;
    location lLoc;

    eVFX = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    eDMG = EffectDamage(1000);
    fDelay = 0.0;
    oArea = GetArea(OBJECT_SELF);
    oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);

    // Cycle through each rune/pillar pair destroying the sparks on the runes
    // and the pillars themselves.
    for (i = 1; i < 9; ++i)
    {
        sRuneTag = S_RUNE_TAG_PRFX + IntToString(i);
        sPllrTag = S_PLLR_TAG_PRFX + IntToString(i);

        oRune = GetObjectByTag(sRuneTag);
        oPllr = GetObjectByTag(sPllrTag);
        oSprk = GetLocalObject(oRune, S_LOCAL_COLOR_OBJ);

        // Object checking.
        if (oRune == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::EndPuzzle: Rune " + IntToString(i) + " INVALID.");
        }

        if (oPllr == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::EndPuzzle: Pillar " + IntToString(i) + " INVALID.");
        }

        if (oSprk == OBJECT_INVALID)
        {
            DebugMessage("inc_puz_rncrcl::EndPuzzle: Spark " + IntToString(i) + " INVALID.");
        }

        lLoc = GetLocation(oPllr);

        // Remove the plot flag.
        SetPlotFlag(oPllr, FALSE);
        SetPlotFlag(oSprk, FALSE);

        DelayCommand(fDelay, DestroyObject(oSprk));
        DelayCommand(fDelay, RemoveGlow(oRune));

        fDelay += 0.5;

        // Apply some lights.
        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));

        fDelay += 0.3;

        // Shortly after destroy everything.
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oPllr));
    }

    // Destroy the hint tomb to avoid disrupting the rewards chest etc.
    object oTomb = DB_GetObjectByTag("ID1_RNCRCL_HNT");

    DestroyObject(oTomb);

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
    DebugMessage("inc_puz_rncrcl::EndPuzzle");
    DebugMessage("Setting " + sVarPrfx + B_PUZZLE_COMPLETED + " TRUE.");
    DebugMessage("");


    // Signal the puzzle solved event on the area.
    // DelayCommand(fDelay, SignalEvent(oArea, EventUserDefined(5000)));
//    SignalEvent(oArea, EventUserDefined(5000));

    DeleteLocalInt(oPuzzleWP, N_PUZZLE_STATE);

}
