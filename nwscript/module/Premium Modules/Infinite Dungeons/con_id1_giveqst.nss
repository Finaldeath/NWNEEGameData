//::////////////////////////////////////////////////////////////////////////////
//:: con_id1_giveqst
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Returns TRUE if the boss isat the state where his/her conversation should
    consist of giving the player a quest.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_boss"

int StartingConditional()
{
    string sTag = GetTag(OBJECT_SELF);
    string sBoss = "";
    if (sTag == ANTOINE_TAG)
    {
        sBoss = "Baccha";
    } else if (sTag == HAGATHA_TAG)
    {
        sBoss = "Hagatha";
    } else if (sTag == MAGGRIS_TAG)
    {
        sBoss = "Maggris";
    } else if (sTag == HARAT_TAG)
    {
        sBoss = "Harat";
    } else if (sTag == GZHORB_TAG)
    {
        sBoss = "Gzhorb";
    } else if (sTag == MASTERIUS_TAG)
    {
        sBoss = "Masterius";
    } else if (sTag == HALASTER_TAG)
    {
        sBoss = "Halaster";
    }
    DebugMessage("sBoss is " + sBoss);

    if (sBoss != "")
    {
        if (GetLocalInt(GetModule(), "b" + sBoss + "Surrender2") == TRUE)
        {
            DebugMessage("  Boss has played surrender line already.");

            SetLocalInt(GetModule(), "nPreviousDungeon", 0);

            return TRUE;
        } else
        {
            DebugMessage("  Boss has not played surrender line.");
        }
    }

    return FALSE;
}
