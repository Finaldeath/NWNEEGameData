//::////////////////////////////////////////////////////////////////////////////
//:: pdm_id1_gzwall
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Damage Event script for the wall boulder placeables in the caverns of
    G'Zhorb. Determines if a cave-in occurs as the walls are being struck based
    on a precentage stored on the nearest 'hole' object.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 19, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_gzhorb"

void main()
{
    // Grab the damage done.
    int nDMG = GetTotalDamageDealt();

    // Based on room number get the nearest hole.
    int nRoom = GetLocalInt(OBJECT_SELF, ROOM_NUM);
    object oHole = DB_GetNearestObjectByTag(HOLE_PLC_PRFX + IntToString(nRoom));
    object oArea = GetArea(oHole);

    // Determine the chance for a cave in.
    int bSurrender = GetLocalInt(GetModule(), "bGzhorbSurrender");
    int nCaveIn = GetLocalInt(oHole, HOLE_CAVE_IN_CHANCE);
    int bCaveIn = GetLocalInt(oHole, HOLE_DESTROYED);
    int nCaveIns = GetLocalInt(oArea, ROOMS_CAVED);
    int bCaveIns = (nCaveIns == 7) || bSurrender;
        // 7 rooms have been collapsed or G'Zhorb has surrendered.

    // Determine if a cave in has occured.
    if (Random(100) < nCaveIn && !bCaveIn && !bCaveIns)
    {
        // Debug
        DebugMessage("Cave in room " + IntToString(nRoom));

        // Gzhorb will leave if his room is collapsing.
        object oGzhorb = DB_GetObjectByTag(GZHORB_TAG);
        int nGzhorb = GetLocalInt(oGzhorb, ROOM_NUM);

        DebugMessage("Gzhorb is in room " + IntToString(nGzhorb));

        if (nGzhorb == nRoom)
        {
            GZ_JumpRooms();
        }

        // Run the cave in animations.
        DelayCommand(0.5, AssignCommand(oHole, RunCaveIn(oHole)));
    }
    // Random chance for some rubble to fall from the ceiling.
    else if (Random(50) < nDMG)
    {
        object oArea = GetArea(oHole);
        effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
        vector vPos = GetPosition(oHole);

        float fX, fY;
        location lLoc;

        // Random positive/negative multiplier for the x scew.
        if (Random(2))
        {
            fX = -1.0;
        }
        else
        {
            fX = 1.0;
        }

        // Random positive/negative multiplier for they y scew.
        if (Random(2))
        {
            fY = -1.0;
        }
        else
        {
            fY = 1.0;
        }

        // Scew the x and y values to create a new, random, location.
        fX = vPos.x + fX * (IntToFloat(Random(5)) + 5.0);
        fY = vPos.y + fY * (IntToFloat(Random(5)) + 5.0);

        vPos = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos, 0.0);

        // Drop some rocks on the location.
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc);
    }
    else if (Random(50) < nDMG)
    {
        ShakeScreen();
    }
}
