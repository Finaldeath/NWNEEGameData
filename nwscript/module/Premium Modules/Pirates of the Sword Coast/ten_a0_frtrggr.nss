//:://////////////////////////////////////////////
//:: ten_a0_mbshwarn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Make hostiles run away from the rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oTarget = GetObjectByTag("WP_A0_FEARPOINT");
    effect eFear = EffectFrightened();

    // If the entering object is hostile, jump them away from the ship.
    if ((GetIsPC(oEnter) == FALSE) && (GetTag(oEnter) != "a0_hench_nisar"))
    {
        AssignCommand(oEnter, ClearAllActions(TRUE));
        DelayCommand(0.5f, AssignCommand(oEnter,
            ActionForceMoveToObject(oTarget, TRUE, 1.0f, 5.0f)));
    }
}
