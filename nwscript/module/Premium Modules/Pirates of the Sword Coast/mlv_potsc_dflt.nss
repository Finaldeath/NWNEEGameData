//::///////////////////////////////////////////////
//:: mlv_potsc_dflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Module Levelup handler for PotSC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"

void main()
{
    object oPC = GetPCLevellingUp();
    object oHench = GetHenchman(oPC, 1);
    object oPoly = GetObjectByTag("a1_poly");

    int iMaxHench, iCurrHench, iLevel, iHitDice, iToggle, iLevelRules;
    effect eHeal;

    // If a PC levels up, heal them and level their henchmen as well.
    if (GetIsPC(oPC) == TRUE)
    {
        // Restore the player.
        SSRemoveEffects(oPC);
        eHeal = EffectHeal(GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);

        // Level up Poly
        if (GetIsObjectValid(oPoly) == TRUE)
        {
            iHitDice = GetFactionAverageLevel(oPC);
            iLevel = GetHitDice(oPoly);
            while (iLevel < iHitDice)
            {
                iLevel = LevelUpHenchman(oPoly);
            }
        }

        // Level up the PCs Henchmen
        iMaxHench = GetMaxHenchmen();
        iCurrHench = 1;
        oHench = GetHenchman(oPC, iCurrHench++);

        while (iMaxHench > iCurrHench)
        {
            iHitDice = GetFactionAverageLevel(oPC);

            // if the Henchmen is Nisar, level him up accordingly
           if ((GetTag(oHench) == "a0_hench_nisar")
            || (GetTag(oHench) == "a2_hench_nisar"))
            {
                //check the Henchmen's level rules
                iLevelRules = GetLocalInt(oHench, "X0_L_LEVELRULES");
                iToggle = GetLocalInt(oHench, "POTSC_HENCH_TOGGLE");
                iLevel = GetHitDice(oHench);

                while (iLevel < iHitDice)
                {
                    if (((iToggle == FALSE) || (iLevelRules == 1)) && (iLevelRules != 2))
                    {
                        iLevel = LevelUpHenchman(oHench, CLASS_TYPE_BARBARIAN,
                            TRUE, PACKAGE_BARBARIAN_SAVAGE);
                        iToggle = TRUE;
                    }
                    else if (((iToggle == TRUE) || (iLevelRules == 2)) && (iLevelRules != 1))
                    {
                        iLevel = LevelUpHenchman(oHench, CLASS_TYPE_SORCERER,
                            TRUE, PACKAGE_SORCERER_ABJURATION);
                        iToggle = FALSE;
                    }
                }

                SetLocalInt(oHench, "POTSC_HENCH_TOGGLE", iToggle);
            }
            // if the Henchmen is Garm, level him up accordingly
            else if (GetTag(oHench) == "a1_hench_garm")
            {
                //check the Henchmen's level rules
                iLevelRules = GetLocalInt(oHench, "X0_L_LEVELRULES");
                iToggle = GetLocalInt(oHench, "POTSC_HENCH_TOGGLE");
                iLevel = GetHitDice(oHench);

                while (iLevel < iHitDice)
                {
                    if (((iToggle == FALSE) || (iLevelRules == 1)) && (iLevelRules != 2))
                    {
                        iLevel = LevelUpHenchman(oHench, CLASS_TYPE_CLERIC,
                            TRUE, PACKAGE_CLERIC_SHAMAN);
                        iToggle = TRUE;
                    }
                    else if (((iToggle == TRUE) || (iLevelRules == 2)) && (iLevelRules != 1))
                    {
                        iLevel = LevelUpHenchman(oHench, CLASS_TYPE_FIGHTER,
                            TRUE, PACKAGE_FIGHTER_GLADIATOR);
                        iToggle = FALSE;
                    }
                }

                SetLocalInt(oHench, "POTSC_HENCH_TOGGLE", iToggle);
            }
            // if the Henchmen is someone else just level them up.
            else if (GetIsObjectValid(oHench) == TRUE)
            {
                while (iLevel < iHitDice)
                {
                    iLevel = LevelUpHenchman(oHench);
               }
            }

            oHench = GetHenchman(oPC, iCurrHench++);
        }
    }
}
