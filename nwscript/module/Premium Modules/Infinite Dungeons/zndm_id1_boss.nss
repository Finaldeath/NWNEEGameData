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
    string sBoss;
    string sJournal;
    string sTag = GetTag(OBJECT_SELF);
    DebugMessage("Damaged boss tag is " + sTag);
    if (sTag == ANTOINE_TAG)
    {
        bBoss = TRUE;
        sBoss = "Baccha";
        sJournal = "id1_baccha";
    } else if (sTag == HAGATHA_TAG)
    {
        bBoss = TRUE;
        sBoss = "Hagatha";
        sJournal = "id1_hagatha";
    } else if (sTag == MAGGRIS_TAG)
    {
        bBoss = TRUE;
        sBoss = "Maggris";
        sJournal = "id1_maggris";
    } else if (sTag == HARAT_TAG)
    {
        bBoss = TRUE;
        sBoss = "Harat";
        sJournal = "id1_harat";
    } else if (sTag == GZHORB_TAG)
    {
        bBoss = TRUE;
        sBoss = "Gzhorb";
        sJournal = "id1_gzhorb";
    } else if (sTag == MASTERIUS_TAG)
    {
        bBoss = TRUE;
        sBoss = "Masterius";
        sJournal = "id1_masterius";
    } else if (sTag == HALASTER_TAG)
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
            // if its defeated
            if (nHitPoints == 1)
            {
                BossSurrender();

                return;
            }
        } else if (bHostile == TRUE)
        {
            // if dead
            if (nHitPoints < 1)
            {
                int nCurrentDungeon = GetLocalInt(GetModule(), "nCurrentDungeon");
                DebugMessage("Current dungeon is " + IntToString(nCurrentDungeon));
                if ((bQuestActive == TRUE) && (nCurrentDungeon < 0))
                {
                    AddJournalQuestEntry(sJournal, 35, GetFirstPC(), TRUE, TRUE, TRUE);

                    // EDIT: add killed boss main journal entry, but DO NOT overwrite higher entry

                    // EDIT: spawn treasure

                    return;
                } else
                {
                    return;
                }
            }
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

        if (sTag == MASTERIUS_TAG)
        {
            ExecuteScript("ndm_id1_masteriu", OBJECT_SELF);
        }
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
