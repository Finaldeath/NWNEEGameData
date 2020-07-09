#include "inc_id1_utility"
#include "inc_id_liltimmy"

void BossStuff();

void main()
{
    BossStuff();

    SetLocalInt(GetModule(), "bGenerating", FALSE);
}

void BossStuff()
{
    // main plot variables
    int bBacchaQuest = GetLocalInt(GetModule(), "bBacchaQuestActive");
    int bBacchaQuestCompleted = GetLocalInt(GetModule(), "bBacchaQuestCompleted");
    int bBacchaQuestItem = FALSE;
    int bBacchaDead = GetLocalInt(GetModule(), "bBacchaDead");
    int bHagathaQuest = GetLocalInt(GetModule(), "bHagathaQuestActive");
    int bHagathaQuestCompleted = GetLocalInt(GetModule(), "bHagathaQuestCompleted");
    int bHagathaQuestItem = FALSE;
    int bHagathaDead = GetLocalInt(GetModule(), "bHagathaDead");
    int bMaggrisQuest = GetLocalInt(GetModule(), "bMaggrisQuestActive");
    int bMaggrisQuestCompleted = GetLocalInt(GetModule(), "bMaggrisQuestCompleted");
    int bMaggrisQuestItem = FALSE;
    int bMaggrisDead = GetLocalInt(GetModule(), "bMaggrisDead");
    int bHaratQuest = GetLocalInt(GetModule(), "bHaratQuestActive");
    int bHaratQuestCompleted = GetLocalInt(GetModule(), "bHaratQuestCompleted");
    int bHaratQuestItem = FALSE;
    int bHaratDead = GetLocalInt(GetModule(), "bHaratDead");
    int bGzhorbQuest = GetLocalInt(GetModule(), "bGzhorbQuestActive");
    int bGzhorbQuestCompleted = GetLocalInt(GetModule(), "bGzhorbQuestCompleted");
    int bGzhorbQuestItem = FALSE;
    int bGzhorbDead = GetLocalInt(GetModule(), "bGzhorbDead");
    int bMasteriusQuest = GetLocalInt(GetModule(), "bMasteriusQuestActive");
    int bMasteriusQuestCompleted = GetLocalInt(GetModule(), "bMasteriusQuestCompleted");
    int bMasteriusQuestItem = FALSE;
    int bMasteriusDead = GetLocalInt(GetModule(), "bMasteriusDead");

    // destination items
    int bBacchaFindItem = FALSE;
    int bBacchaItemFound = GetLocalInt(GetModule(), "bBacchaQuestItemFound");
    int bHagathaFindItem = FALSE;
    int bHagathaItemFound = GetLocalInt(GetModule(), "bHagathaQuestItemFound");
    int bMaggrisFindItem = FALSE;
    int bMaggrisItemFound = GetLocalInt(GetModule(), "bMaggrisQuestItemFound");
    int bHaratFindItem = FALSE;
    int bHaratItemFound = GetLocalInt(GetModule(), "bHaratQuestItemFound");
    int bGzhorbFindItem = FALSE;
    int bGzhorbItemFound = GetLocalInt(GetModule(), "bGzhorbQuestItemFound");
    int bMasteriusFindItem = FALSE;
    int bMasteriusItemFound = GetLocalInt(GetModule(), "bMasteriusQuestItemFound");

    object oDungeonEntrance = GetObjectByTag("DungeonEntranceStairs");
    object oPC = GetFirstPC();
    object oTempLocation = GetLocalObject(GetModule(), "oTempLocation");
    object oTempLocation2 = oTempLocation;
    object oArea;
    while (oPC != OBJECT_INVALID)
    {
        DebugMessage("Transporting " + GetPCIdentifier(oPC));

        // if this is a level transition, check to see if anyone has needed plot items
        if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE))
        {
            DebugMessage("Baccha's quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_anttot_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Baccha's item is present.");
                bBacchaQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_ant") != OBJECT_INVALID)
            {
                DebugMessage("  Baccha's find item is present.");
                bBacchaFindItem = TRUE;
            }
        }
        if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE))
        {
            DebugMessage("Hagatha's quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_widhair_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Hagatha's item is present.");
                bHagathaQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_hag") != OBJECT_INVALID)
            {
                DebugMessage("  Hagatha's find item is present.");
                bHagathaFindItem = TRUE;
            }
        }
        if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE))
        {
            DebugMessage("Maggris' quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_maggegg_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Maggris' item is present.");
                bMaggrisQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_mag") != OBJECT_INVALID)
            {
                DebugMessage("  Maggris' find item is present.");
                bMaggrisFindItem = TRUE;
            }
        }
        if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE))
        {
            DebugMessage("Harat's quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_harattg_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Harat's item is present.");
                bHaratQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_har1") != OBJECT_INVALID)
            {
                DebugMessage("  Harat's first find item is present.");
                bHaratFindItem = TRUE;
            } else
            {
                if (GetItemPossessedBy(oPC, "id1_bossplot_har2") != OBJECT_INVALID)
                {
                    DebugMessage("  Harat's second find item is present.");
                    bHaratFindItem = TRUE;
                }
            }
        }
        if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE))
        {
            DebugMessage("Gzhorb's quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_gzrbeye_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Gzhorb's item is present.");
                bGzhorbQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_gzb") != OBJECT_INVALID)
            {
                DebugMessage("  Gzhorb's find item is present.");
                bGzhorbFindItem = TRUE;
            }
        }
        if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE))
        {
            DebugMessage("Masterius' quest is active.");
            if (GetItemPossessedBy(oPC, "itm_id1_masbone_dormant") != OBJECT_INVALID)
            {
                DebugMessage("  Masterius' item is present.");
                bMasteriusQuestItem = TRUE;
            }
            if (GetItemPossessedBy(oPC, "id1_bossplot_mas") != OBJECT_INVALID)
            {
                DebugMessage("  Masterius' find item is present.");
                bMasteriusFindItem = TRUE;
            }
        }

        // EDIT: check to see if player meets plot cutscene requirements
        oArea = GetArea(oPC);
        DebugMessage("  Area tag is " + GetTag(oArea));
        if (GetTag(oArea) != "DungeonEntrance")
        {
            // take PC out of cutscene mode
            if (GetCutsceneMode(oPC) == TRUE)
            {
                SetCutsceneMode(oPC, FALSE);
            }

            // reset commoner faction
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPC);

            // check conditions to see if this should be a cutscene
            int nMainPlot = lt_GetDungeonLevel();
            int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");
            DebugMessage("  nMainPlot is " + IntToString(nMainPlot) + " and nTriggerPlot is " + IntToString(nTriggerPlot));
            if ((nMainPlot == ID_LOCAL_FIRST_DUNGEON_COMPLETED) && (nTriggerPlot == 1)) // first lieutenant done
            {
                object oNarratorArea = GetObjectByTag("NarratorArea");
                SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 2);
                SetLocalObject(oNarratorArea, "TeleportWP", oTempLocation2);
                oTempLocation = GetObjectByTag("ID1_STATIC_NARRATOR_START");
            } else if ((nMainPlot == ID_LOCAL_THIRD_DUNGEON_COMPLETED) && (nTriggerPlot == 2)) // all lieutenants done
            {
                object oNarratorArea = GetObjectByTag("NarratorArea");
                SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 3);
                SetLocalObject(oNarratorArea, "TeleportWP", oTempLocation2);
                oTempLocation = GetObjectByTag("ID1_STATIC_NARRATOR_START");
            } else if ((nMainPlot == ID_LOCAL_THIRD_BOSS_DEFEATED) && (nTriggerPlot == 3)) // all inner circle done
            {
                object oNarratorArea = GetObjectByTag("NarratorArea");
                SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 4);
                SetLocalObject(oNarratorArea, "TeleportWP", oTempLocation2);
                oTempLocation = GetObjectByTag("ID1_STATIC_NARRATOR_START");
            } else if ((nMainPlot == ID_LOCAL_HALASTER_TIMMY) && (nTriggerPlot == 4)) // halaster done
            {
                object oNarratorArea = GetObjectByTag("NarratorArea");
                SetLocalInt(oNarratorArea, "NarratorCutsceneNumber", 5);
                SetLocalObject(oNarratorArea, "TeleportWP", oTempLocation2);
                oTempLocation = GetObjectByTag("ID1_STATIC_NARRATOR_START");
            }

            // transport player to start location
            DebugMessage("Clearing actions. Point 4.");
            DelayCommand(0.01, AssignCommand(oPC, ClearAllActions()));
            DelayCommand(0.02, AssignCommand(oPC, ActionJumpToObject(oTempLocation)));

            // setting plot to false to be safe
            if (GetPlotFlag(oPC) == TRUE)
            {
                DebugMessage("Plot flag was set on player.");
            }
            SetPlotFlag(oPC, FALSE);
        }

        // set the respawn point as the dungeon stairs
        SetLocalObject(oPC, "ptr_id1_door", oDungeonEntrance);

        // cycle to next PC
        oPC = GetNextPC();
    }

    // reset little timmy's faction
//    ChangeFaction(GetObjectByTag("id1_littletimmy"), GetObjectByTag("DungeonAngel"));

    // if a needed plot item isn't present
    if ((bBacchaQuest == TRUE) && (bBacchaQuestCompleted == FALSE) && (bBacchaDead == FALSE))
    {
        if (bBacchaQuestItem == FALSE)
        {
            DebugMessage("Baccha's item needed.");
            CreateItemOnObject("itm_id1_anttot1", GetFirstPC());
        }
        if ((bBacchaItemFound == TRUE) && (bBacchaFindItem == FALSE))
        {
            DebugMessage("Baccha's find item needed.");
            CreateItemOnObject("id1_bossplot_ant", GetFirstPC());
        }
    }
    if ((bHagathaQuest == TRUE) && (bHagathaQuestCompleted == FALSE) && (bHagathaDead == FALSE))
    {
        if (bHagathaQuestItem == FALSE)
        {
            DebugMessage("Hagatha's item needed.");
            CreateItemOnObject("itm_id1_widhair1", GetFirstPC());
        }
        if ((bHagathaItemFound == TRUE) && (bHagathaFindItem == FALSE))
        {
            DebugMessage("Hagatha's find item needed.");
            CreateItemOnObject("id1_bossplot_hag", GetFirstPC());
        }
    }
    if ((bMaggrisQuest == TRUE) && (bMaggrisQuestCompleted == FALSE) && (bMaggrisDead == FALSE))
    {
        if (bMaggrisQuestItem == FALSE)
        {
            DebugMessage("Maggris' item needed.");
            CreateItemOnObject("itm_id1_maggegg1", GetFirstPC());
        }
        if ((bMaggrisItemFound == TRUE) && (bMaggrisFindItem == FALSE))
        {
            DebugMessage("Maggris' find item needed.");
            CreateItemOnObject("id1_bossplot_mag", GetFirstPC());
        }
    }
    if ((bHaratQuest == TRUE) && (bHaratQuestCompleted == FALSE) && (bHaratDead == FALSE))
    {
        if (bHaratQuestItem == FALSE)
        {
            DebugMessage("Harat's item needed.");
            CreateItemOnObject("itm_id1_harattg1", GetFirstPC());
        }
        if ((bHaratItemFound == TRUE) && (bHaratFindItem == FALSE))
        {
            DebugMessage("Harat's find item needed.");
            CreateItemOnObject("id1_bossplot_har1", GetFirstPC());
        }
    }
    if ((bGzhorbQuest == TRUE) && (bGzhorbQuestCompleted == FALSE) && (bGzhorbDead == FALSE))
    {
        if (bGzhorbQuestItem == FALSE)
        {
            DebugMessage("Gzhorb's item needed.");
            CreateItemOnObject("itm_id1_gzrbeye1", GetFirstPC());
        }
        if ((bGzhorbItemFound == TRUE) && (bGzhorbFindItem == FALSE))
        {
            DebugMessage("Gzhorb's find item needed.");
            CreateItemOnObject("id1_bossplot_gzb", GetFirstPC());
        }
    }
    if ((bMasteriusQuest == TRUE) && (bMasteriusQuestCompleted == FALSE) && (bMasteriusDead == FALSE))
    {
        if (bMasteriusQuestItem == FALSE)
        {
            DebugMessage("Masterius' item needed.");
            CreateItemOnObject("itm_id1_masbone1", GetFirstPC());
        }
        if ((bMasteriusItemFound == TRUE) && (bMasteriusFindItem == FALSE))
        {
            DebugMessage("Masterius' find item needed.");
            CreateItemOnObject("id1_bossplot_mas", GetFirstPC());
        }
    }
}

