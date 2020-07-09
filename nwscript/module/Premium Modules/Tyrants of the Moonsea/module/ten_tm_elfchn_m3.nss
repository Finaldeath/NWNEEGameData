//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Removes guards in the Melvaunt Market area
//:: They are restored in "ten_tm_elfchn_m4"
//::////////////////////////////////////////////////////

#include "x0_i0_walkway"
#include "hf_in_plot"


// Exit waypoint for guards
const string WP_TAG_EXIT = "WP_elfchain_guard_exit";

// Static guard with POSTs and unique tags
const string NPC_RESREF_GUARD0 = "tm_cr_mel_guard0";
const string NPC_TAG_GUARD0 = "tm_cr_mel_guard0_"; // append number
const string WP_TAG_GUARD0 = "POST_tm_cr_tm_guard0_"; // append number

// Moving guards (all have the same tag)
const string NPC_RESREF_GUARD1 = "tm_cr_mel_guard1";
const string NPC_TAG_GUARD1 = "tm_cr_mel_guard1";
const string WP_TAG_GUARD1 = "WP_elfchain_guard1_respawn";


void removeGuards(object oNearest)
{
    int nNth = 0;
    object oGuard = OBJECT_INVALID;

    // Remove static guards with POSTs and unique tags
    nNth = 0;
    oGuard = GetNearestObjectByTag(NPC_TAG_GUARD0 + IntToString(nNth), oNearest);
    while (GetIsObjectValid(oGuard))
    {
        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oGuard);
        SetLocalString(oGuard, "HF_EXIT_NAME", WP_TAG_EXIT);
        SetLocalInt(oGuard, "HF_EXIT_RUN", 1);
        DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oGuard));

        nNth++;
        oGuard = GetNearestObjectByTag(NPC_TAG_GUARD0 + IntToString(nNth), oNearest);
    }

    // Remove moving guards which all have the same tag
    nNth = 0;
    oGuard = GetNearestObjectByTag(NPC_TAG_GUARD1, oNearest, nNth);
    while (GetIsObjectValid(oGuard))
    {
        SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oGuard);
        SetLocalString(oGuard, "HF_EXIT_NAME", WP_TAG_EXIT);
        SetLocalInt(oGuard, "HF_EXIT_RUN", 1);
        DelayCommand(1.0f, ExecuteScript("hf_cs_exit", oGuard));

        nNth++;
        oGuard = GetNearestObjectByTag(NPC_TAG_GUARD1, oNearest, nNth);
    }
}


void main()
{
    object oPC = GetEnteringObject();
    int nTriggerStatus = GetLocalInt(OBJECT_SELF, "status");
    int nPlotStatus = PlotLevelGet("ElfInChains-Status");

    if (GetIsPC(oPC) && (nTriggerStatus == 0) && (nPlotStatus == 3))
    {
        // Riot in progress, make guards in the current area leave
        SetLocalInt(OBJECT_SELF, "status", 1);

        removeGuards(OBJECT_SELF);
    }
}
