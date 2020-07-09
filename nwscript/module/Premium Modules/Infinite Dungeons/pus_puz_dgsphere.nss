//::////////////////////////////////////////////////////////////////////////////
//:: puc_puz_dgsphere
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Used script for the energized sphere placeables involved in the direction
    grid puzzle.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: July 27, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_drctngrd"

void main()
{
    object oPC = GetLastUsedBy();
    object oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);

    // Set the player as a variable on the puzzle waypoint for reference in the
    // case of a solution.
    SetLocalObject(oPuzzleWP, O_PUZZLE_SOLVER, oPC);

    ActivateSpheres();
}
