//::///////////////////////////////////////////////
//:: cac_a2_hnisar_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Nisar
    atleast once in Act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    object oHenchNisar = OBJECT_SELF;
    int iToggle, iHitDice, iLevel;

    iHitDice = GetFactionAverageLevel(oPC);
    iLevel = GetHitDice(oHenchNisar);
    iToggle = GetLocalInt(oHenchNisar, "POTSC_HENCH_TOGGLE");

    while (iLevel < iHitDice)
    {
        if (iToggle == FALSE)
        {
            iLevel = LevelUpHenchman(oHenchNisar, CLASS_TYPE_SORCERER, TRUE, PACKAGE_SORCERER_ABJURATION);
            iToggle = TRUE;
        }
        else
        {
            iLevel = LevelUpHenchman(oHenchNisar, CLASS_TYPE_BARBARIAN, TRUE, PACKAGE_BARBARIAN_SAVAGE);
            iToggle = FALSE;
        }
    }

    SetLocalInt(oHenchNisar, "POTSC_HENCH_TOGGLE", iToggle);

    HireHenchman(oPC, oHenchNisar);
    AssignCommand(oHenchNisar, ActionForceFollowObject(oPC, 5.0f));
    SetLocalInt(oHenchNisar, "cac_a2_hnisar_d1", TRUE);
}
