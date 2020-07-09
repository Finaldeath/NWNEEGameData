//::////////////////////////////////////////////////////////////////////////////
//:: con_puz_tpsmmd
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Starting Conditional for the crystal conversation in the 'Trip's Prison'
    puzzle. Returns TRUE if the imp has already been summoned once and the
    crystals are, therefore, active.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

int StartingConditional()
{
    object oPuzzleWP = GetNearestObjectByTag(CREATE_WP_TAG);

    return GetLocalInt(oPuzzleWP, S_SUMMONED_BOOL);
}
