//::///////////////////////////////////////////////
//:: cut_id1_antoin_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Antoine boss battle intro cutscene (end script).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "inc_id1_antoine"
#include "_inc_cutscene"

void main()
{
    // Call the area setup function. Normally this is called in the area
    // OnEnter script, but when a cutscene runs we need to delay it until
    // the cutscene finishes.
    DebugMessage("  Area is not activated. Setting up.");
    Setup();
}
