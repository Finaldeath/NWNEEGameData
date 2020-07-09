//::////////////////////////////////////////////////////////////////////////////
//:: ndm_id1_harat
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Damaged Event script for Harat. This script is ran via an ExecuiteScript
    call from ndm_id1_boss where the damage events of all the various bosses
    are handled.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 28, 2005
//::////////////////////////////////////////////////////////////////////////////

#include "inc_id1_harat"

void main()
{
    object oThis = OBJECT_SELF;

    // If the plot flag is set in an on damage event we should ignore
    // special behaviours.
    if (GetPlotFlag(oThis)) return;

    // When Harat is hit he will jump away.
    if (!GetLocalInt(oThis, HARAT_TELEPORT_PROHIBITED))
    {
        // int nRand = Random(4); // Only usefull with disappear/appear
        object oWP = GetNearestObjectByTag(RETREAT_WP_TAG, oThis, 3);
        location lLoc_1 = GetLocation(oWP);
        location lLoc_2 = GetLocation(oThis);

        effect eJump = EffectDisappearAppear(lLoc_1);
        //effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

        // Re-establish Harat's damage reduction effect.
        DebugMessage("Clearing actions. Point 26.");
        ClearAllActions(TRUE);

        ApplyDemonShield(oThis);

        // Apply the visual and jump Harat to his escape point.
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lLoc_1);
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lLoc_2);
        //DelayCommand(3.0, JumpToLocation(lLoc_1));

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eJump, oThis, 10.0);
    }
}
