//::///////////////////////////////////////////////
//:: inc_a2_crystpuzz
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is the master include script for the
    Vantabular light house puzzle in act 2 of
    PotSC. All funcitons required to handle the
    puzzle are stored here.

    Note: after making
    changes it is best to recompile sll scripts
    int the module to ensure all scripts using
    this code are kept valid.

    a2_cryst_#X_#Y
    a2_tile_#X_#Y
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

const string sWPTile = "PUZ_LOC_";
const string sCryst = "a2_cryst_";
const string sTile = "a2_tile_";

const int COLOR_RED = 100;
const int COLOR_GREEN = 10;
const int COLOR_BLUE = 1;


//------------------------------------------------
// Activates the puzzle.
void ActivatePuzzle();

//------------------------------------------------
// Clears the current puzzle data
void ClearPuzzle();

//------------------------------------------------
// Initiates the current puzzle data.
void InitPuzzle();

//------------------------------------------------
// Checks the puzzle for a solution, and returns
// true on success.
int CheckPuzzle();

//------------------------------------------------
// Update the target light emitter.
int RenderLight(object oTarget, int iEffects);

//------------------------------------------------
// Get the target light emmiter of a specific
// stone tile.
object CalcTarget(int iX, int iY, int iDir);

//------------------------------------------------
// Debug function. Writes data in a string as
// a SendMessageToPC call.
void Debug(string sMSG);

//------------------------------------------------
// Creates the tile nodes where arrows are placed
void StartPuzzle();

//------------------------------------------------
// Removes the Tile nodes where arrows are placed
void EndPuzzle();

void StartPuzzle()
{
    object oTile, oWP;
    int iX, iY;
    string sTileTag, sWPTag;

    SetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE", TRUE);
    SetLocalInt(GetModule(), "CRYST_PUZZ_COMLPETE", FALSE);

    iY = 1;
    while (iY < 5)
    {
        iX = 1;
        while (iX < 5)
        {
            sTileTag = sTile + IntToString(iX) + "_" + IntToString(iY);
            sWPTag = sWPTile + IntToString(iX) + "_" + IntToString(iY);

            oWP = GetWaypointByTag(sWPTag);
            oTile = CreateObject(OBJECT_TYPE_PLACEABLE, "a2_tile",
                GetLocation(oWP), FALSE, sTileTag);

            iX++;
        }
        iY++;
    }
}

void EndPuzzle()
{
    object oTile, oCrystal, oLight;
    string sCrystal, sTileTag, sLight;
    int iX, iY;

    SetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE", FALSE);
    SetLocalInt(GetModule(), "CRYST_PUZZ_COMLPETE", TRUE);

    iY = 1;
    while (iY < 5)
    {
        iX = 1;
        while (iX < 5)
        {
            sTileTag = sTile + IntToString(iX) + "_" + IntToString(iY);
            oTile = GetObjectByTag(sTileTag);
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
            sCrystal = sCryst + IntToString(iX) + "_" + IntToString(iY);
            oCrystal = GetObjectByTag(sCrystal);

            if (GetIsObjectValid(oCrystal) == TRUE)
            {
                sLight = GetLocalString(oCrystal, "sLightTag");
                oLight = GetNearestObjectByTag(sLight, oCrystal, 0);
                DestroyObject(oLight);

                CreateObject(OBJECT_TYPE_PLACEABLE, "final_light", GetLocation(oCrystal));
            }
            iX++;
        }
        iY++;
    }
}

void ActivatePuzzle()
{
    if (GetLocalInt(GetModule(), "CRYST_PUZZ_ACTIVE") == FALSE)
    {
        Debug("Called StartPuzzle");
        StartPuzzle();
    }

    ClearPuzzle();
    DelayCommand(0.5f, InitPuzzle());
}

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
            sTileTag = sTile + IntToString(iXTarg) + "_"+ IntToString(iYTarg);
            oTile = GetObjectByTag(sTileTag);

            oArrow = GetLocalObject(oTile, "TILE_ARROW");
            DestroyObject(oArrow);

            Debug("Clearing arrow '"+GetTag(oArrow)+"' on tile :" + GetTag(oTile));

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
            sTargTag = sCryst + IntToString(iXTarg) + "_" + IntToString(iYTarg);
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
            sTileTag = sTile + IntToString(iXCurs) + "_"+ IntToString(iYCurs);
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
                                Debug("ERROR FINDING COLOR : " + GetTag(oTile));
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
                                Debug("ERROR FINDING COLOR : " + GetTag(oTile));
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
                                Debug("ERROR FINDING COLOR : " + GetTag(oTile));
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
            sTargTag = sCryst + IntToString(iXTarg) + "_" + IntToString(iYTarg);
            oTarget = GetObjectByTag(sTargTag);
            iColor = 0;

            if (GetIsObjectValid(oTarget) == TRUE)
            {
                iColor = RenderLight(oTarget, FALSE);

                // if the puzzle returns a color it is not complete so flag the
                // check as a fail
                Debug("CheckPuzzle, " + sTargTag + " returned :" + IntToString(iColor));
                if (iColor < 3)
                {
                    iSuccess = FALSE;
                }
            }

/*//            // debug text
          sDebugText = "**DEBUG: CheckPuzzle " + sTargTag + " returned color : "
                + IntToString(iColor);

            if (GetIsObjectValid(oTarget) == TRUE)
                sDebugText += " *OBJECT_VALID*";
            else
                sDebugText += " OBJECT_INVALID";

            Debug(sDebugText);
*///

            iXTarg++;
        }
        iXTarg = 0;
        iYTarg++;
    }

    return iSuccess;
}

int RenderLight(object oTarget, int iEffects)
{
    location lLoc = GetLocation(oTarget);
    int iXTarg, iYTarg, iCLRTarg, iSUBTarg, iActive, iNewActive;
    int iRed, iGreen, iBlue, iTotalOld, iTotalNew, iWinner, iVFX;
    string sColor, sChange, sDebugText;
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

    //sDebugText = "**DEBUG: Red Color count for Target: "+ GetTag(oTarget)
    //  + " = " + IntToString(iRed);
    //Debug(sDebugText);

    iCLRTarg = GetLocalInt(oTarget, "COLOR_GREEN_COUNT");
    iSUBTarg = GetLocalInt(oTarget, "ADDITV_GREEN_COUNT");
    iGreen = iCLRTarg + iSUBTarg;

    if (iGreen > 1) iGreen = 1;

    //sDebugText = "**DEBUG: Green Color count for Target: " + GetTag(oTarget)
    //  + " = " + IntToString(iGreen);
    //Debug(sDebugText);

    iCLRTarg = GetLocalInt(oTarget, "COLOR_BLUE_COUNT");
    iSUBTarg = GetLocalInt(oTarget, "ADDITV_BLUE_COUNT");
    iBlue = iCLRTarg + iSUBTarg;

    if (iBlue > 1) iBlue = 1;

    //sDebugText = "**DEBUG: Blue Color count for Target: "+ GetTag(oTarget)
    //  + " = " + IntToString(iBlue);
    //Debug(sDebugText);

    iTotalOld = GetLocalInt(oTarget, "iTotalOld");

    // calculate what color light to display on the emitter
    // WHITE
    if ((iRed > 0) && (iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_white")
        {
            sChange = "clr_white";
        }
        iNewActive = TRUE;
    }
    // RED
    else if ((iRed > 0) && !(iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_red")
        {
            sChange = "clr_red";
        }
        iNewActive = FALSE;
    }
    // GREEN
    else if (!(iRed > 0) && (iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_green")
        {
            sChange = "clr_green";
        }
        iNewActive = FALSE;
    }
    // BLUE
    else if (!(iRed > 0) && !(iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_blue")
        {
            sChange = "clr_blue";
        }
        iNewActive = FALSE;
    }
    // PURPLE
    else if ((iRed > 0) && !(iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_purple")
        {
            sChange = "clr_purple";
        }
        iNewActive = FALSE;
    }
    // YELLOW
    else if ((iRed > 0) && (iGreen > 0) && !(iBlue > 0))
    {
        if (sColor != "clr_yellow")
        {
            sChange = "clr_yellow";
        }
        iNewActive = FALSE;
    }
    // CYAN
    else if (!(iRed > 0) && (iGreen > 0) && (iBlue > 0))
    {
        if (sColor != "clr_cyan")
        {
            sChange = "clr_cyan";
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
        CreateObject(OBJECT_TYPE_PLACEABLE, sChange, lLoc);
        SetLocalString(oTarget, "sLightTag", sChange);

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
    Debug("** Old Number = " + IntToString(iTotalOld)
        + ", New Number = " + IntToString(iTotalNew));

    if (iEffects == TRUE)
    {
        if (iTotalNew > iTotalOld)
        {
            if (iTotalNew == 3)
            {
                iVFX = VFX_FNF_STRIKE_HOLY;
            }
            else
            {
                iVFX = VFX_IMP_HEALING_M;
            }
        }
        else if (iTotalNew < iTotalOld)
        {
            iVFX = VFX_IMP_HARM;
        }
        else
        {
            iVFX = VFX_IMP_WILL_SAVING_THROW_USE;
        }

        eVFX = EffectVisualEffect(iVFX);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oTarget, 1.0f);
    }

    return (iTotalNew);
}

object CalcTarget(int iX, int iY, int iDir)
{
    object oTarget, oPC;
    string sTargTag, sDebugText;
    int iXb, iYb, iZb;

    // find the destination emitter based on the tile and direction
    // passed by referance.
    switch (iDir)
    {
        //North
        case 1 :
            sTargTag = sCryst + IntToString(0) + "_" + IntToString(iY);
            oTarget = GetObjectByTag(sTargTag);
        break;
        //North East
        case 2 :
            iYb = iY + iX;
            iXb = 0;
            if (iYb > 5)
            {
                iXb = iYb - 5;
                iYb = 5;
            }
            sTargTag = sCryst + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // East
        case 3 :
            sTargTag = sCryst + IntToString(iX) + "_" + IntToString(5);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South East
        case 4 :
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

            sTargTag = sCryst + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South
        case 5 :
            sTargTag = sCryst + IntToString(5) + "_" + IntToString(iY);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // South West
        case 6 :
            iXb = iY + iX;
            iYb = 0;
            if (iXb > 5)
            {
                iYb = iXb - 5;
                iXb = 5;
            }
            sTargTag = sCryst + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // West
        case 7 :
            sTargTag = sCryst + IntToString(iX) + "_" + IntToString(0);
            oTarget = GetObjectByTag(sTargTag);
        break;
        // North West
        case 8 :
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
            sTargTag = sCryst + IntToString(iXb) + "_" + IntToString(iYb);
            oTarget = GetObjectByTag(sTargTag);
        break;
    }

    //sDebugText = "**DEBUG: GetTarget a2_tile_"+ IntToString(iX) + "_" + IntToString(iY)
    //  + " Direction : " + IntToString(iDir) + "; Returned target: " + sTargTag;
    //Debug(sDebugText);

    return oTarget;
}

void Debug(string sMSG)
{
    object oPC = GetFirstPC();

    // send Debug text to all PC's
    while(GetIsObjectValid(oPC) == TRUE)
    {
        //SendMessageToPC(oPC, sMSG);
        oPC = GetNextPC();
    }
}
