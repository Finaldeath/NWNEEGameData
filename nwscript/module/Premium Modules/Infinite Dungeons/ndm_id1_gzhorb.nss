//::////////////////////////////////////////////////////////////////////////////
//:: ndm_id1_gzhorb
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Damaged Event script for G'Zhorb.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 19, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_gzhorb"

void main()
{
    object oThis = OBJECT_SELF;

    // If the plot flag is set in an on damage event we should ignore
    // special behaviours.
    if (GetPlotFlag(oThis)) return;

    int nHits = GetLocalInt(oThis, GZHORB_HITS);

    nHits++;

    DebugMessage("G'Zhorb has been hit " + IntToString(nHits) + " times.");

    if (Random(100) < nHits * 20) // 20% chance per time hit that gzhorb will run.
    {
        SetLocalInt(oThis, GZHORB_HITS, 0);

        GZ_JumpRooms();
    }
    else // Increment the hit counter for next time.
    {
        SetLocalInt(oThis, GZHORB_HITS, nHits);
    }
}
