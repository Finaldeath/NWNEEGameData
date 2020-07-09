//::////////////////////////////////////////////////////////////////////////////
//:: pdt_id1_gzwall
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Destruction Event script for the walls in the caverns of G'Zhorb. Adds
    25% to the chance that a cave-in will occur in the room which the object
    formerly inhabited.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 19, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_gzhorb"

void main()
{
    // Based on room number get the nearest hole.
    int nRoom = GetLocalInt(OBJECT_SELF, ROOM_NUM);
    object oHole = DB_GetNearestObjectByTag(HOLE_PLC_PRFX + IntToString(nRoom));

    // Increment the cave-in probability by 25%.
    int nCaveIn = GetLocalInt(oHole, HOLE_CAVE_IN_CHANCE);

    nCaveIn += 25;

    SetLocalInt(oHole, HOLE_CAVE_IN_CHANCE, nCaveIn);
}
