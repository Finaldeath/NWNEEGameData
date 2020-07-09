//::////////////////////////////////////////////////////////////////////////////
//:: ndm_id1_boss
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Default On Damaged script with some additions for the bosses of Infinite
    Dungeons.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11, 2003
//:: Modified By: Grant Mackay
//:: Modified On: Sep 22, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id_liltimmy"
#include "inc_id1_boss"

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    int bBoss;
    string sBoss, sJournal;
    string sTag = GetTag(OBJECT_SELF);

    DebugMessage("Damaged boss tag is " + sTag);

    if (sTag == ANTOINE_TAG)
    {
        bBoss = TRUE;
        sBoss = "Baccha";
        sJournal = "id1_baccha";
    }
    else if (sTag == HAGATHA_TAG)
    {
        bBoss = TRUE;
        sBoss = "Hagatha";
        sJournal = "id1_hagatha";
    }
    else if (sTag == MAGGRIS_TAG)
    {
        bBoss = TRUE;
        sBoss = "Maggris";
        sJournal = "id1_maggris";
    }
    else if (sTag == HARAT_TAG)
    {
        bBoss = TRUE;
        sBoss = "Harat";
        sJournal = "id1_harat";
    }
    else if (sTag == GZHORB_TAG)
    {
        bBoss = TRUE;
        sBoss = "Gzhorb";
        sJournal = "id1_gzhorb";
    }
    else if (sTag == MASTERIUS_TAG)
    {
        bBoss = TRUE;
        sBoss = "Masterius";
        sJournal = "id1_masterius";
    }
    else if (sTag == HALASTER_TAG)
    {
        bBoss = TRUE;
        sBoss = "Halaster";
    }

    // if this is a boss
    if (bBoss == TRUE)
    {
        int bSurrender = GetLocalInt(GetModule(), "b" + sBoss + "Surrender");
        int bHostile = GetLocalInt(GetModule(), "b" + sBoss + "Hostile");
        int bQuestActive = GetLocalInt(GetModule(), "b" + sBoss + "QuestActive");

        DebugMessage("Surrender = " + IntToString(bSurrender) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive));

        int nHitPoints = GetCurrentHitPoints();

        DebugMessage("Boss hit points = " + IntToString(nHitPoints));

        // if the creature has not already surrendered
        if (bSurrender == FALSE)
        {
            // Check to make sure we're in a plot dungeon.
            object oDungeon = GetCurrentDungeon();

            int nDungeon = GetLocalInt(GetModule(), "nDungeonNumber");
            int bPlot = (nDungeon < 0) && (nDungeon > -8);

            DebugMessage("Boss is in nDungeon " + IntToString(nDungeon));

            // if its defeated
            if (nHitPoints == 1)
            {
                if (bPlot) // Boss surrenders if the dungeon is plot.
                {
                    BossSurrender();
                }
                else // The boss should die.
                {
                    if (sTag == GZHORB_TAG && !GetLocalInt(OBJECT_SELF, "bDying"))
                    {
                        // Current position.
                        object oArea = GetArea(OBJECT_SELF);
                        vector vPos = GetPosition(OBJECT_SELF);
                        float fOrnt = GetFacing(OBJECT_SELF);

                        // Update to be just north enough of myself to be lootable.
                        vPos = Vector(vPos.x, vPos.y + 3.0, vPos.z);

                        location lLoc = Location(oArea, vPos, fOrnt);

                        // Jump there.
                        ClearAllActions(TRUE);
                        JumpToLocation(lLoc);
                        SetLocalInt(OBJECT_SELF, "bDying", TRUE);
                    }
                    else
                    {
                        SetImmortal(OBJECT_SELF, FALSE);
                    }
                }
            } // if (nHitPoints == 1)
        }

        // Specific boss damage handling if any here.
        if (sTag == ANTOINE_TAG)
        {
            ExecuteScript("ndm_id1_antoine", OBJECT_SELF);
        }

        if (sTag == GZHORB_TAG)
        {
            ExecuteScript("ndm_id1_gzhorb", OBJECT_SELF);
        }

        if (sTag == HARAT_TAG)
        {
            ExecuteScript("ndm_id1_harat", OBJECT_SELF);
        }

        if (sTag == HAGATHA_TAG)
        {
            ExecuteScript("ndm_id1_hagatha", OBJECT_SELF);
        }
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
