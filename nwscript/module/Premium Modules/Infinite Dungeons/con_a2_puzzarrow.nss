//::///////////////////////////////////////////////
//:: con_a2_puzzarrow
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is there an arrow associated with this tile
    already?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oTile = OBJECT_SELF;
    object oArrow = GetLocalObject(oTile, "TILE_ARROW");
    int iResult = FALSE;

    // if this is a valid object there is already an associated tile.
    if (GetIsObjectValid(oArrow) == TRUE)
    {
        iResult = TRUE;
    }

    return iResult;
}
