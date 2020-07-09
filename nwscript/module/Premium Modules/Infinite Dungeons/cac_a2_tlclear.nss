//::///////////////////////////////////////////////
//:: cac_a2_tlclear
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Clear the tile and update any targeted
     emmiters this tile may effect.
     Update July 20, 2005: Now uses the updated
     include file for Infinite dungeons.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_puz_crstpzzl"
void main()
{
    object oTile = OBJECT_SELF;
    object oArrow = GetLocalObject(oTile, "TILE_ARROW");
    object oTarget;

    int iColor = GetLocalInt(oTile, "iCOLOR");
    int iDirection = GetLocalInt(oTile, "iDIRECTION");
    int iXCord = StringToInt(GetSubString(GetTag(oTile), 8, 1));
    int iYCord = StringToInt(GetSubString(GetTag(oTile), 10, 1));

    // destroy the arrow and reset the local data
    DestroyObject(oArrow);
    SetLocalInt(oTile, "iCOLOR", 0);
    SetLocalInt(oTile, "iDIRECTION", 0);

    // find the target emitter of the arrow that existed here
    oTarget = CalcTarget(iXCord, iYCord, iDirection);

    // update the target emitters local data
    if (iColor == COLOR_RED)
    {
        iColor = GetLocalInt(oTarget, "ADDITV_RED_COUNT") - 1;
        SetLocalInt(oTarget, "ADDITV_RED_COUNT", iColor);
    }
    else if (iColor == COLOR_GREEN)
    {
        iColor = GetLocalInt(oTarget, "ADDITV_GREEN_COUNT") - 1;
        SetLocalInt(oTarget, "ADDITV_GREEN_COUNT", iColor);
    }
    else if (iColor == COLOR_BLUE)
    {
        iColor = GetLocalInt(oTarget, "ADDITV_BLUE_COUNT") - 1;
        SetLocalInt(oTarget, "ADDITV_BLUE_COUNT", iColor);
    }

    // Update the instance of the light for the target emitter
    RenderLight(oTarget, TRUE);
}
