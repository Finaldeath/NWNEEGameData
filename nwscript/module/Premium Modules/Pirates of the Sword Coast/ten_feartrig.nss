//::///////////////////////////////////////////////
//:: ten_feartrig
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This Trigger on Enter script will scare away any
    non-pc targets and direct them to the nearest
    "Safe" location.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

void main()
{
    effect eFear = EffectFrightened();
    object oTarget = GetEnteringObject();
    object oWaypoint = GetObjectByTag("WP_SAFELOCATION");

    if (GetIsPC(oTarget) == FALSE)
    {
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, ActionForceMoveToObject(oWaypoint, TRUE));
    }
}
