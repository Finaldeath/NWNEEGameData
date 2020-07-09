//::///////////////////////////////////////////////
//:: cac_a0_nisarhnch
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Add Nisar to the PC party
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    object oHench = GetObjectByTag("a0_hench_nisar");
    int iToggle, iHitDice, iLevel;

    SetLocalInt(oSelf, "A0_INTROOVER", TRUE);
    iHitDice = GetFactionAverageLevel(oPC);
    iLevel = GetHitDice(oHench);
    iToggle = GetLocalInt(oHench, "POTSC_HENCH_TOGGLE");

    while (iLevel < iHitDice)
    {
        if (iToggle == FALSE)
        {
            iLevel = LevelUpHenchman(oHench, CLASS_TYPE_SORCERER, TRUE, PACKAGE_SORCERER_ABJURATION);
            iToggle = TRUE;
        }
        else
        {
            iLevel = LevelUpHenchman(oHench, CLASS_TYPE_BARBARIAN, TRUE, PACKAGE_BARBARIAN_SAVAGE);
            iToggle = FALSE;
        }
    }

    SetLocalInt(oHench, "POTSC_HENCH_TOGGLE", iToggle);

    HireHenchman(oPC, oHench);
    AssignCommand(oHench, ActionForceFollowObject(oPC, 5.0f));
}
