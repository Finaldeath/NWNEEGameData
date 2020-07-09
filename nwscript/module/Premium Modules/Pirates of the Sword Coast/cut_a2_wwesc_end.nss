//::///////////////////////////////////////////////
//:: Whipped Willigan escape (end script)
//:: cut_a2_wwesc_end
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Whipped Willigan makes his dramatic escape
    from the clutches of his evil wife and her
    wicked sisters.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 22, 2005
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oDoorOutside = GetObjectByTag(a2d_Spindrift_Willigan);
    SetPlotFlag(oDoorOutside, FALSE);
    DestroyObject(oDoorOutside, 0.1);

    object oWilligan = GetObjectByTagInArea(a2c_tag_Willigan);

    // for now jump Willigan and all pc's to the same point outside
    // we should have specific waypoints for each so it looks better though
    object oWP = GetWaypointByTag(a2w_Willigan_Town_Kicked_Out);

    AssignCommand(oWilligan, ClearAllActions(TRUE));
    AssignCommand(oWilligan, ActionJumpToObject(oWP));
    SignalEvent(oWilligan, EventUserDefined(1));

    int nIndex=0;
    object oPC = GetPCInArea(OBJECT_SELF, 0);
    while(GetIsObjectValid(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionJumpToObject(oWP));
        nIndex++;
        oPC = GetPCInArea(OBJECT_SELF, nIndex);
    }

}
