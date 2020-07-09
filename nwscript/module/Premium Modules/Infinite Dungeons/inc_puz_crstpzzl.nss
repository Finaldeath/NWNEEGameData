//::////////////////////////////////////////////////////////////////////////////
//:: inc_puz_rgbpzzl
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Crystal mechanism puzzle main include file. This puzzle consists of an 8X8
    grid of 'tiles' surronded by 20 'crystal mechanisms'. Each of the mechanisms
    start with a random number of color markers (either red, green or blue) and
    additional markers can be added by placing arrows (again red, green or blue)
    on the tiles, pointed towards the mechanisms. The objective is to ensure
    that each mechanism has a marker of each color, thus making it white.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////


#include "inc_puz_general"
#include "inc_id1_puzzle"


// DEBUG
//void main() {}


/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/
const string S_TILE_PLC_TAG    = "a2_tile_";
const string S_CRST_PLC_TAG    = "a2_cryst_";

// Resref constants
const string S_TILE_RESREF     = "puzzleplate";
const string S_MECH_RESREF     = "crystalmech";
const string S_PANEL_RESREF    = "puzzlepanel";
const string S_RED_ARRW_RESREF = "redarrow";
const string S_GRN_ARRW_RESREF = "greenarrow";
const string S_BLU_ARRW_RESREF = "bluearrow";
const string S_WHT_PLR_RESREF  = "solwhite";
const string S_RED_PLR_RESREF  = "solred";
const string S_GRN_PLR_RESREF  = "solgreen";
const string S_BLU_PLR_RESREF  = "solblue";
const string S_PRP_PLR_RESREF  = "solpurple";
const string S_YLW_PLR_RESREF  = "solyellow";
const string S_CYN_PLR_RESREF  = "solcyan";

const string HINT_PLC_RESREF = "id1_crstpzzl_hnt";

// Directional constants.
const int NORTH      = 1;
const int NORTH_EAST = 2;
const int EAST       = 3;
const int SOUTH_EAST = 4;
const int SOUTH      = 5;
const int SOUTH_WEST = 6;
const int WEST       = 7;
const int NORTH_WEST = 8;

// Color constants.
const int COLOR_RED   = 100;
const int COLOR_GREEN = 10;
const int COLOR_BLUE  = 1;

/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/

// Name: Create Puzzle
//
// Defined in: inc_puz_rgbpzzl
//
// This function creates all the placeable elements of the puzzle in the area of
// the nearest waypoint with the puzzle waypoint tag as defined by the
// S_SPAWN_WP_TAG constant. The puzzle consists of a grid, 8 squares wide and 8
// squares deep, constructed from pressure plate placeables surrounded by 20
// 'Crystal Mechanism' placeables.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreatePuzzle();

// Name: Create Cell
//
// Defined in: inc_puz_rgbpzzl
//
// This function creates a cell in the puzzle grid, either a tile or a crystal
// mechanism based on the sResref argument, for the crystal puzzle at location
// lLoc using nRow and nCol to determine the tile's tag. If the created object
// is invalid a debug message is created (using the DebugMessage method).
//
// Parameters:
// lLoc - The location to create the tile.
// nRow - The row in which the tile is being created.
// nCol - The column in which the tile is being created.
// sResref - The string Resref of the object to be created as a tile in the.
//
// Return:
// NONE
void CreateCell(location lLoc, int nRow, int nCol, string sResref);

// Name: Activate Puzzle
//
// Defined in: inc_puz_crstpzzl
//
// Activates the puzzle. Sets local variables indicating the puzzle is active
// and clears and initializes the puzzle.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ActivatePuzzle();

// Name: Init Puzzle
//
// Defined in: inc_puz_crstpzzl
//
// Initalizes the puzzle's state, by establishing initial color states for all
// of the crystal mechanisms randomly and establishing a randomized solution.
// Update July 20, 2005: Moved from inc_a2_crystpuzz (PotSC) to inc_puz_crstpzzl
//
// Parameters:
// NONE
//
// Return:
// NONE
void InitPuzzle();

// Name: Calc Target
//
// Defined in: inc_puz_crstpzzl
//
// Determines the target crystal mechanism/light emmiter for a placed arrow
// based on the X and Y coordinates in the overall grid and the direction the
// arrow is facing.
// Update July 20, 2005: Moved from inc_a2_crystpuzz (PotSC) to inc_puz_crstpzzl
// Replaced directional literals with a set of constants for clarity.
//
// Parameters:
// iX - The column of the grid in which the arrow is being placed.
// iY - The row of the grid in which the arrow is being placed.
// int iDir - The direction the arrow is pointing, one of the constants:
// NORTH, NORTH_EAST, EAST, SOUTH_EAST, SOUTH, SOUTH_WEST, WEST, NORTH_WEST
//
// Return:
// NONE
object CalcTarget(int iX, int iY, int iDir);

// Name: Clear Puzzle
//
// Defined in: inc_puz_crstpzzl
//
// Clears the current puzzle data. Destroys any arrows and shuts off lights
// on the crystal mechanisms.
// Update July 20, 2005: Moved function from inc_a2_crystpuzz (PotSC) to
// inc_puz_crstpzzl. Edited to use constants for generality when determining
// tile tags.
//
// Parameters:
// NONE
//
// Return:
// NONE
void ClearPuzzle();

// Name: Render Light
//
// Defined in: inc_puz_crstpzzl
//
// Renders lights on the crystal mechanisms based on the local counts of red
// green and blue. These counts are derived from an initial state and additives
// from arrows placed by the player while attempting to solve the puzzle.
// Possible states include:
// Red    - If there are only Red counters.
// Green  - If there are only Green counters.
// Blue   - If there are only Blue counters.
// Purple - If there are both Red and Blue counters.
// Yellow - If there are both Green and Red counters.
// Cyan   - If there are both Green and Blue counters.
// White  - If all three color counters are present.
// No-color - If there are no color counters present.
// Update July 20, 2005: Moved function from inc_a2_crystpuzz (PotSC) to
// inc_puz_crstpzzl. Now uses local constants to create light pillars from
// resref, this makes it more robust in terms of changing the placeables that
// are displayed.
//
// Parameters:
// oTarget - The crystal mechanism in question, on which lights will be rendered
// iEffects - If this is TRUE a Visual effect will be applied to the mechanism
//
// Return:
// The total number of new color counters added.
int RenderLight(object oTarget, int iEffects);

// Name: Check Puzzle
//
// Defined in: inc_puz_crstpzzl
//
// Cycles through all the crystal mechanisms calling the RenderLight funcion on
// each to update there display color and determine if the puzzle is in a win
// state.
// Update July 20, 2005: Moved function from inc_a2_crystpuzz (PotSC) to
// inc_puz_crstpzzl.
//
// Parameters:
// NONE
//
// Return:
// TRUE if the puzzle has been successfully solved.
// FALSE otherwise.
int CheckPuzzle();

// Name: End Puzzle
//
// Defined in: inc_puz_crstpzzl
//
// This function wraps up the crystal puzzle by destroying the tile and light
// placeables created when the puzzle is made and during its solution. A couple
// of variables are set on the module indicating the puzzle is no longer
// active and has been completed.
// Update July 20, 2005: Moved function from inc_a2_crystpuzz (PotSC) to
// inc_puz_crstpzzl. This function will now also destroy arrow placeables,
// signal a user defined event on the area (5000) and display some floating
// string on the player that indicates the puzzle is completed. Finally, all the
// crystal mechanism placeables should play an activation animation.
//
// Parameters:
// oPC - The player who solved the puzzle.
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
//:: Created On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreatePuzzle()
{
    // VARIABLES
    object oPzzlWP, oArea, oTile, oMech;
    vector vLoc, vTmp;
    location lCreate; // Location to create tiles.
    float fX, fY; // X and Y coordinates of the location to create next tile.
    int nRow, nCol; // The row and column, for tracking and naming purposes.
    string sResref;

    // LOCAL CONSTANT VALUES

    // The variance between the center and top left corner X and Y values.
    float fXCrnrVar = -6.25;
    float fYCrnrVar = 6.25;

    // The amount of stagger between the X and Y value of each tile along a row
    // or column.
    float fXStggr = 2.5;
    float fYStggr = 2.5;

    // Distance between the X of the first and last tiles in a row.
    float fRowLngth = 10.0;

    float fOrnt = 0.0; // General Orientation.

    // Variable Initializations
    oPzzlWP = OBJECT_SELF;
    oArea = GetArea(oPzzlWP);

    vLoc = GetPosition(oPzzlWP);

    float fZ = vLoc.z; // Height from the ground.

    // Create the control panel ////////////////////////////////////////////////
    vTmp = Vector(vLoc.x, (vLoc.y + 8.75), vLoc.z);
    lCreate = Location(oArea, vTmp, 90.0);

    oMech = DB_CreateObject(OBJECT_TYPE_PLACEABLE, HINT_PLC_RESREF, lCreate);
    ////////////////////////////////////////////////////////////////////////////

    fX = vLoc.x + fXCrnrVar;
    fY = vLoc.y + fYCrnrVar;

    nRow = 0;
    nCol = 0;

    // Create 4 rows and 4 columns of tiles to represent the puzzle 'board'
    while (nRow < 6)
    {
        while (nCol < 6)
        {
            // Get a location
            vLoc    = Vector(fX, fY, fZ);
            lCreate = Location(oArea, vLoc, fOrnt);

            if (nRow == 0 || nCol == 0 || nRow == 5 || nCol == 5)
            {
                sResref = S_MECH_RESREF;
            }
            else
            {
                sResref = S_TILE_RESREF;
            }

            CreateCell(lCreate, nRow, nCol, sResref);

            // Increment the column and X value.
            nCol++;
            fX += fXStggr;
        }
        // Increment the row and Y value. Reset the column and X value. The X
        // value is incremented once beyond the end of the row so subtract the
        // extra distance
        nRow++;
        nCol = 0;
        fY -= fYStggr;
        fX -= (fRowLngth + (fXStggr * 2));
    }

    // Activate the puzzle once everything is in place.
    ActivatePuzzle();
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateCell
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateCell(location lLoc, int nRow, int nCol, string sResref)
{
    string sCellTag;
    object oCell;
    effect eVFX;

    // Create a tile with the proper tag.
    if (sResref == S_TILE_RESREF)
    {
        sCellTag = S_TILE_PLC_TAG;
    }
    else
    {
        sCellTag = S_CRST_PLC_TAG;
    }

    sCellTag = sCellTag + IntToString(nRow) + "_" + IntToString(nCol);

    oCell = CreateObject(OBJECT_TYPE_PLACEABLE, sResref, lLoc, FALSE, sCellTag);

    eVFX = EffectVisualEffect(VFX_DUR_GLOW_WHITE);

    if (oCell == OBJECT_INVALID)
    {
        DebugMessage("CreatePuzzle::" + sCellTag + " invalid.");
    }
    else
    {
        AssignCommand(oCell, SetIsDestroyable(FALSE));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: ActivatePuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void ActivatePuzzle()                                                            //TBD
{
    /*
    if (GetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE") == FALSE)
    {
        DebugMessage("inc_puz_crstpzzl::ActivatePuzzle (1st time)");
        SetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE", TRUE);
        SetLocalInt(GetModule(), "CRYST_PUZZ_COMLPETE", FALSE);
    }
    */

    ClearPuzzle();
    InitPuzzle();
    //DelayCommand(0.5f, InitPuzzle());
}

//::////////////////////////////////////////////////////////////////////////////
//:: InitPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void InitPuzzle()
{
    object oTarget, oArrow, oTile, oLight;
    int iXCurs, iYCurs, iXTarg, iYTarg, iCheckValid;
    int iCLRTarg, iRandColor, iRandDirction;
    string sTileTag, sTargTag, sColor;
    float fBuffer;

    iYCurs = 1;
    // cycle through tiles where x = 1-4 and y = 1-4
    while (iYCurs < 5)
    {
        iXCurs = 1;
        while (iXCurs < 5)
        {
            sTileTag = S_TILE_PLC_TAG + IntToString(iXCurs) + "_"+ IntToString(iYCurs);
            oTile = GetObjectByTag(sTileTag);

            // generate a random direction and color
            iRandColor = Random(3);
            iRandDirction = Random(8)+1;
            iCheckValid = TRUE;
            oTarget = CalcTarget(iXCurs, iYCurs, iRandDirction);

            // Save the random information to the target sources based on color.
            switch (iRandColor)
            {
                // Red
                case 0 :
                    iCLRTarg = GetLocalInt(oTarget, "COLOR_RED_COUNT");
                    if (iCLRTarg > 0 )
                    {
                        SetLocalInt(oTarget, "COLOR_RED_COUNT", iCLRTarg - 1);
                    }
                    else
                    {
                        iCLRTarg = GetLocalInt(oTarget, "COLOR_GREEN_COUNT");
                        if (iCLRTarg > 0)
                        {
                            SetLocalInt(oTarget, "COLOR_GREEN_COUNT", iCLRTarg - 1);
                        }
                        else
                        {
                            iCLRTarg = GetLocalInt(oTarget, "COLOR_BLUE_COUNT");
                            if (iCLRTarg > 0)
                            {
                                SetLocalInt(oTarget, "COLOR_BLUE_COUNT", iCLRTarg - 1);
                            }
                            else
                            {
                                DebugMessage("ERROR FINDING COLOR : " + GetTag(oTile));
                                iCheckValid = FALSE;
                            }
                        }
                    }
                    // Debug
                    //oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, "a2puz_redarrow", GetLocation(oTile));
                break;
                // Green
                case 1 :
                    iCLRTarg = GetLocalInt(oTarget, "COLOR_GREEN_COUNT");
                    if (iCLRTarg > 0)
                    {
                        SetLocalInt(oTarget, "COLOR_GREEN_COUNT", iCLRTarg - 1);
                    }
                    else
                    {
                        iCLRTarg = GetLocalInt(oTarget, "COLOR_BLUE_COUNT");
                        if (iCLRTarg > 0)
                        {
                            SetLocalInt(oTarget, "COLOR_BLUE_COUNT", iCLRTarg - 1);
                        }
                        else
                        {
                            iCLRTarg = GetLocalInt(oTarget, "COLOR_RED_COUNT");
                            if (iCLRTarg > 0)
                            {
                                SetLocalInt(oTarget, "COLOR_RED_COUNT", iCLRTarg - 1);
                            }
                            else
                            {
                                DebugMessage("ERROR FINDING COLOR : " + GetTag(oTile));
                                iCheckValid = FALSE;
                            }
                        }
                    }
                    // Debug
                    //oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, "a2puz_grnarrow", GetLocation(oTile));
                break;
                // Blue
                case 2 :
                    iCLRTarg = GetLocalInt(oTarget, "COLOR_BLUE_COUNT");
                    if (iCLRTarg > 0)
                    {
                        SetLocalInt(oTarget, "COLOR_BLUE_COUNT", iCLRTarg - 1);
                    }
                    else
                    {
                        iCLRTarg = GetLocalInt(oTarget, "COLOR_RED_COUNT");
                        if (iCLRTarg > 0)
                        {
                             SetLocalInt(oTarget, "COLOR_RED_COUNT", iCLRTarg - 1);
                        }
                        else
                        {
                            iCLRTarg = GetLocalInt(oTarget, "COLOR_GREEN_COUNT");
                            if (iCLRTarg > 0)
                            {
                                SetLocalInt(oTarget, "COLOR_GREEN_COUNT", iCLRTarg - 1);
                            }
                            else
                            {
                                DebugMessage("ERROR FINDING COLOR : " + GetTag(oTile));
                                iCheckValid = FALSE;
                            }
                        }
                    }
                 // Debug
                 //oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, "a2puz_bluarrow", GetLocation(oTile));
                 break;
            }
            // Debug
            //AssignCommand(oArrow, SetFacingPoint(GetPosition(oTarget)));

            RenderLight(oTarget, FALSE);

            iXCurs++;
        }
        iYCurs++;
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CalcTarget
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
object CalcTarget(int iX, int iY, int iDir)
{
    object oTarget, oPC;
    string sTargTag, sDebugText;
    int iXb, iYb, iZb;

    // find the destination emitter based on the tile and direction
    switch (iDir)
    {
        //North
        case NORTH :
            sTargTag = S_CRST_PLC_TAG + IntToString(0) + "_" + IntToString(iY);
            oTarget = GetObjectByTag(sTargTag);
        break;
        //North East
        case NORTH_EAST :
            iYb = iY + iX;
            iXb = 0;
            if (iYb > 5)
            {
                iXb = iYb - 5;
                iYb = 5;
            }
            sTargTag = S_CRST_PLC_TAG + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // East
        case EAST :
            sTargTag = S_CRST_PLC_TAG + IntToString(iX) + "_" + IntToString(5);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South East
        case SOUTH_EAST :
            iYb = 5 - iY;
            iXb = 5 - iX;

            if (iY > iX)
            {
                iZb = iYb;
                iYb = iY + iZb;
                iXb = iX + iZb;
            }
            else
            {
                iZb = iXb;
                iXb = iX + iZb;
                iYb = iY + iZb;
            }

            sTargTag = S_CRST_PLC_TAG + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South
        case SOUTH :
            sTargTag = S_CRST_PLC_TAG + IntToString(5) + "_" + IntToString(iY);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South West
        case SOUTH_WEST :
            iXb = iY + iX;
            iYb = 0;
            if (iXb > 5)
            {
                iYb = iXb - 5;
                iXb = 5;
            }
            sTargTag = S_CRST_PLC_TAG + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // West
        case WEST :
            sTargTag = S_CRST_PLC_TAG + IntToString(iX) + "_" + IntToString(0);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // North West
        case NORTH_WEST :
            if (iX < iY)
            {
                iXb = iX - iX;
                iYb = iY - iX;
            }
            else
            {
                iYb = iY - iY;
                iXb = iX - iY;
            }
            sTargTag = S_CRST_PLC_TAG + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
    }

    //sDebugText = "**DEBUG: GetTarget a2_tile_"+ IntToString(iX) + "_" + IntToString(iY)
    //  + " Direction : " + IntToString(iDir) + "; Returned target: " + sTargTag;
    //Debug(sDebugText);

    return oTarget;
}

//::////////////////////////////////////////////////////////////////////////////
//:: ClearPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void ClearPuzzle()
{
    object oTarget, oArrow, oTile, oLight;
    int iXTarg, iYTarg;
    string sTargTag, sTileTag;

    iYTarg = 1;
    while (iYTarg < 5)
    {
        iXTarg = 1;
        while (iXTarg < 5)
        {
            sTileTag = S_TILE_PLC_TAG + IntToString(iXTarg) + "_"+ IntToString(iYTarg);
            oTile = GetObjectByTag(sTileTag);

            oArrow = GetLocalObject(oTile, "TILE_ARROW");
            DestroyObject(oArrow);

            DebugMessage("Clearing arrow '"+GetTag(oArrow)+"' on tile :" + GetTag(oTile));

            iXTarg++;
        }
        iYTarg++;
    }

    iYTarg = 0;
    // cycle through and update all emitters while checking for a win state
    while (iYTarg < 6)
    {
        iXTarg = 0;

        while (iXTarg < 6)
        {
            sTargTag = S_CRST_PLC_TAG + IntToString(iXTarg) + "_" + IntToString(iYTarg);
            oTarget = GetObjectByTag(sTargTag);

            if (GetIsObjectValid(oTarget) == TRUE)
            {
                SetLocalInt(oTarget, "COLOR_RED_COUNT", 1);
                SetLocalInt(oTarget, "ADDITV_RED_COUNT", 0);
                SetLocalInt(oTarget, "COLOR_GREEN_COUNT", 1);
                SetLocalInt(oTarget, "ADDITV_GREEN_COUNT", 0);
                SetLocalInt(oTarget, "COLOR_BLUE_COUNT", 1);
                SetLocalInt(oTarget, "ADDITV_BLUE_COUNT", 0);

                RenderLight(oTarget, FALSE);

                //Debug(" Clearing object " + sTargTag);
            }
            iXTarg++;
        }
        iYTarg++;
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: Render Light
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
int RenderLight(object oTarget, int iEffects)
{
    location lLoc = GetLocation(oTarget);
    int iXTarg, iYTarg, iCLRTarg, iSUBTarg, iActive, iNewActive;
    int iRed, iGreen, iBlue, iTotalOld, iTotalNew, iWinner, iVFX;
    string sColor, sChange, sChgTag, sDebugText;
    object oLight;
    effect eVFX;

    // make note of the emmiters initial state. this is so we can
    // do special effects and animations on a change in state
    iActive = GetLocalInt(oTarget, "iActive");
    sColor = GetLocalString(oTarget, "sLightTag");
    sChange = "";

    // tabulate the set colors and subtrations from the arrows
    iCLRTarg = GetLocalInt(oTarget, "COLOR_RED_COUNT");
    iSUBTarg = GetLocalInt(oTarget, "ADDITV_RED_COUNT");
    iRed = iCLRTarg + iSUBTarg;

    if (iRed > 1) iRed = 1;

    iCLRTarg = GetLocalInt(oTarget, "COLOR_GREEN_COUNT");
    iSUBTarg = GetLocalInt(oTarget, "ADDITV_GREEN_COUNT");
    iGreen = iCLRTarg + iSUBTarg;

    if (iGreen > 1) iGreen = 1;

    iCLRTarg = GetLocalInt(oTarget, "COLOR_BLUE_COUNT");
    iSUBTarg = GetLocalInt(oTarget, "ADDITV_BLUE_COUNT");
    iBlue = iCLRTarg + iSUBTarg;

    if (iBlue > 1) iBlue = 1;

    iTotalOld = GetLocalInt(oTarget, "iTotalOld");

    // calculate what color light to display on the emitter
    // WHITE
    if ((iRed > 0) && (iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_white")
        {
            sChange = S_WHT_PLR_RESREF;
            sChgTag = "clr_white";
        }
        iNewActive = TRUE;
    }
    // RED
    else if ((iRed > 0) && !(iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_red")
        {
            sChange = S_RED_PLR_RESREF;
            sChgTag = "clr_red";
        }
        iNewActive = FALSE;
    }
    // GREEN
    else if (!(iRed > 0) && (iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_green")
        {
            sChange = S_GRN_PLR_RESREF;
            sChgTag = "clr_green";
        }
        iNewActive = FALSE;
    }
    // BLUE
    else if (!(iRed > 0) && !(iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_blue")
        {
            sChange = S_BLU_PLR_RESREF;
            sChgTag = "clr_blue";
        }
        iNewActive = FALSE;
    }
    // PURPLE
    else if ((iRed > 0) && !(iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_purple")
        {
            sChange = S_PRP_PLR_RESREF;
            sChgTag = "clr_purple";
        }
        iNewActive = FALSE;
    }
    // YELLOW
    else if ((iRed > 0) && (iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_yellow")
        {
            sChange = S_YLW_PLR_RESREF;
            sChgTag = "clr_yellow";
        }
        iNewActive = FALSE;
    }
    // CYAN
    else if (!(iRed > 0) && (iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_cyan")
        {
            sChange = S_CYN_PLR_RESREF;
            sChgTag = "clr_cyan";
        }
        iNewActive = FALSE;
    }
    // NONE - No Color
    else if (!(iRed > 0) && !(iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "CLR_BLACK")
        {
            oLight = GetNearestObjectByTag(sColor, oTarget, 0);
            SetLocalString(oTarget, "sLightTag", "CLR_BLACK");
            sChange = "CLR_BLACK";
            DestroyObject(oLight);
        }
        iNewActive = FALSE;
    }

    // if there has been a change in state clear the old light and create the
    // new light color in its place.
    if (sChange != "")
    {
        oLight = GetNearestObjectByTag(sColor, oTarget, 0);
        CreateObject(OBJECT_TYPE_PLACEABLE, sChange, lLoc, FALSE, sChgTag);
        SetLocalString(oTarget, "sLightTag", sChgTag);

        DestroyObject(oLight);
    }

    // animate the emitter opening or closing based on state.
    if ((iActive == TRUE) && (iNewActive == FALSE))
    {
        AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }
    else if ((iActive == FALSE) && (iNewActive == TRUE))
    {
        AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }

    iTotalNew = iRed + iGreen + iBlue;
    SetLocalInt(oTarget, "iTotalOld", iTotalNew);
    DebugMessage("** Old Number = " + IntToString(iTotalOld)
        + ", New Number = " + IntToString(iTotalNew));

    // While the player is solving the puzzle display some effects as status updates.
    if (iEffects == TRUE)
    {
        if (iTotalNew > iTotalOld)
        {
            if (iTotalNew == 3) // The mechanism is in the white state or solved
            {
                iVFX = VFX_FNF_STRIKE_HOLY;
            }
            else // Color changed but not to white.
            {
                iVFX = VFX_IMP_HEALING_M;
            }
        }
        else if (iTotalNew < iTotalOld) // A color has been removed.
        {
            iVFX = VFX_IMP_HARM;
        }
        else // A color was added.
        {
            iVFX = VFX_IMP_WILL_SAVING_THROW_USE;
        }

        eVFX = EffectVisualEffect(iVFX);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, 1.0f);
    }

    return (iTotalNew);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CheckPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
int CheckPuzzle()
{
    object oTarget, oPC;
    string sTargTag, sDebugText;
    int iXTarg, iYTarg, iCLRTarg, iSUBTarg;
    int iColor, iSuccess;

    iSuccess = TRUE;
    iYTarg = 0;
    iXTarg = 0;

    // cycle through and update all emitters while checking for a win state
    while (iYTarg < 6)
    {
        while (iXTarg < 6)
        {
            sTargTag = S_CRST_PLC_TAG + IntToString(iXTarg) + "_" + IntToString(iYTarg);
            oTarget = GetObjectByTag(sTargTag);
            iColor = 0;

            if (GetIsObjectValid(oTarget) == TRUE)
            {
                iColor = RenderLight(oTarget, FALSE);

                // if the puzzle returns a color it is not complete so flag the
                // check as a fail
                DebugMessage("CheckPuzzle, " + sTargTag + " returned :" + IntToString(iColor));
                if (iColor < 3)
                {
                    iSuccess = FALSE;
                }
            }

            iXTarg++;
        }
        iXTarg = 0;
        iYTarg++;
    }

    return iSuccess;
}

//::////////////////////////////////////////////////////////////////////////////
//:: EndPuzzle
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:: Modified By: Grant Mackay
//:: Modified On: July 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void EndPuzzle(object oPC)
{
    DebugMessage("inc_puz_crstpzzl::EndPuzzle()");

    object oTile, oCrystal, oLight, oArrow, oArea, oWP;
    string sCrystal, sTileTag, sLight;
    int iX, iY;

/*  SetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE", FALSE);
    SetLocalInt(GetModule(), "CRYST_PUZZ_COMLPETE", TRUE); */

    iY = 1;
    while (iY < 5)
    {
        iX = 1;
        while (iX < 5)
        {
            sTileTag = S_TILE_PLC_TAG + IntToString(iX) + "_" + IntToString(iY);
            oTile = GetObjectByTag(sTileTag);
            oArrow = GetLocalObject(oTile, "TILE_ARROW");

            DestroyObject(oArrow);
            DestroyObject(oTile);

            iX++;
        }
        iY++;
    }

    iY = 0;
    while (iY < 6)
    {
        iX = 0;
        while (iX < 6)
        {
            sCrystal = S_CRST_PLC_TAG + IntToString(iX) + "_" + IntToString(iY);
            oCrystal = GetObjectByTag(sCrystal);

            if (GetIsObjectValid(oCrystal) == TRUE)
            {
                sLight = GetLocalString(oCrystal, "sLightTag");
                oLight = GetNearestObjectByTag(sLight, oCrystal, 0);
                DestroyObject(oLight);

                AssignCommand(oCrystal, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
                CreateObject(OBJECT_TYPE_PLACEABLE, S_WHT_PLR_RESREF, GetLocation(oCrystal));
            }
            iX++;
        }
        iY++;
    }

    // Award the puzzle's solver some points.
    AwardPuzzleSolvedPoints(oPC);

    // Set the completion indicator on the dungeon object.
    object oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
    object oDungeon = GetCurrentDungeon();
    string sVarPrfx = GetVariableNamePrefix(oPuzzleWP, "b");

    SetLocalInt(oDungeon, sVarPrfx + B_PUZZLE_COMPLETED, TRUE);

    // Reward and score tracking...

    DebugMessage("Puzzle Completed.");

    // Signal the user defined event 5000 on the area to indicate puzzle.
//    oArea = GetArea(oPC);

//    SignalEvent(oArea, EventUserDefined(5000));

    // reward the player for completing the puzzle
    GeneratePuzzleReward(oPuzzleWP, oPC);
}

