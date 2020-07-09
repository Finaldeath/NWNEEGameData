//::///////////////////////////////////////////////
//:: cac_a2_tlset
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script Sets the tile with the local
     previously stored temp data. Once the
     information has been colliated into somthing
     useful it is sent to the emitter.

     Update July 21, 2005: Commented out PotSC
     specific plot handling/journal updates.
     Edited to use the new include file for use
     in inifinite dungeons.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_puz_crstpzzl"

// void PuzzleWinCutscene();

void main()
{
    //object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oTile = OBJECT_SELF;
    object oTarget, oArrow;

    vector vLoc = GetPosition(oTile);
    vector vNew = Vector(vLoc.x, vLoc.y, vLoc.z + 0.02);

    location lObject = Location(GetArea(OBJECT_SELF), vNew, 0.0);
    //int iEXP = GetJournalQuestExperience("a2_vantab");

    // gather all the temp data
    int iSubColor = GetLocalInt(oTile, "iTempColor");
    int iDirection = GetLocalInt(oTile, "iTempDirection");
    int iXCord = StringToInt(GetSubString(GetTag(oTile), 8, 1));
    int iYCord = StringToInt(GetSubString(GetTag(oTile), 10, 1));
    int iWinner = FALSE;
    SetLocalInt(oTile, "iCOLOR", iSubColor);
    SetLocalInt(oTile, "iDIRECTION", iDirection);

    // find the target emitter
    oTarget = CalcTarget(iXCord, iYCord, iDirection);

    // store the temp data on the emitter and create the arrow
    if (iSubColor == COLOR_RED)
    {
        iSubColor = GetLocalInt(oTarget, "ADDITV_RED_COUNT")+1;
        SetLocalInt(oTarget, "ADDITV_RED_COUNT", iSubColor);
        oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, S_RED_ARRW_RESREF, lObject);
    }
    else if (iSubColor == COLOR_GREEN)
    {
        iSubColor = GetLocalInt(oTarget, "ADDITV_GREEN_COUNT")+1;
        SetLocalInt(oTarget, "ADDITV_GREEN_COUNT", iSubColor);
        oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, S_GRN_ARRW_RESREF, lObject);
    }
    else if (iSubColor == COLOR_BLUE)
    {
        iSubColor = GetLocalInt(oTarget, "ADDITV_BLUE_COUNT")+1;
        SetLocalInt(oTarget, "ADDITV_BLUE_COUNT", iSubColor);
        oArrow = CreateObject(OBJECT_TYPE_PLACEABLE, S_BLU_ARRW_RESREF, lObject);
    }

    // Set the arrow to face the emitter it targets
    AssignCommand(oArrow, SetFacingPoint(GetPosition(oTarget)));
    SetLocalObject(oTile, "TILE_ARROW", oArrow);

    // Update the light on the emiter
    if (RenderLight(oTarget, TRUE) == 3)
    {
        iWinner = CheckPuzzle();
        // Do we have a winner?
        if (iWinner != FALSE)
        {
            // JE: It is important to run this function off of a different
            // object, because this object is about to be destroyed.
            // AssignCommand(GetArea(OBJECT_SELF), PuzzleWinCutscene());
            object oPuzzleWP = DB_GetNearestObjectByTag(CREATE_WP_TAG);
            object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", GetLocation(oPuzzleWP));
            AssignCommand(oInvis, EndPuzzle(oPC));

            //K2 - update the plot and reward the player.
            //HandoutQuestXP(oPC, iEXP);
            //SetLocalInt(oModule, "A2_VANTAB", 30);
            //AddJournalQuestEntry("a2_vantab", 30, oPC);
        }
    }
}

void PuzzleWinCutscene()
{
    // JE: Start portal-opening cutscene
    //cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    //cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE);
    //cs_StartCutscene_Poly("cut_a2_puzzw", "cut_a2_puzzw_end", 1.0, TRUE);
}
