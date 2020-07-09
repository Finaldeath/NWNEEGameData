//::///////////////////////////////////////////////
//:: cac_a2_tlcleard
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Clears the Tile, but re-initiates the
    original color.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

#include "inc_a2_crystpuzz"
void main()
{
    object oTile = OBJECT_SELF;
    int iColor = GetLocalInt(oTile, "iCOLOR");

    ActionPauseConversation();

    // Clear the tile, but restore the Color Variable.
    ExecuteScript("cac_a2_tlclear", oTile);
    DelayCommand(0.5f, SetLocalInt(oTile, "iCOLOR", iColor));

    DelayCommand(0.6f, ActionResumeConversation());
}
