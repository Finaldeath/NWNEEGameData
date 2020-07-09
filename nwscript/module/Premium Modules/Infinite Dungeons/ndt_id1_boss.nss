//::///////////////////////////////////////////////
//:: Name x2_def_ondeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDeath script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_score"
#include "inc_id1_boss"
#include "inc_id_liltimmy"

void main()
{
    DebugMessage("");

    int bClean = GetLocalInt(OBJECT_SELF, "bClean");
    if (bClean == FALSE)
    {
        DebugMessage("Boss is not being cleaned.");

        object oDungeon = GetCurrentDungeon();
        string sTag = GetTag(OBJECT_SELF);
        DebugMessage("Boss tag is " + sTag);
        object oWaypoint = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER");

        int nDungeonNumber = GetLocalInt(GetModule(), "nDungeonNumber");
        DebugMessage("nDungeonNumber is " + IntToString(nDungeonNumber));

        SetLocalInt(oDungeon, "bBossDead", TRUE);

        if (nDungeonNumber < 0)
        {
            // March 27, 2006 - Grant.
            // Moved GetTag call outside of if for use in the remainder
            // of the function.

            int nFirstLieutenant = lt_GetFirstLieutenant();
            int nSecondLieutenant = lt_GetSecondLieutenant();
            int nThirdLieutenant = lt_GetThirdLieutenant();
            int nFirstBoss = lt_GetFirstBoss();
            int nSecondBoss = lt_GetSecondBoss();
            int nThirdBoss = lt_GetThirdBoss();

            int nDungeonLevel = lt_GetDungeonLevel();

            object oPC = GetFirstPC();

            // if baccha
            if (sTag == ANTOINE_TAG)
            {
                SetLocalInt(GetModule(), "bBacchaDead", TRUE);
                if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
                {
                    AddJournalQuestEntry("id1_main", 20, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_COMPLETED);
                    }
                } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
                {
                    AddJournalQuestEntry("id1_main", 30, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_DUNGEON_COMPLETED);
                    }
                } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_WEREBOAR)
                {
                    AddJournalQuestEntry("id1_main", 40, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_DUNGEON_COMPLETED);
                    }
                }

                if (GetLocalInt(GetModule(), "bBacchaQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_baccha", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }

            // if hagatha
            if (sTag == HAGATHA_TAG)
            {
                SetLocalInt(GetModule(), "bHagathaDead", TRUE);
                if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
                {
                    AddJournalQuestEntry("id1_main", 21, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_COMPLETED);
                    }
                } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
                {
                    AddJournalQuestEntry("id1_main", 31, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_DUNGEON_COMPLETED);
                    }
                } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_GIANTESS)
                {
                    AddJournalQuestEntry("id1_main", 41, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_DUNGEON_COMPLETED);
                    }
                }

                if (GetLocalInt(GetModule(), "bHagathaQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_hagatha", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }

            // if maggris
            if (sTag == MAGGRIS_TAG)
            {
                SetLocalInt(GetModule(), "bMaggrisDead", TRUE);
                if (nFirstLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
                {
                    AddJournalQuestEntry("id1_main", 22, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_DUNGEON_COMPLETED);
                    }
                } else if (nSecondLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
                {
                    AddJournalQuestEntry("id1_main", 32, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_DUNGEON_COMPLETED);
                    }
                } else if (nThirdLieutenant == ID_LOCAL_LIEUTENANT_INSECT)
                {
                    AddJournalQuestEntry("id1_main", 42, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_DUNGEON_COMPLETED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_DUNGEON_COMPLETED);
                    }
                }

                if (GetLocalInt(GetModule(), "bMaggrisQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_maggris", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }

            // if harat
            if (sTag == HARAT_TAG)
            {
                SetLocalInt(GetModule(), "bHaratDead", TRUE);
                if (nFirstBoss == ID_LOCAL_BOSS_DEMON)
                {
                    AddJournalQuestEntry("id1_main", 50, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
                    }
                } else if (nSecondBoss == ID_LOCAL_BOSS_DEMON)
                {
                    AddJournalQuestEntry("id1_main", 60, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
                    }
                } else if (nThirdBoss == ID_LOCAL_BOSS_DEMON)
                {
                    AddJournalQuestEntry("id1_main", 70, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
                    }
                }

                if (GetLocalInt(GetModule(), "bHaratQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_harat", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }

            // if gzhorb
            if (sTag == GZHORB_TAG)
            {
                SetLocalInt(GetModule(), "bGzhorbDead", TRUE);
                if (nFirstBoss == ID_LOCAL_BOSS_BEHOLDER)
                {
                    AddJournalQuestEntry("id1_main", 51, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
                    }
                } else if (nSecondBoss == ID_LOCAL_BOSS_BEHOLDER)
                {
                    AddJournalQuestEntry("id1_main", 61, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
                    }
                } else if (nThirdBoss == ID_LOCAL_BOSS_BEHOLDER)
                {
                    AddJournalQuestEntry("id1_main", 71, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
                    }
                }

                if (GetLocalInt(GetModule(), "bGzhorbQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_gzhorb", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }

            // if masterius
            if (sTag == MASTERIUS_TAG)
            {
                SetLocalInt(GetModule(), "bMasteriusDead", TRUE);
                if (nFirstBoss == ID_LOCAL_BOSS_LICH)
                {
                    AddJournalQuestEntry("id1_main", 52, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_FIRST_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_FIRST_BOSS_DEFEATED);
                    }
                } else if (nSecondBoss == ID_LOCAL_BOSS_LICH)
                {
                    AddJournalQuestEntry("id1_main", 62, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_SECOND_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_SECOND_BOSS_DEFEATED);
                    }
                } else if (nThirdBoss == ID_LOCAL_BOSS_LICH)
                {
                    AddJournalQuestEntry("id1_main", 72, oPC, TRUE, TRUE);
                    if (nDungeonLevel < ID_LOCAL_THIRD_BOSS_DEFEATED)
                    {
                        lt_SetDungeonLevel(ID_LOCAL_THIRD_BOSS_DEFEATED);
                    }
                }

                if (GetLocalInt(GetModule(), "bMasteriusQuestActive") == TRUE)
                {
                    AddJournalQuestEntry("id1_masterius", 35, oPC, TRUE, TRUE);
                }

                // create portal
                SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

                // add map pin
                SetMapPinEnabled(oWaypoint, TRUE);

                // create teleporter
                CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
            }
        } else
        {
            DebugMessage("Spawning boss teleporter.");

            // Spawn in a teleporter and flag the boss as dead.
            // create portal
            SetLocalInt(oDungeon, "bBossTeleporter", TRUE);

            // add map pin
            SetMapPinEnabled(oWaypoint, TRUE);

            // create teleporter
            CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oWaypoint));
        }

        // April 5, 2006 GM: Award some creature killed points with the
        // the boss flag on the creature.
        SetLocalInt(OBJECT_SELF, "bBoss", TRUE);

        // give each player an experience reward for completing the boss quest
        int nBossLevel = GetLocalInt(oDungeon, "nBossLevel");
        int nReward = nBossLevel * 500;
        object oPC = GetFirstPC();
        while (oPC != OBJECT_INVALID)
        {
            GiveXPToCreature(oPC, nReward);
            AwardCreatureKilledPoints(oPC);

            oPC = GetNextPC();
        }

        // March 27, 2006 - Grant.
        // Bosses need to drop loot.
        BossTransferLoot(OBJECT_SELF);

        // And unlock their areas.
        LockArea(GetArea(OBJECT_SELF), TRUE);
    }

    // Update Oct 20, 2005 for Infinite Dungeons.
    // Determine if the creature is currently a follower.
    // If so run the henchmen AI otherwise run the default.
    // - Grant Mackay
    if (GetLocalInt(OBJECT_SELF, "bFollower"))
    {
        ExecuteScript("ndt_potsc_hench", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_default7", OBJECT_SELF);
    }
}
