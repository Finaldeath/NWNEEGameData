//::////////////////////////////////////////////////////////////////////////////
//:: aen_id1_harat
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Area On Enter script for Harat lair. This script sets up the area for
    the boss fight and gets things going.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"
#include "inc_id1_utility"
#include "inc_id1_score"
#include "_inc_cutscene"

const string CUT_SCRIPT = "cut_id1_harat";
const string CUT_SCRIPT_END = "cut_id1_harat_e";
const string CUT_NUMBER_VAR = "cs_last_cut_number";

void main()
{
    object oEntering = GetEnteringObject();
    object oDungeon = GetCurrentDungeon();
    int bActivated = GetLocalInt(oDungeon, "bBossActivated");

    if (GetIsPC(oEntering) == TRUE)
    {
        DebugMessage("Player is entering area with identifier " + GetPCIdentifier(oEntering));

        ExploreAreaForPlayer(OBJECT_SELF, oEntering);

        if (bActivated == FALSE)
        {
            // JE: Get the cutscene-number last used - will be zero if no
            // cutscene has run in the area yet.
            int nCutNumber = GetLocalInt(OBJECT_SELF, CUT_NUMBER_VAR);

            // JE: If we haven't run a cutscene for this area yet, this is
            // the time to do so. The Setup() function will be called in the
            // cutscene-end script.
            if (nCutNumber == 0)
            {
                // Increment cutscene number - currently we only run the
                // cutscene once, but if we decide to allow it to run more
                // than once we should use a different number each time.
                nCutNumber++;
                SetLocalInt(OBJECT_SELF, CUT_NUMBER_VAR, nCutNumber);

                // Set option to restore the PC's location once the cutscene is done.
                cs_SetOption(CS_OPTION_RESTORE_PC_LOCATION, TRUE);
                // Fade-out
                cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
                // Cutscene start
                cs_StartCutscene(CUT_SCRIPT, CUT_SCRIPT_END, 2.0, TRUE, TRUE, nCutNumber);
            }
            // JE: If the cutscene is still running, we simply add the
            // player to that cutscene and do nothing else. The Setup() function
            // will still be called when the cutscene ends.
            else if (cs_GetCutsceneRunning())
            {
                cs_AreaOnEnter(oEntering);
            }
            // JE: Default for when no cutscene stuff is involved.
            else
            {
                DebugMessage("  Area is not activated. Setting up.");

                // run setup
                Setup();
            }
        }
        else
        {
            DebugMessage("  Area is already activated.");
        }
    }
}

