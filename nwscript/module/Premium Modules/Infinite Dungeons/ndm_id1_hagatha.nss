//::////////////////////////////////////////////////////////////////////////////
//:: ndm_id1_hagatha
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Damaged Event script for The Widow Hagatha. When damaged Hagatha will
    occaisonally create a totem nearby if several have been destroy.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 09, 2006
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_hagatha"

void main()
{
    // If the plot flag is set in an on damage event we should ignore
    // special behaviours.
    if (GetPlotFlag(OBJECT_SELF)) return;
    DebugMessage("ndm_id1_hagatha::main()");

    // Stop multiple totem creation.
    if (!GetCommandable()) return;

    // Determine if there are any free locations to create a totem.
    int nWP;
    object oWP;

    int nTarget = -1;

    // Cycle the nearby totem waypoints to determine if one was destroyed.
    for (nWP = 1; nWP < 5; nWP++)
    {
        oWP = DB_GetWaypointByTag(TOTEM_WP_PRFX + IntToString(nWP));

        // If the flag is set store the waypoint and break the loop.
        if (GetLocalInt(oWP, TOTEM_DESTROYED))
        {
            nTarget = nWP;
            break;
        }
    }

    // If no suitable waypoint is found jump out.
    if (nTarget == -1) return;

    DebugMessage("^ There is room for a new totem.");

    // Based on Hagatha's current health determine if a totem should be created.
    int nHP = GetCurrentHitPoints();
    int nMax = GetMaxHitPoints();

    float fHealthRatio = IntToFloat(nHP) / IntToFloat(nMax);

    int nTotemType = -1;

    // If a random number for 0 to hagatha's max health is greater than her
    // current health summon a totem.
    if (Random(nMax) >  nHP)
    {
        /*
        if (fHealthRatio < 0.25) // Less than 25% health summon a healing totem.
        {
            nTotemType = TOTEM_POWER_HEAL;
        }
        if (fHealthRatio < 0.50) // Less than 50% health summon a protection.
        {
            nTotemType = TOTEM_POWER_DAMAGE_REDUCTION;
        }
        if (fHealthRatio < 0.75) // Less than 75% health summon a strength totem.
        {
            nTotemType = TOTEM_POWER_DAMAGE_INCREASE;
        }
        else // Summon a random elemental totem.
        {
            nTotemType = Random(3) + 1;
        }
        */

        nTotemType = Random(6) + 1;
    }

    DebugMessage("^ Creating totem type: " + IntToString(nTotemType));

    // If a totem was determined summon it.
    if (nTotemType != -1)
    {
        DebugMessage("Clearing actions. Point 25.");
        ClearAllActions(TRUE);
        ActionCreateTotem(nTarget, nTotemType);
        SetCommandable(FALSE);
        //DelayCommand(3.0, SetCommandable(TRUE));
    }
}
