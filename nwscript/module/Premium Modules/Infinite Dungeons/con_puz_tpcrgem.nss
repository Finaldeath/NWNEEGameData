//::////////////////////////////////////////////////////////////////////////////
//:: con_puz_tppcgem
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Determines if the crystal has had a gem placed.
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

    nCrystal = GetLocalInt(oThis, S_CRYSTAL_NUM);
    sTag = S_PEDESTAL_TAG_PRFX + IntToString(nCrystal);
    oPedestal = GetObjectByTag(sTag);

    if (oPedestal == OBJECT_INVALID)
    {
        DebugMessage("INVALID object retrieved: " + sTag);
    }

    if (GetLocalInt(oPedestal, S_STATE_INT) == N_ACTIVE_STATE)
    {
        return TRUE;
    }

    return FALSE;
}
