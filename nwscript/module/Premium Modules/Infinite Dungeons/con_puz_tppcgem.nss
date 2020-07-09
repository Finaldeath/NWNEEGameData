//::////////////////////////////////////////////////////////////////////////////
//:: con_puz_tppcgem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Determines if the player has an appropriate gem in their inventory and the
    crystal is not already active.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Aug 15, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_puz_trpsprsn"

int StartingConditional()
{
    object oPC, oGem, oThis, oPedestal;
    string sTag;
    int nCrystal;

    oThis = OBJECT_SELF;
    oPC = GetPCSpeaker();

    nCrystal = GetLocalInt(oThis, S_CRYSTAL_NUM);
    sTag = S_PEDESTAL_TAG_PRFX + IntToString(nCrystal);
    oPedestal = GetObjectByTag(sTag);

    if (oPedestal == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag);
    }

    // If the pedestal is already active the player cannot place another gem.
    if (GetLocalInt(oPedestal, S_STATE_INT) == N_ACTIVE_STATE)
    {
        DebugMessage("Pedestal already active.");

        return FALSE;
    }

    oGem = GetItemPossessedBy(oPC, S_GEM_RESREF);

    // If the player has no more gems to place.
    if (oGem == OBJECT_INVALID)
    {
        DebugMessage("Player has no gems.");

        return FALSE;
    }

    return TRUE;
}
