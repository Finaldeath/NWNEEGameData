//::////////////////////////////////////////////////////////////////////////////
//:: con_id1_srrndr
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Conversation starting conditional that will return TRUE if the creature has
    the 'surrendered' flag set on them. The surrendered flag is set on a boss
    when it is deafeated (brought to 1 hitpoint) in combat. In addition if the
    starting condition is TRUE the inital converse flag is set to indicate the
    bosses next dialog.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
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
        if (GetLocalInt(GetModule(), "b" + sBoss + "Surrender") == TRUE)
        {
            DebugMessage("  Boss has surrendered.");

            SetLocalInt(GetModule(), "b" + sBoss + "Surrender2", TRUE);

            // give each player an experience reward for completing the boss quest
            object oDungeon = GetCurrentDungeon();
            int nBossLevel = GetLocalInt(oDungeon, "nBossLevel");
            int nReward = nBossLevel * 500;
            object oPC = GetFirstPC();
            while (oPC != OBJECT_INVALID)
            {
                GiveXPToCreature(oPC, nReward);

                oPC = GetNextPC();
            }

            return TRUE;
        } else
        {
            DebugMessage("  Boss has not surrendered.");
        }
    }

    return FALSE;
}
