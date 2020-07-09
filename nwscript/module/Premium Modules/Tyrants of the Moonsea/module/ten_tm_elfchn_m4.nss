//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Restores guards in the Melvaunt Market area
//:: They were removed in "ten_tm_elfchn_m3"
//::////////////////////////////////////////////////////

#include "hf_in_plot"


// Static guard with POSTs and unique tags
const string NPC_RESREF_GUARD0 = "tm_cr_mel_guard0";
const string NPC_TAG_GUARD0 = "tm_cr_mel_guard0_"; // append number
const string WP_TAG_GUARD0 = "POST_tm_cr_mel_guard0_"; // append number

// Moving guards (all have the same tag)
const string NPC_RESREF_GUARD1 = "tm_cr_mel_guard1";
const string NPC_TAG_GUARD1 = "tm_cr_mel_guard1";
const string WP_TAG_GUARD1 = "WP_elfchain_guard1_respawn";


void restoreGuards(object oNearest)
{
    int nNth = 0;
    object oWaypoint = OBJECT_INVALID;
    object oGuard = OBJECT_INVALID;

    // Restore static guards with POSTs and unique tags
    nNth = 0;
    oWaypoint = GetNearestObjectByTag(WP_TAG_GUARD0 + IntToString(nNth), oNearest);
    while (GetIsObjectValid(oWaypoint))
    {
        // Avoid creating existing guards
        oGuard = GetObjectByTag(NPC_TAG_GUARD0 + IntToString(nNth));
        if (!GetIsObjectValid(oGuard))
            CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_GUARD0, GetLocation(oWaypoint), FALSE, NPC_TAG_GUARD0 + IntToString(nNth));

        nNth++;
        oWaypoint = GetNearestObjectByTag(WP_TAG_GUARD0 + IntToString(nNth));
    }

    // Restore moving guards which all have the same tag
    // Avoid creating existing guards (checking for the first one is enough)
    oGuard = GetNearestObjectByTag(NPC_TAG_GUARD1, oNearest);
    if (!GetIsObjectValid(oGuard))
    {
        nNth = 1;
        oWaypoint = GetNearestObjectByTag(WP_TAG_GUARD1, oNearest, nNth);
        while (GetIsObjectValid(oWaypoint))
        {
            CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_GUARD1, GetLocation(oWaypoint), FALSE, NPC_TAG_GUARD1);

            nNth++;
            oWaypoint = GetNearestObjectByTag(WP_TAG_GUARD1, oNearest, nNth);
        }
    }
}


void main()
{
    object oPC = GetEnteringObject();
    int nTriggerStatus = GetLocalInt(OBJECT_SELF, "status");
    int nPlotStatus = PlotLevelGet("ElfInChains-Status");

    if (GetIsPC(oPC) && (nTriggerStatus == 0) && (nPlotStatus >= 4))
    {
        // Quest solved, restore guard (in case they left)
        SetLocalInt(OBJECT_SELF, "status", 1);

        restoreGuards(OBJECT_SELF);
    }
}
