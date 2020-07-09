#include "inc_id1_utility"
#include "inc_id1_prop"

void main()
{
    object oForge = GetLocalObject(OBJECT_SELF, "oForge");
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
    object oItem = GetLocalObject(OBJECT_SELF, "oItem");
    string sColumn = GetLocalString(OBJECT_SELF, "sColumn");

    DebugMessage("");
    DebugMessage("Cataloging recipe for forge.");

    string sTag = GetTag(oItem);
    DebugMessage("  Recipe tag is " + sTag);

    string sName = GetName(oItem);
    DebugMessage("  Recipe name is " + sName);

    // get item property
    itemproperty ipRecipe = GetFirstItemProperty(oItem);

    // get property type
    int nRecipeType = GetItemPropertyType(ipRecipe);
    DebugMessage("  Recipe type is " + IntToString(nRecipeType));

    // make sure its not the custom spell property
    if (nRecipeType == ITEM_PROPERTY_CAST_SPELL)
    {
        DebugMessage("  Switching to real property.");
        ipRecipe = GetNextItemProperty(oItem);
        nRecipeType = GetItemPropertyType(ipRecipe);
        DebugMessage("    Recipe type is " + IntToString(nRecipeType));
    }

    // can this item use this property
    DebugMessage("  sColumn is " + sColumn);
    string sItemProp = Get2DAString("itemprops", sColumn, nRecipeType);
    DebugMessage("  Itemprop lookup is " + sItemProp);
    if (sItemProp != "")
    {
        DebugMessage("    This recipe's property can be used on this item.");

        // get property subtype
        int nRecipeSubType = GetItemPropertySubType(ipRecipe);
        DebugMessage("    Recipe subtype is " + IntToString(nRecipeSubType));

        // get property parameter
        int nRecipeParameter = GetItemPropertyParam1(ipRecipe);
        DebugMessage("    Recipe parameter is " + IntToString(nRecipeParameter));

        // get property parameter value
        int nRecipeParameterValue = GetItemPropertyParam1Value(ipRecipe);
        DebugMessage("    Recipe parameter value is " + IntToString(nRecipeParameterValue));

        // get property cost table
        int nRecipeCostTable = GetItemPropertyCostTable(ipRecipe);
        DebugMessage("    Recipe cost table is " + IntToString(nRecipeCostTable));

        // get property cost table value
        int nRecipeCostTableValue = GetItemPropertyCostTableValue(ipRecipe);
        DebugMessage("    Recipe cost table value is " + IntToString(nRecipeCostTableValue));

        // reset validity
        int bValidProperty = FALSE;
        string sVariable1 = "";
        string sVariable2 = "";
        string sVariable3 = "";
        string sVariable4 = "";

        // set booleans
        if (nRecipeType == ITEM_PROPERTY_ABILITY_BONUS)
        {
            sVariable1 = "AbilityScore";

            if (nRecipeSubType == IP_CONST_ABILITY_STR)
            {
                sVariable2 = "Strength";
            } else if (nRecipeSubType == IP_CONST_ABILITY_DEX)
            {
                sVariable2 = "Dexterity";
            } else if (nRecipeSubType == IP_CONST_ABILITY_CON)
            {
                sVariable2 = "Constitution";
            } else if (nRecipeSubType == IP_CONST_ABILITY_INT)
            {
                sVariable2 = "Intelligence";
            } else if (nRecipeSubType == IP_CONST_ABILITY_WIS)
            {
                sVariable2 = "Wisdom";
            } else if (nRecipeSubType == IP_CONST_ABILITY_CHA)
            {
                sVariable2 = "Charisma";
            }

            if (sVariable2 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_AC_BONUS)
        {
            sVariable1 = "ACBonus";
            sVariable2 = "Universal";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
        {
            sVariable1 = "ACBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Group";
            sVariable4 = StringAlignmentGroup(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
        {
            sVariable1 = "ACBonus";
            sVariable2 = "DamageType";
            sVariable3 = StringDamageType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
        {
            sVariable1 = "ACBonus";
            sVariable2 = "RacialType";
            sVariable3 = StringRacialType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)
        {
            sVariable1 = "ACBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Specific";
            sVariable4 = StringAlignmentSpecific(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
        {
            sVariable1 = "ArcaneSpellFailure";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_ATTACK_BONUS)
        {
            sVariable1 = "AttackBonus";
            sVariable2 = "Universal";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
        {
            sVariable1 = "AttackBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Group";
            sVariable4 = StringAlignmentGroup(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
        {
            sVariable1 = "AttackBonus";
            sVariable2 = "RacialType";
            sVariable3 = StringRacialType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)
        {
            sVariable1 = "AttackBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Specific";
            sVariable4 = StringAlignmentSpecific(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
        {
            sVariable1 = "WeightReduction";
            sVariable2 = "Item";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_BONUS_FEAT)
        {
            sVariable1 = "BonusFeat";
            sVariable2 = StringFeat(nRecipeSubType);

            if (sVariable2 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
        {
            sVariable1 = "BonusSpellSlot";
            sVariable2 = StringClass(nRecipeSubType);

            if (sVariable2 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_BONUS)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "Universal";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Group";
            sVariable4 = StringAlignmentGroup(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "RacialType";
            sVariable3 = StringRacialType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Specific";
            sVariable4 = StringAlignmentSpecific(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_REDUCTION)
        {
            sVariable1 = "Immunity";
            sVariable2 = "DamageReduction";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_DAMAGE_RESISTANCE)
        {
            sVariable1 = "Immunity";
            sVariable2 = "DamageResistance";
            sVariable3 = StringDamageType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_DARKVISION)
        {
            sVariable1 = "Vision";
            sVariable2 = "Darkvision";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)
        {
            sVariable1 = "WeightReduction";
            sVariable2 = "Container";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_ENHANCEMENT_BONUS)
        {
            sVariable1 = "EnhancementBonus";
            sVariable2 = "Universal";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
        {
            sVariable1 = "EnhancementBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Group";
            sVariable4 = StringAlignmentGroup(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)
        {
            sVariable1 = "EnhancementBonus";
            sVariable2 = "RacialType";
            sVariable3 = StringRacialType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)
        {
            sVariable1 = "EnhancementBonus";
            sVariable2 = "Alignment";
            sVariable3 = "Specific";
            sVariable4 = StringAlignmentSpecific(nRecipeSubType);

            if (sVariable4 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "ExtraDamageType";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
        {
            sVariable1 = "DamageBonus";
            sVariable2 = "ExtraDamageType";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)
        {
            sVariable1 = "Movement";
            sVariable2 = "FreedomOfMovement";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_HASTE)
        {
            sVariable1 = "Movement";
            sVariable2 = "Haste";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_HEALERS_KIT)
        {
            sVariable1 = "HealersKit";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_HOLY_AVENGER)
        {
            sVariable1 = "HolyAvenger";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
        {
            sVariable1 = "Immunity";
            sVariable2 = "DamageImmunity";
            sVariable3 = StringDamageType(nRecipeSubType);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
        {
            sVariable1 = "Immunity";

            if (nRecipeSubType == IP_CONST_IMMUNITYMISC_BACKSTAB)
            {
                sVariable2 = "Backstab";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_CRITICAL_HITS)
            {
                sVariable2 = "CriticalHits";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_DEATH_MAGIC)
            {
                sVariable2 = "DeathMagic";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_DISEASE)
            {
                sVariable2 = "Disease";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_FEAR)
            {
                sVariable2 = "Fear";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_KNOCKDOWN)
            {
                sVariable2 = "Knockdown";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN)
            {
                sVariable2 = "LevelAbilityDrain";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_MINDSPELLS)
            {
                sVariable2 = "MindAffecting";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_PARALYSIS)
            {
                sVariable2 = "Paralysis";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_IMMUNITYMISC_POISON)
            {
                sVariable2 = "Poison";
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
        {
            sVariable1 = "Immunity";
            sVariable2 = "SpellSchool";

            if (nRecipeSubType == IP_CONST_SPELLSCHOOL_ABJURATION)
            {
                sVariable3 = "Abjuration";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_CONJURATION)
            {
                sVariable3 = "Conjuration";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_DIVINATION)
            {
                sVariable3 = "Divination";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_ENCHANTMENT)
            {
                sVariable3 = "Enchantment";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_EVOCATION)
            {
                sVariable3 = "Evocation";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_ILLUSION)
            {
                sVariable3 = "Illusion";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_NECROMANCY)
            {
                sVariable3 = "Necromancy";
                bValidProperty = TRUE;
            } else if (nRecipeSubType == IP_CONST_SPELLSCHOOL_TRANSMUTATION)
            {
                sVariable3 = "Transmutation";
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
        {
            sVariable1 = "Immunity";
            sVariable2 = "SpellLevel";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_IMPROVED_EVASION)
        {
            sVariable1 = "Movement";
            sVariable2 = "ImprovedEvasion";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_KEEN)
        {
            sVariable1 = "CriticalHits";
            sVariable2 = "Keen";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_LIGHT)
        {
            sVariable1 = "Vision";
            sVariable2 = "Light";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_MASSIVE_CRITICALS)
        {
            sVariable1 = "CriticalHits";
            sVariable2 = "MassiveCriticals";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_REGENERATION)
        {
            sVariable1 = "Regeneration";
            sVariable2 = "RegenerationNormal";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_REGENERATION_VAMPIRIC)
        {
            sVariable1 = "Regeneration";
            sVariable2 = "RegenerationVampiric";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
        {
            DebugMessage("Adding non-specific.");

            sVariable1 = "SavingThrows";
            sVariable2 = "Specific";
            sVariable3 = StringSavingThrowType(nRecipeSubType);
            DebugMessage("SPECIAL: sVariable3 is " + sVariable3);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_SAVING_THROW_BONUS)
        {
            DebugMessage("Adding specific.");

            sVariable1 = "SavingThrows";
            sVariable2 = "AttackType";
            sVariable3 = StringSavingThrowAttackType(nRecipeSubType);
            DebugMessage("SPECIAL: sVariable3 is " + sVariable3);

            if (sVariable3 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_SKILL_BONUS)
        {
            sVariable1 = "SkillBonus";
            sVariable2 = StringSkill(nRecipeSubType);

            if (sVariable2 != "")
            {
                bValidProperty = TRUE;
            }
        } else if (nRecipeType == ITEM_PROPERTY_SPELL_RESISTANCE)
        {
            sVariable1 = "Immunity";
            sVariable2 = "SpellResistance";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_THIEVES_TOOLS)
        {
            sVariable1 = "ThievesTools";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_TRUE_SEEING)
        {
            sVariable1 = "Vision";
            sVariable2 = "TrueSeeing";
            bValidProperty = TRUE;
        } else if (nRecipeType == ITEM_PROPERTY_UNLIMITED_AMMUNITION)
        {
            sVariable1 = "UnlimitedAmmunition";
            bValidProperty = TRUE;
        }

        // add to recipe list
        if (bValidProperty == TRUE)
        {
            DebugMessage("    Combined is " + sVariable1 + sVariable2 + sVariable3 + sVariable4 + ".");

            // check each string and strip illegal characters
            DebugMessage("    sVariable1 before is " + sVariable1);
            sVariable1 = RemoveIllegalCharacters(sVariable1);
            DebugMessage("    sVariable1 after is " + sVariable1);

            DebugMessage("    sVariable2 before is " + sVariable2);
            sVariable2 = RemoveIllegalCharacters(sVariable2);
            DebugMessage("    sVariable2 after is " + sVariable2);

            DebugMessage("    sVariable3 before is " + sVariable3);
            sVariable3 = RemoveIllegalCharacters(sVariable3);
            DebugMessage("    sVariable3 after is " + sVariable3);

            DebugMessage("    sVariable4 before is " + sVariable4);
            sVariable4 = RemoveIllegalCharacters(sVariable4);
            DebugMessage("    sVariable4 after is " + sVariable4);

            // exceptions (armor proficiency, weapon proficiency, sneak attack, spell focus)
            if (sVariable1 == "BonusFeat")
            {
                string sSubString = GetSubString(sVariable2, 0, 10);
                int nStringLength = GetStringLength(sVariable2);
                DebugMessage("    Substring is " + sSubString);

                if (sSubString == "ArmorProfi") // "ArmorProficiency" 16
                {
                    sSubString = GetSubString(sVariable2, 16, nStringLength - 1);
                    DebugMessage("    Substring is " + sSubString);

                    if (sSubString == "Light")
                    {
                        sVariable3 = "Light";
                        sVariable2 = GetSubString(sVariable2, 0, 16);
                    } else if (sSubString == "Medium")
                    {
                        sVariable3 = "Medium";
                        sVariable2 = GetSubString(sVariable2, 0, 16);
                    } else if (sSubString == "Heavy")
                    {
                        sVariable3 = "Heavy";
                        sVariable2 = GetSubString(sVariable2, 0, 16);
                    }
                } else if (sSubString == "WeaponProf") // "WeaponProficiency" 17
                {
                    sSubString = GetSubString(sVariable2, 17, nStringLength - 1);
                    DebugMessage("    Substring is " + sSubString);

                    if (sSubString == "Simple")
                    {
                        sVariable3 = "Simple";
                        sVariable2 = GetSubString(sVariable2, 0, 17);
                    } else if (sSubString == "Martial")
                    {
                        sVariable3 = "Martial";
                        sVariable2 = GetSubString(sVariable2, 0, 17);
                    } else if (sSubString == "Exotic")
                    {
                        sVariable3 = "Exotic";
                        sVariable2 = GetSubString(sVariable2, 0, 17);
                    }
                } else if (sSubString == "SneakAttac") // "SneakAttack" 11
                {
                    sVariable2 = "SneakAttack";
                } else if (sSubString == "SpellFocus") // "SpellFocus" 10
                {
                    sSubString = GetSubString(sVariable2, 10, nStringLength - 1);
                    DebugMessage("    Substring is " + sSubString);

                    if (sSubString == "Abjuration")
                    {
                        sVariable3 = "Abjuration";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Conjuration")
                    {
                        sVariable3 = "Conjuration";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Divination")
                    {
                        sVariable3 = "Divination";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Enchantment")
                    {
                        sVariable3 = "Enchantment";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Evocation")
                    {
                        sVariable3 = "Evocation";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Illusion")
                    {
                        sVariable3 = "Illusion";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    } else if (sSubString == "Necromancy")
                    {
                        sVariable3 = "Necromancy";
                        sVariable2 = GetSubString(sVariable2, 0, 10);
                    }
                }
            }

            // mark each property as true
            if (sVariable1 != "")
            {
                DebugMessage("Setting b" + sVariable1);
                SetLocalInt(oForge, "b" + sVariable1, TRUE);
            }

            if (sVariable2 != "")
            {
                DebugMessage("Setting b" + sVariable2);
                SetLocalInt(oForge, "b" + sVariable1 + sVariable2, TRUE);
            }

            if (sVariable3 != "")
            {
                DebugMessage("Setting b" + sVariable3);
                SetLocalInt(oForge, "b" + sVariable1 + sVariable2 + sVariable3, TRUE);
            }

            if (sVariable4 != "")
            {
                DebugMessage("Setting b" + sVariable4);
                SetLocalInt(oForge, "b" + sVariable1 + sVariable2 + sVariable3 + sVariable4, TRUE);
            }

            // add this recipe to the list
            int nRecipeNum = GetLocalInt(oForge, "n" + sVariable1 + sVariable2 + sVariable3 + sVariable4);
            nRecipeNum++;
            SetLocalInt(oForge, "n" + sVariable1 + sVariable2 + sVariable3 + sVariable4, nRecipeNum);
            SetLocalObject(oForge, "o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipeNum), oItem);
            DebugMessage("Set " + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipeNum));
        }
    } else
    {
        DebugMessage("Recipe cannot be used on an item of this type.");
    }

    // increment number of gems cataloged on forge
    int nForgeGemNum = GetLocalInt(oForge, "nGemNum");
    int nForgeGemCurrent = GetLocalInt(oForge, "nGemCurrent");
    int nForgeRecipeNum = GetLocalInt(oForge, "nRecipeNum");
    int nForgeRecipeCurrent = GetLocalInt(oForge, "nRecipeCurrent");

    nForgeRecipeCurrent++;
    SetLocalInt(oForge, "nRecipeCurrent", nForgeRecipeCurrent);

    DebugMessage("  Have cataloged " + IntToString(nForgeGemCurrent) + " out of " + IntToString(nForgeGemNum) + " gems.");
    DebugMessage("  Have cataloged " + IntToString(nForgeRecipeCurrent) + " out of " + IntToString(nForgeRecipeNum) + " recipes.");

    if ((nForgeGemCurrent >= nForgeGemNum) && (nForgeRecipeCurrent >= nForgeRecipeNum))
    {
        DebugMessage("Item catalog finished.");
        SetLocalInt(oForge, "bCataloging", FALSE);
        DelayCommand(0.01, AssignCommand(oPC, ActionStartConversation(oForge, "id1_forge", TRUE, FALSE)));
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
