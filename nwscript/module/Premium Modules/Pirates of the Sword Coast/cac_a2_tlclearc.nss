//::///////////////////////////////////////////////
//:: cac_a2_tlclearc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Clears the Tile, but re-initiates the
    original Direction.

    (Clears the tile and the color)
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_a2_crystpuzz"
void main()
{
    object oTile = OBJECT_SELF;
    int iDirection = GetLocalInt(oTile, "iDIRECTION");

    ActionPauseConversation();

    // Clear the tile, but restore the Direction Variable.
    ExecuteScript("cac_a2_tlclear", oTile);
    DelayCommand(0.5f, SetLocalInt(oTile, "iDIRECTION", iDirection));

    DelayCommand(0.6f, ActionResumeConversation());
}
