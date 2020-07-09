//:://////////////////////////////////////////////////////////////
//:: exe_id1_catalog                                            //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
    This script controls the catalog process. This process is
    divided into a number of different stages:
        - dungeon entrance area (exe_id1_catbase)
        - emergency up area (exe_id1_cateup)
        - emergency down area (exe_id1_catedown)
        - basic dungeon areas (exe_id1_catarea)
        - boss areas (exe_id1_catbossz)
        - tileset list (exe_id1_cattile)
        - theme list (exe_id1_cattheme)
        - theme sets (exe_id1_catsets)
        - tileset linkings (exe_id1_catlink)
        - tileset themes (exe_id1_cattithe)
        - decor items (exe_id1_catdecor)
        - puzzles (exe_id1_catpuzz)
        - secret doors (exe_id1_catsdoor)
        - monsters (exe_id1_catmon)
        - trap damage types (exe_id1_cattrap)
        - treasure containers (exe_id1_catcon)
        - clean up
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: September 2005                                 //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id_liltimmy"
#include "_inc_cutscene"

void UpdatePlayers(string sMessage);

//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    // loop that steps through each process in the catalog
    int nProcess = GetLocalInt(GetModule(), "nCatalogProcess");

    object oPC;
    object oNarrator;
    object oMicroCPU;
    object oSpeaker = GetObjectByTag("CatalogSpeaker");

    // start the appropriate generation process
    switch (nProcess)
    {
        case 0:
            DebugMessage("Catalog begins.");

            // emergency up area
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            AssignCommand(oSpeaker, SpeakString("Cataloging emergency up area. (1%)"));

            DebugMessage("Cataloging emergency up area.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cateup", GetNextCPU()));

            break;

        case 1:
            // emergency down area
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            AssignCommand(oSpeaker, SpeakString("Cataloging emergency down area. (2%)"));

            DebugMessage("Cataloging emergency down area.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catedown", GetNextCPU()));

            break;

        case 2:
            // dungeon areas
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 1);
            SetLocalInt(GetModule(), "nQueueMax", 0);
            SetLocalInt(GetModule(), "nMicroNum", 0);
            SetLocalInt(GetModule(), "nMicroDead", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging dungeon areas. (12%)"));

            DebugMessage("Cataloging dungeon areas.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catarea", GetNextCPU()));

            break;

        case 3:
            // boss areas
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 1);

            AssignCommand(oSpeaker, SpeakString("Cataloging boss areas. (16%)"));

            DebugMessage("Cataloging boss areas.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catboss", GetNextCPU()));

            break;

        case 4:
            // theme list
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging theme list. (17%)"));

            DebugMessage("Cataloging theme list.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattheme", GetNextCPU()));

            break;

        case 5:
            // theme sets
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);
            SetLocalInt(GetModule(), "nMicroNum", 0);
            SetLocalInt(GetModule(), "nMicroDead", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging theme sets. (18%)"));

            DebugMessage("Cataloging theme sets.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catsets", GetNextCPU()));

            break;

        case 6:
            // tileset list
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging tileset list. (20%)"));

            DebugMessage("Cataloging tileset list.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattile", GetNextCPU()));

            break;

        case 7:
            // tileset linking
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 1);
            SetLocalInt(GetModule(), "nMicroNum", 0);
            SetLocalInt(GetModule(), "nMicroDead", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging tileset linkings. (22%)"));

            DebugMessage("Cataloging tileset linkings.");

            // EDIT: this will crash for huge numbers of tilesets
            DelayCommand(0.01, ExecuteScript("exe_id1_catlink", GetNextCPU()));

            break;

        case 8:
            // tileset themes
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 1);
            SetLocalInt(GetModule(), "nMicroNum", 0);
            SetLocalInt(GetModule(), "nMicroDead", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging tileset themes. (24%)"));

            DebugMessage("Cataloging tileset themes.");

            // EDIT: this will crash for huge numbers of themes
            DelayCommand(0.01, ExecuteScript("exe_id1_cattith", GetNextCPU()));

            break;

        case 9:
            // decor items
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging decor items. (30%)"));

            DebugMessage("");
            DebugMessage("Cataloging decor items.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catdecor", GetNextCPU()));

            break;

        case 10:
            // puzzles
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging puzzles. (32%)"));

            DebugMessage("Cataloging puzzles.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catpuzz", GetNextCPU()));

            break;

        case 11:
            // secret doors
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging secret doors. (34%)"));

            DebugMessage("Cataloging secret doors.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catsdoor", GetNextCPU()));

            break;

        case 12:
            // creatures
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging creatures. (44%)"));

            DebugMessage("Cataloging creatures.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catmon", GetNextCPU()));

            break;

        case 13:
            // minibosses
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging minibosses. (50%)"));

            DebugMessage("Cataloging minibosses.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catmini", GetNextCPU()));

            break;

        case 14:
            // trap damage types
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging trap damage types. (51%)"));

            DebugMessage("Cataloging trap damage types.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattrap", GetNextCPU()));

            break;

        case 15:
            // treasure containers
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging treasure containers. (53%)"));

            DebugMessage("Cataloging treasure containers.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catcon", GetNextCPU()));

            break;

        case 16:
            // plot containers
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging plot containers. (55%)"));

            DebugMessage("Cataloging plot containers.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catpltcn", GetNextCPU()));

            break;

        case 17:
            // plot items
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging plot items. (57%)"));

            DebugMessage("Cataloging plot items.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catpltit", GetNextCPU()));

            break;

        case 18:
            // dialog words
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0); // position in the 2da
            SetLocalInt(GetModule(), "nQueueMax", 0); // 2da to examine

            AssignCommand(oSpeaker, SpeakString("Cataloging random dialog words. (67%)"));

            DebugMessage("Cataloging dialog words.");
            DebugMessage("Random lines.");

            DelayCommand(0.01, ExecuteScript("exe_id1_catdiagw", GetNextCPU()));

            break;

        case 19:
            // treasure items
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging treasure items. (77%)"));

            DebugMessage("Cataloging treasure items.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattritm", GetNextCPU()));

            break;

        case 20:
            // ideal treasure percentages
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 0);

            AssignCommand(oSpeaker, SpeakString("Cataloging ideal treasure percentages. (78%)"));

            DebugMessage("Cataloging ideal treasure percentages.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattriti", GetNextCPU()));

            break;

        case 21:
            // item properties
            nProcess++;
            SetLocalInt(GetModule(), "nCatalogProcess", nProcess);

            // reset the queue
            SetLocalInt(GetModule(), "nQueueMin", 1);

            AssignCommand(oSpeaker, SpeakString("Cataloging item properties. (79%)"));

            DebugMessage("Cataloging item properties.");

            DelayCommand(0.01, ExecuteScript("exe_id1_cattritp", GetNextCPU()));

            break;

        case 22:
            DebugMessage("Catalog ends.");

            // clean up
            SetLocalInt(GetModule(), "nCatalogProcess", 0);

            AssignCommand(oSpeaker, SpeakString("Cleaning catalog variables. (100%)"));
            DelayCommand(1.0, DestroyObject(oSpeaker));

            DebugMessage("Cleaning catalogue variables.");

            DeleteLocalInt(GetModule(), "nCatalogProcess");
            DeleteLocalInt(GetModule(), "nQueueMin");
            DeleteLocalInt(GetModule(), "nQueueMax");

            SetLocalInt(GetModule(), "bCataloging", FALSE);
//            SetLocalInt(GetModule(), "bCatalogingFinished", TRUE);

            if (lt_GetIsEntryAgreed(GetObjectByTag("id1_littletimmy")) == TRUE)
            {
                SetLocked(GetObjectByTag("DungeonEntranceStairs"), FALSE);
            }

            // remove cutscene mode from all players
            oPC = GetFirstPC();
            int bPlayerPresent;
            if (oPC != OBJECT_INVALID)
            {
                bPlayerPresent = TRUE;
            }
            while (oPC != OBJECT_INVALID)
            {
                if (GetCutsceneMode(oPC) == TRUE)
                {
                    SetCutsceneMode(oPC, FALSE);
                }
                oPC = GetNextPC();
            }

            if (bPlayerPresent == TRUE)
            {
                // start intro cutscene
                object oArea = GetObjectByTag("DungeonEntrance");
                cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE, oArea);
                cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST, oArea);
                cs_StartCutscene("cut_id1_narr01", "cut_id1_narr01_e", 1.5, TRUE, TRUE, 1, oArea);
            }

            break;
    }
}

void UpdatePlayers(string sMessage)
{
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        AssignCommand(oPC, SpeakString(sMessage, TALKVOLUME_WHISPER));

        oPC = GetNextPC();
    }
}

