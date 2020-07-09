#include "hf_in_cutscene"

// for world map
#include "inc_bw_worldmap"

void main()
{
    object oPC = GetLastPCToCancelCutscene();

    // *************************************************************************
    // * This will handle players that hit 'Esc' on world map.
    // * -Brian Watson (5/5/2006)

    string sAreaTag = GetTag(GetArea(oPC));
    sAreaTag = GetStringLowerCase(GetStringLeft(sAreaTag, nWM_AREAPREFIX));
    if (sAreaTag == sWM_AREATAG) // pc is in world map area
    {
        // if player used inventory map to get here, return to where
        // they were previously
        if (GetLocalInt(oPC, "nWM_UsedInventoryMap") == 1)
        {
            location lJump = GetLocalLocation(oPC, "lWM_PrevLocation");
            FadeToBlack(oPC, FADE_SPEED_FAST);

            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionDoCommand(SetCutsceneMode(oPC, FALSE)));
            AssignCommand(oPC, ActionJumpToLocation(lJump));
            return;
        }

        // cancel the world map, restore camera, return player to
        // last transition they clicked to get to world map
        string sTrigger = GetLocalString(oPC, "sWM_PreviousTrig");
        object oTrigger = GetObjectByTag(sTrigger);

        if (GetIsObjectValid(oTrigger))
        {
            FadeToBlack(oPC, FADE_SPEED_FAST);
            MapTravel(oPC, oTrigger, 0, 0, FALSE);
            return;
        }
    }

    // * End world map cutscene abort.
    // *************************************************************************


    CutsceneAbort(oPC);
}
