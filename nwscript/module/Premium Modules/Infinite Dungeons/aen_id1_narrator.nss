//::////////////////////////////////////////////////////////////////////////////
//:: aen_id1_narrator
//:: Copyright (c) 2006 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Area On Enter script for the Narrator area.

    - Figures out what cutscene should be running, and starts it.
    - Or if a cutscene is already running, adds player to that cutscene.
    - Failsafe: If for some reason variables on which cutscene should play
      have not properly been set, send the player back to the warehouse.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 20, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "_inc_cutscene"

const string CUT_NUMBER = "NarratorCutsceneNumber";
const string TELEPORT_WAYPOINT = "TeleportWP";

const string CUT_SCRIPT_PREFIX = "cut_id1_narr0";
const string CUT_SCRIPT_END = "cut_id1_narr_e";

void main()
{
    object oEntering = GetEnteringObject();

    if(GetIsPCNotDM(oEntering))
    {
        // JE: Explore the area for the player - the corners look a little
        // ugly if we don't do this
        ExploreAreaForPlayer(OBJECT_SELF, oEntering);

        // If there's a cutscene running, add the player to it.
        if(cs_GetCutsceneRunning())
        {
            cs_AreaOnEnter(oEntering);
            // Nothing else to do in this case.
            return;
        }

        int nCutNumber = GetLocalInt(OBJECT_SELF, CUT_NUMBER);

        // only cutscene numbers between 2 and 5 are valid. I skip 1 because
        // the 1st narrator cutscene takes place in a different area.
        if(nCutNumber > 1 && nCutNumber < 6)
        {
            // ie. cut_id1_narr02
            string sCutScript = CUT_SCRIPT_PREFIX + IntToString(nCutNumber);

            // Fade-out
            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            // Cutscene start
            cs_StartCutscene(sCutScript, CUT_SCRIPT_END, 3.0, TRUE, TRUE, nCutNumber);

            // reset the cutscene variable
            SetLocalInt(OBJECT_SELF, CUT_NUMBER, 0);
        }
        else
        {
            // nCutNumber is invalid, and there isn't a cutscene running
            // This case shouldn't happen, but in case it does we need to send
            // the player out of here so they can keep playing.

            // if the teleport waypoint object has been set, we'll use that
            object oWP = GetLocalObject(OBJECT_SELF, TELEPORT_WAYPOINT);
            location lWP;

            if(!GetIsObjectValid(oWP))
            {
                // if the teleport waypoint hasn't been set, we'll use the
                // start location
                lWP = GetStartingLocation();
            }
            else
            {
                // teleport waypoint is valid, so use its location
                lWP = GetLocation(oWP);
            }

            JumpPCsToLocation(lWP, 0, oEntering);
        }
    }
}
