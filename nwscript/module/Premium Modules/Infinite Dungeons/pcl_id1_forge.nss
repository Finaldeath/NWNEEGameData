#include "inc_id1_debug"
#include "inc_id1_prop"
#include "inc_id1_utility"

#include "x2_inc_itemprop"

void ResetForgeBooleans();
void ResetForgeRecipeNumbers();
void ResetForgeGemCounters();


void main()
{
    object oForge = OBJECT_SELF;
    object oPC = GetLastClosedBy();
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable"); // AreaXWaypointPuzzleYLevelZ

    if (IsInConversation(oForge) == FALSE)
    {
        SetLocked(OBJECT_SELF, TRUE);
        SetLocalObject(OBJECT_SELF, "oUser", oPC);

        // if no charges, fail
        int nCharges = GetLocalInt(oDungeon, "n" + sVariable + "Charges");
        DebugMessage("Forge has " + IntToString(nCharges) + " charges remaining.");
        if (nCharges > 0)
        {
            // count the number of items in inventory
            int nCount = 0;
            object oItemTemp = GetFirstItemInInventory(OBJECT_SELF);
            object oItem;
            int bInvalid = FALSE;
            string sTag;
            string sSubTag;
            while (oItemTemp != OBJECT_INVALID)
            {
                nCount++;
                oItem = oItemTemp;
                DebugMessage("Counted item " + IntToString(nCount));
                oItemTemp = GetNextItemInInventory(OBJECT_SELF);

                sTag = GetTag(oItem);
                DebugMessage("Object is tag " + sTag);

                // if gem
                sSubTag = GetSubString(sTag, 0, 8);
                if (sSubTag == "id1_gem_")
                {
                    DebugMessage("Gem found.");

                    bInvalid = TRUE;
                }

                // if recipe
                sSubTag = GetSubString(sTag, 0, 11);
                if (sSubTag == "id1_recipe_")
                {
                    DebugMessage("Recipe found.");

                    bInvalid = TRUE;
                }
            }

            // if there are no items in the forge
            DebugMessage("There were " + IntToString(nCount) + " items in the forge.");
            if (nCount > 0)
            {
                DebugMessage("Inside loop");

                if (bInvalid == FALSE)
                {
                    // if there is only a single item in the forge
                    if (nCount == 1)
                    {
                        // if not pc, fail
                        if (GetIsPC(oPC) == TRUE)
                        {
                            // get the itemprops 2da column
                            string sColumn = "";

                            // get item base type
                            int nItemType = GetBaseItemType(oItem);
                            int nPropertyColumn = StringToInt(Get2DAString("baseitems", "PropColumn", nItemType));
                            DebugMessage("Item type is " + IntToString(nItemType) + " and property column is " + IntToString(nPropertyColumn));

                            // EDIT: make sure it doesnt already have too many properties
                            int nCurrentPropertyNum = IPGetNumberOfItemProperties(oItem);
                            int nMaxPropertyNum = StringToInt(Get2DAString("baseitems", "MaxProps", nItemType));
                            DebugMessage("Item has " + IntToString(nCurrentPropertyNum) + " properties out of maximum " + IntToString(nMaxPropertyNum));
                            if (nCurrentPropertyNum < nMaxPropertyNum)
                            {
                                // get item property column
                                sColumn = GetItemPropertyColumn(nPropertyColumn);
                                DebugMessage("Property is column " + sColumn);

                                // reset all property variables
                                ResetForgeBooleans();
                                ResetForgeRecipeNumbers();

                                // reset the number of gems
                                ResetForgeGemCounters();

                                // cycle through player's entire inventory and catalog
                                SetLocalInt(oForge, "bCataloging", TRUE);
                                int nGemNum = 0;
                                SetLocalInt(oForge, "nGemNum", 0);
                                SetLocalInt(oForge, "nGemCurrent", 0);
                                int nRecipeNum = 0;
                                SetLocalInt(oForge, "nRecipeNum", 0);
                                SetLocalInt(oForge, "nRecipeCurrent", 0);
                                object oMicroCPU;
                                oItem = GetFirstItemInInventory(oPC);
                                while (oItem != OBJECT_INVALID)
                                {
                                    sTag = GetTag(oItem);
                                    DebugMessage("Object is tag " + sTag);

                                    // if gem
                                    sSubTag = GetSubString(sTag, 0, 8);
                                    if (sSubTag == "id1_gem_")
                                    {
                                        DebugMessage("Gem found.");

                                        // increment gem number
                                        nGemNum++;
                                        SetLocalInt(oForge, "nGemNum", nGemNum);

                                        // create microcpu
                                        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU114");
                                        SetLocalObject(oMicroCPU, "oForge", oForge);
                                        SetLocalObject(oMicroCPU, "oPC", oPC);
                                        SetLocalObject(oMicroCPU, "oItem", oItem);

                                        // catalog item
                                        DelayCommand(0.01, ExecuteScript("exe_id1_micitgm", oMicroCPU));
                                    }

                                    // if recipe
                                    sSubTag = GetSubString(sTag, 0, 11);
                                    if (sSubTag == "id1_recipe_")
                                    {
                                        DebugMessage("Recipe found.");

                                        // increment recipe number
                                        nRecipeNum++;
                                        SetLocalInt(oForge, "nRecipeNum", nRecipeNum);

                                        // create microcpu
                                        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU115");
                                        SetLocalObject(oMicroCPU, "oForge", oForge);
                                        SetLocalObject(oMicroCPU, "oPC", oPC);
                                        SetLocalObject(oMicroCPU, "oItem", oItem);
                                        SetLocalString(oMicroCPU, "sColumn", sColumn);

                                        // catalog item
                                        DelayCommand(0.01, ExecuteScript("exe_id1_micitrc", oMicroCPU));
                                    }

                                    // cycle to next item
                                    oItem = GetNextItemInInventory(oPC);
                                }

                                if ((nGemNum == 0) && (nRecipeNum == 0))
                                {
                                    DebugMessage("No items to catalog.");
                                    SetLocalInt(oForge, "bCataloging", FALSE);
                                    DelayCommand(0.01, AssignCommand(oPC, ActionStartConversation(oForge, "id1_forge", TRUE, FALSE)));
                                }
                            } else
                            {
                                SetLocked(OBJECT_SELF, FALSE);
                                SpeakString("Item already has the maximum number of properties.");
                            }
                        } else
                        {
                            SetLocked(OBJECT_SELF, FALSE);
                            DebugMessage("Person using the forge was not a PC.");
                        }
                    } else
                    {
                        SetLocked(OBJECT_SELF, FALSE);
                        SpeakString("A mystic forge can only enchant one item at a time.");
                    }
                } else
                {
                    SetLocked(OBJECT_SELF, FALSE);
                    SpeakString("Gems and recipes cannot be enchanted.");
                }
            } else
            {
                SetLocked(OBJECT_SELF, FALSE);
                SpeakString("There are no items in the mystic forge to enchant.");
            }
        } else
        {
            SetLocked(OBJECT_SELF, FALSE);
            SpeakString("This mystic forge has been drained of magical power.");
        }
    } else
    {
        SpeakString("Only one person may use the Forge at a time.");
    }
}

void ResetForgeBooleans()
{
    SetLocalInt(OBJECT_SELF, "bAbilityScore", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreStrength", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreDexterity", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreConstitution", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreIntelligence", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreWisdom", FALSE);
        SetLocalInt(OBJECT_SELF, "bAbilityScoreCharisma", FALSE);
    SetLocalInt(OBJECT_SELF, "bArcaneSpellFailure", FALSE);
    SetLocalInt(OBJECT_SELF, "bACBonus", FALSE);
        SetLocalInt(OBJECT_SELF, "bACBonusUniversal", FALSE);
        SetLocalInt(OBJECT_SELF, "bACBonusAlignment", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroup", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroupNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroupLawful", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroupChaotic", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroupGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentGroupEvil", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecific", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificLawfulGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificLawfulNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificLawfulEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificNeutralGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificTrueNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificNeutralEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificChaoticGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificChaoticNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bACBonusAlignmentSpecificChaoticEvil", FALSE);
        SetLocalInt(OBJECT_SELF, "bACBonusDamageType", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeBludgeoning", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypePiercing", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeSlashing", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeMagical", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeAcid", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeCold", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeDivine", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeElectrical", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeFire", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeNegative", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypePositive", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusDamageTypeSonic", FALSE);
        SetLocalInt(OBJECT_SELF, "bACBonusRacialType", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeDwarf", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeGnome", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeHalfling", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeHalfElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeHalfOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeHuman", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeAberration", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeAnimal", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeConstruct", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeDragon", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeGoblinoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeMonstrousHumanoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeReptile", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeElemental", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeFey", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeGiant", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeMagicalBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeOutsider", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeShapechanger", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeUndead", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeVermin", FALSE);
            SetLocalInt(OBJECT_SELF, "bACBonusRacialTypeOoze", FALSE);
    SetLocalInt(OBJECT_SELF, "bAttackBonus", FALSE);
        SetLocalInt(OBJECT_SELF, "bAttackBonusUniversal", FALSE);
        SetLocalInt(OBJECT_SELF, "bAttackBonusAlignment", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroup", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroupNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroupLawful", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroupChaotic", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroupGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentGroupEvil", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecific", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificLawfulGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificLawfulNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificLawfulEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificNeutralGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificTrueNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificNeutralEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificChaoticGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificChaoticNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bAttackBonusAlignmentSpecificChaoticEvil", FALSE);
        SetLocalInt(OBJECT_SELF, "bAttackBonusRacialType", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeDwarf", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeGnome", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeHalfling", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeHalfElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeHalfOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeHuman", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeAberration", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeAnimal", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeConstruct", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeDragon", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeGoblinoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeMonstrousHumanoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeReptile", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeElemental", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeFey", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeGiant", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeMagicalBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeOutsider", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeShapechanger", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeUndead", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeVermin", FALSE);
            SetLocalInt(OBJECT_SELF, "bAttackBonusRacialTypeOoze", FALSE);
    SetLocalInt(OBJECT_SELF, "bBonusFeat", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatAlertness", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatAmbidexterous", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatCleave", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatCombatCasting", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatDodge", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatExtraTurning", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatKnockdown", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatPointBlankShot", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocus", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusAbjuration", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusConjuration", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusDivination", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusEnchantment", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusEvocation", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusIllusion", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatSpellFocusNecromancy", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatSpellPenetration", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatPowerAttack", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatTwoWeaponFighting", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponSpecializationUnarmed", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponFinesse", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatImprovedCriticalUnarmed", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponProficiency", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponProficiencySimple", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponProficiencyMartial", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatWeaponProficiencyExotic", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatArmorProficiency", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatArmorProficiencyShield", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatArmorProficiencyLight", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatArmorProficiencyMedium", FALSE);
            SetLocalInt(OBJECT_SELF, "bBonusFeatArmorProficiencyHeavy", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatMobility", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatDisarm", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatWhirlwind", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatRapidShot", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatHideInPlainSight", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatSneakAttack", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatUsePoison", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusFeatDisarmWhip", FALSE);
    SetLocalInt(OBJECT_SELF, "bBonusSpellSlot", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotBard", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotCleric", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotDruid", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotPaladin", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotRanger", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotSorcerer", FALSE);
        SetLocalInt(OBJECT_SELF, "bBonusSpellSlotWizard", FALSE);
    SetLocalInt(OBJECT_SELF, "bCriticalHits", FALSE);
        SetLocalInt(OBJECT_SELF, "bCriticalHitsKeen", FALSE);
        SetLocalInt(OBJECT_SELF, "bCriticalHitsMassiveCriticals", FALSE);
    SetLocalInt(OBJECT_SELF, "bDamageBonus", FALSE);
        SetLocalInt(OBJECT_SELF, "bDamageBonusUniversal", FALSE);
        SetLocalInt(OBJECT_SELF, "bDamageBonusAlignment", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroup", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroupNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroupLawful", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroupChaotic", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroupGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentGroupEvil", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecific", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificLawfulGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificLawfulNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificLawfulEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificNeutralGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificTrueNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificNeutralEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificChaoticGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificChaoticNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bDamageBonusAlignmentSpecificChaoticEvil", FALSE);
        SetLocalInt(OBJECT_SELF, "bDamageBonusRacialType", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeDwarf", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeGnomes", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeHalfling", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeHalfElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeHalfOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeHuman", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeAberration", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeAnimal", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeConstruct", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeDragon", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeGoblinoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeMonstrousHumanoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeReptile", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeElemental", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeFey", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeGiant", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeMagicalBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeOutsider", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeShapechanger", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeUndead", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeVermin", FALSE);
            SetLocalInt(OBJECT_SELF, "bDamageBonusRacialTypeOoze", FALSE);
        SetLocalInt(OBJECT_SELF, "bDamageBonusExtraDamageType", FALSE);
    SetLocalInt(OBJECT_SELF, "bEnhancementBonus", FALSE);
        SetLocalInt(OBJECT_SELF, "bEnhancementBonusUniversal", FALSE);
        SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignment", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroup", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroupNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroupLawful", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroupChaotic", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroupGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentGroupEvil", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecific", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificLawfulGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificLawfulNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificLawfulEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificNeutralGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificTrueNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificNeutralEvil", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificChaoticGood", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificChaoticNeutral", FALSE);
                SetLocalInt(OBJECT_SELF, "bEnhancementBonusAlignmentSpecificChaoticEvil", FALSE);
        SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialType", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeDwarf", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeGnome", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeHalfling", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeHalfElf", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeHalfOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeHuman", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeAberration", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeAnimal", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeConstruct", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeDragon", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeGoblinoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeMonstrousHumanoid", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeOrc", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeReptile", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeElemental", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeFey", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeGiant", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeMagicalBeast", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeOutsider", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeShapechanger", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeUndead", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeVermin", FALSE);
            SetLocalInt(OBJECT_SELF, "bEnhancementBonusRacialTypeOoze", FALSE);
    SetLocalInt(OBJECT_SELF, "bHolyAvenger", FALSE);
    SetLocalInt(OBJECT_SELF, "bMovement", FALSE);
        SetLocalInt(OBJECT_SELF, "bMovementImprovedEvasion", FALSE);
        SetLocalInt(OBJECT_SELF, "bMovementFreedomOfMovement", FALSE);
        SetLocalInt(OBJECT_SELF, "bMovementHaste", FALSE);
    SetLocalInt(OBJECT_SELF, "bImmunity", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityDamageResistance", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceBludgeoning", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistancePiercing", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceSlashing", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceMagical", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceAcid", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceCold", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceDivine", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceElectrical", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceFire", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceNegative", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistancePositive", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageResistanceSonic", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunity", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityBludgeoning", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityPiercing", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunitySlashing", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityMagical", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityAcid", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityCold", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityDivine", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityElectrical", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityFire", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityNegative", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunityPositive", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunityDamageImmunitySonic", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunitySpellSchool", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolAbjuration", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolConjuration", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolDivination", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolEnchantment", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolEvocation", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolIllusion", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolNecromancy", FALSE);
            SetLocalInt(OBJECT_SELF, "bImmunitySpellSchoolTransmutation", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunitySpellLevel", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunitySpellResistance", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityDamageReduction", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityCriticalHits", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityDeathMagic", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityDisease", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityFear", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityKnockdown", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityLevelAbilityDrain", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityMindAffecting", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityParalysis", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityPoison", FALSE);
        SetLocalInt(OBJECT_SELF, "bImmunityBackstab", FALSE);
    SetLocalInt(OBJECT_SELF, "bSavingThrows", FALSE);
        SetLocalInt(OBJECT_SELF, "bSavingThrowsSpecific", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsSpecificFortitude", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsSpecificReflex", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsSpecificWillpower", FALSE);
        SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackType", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeUniversal", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeAcid", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeCold", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeDeath", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeDisease", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeDivine", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeElectrical", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeFear", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeFire", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeMindAffecting", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeNegative", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypePoison", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypePositive", FALSE);
            SetLocalInt(OBJECT_SELF, "bSavingThrowsAttackTypeSonic", FALSE);
    SetLocalInt(OBJECT_SELF, "bRegeneration", FALSE);
        SetLocalInt(OBJECT_SELF, "bRegenerationNormal", FALSE);
        SetLocalInt(OBJECT_SELF, "bRegenerationVampiric", FALSE);
    SetLocalInt(OBJECT_SELF, "bSkillBonus", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusAnimalEmpathy", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusConcentration", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusDisableTrap", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusDiscipline", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusHeal", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusHide", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusListen", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusLore", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusMoveSilently", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusOpenLock", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusParry", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusPerform", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusPersuade", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusSearch", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusSetTrap", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusSpellcraft", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusSpot", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusTaunt", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusUseMagicDevice", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusAppraise", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusTumble", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusCraftTrap", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusBluff", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusIntimidate", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusCraftArmor", FALSE);
        SetLocalInt(OBJECT_SELF, "bSkillBonusCraftWeapon", FALSE);
    SetLocalInt(OBJECT_SELF, "bUnlimitedAmmunition", FALSE);
    SetLocalInt(OBJECT_SELF, "bVision", FALSE);
        SetLocalInt(OBJECT_SELF, "bVisionLight", FALSE);
        SetLocalInt(OBJECT_SELF, "bVisionDarkvision", FALSE);
        SetLocalInt(OBJECT_SELF, "bVisionTrueSeeing", FALSE);
    SetLocalInt(OBJECT_SELF, "bWeightReduction", FALSE);
        SetLocalInt(OBJECT_SELF, "bWeightReductionContainer", FALSE);
        SetLocalInt(OBJECT_SELF, "bWeightReductionItem", FALSE);
    SetLocalInt(OBJECT_SELF, "bHealersKit", FALSE);
    SetLocalInt(OBJECT_SELF, "bThievesTools", FALSE);
}

void ResetForgeRecipeNumbers()
{
    SetLocalInt(OBJECT_SELF, "nAbilityScore", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreStrength", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreDexterity", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreConstitution", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreIntelligence", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreWisdom", 0);
        SetLocalInt(OBJECT_SELF, "nAbilityScoreCharisma", 0);
    SetLocalInt(OBJECT_SELF, "nArcaneSpellFailure", 0);
    SetLocalInt(OBJECT_SELF, "nACBonus", 0);
        SetLocalInt(OBJECT_SELF, "nACBonusUniversal", 0);
        SetLocalInt(OBJECT_SELF, "nACBonusAlignment", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroup", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroupNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroupLawful", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroupChaotic", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroupGood", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentGroupEvil", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecific", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificLawfulGood", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificLawfulNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificLawfulEvil", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificNeutralGood", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificTrueNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificNeutralEvil", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificChaoticGood", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificChaoticNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nACBonusAlignmentSpecificChaoticEvil", 0);
        SetLocalInt(OBJECT_SELF, "nACBonusDamageType", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeBludgeoning", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypePiercing", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeSlashing", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeMagical", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeAcid", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeCold", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeDivine", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeElectrical", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeFire", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeNegative", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypePositive", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusDamageTypeSonic", 0);
        SetLocalInt(OBJECT_SELF, "nACBonusRacialType", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeDwarf", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeElf", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeGnome", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeHalfling", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeHalfElf", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeHalfOrc", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeHuman", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeAberration", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeAnimal", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeBeast", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeConstruct", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeDragon", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeGoblinoid", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeMonstrousHumanoid", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeOrcs", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeReptile", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeElemental", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeFey", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeGiants", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeMagicalBeast", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeOutsiders", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeShapechanger", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeUndead", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeVermin", 0);
            SetLocalInt(OBJECT_SELF, "nACBonusRacialTypeOoze", 0);
    SetLocalInt(OBJECT_SELF, "nAttackBonus", 0);
        SetLocalInt(OBJECT_SELF, "nAttackBonusUniversal", 0);
        SetLocalInt(OBJECT_SELF, "nAttackBonusAlignment", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroup", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroupNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroupLawful", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroupChaotic", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroupGood", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentGroupEvil", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecific", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificLawfulGood", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificLawfulNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificLawfulEvil", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificNeutralGood", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificTrueNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificNeutralEvil", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificChaoticGood", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificChaoticNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nAttackBonusAlignmentSpecificChaoticEvil", 0);
        SetLocalInt(OBJECT_SELF, "nAttackBonusRacialType", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeDwarf", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeElf", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeGnome", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeHalfling", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeHalfElf", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeHalfOrc", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeHuman", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeAberration", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeAnimal", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeBeast", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeConstruct", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeDragon", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeGoblinoid", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeMonstrousHumanoid", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeOrc", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeReptile", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeElemental", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeFey", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeGiant", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeMagicalBeast", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeOutsider", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeShapechanger", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeUndead", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeVermin", 0);
            SetLocalInt(OBJECT_SELF, "nAttackBonusRacialTypeOoze", 0);
    SetLocalInt(OBJECT_SELF, "nBonusFeat", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatAlertness", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatAmbidexterous", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatCleave", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatCombatCasting", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatDodge", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatExtraTurning", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatKnockdown", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatPointBlankShot", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocus", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusAbjuration", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusConjuration", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusDivination", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusEnchantment", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusEvocation", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusIllusion", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatSpellFocusNecromancy", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatSpellPenetration", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatPowerAttack", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatTwoWeaponFighting", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponSpecializationUnarmed", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponFinesse", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatImprovedCriticalUnarmed", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponProficiency", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponProficiencySimple", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponProficiencyMartial", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatWeaponProficiencyExotic", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatArmorProficiency", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatArmorProficiencyShield", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatArmorProficiencyLight", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatArmorProficiencyMedium", 0);
            SetLocalInt(OBJECT_SELF, "nBonusFeatArmorProficiencyHeavy", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatMobility", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatDisarm", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatWhirlwind", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatRapidShot", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatHideInPlainSight", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatSneakAttack", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatUsePoison", 0);
        SetLocalInt(OBJECT_SELF, "nBonusFeatDisarmWhip", 0);
    SetLocalInt(OBJECT_SELF, "nBonusSpellSlot", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotBard", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotCleric", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotDruid", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotPaladin", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotRanger", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotSorcerer", 0);
        SetLocalInt(OBJECT_SELF, "nBonusSpellSlotWizard", 0);
    SetLocalInt(OBJECT_SELF, "nCriticalHits", 0);
        SetLocalInt(OBJECT_SELF, "nCriticalHitsKeen", 0);
        SetLocalInt(OBJECT_SELF, "nCriticalHitsMassiveCriticals", 0);
    SetLocalInt(OBJECT_SELF, "nDamageBonus", 0);
        SetLocalInt(OBJECT_SELF, "nDamageBonusUniversal", 0);
        SetLocalInt(OBJECT_SELF, "nDamageBonusAlignment", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroup", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroupNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroupLawful", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroupChaotic", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroupGood", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentGroupEvil", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecific", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificLawfulGood", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificLawfulNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificLawfulEvil", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificNeutralGood", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificTrueNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificNeutralEvil", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificChaoticGood", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificChaoticNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nDamageBonusAlignmentSpecificChaoticEvil", 0);
        SetLocalInt(OBJECT_SELF, "nDamageBonusRacialType", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeDwarf", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeElf", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeGnome", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeHalfling", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeHalfElf", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeHalfOrc", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeHuman", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeAberration", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeAnimal", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeBeast", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeConstruct", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeDragon", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeGoblinoid", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeMonstrousHumanoid", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeOrc", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeReptile", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeElemental", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeFey", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeGiant", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeMagicalBeast", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeOutsider", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeShapechanger", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeUndead", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeVermin", 0);
            SetLocalInt(OBJECT_SELF, "nDamageBonusRacialTypeOoze", 0);
        SetLocalInt(OBJECT_SELF, "nDamageBonusExtraDamageType", 0);
    SetLocalInt(OBJECT_SELF, "nEnhancementBonus", 0);
        SetLocalInt(OBJECT_SELF, "nEnhancementBonusUniversal", 0);
        SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignment", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroup", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroupNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroupLawful", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroupChaotic", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroupGood", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentGroupEvil", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecific", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificLawfulGood", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificLawfulNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificLawfulEvil", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificNeutralGood", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificTrueNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificNeutralEvil", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificChaoticGood", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificChaoticNeutral", 0);
                SetLocalInt(OBJECT_SELF, "nEnhancementBonusAlignmentSpecificChaoticEvil", 0);
        SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialType", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeDwarf", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeElf", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeGnome", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeHalfling", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeHalfElf", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeHalfOrc", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeHuman", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeAberration", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeAnimal", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeBeast", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeConstruct", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeDragon", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeGoblinoid", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeMonstrousHumanoid", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeOrc", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeReptile", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeElemental", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeFey", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeGiant", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeMagicalBeast", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeOutsider", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeShapechanger", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeUndead", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeVermin", 0);
            SetLocalInt(OBJECT_SELF, "nEnhancementBonusRacialTypeOoze", 0);
    SetLocalInt(OBJECT_SELF, "nHolyAvenger", 0);
    SetLocalInt(OBJECT_SELF, "nMovement", 0);
        SetLocalInt(OBJECT_SELF, "nMovementImprovedEvasion", 0);
        SetLocalInt(OBJECT_SELF, "nMovementFreedomOfMovement", 0);
        SetLocalInt(OBJECT_SELF, "nMovementHaste", 0);
    SetLocalInt(OBJECT_SELF, "nImmunity", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityDamageResistance", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceBludgeoning", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistancePiercing", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceSlashing", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceMagical", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceAcid", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceCold", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceDivine", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceElectrical", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceFire", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceNegative", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistancePositive", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageResistanceSonic", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunity", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityBludgeoning", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityPiercing", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunitySlashing", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityMagical", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityAcid", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityCold", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityDivine", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityElectrical", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityFire", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityNegative", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunityPositive", 0);
            SetLocalInt(OBJECT_SELF, "nImmunityDamageImmunitySonic", 0);
        SetLocalInt(OBJECT_SELF, "nImmunitySpellSchool", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolAbjuration", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolConjuration", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolDivination", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolEnchantment", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolEvocation", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolIllusion", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolNecromancy", 0);
            SetLocalInt(OBJECT_SELF, "nImmunitySpellSchoolTransmutation", 0);
        SetLocalInt(OBJECT_SELF, "nImmunitySpellLevel", 0);
        SetLocalInt(OBJECT_SELF, "nImmunitySpellResistance", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityDamageReduction", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityCriticalHits", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityDeathMagic", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityDisease", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityFear", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityKnockdown", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityLevelAbilityDrain", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityMindAffecting", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityParalysis", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityPoison", 0);
        SetLocalInt(OBJECT_SELF, "nImmunityBackstab", 0);
    SetLocalInt(OBJECT_SELF, "nSavingThrows", 0);
        SetLocalInt(OBJECT_SELF, "nSavingThrowsSpecific", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsSpecificFortitude", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsSpecificReflex", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsSpecificWillpower", 0);
        SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackType", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeUniversal", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeAcid", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeCold", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeDeath", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeDisease", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeDivine", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeElectrical", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeFear", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeFire", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeMindAffecting", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeNegative", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypePoison", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypePositive", 0);
            SetLocalInt(OBJECT_SELF, "nSavingThrowsAttackTypeSonic", 0);
    SetLocalInt(OBJECT_SELF, "nRegeneration", 0);
        SetLocalInt(OBJECT_SELF, "nRegenerationNormal", 0);
        SetLocalInt(OBJECT_SELF, "nRegenerationVampiric", 0);
    SetLocalInt(OBJECT_SELF, "nSkillBonus", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusAnimalEmpathy", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusConcentration", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusDisableTrap", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusDiscipline", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusHeal", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusHide", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusListen", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusLore", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusMoveSilently", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusOpenLock", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusParry", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusPerform", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusPersuade", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusSearch", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusSetTrap", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusSpellcraft", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusSpot", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusTaunt", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusUseMagicDevice", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusAppraise", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusTumble", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusCraftTrap", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusBluff", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusIntimidate", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusCraftArmor", 0);
        SetLocalInt(OBJECT_SELF, "nSkillBonusCraftWeapon", 0);
    SetLocalInt(OBJECT_SELF, "nUnlimitedAmmunition", 0);
    SetLocalInt(OBJECT_SELF, "nVision", 0);
        SetLocalInt(OBJECT_SELF, "nVisionLight", 0);
        SetLocalInt(OBJECT_SELF, "nVisionDarkvision", 0);
        SetLocalInt(OBJECT_SELF, "nVisionTrueSeeing", 0);
    SetLocalInt(OBJECT_SELF, "nWeightReduction", 0);
        SetLocalInt(OBJECT_SELF, "nWeightReductionContainer", 0);
        SetLocalInt(OBJECT_SELF, "nWeightReductionItem", 0);
    SetLocalInt(OBJECT_SELF, "nHealersKit", 0);
    SetLocalInt(OBJECT_SELF, "nThievesTools", 0);
}

void ResetForgeGemCounters()
{
    SetLocalInt(OBJECT_SELF, "nGem_1_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_1_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_1_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_1_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_1_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_2_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_2_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_2_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_2_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_2_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_3_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_3_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_3_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_3_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_3_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_4_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_4_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_4_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_4_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_4_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_5_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_5_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_5_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_5_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_5_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_6_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_6_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_6_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_6_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_6_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_7_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_7_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_7_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_7_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_7_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_8_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_8_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_8_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_8_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_8_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_9_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_9_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_9_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_9_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_9_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_10_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_10_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_10_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_10_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_10_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_11_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_11_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_11_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_11_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_11_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_12_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_12_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_12_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_12_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_12_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_13_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_13_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_13_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_13_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_13_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_14_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_14_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_14_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_14_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_14_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_15_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_15_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_15_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_15_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_15_5", 0);
    SetLocalInt(OBJECT_SELF, "nGem_16_1", 0);
    SetLocalInt(OBJECT_SELF, "nGem_16_2", 0);
    SetLocalInt(OBJECT_SELF, "nGem_16_3", 0);
    SetLocalInt(OBJECT_SELF, "nGem_16_4", 0);
    SetLocalInt(OBJECT_SELF, "nGem_16_5", 0);
}

