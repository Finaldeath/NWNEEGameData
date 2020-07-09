#include "inc_id1_prop"
#include "inc_id1_score"

void SetItemName(object oItem);
string GetCategoryVariableName(int nCategory);
int GetSubCategoryNum(int nCategory, int bGeneric = FALSE);
string GetSubCategoryVariableName(int nCategory, int nSubCategory);
int GetTypeNum(int nCategory, int nSubCategory);
string GetTypeVariableName(int nCategory, int nSubCategory, int nType);
string ReturnBaseItemString(int nBaseType);
string GetTypeGenericItem(int nCategory, int nSubCategory, int nType);
void SetRecipeName(object oItem);
int GetScrollNum(int nLevel);
string GetScrollResRef(int nSpellLevel, int nSpellID);
int GetPotionNum(int nLevel);
string GetPotionResRef(int nLevel, int nNum);
int GetGrenadeNum(int nLevel);
string GetGrenadeResRef(int nLevel, int nNum);
int GetWandNum(int nLevel);
string GetWandResRef(int nLevel, int nNum);
int GetMiscellaneousNum(int nLevel);
string GetMiscellaneousResRef(int nLevel, int nNum);

void SetItemName(object oItem)
{
    if (oItem == OBJECT_INVALID)
    {
        DebugMessage("Item does not exist.");
    } else
    {
        DebugMessage("Item does exist with tag " + GetTag(oItem));
    }
    string sName = GetName(oItem);
    DebugMessage("Item name is " + sName);
    int nPrefix = 0;
    int nPrefixSubType = 0;
    int nBonusType = 0; // (1 is number, 2 is iprp_redcost, 3 is iprp_damagecost)
    int nBonus = 0;
    int nSuffix = 0;
    int nSuffixBonus = 0;
    int nSuffixSubType = 0;

    int nItemType = GetBaseItemType(oItem);
    int nPropertyColumn = StringToInt(Get2DAString("baseitems", "PropColumn", nItemType));
    DebugMessage("Item type is " + IntToString(nItemType) + " and property column is " + IntToString(nPropertyColumn));

    int bWeapon = FALSE;
    int bRanged = FALSE;
    int bAmmo = FALSE;
    int bArmor = FALSE;
    int bWand = FALSE;
    if ((nPropertyColumn == 0) || (nPropertyColumn == 2) || (nPropertyColumn == 3)) // melee/thrown/staff
    {
        bWeapon = TRUE;
    } else if (nPropertyColumn == 1) // ranged
    {
        bRanged = TRUE;
    } else if (nPropertyColumn == 4) // rods
    {
    } else if (nPropertyColumn == 5) // ammo
    {
        bAmmo = TRUE;
    } else if ((nPropertyColumn == 6) || (nPropertyColumn == 7) || (nPropertyColumn == 21)) // armor/helm/glove
    {
        bArmor = TRUE;
    } else if (nPropertyColumn == 8) // potions
    {
    } else if (nPropertyColumn == 9) // scrolls
    {
    } else if (nPropertyColumn == 10) // wands
    {
        bWand = TRUE;
    } else if (nPropertyColumn == 11) // thieves tools
    {
    } else if (nPropertyColumn == 12) // trap kits
    {
    } else if (nPropertyColumn == 13) // hides
    {
    } else if (nPropertyColumn == 14) // claws
    {
    } else if (nPropertyColumn == 15) // miscellaneous unequipped
    {
    } else if (nPropertyColumn == 16) // miscellaneous
    {
    } else if (nPropertyColumn == 17) // no properties
    {
    } else if (nPropertyColumn == 18) // containers
    {
    } else if (nPropertyColumn == 19) // healer kits
    {
    } else if (nPropertyColumn == 20) // torch
    {
    } else if (nPropertyColumn == 22) // recipes
    {
    }

    itemproperty ipItem = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipItem) == TRUE)
    {
        int nType = GetItemPropertyType(ipItem);
        DebugMessage("Item property type is " + IntToString(nType));
        int nSubType = GetItemPropertySubType(ipItem);
        DebugMessage("  Item property subtype is " + IntToString(nSubType));
        int nCost = GetItemPropertyCostTable(ipItem);
        DebugMessage("  Item property cost table is " + IntToString(nCost));
        int nCostValue = GetItemPropertyCostTableValue(ipItem);
        DebugMessage("  Item property cost table value is " + IntToString(nCostValue));
        int nParam1 = GetItemPropertyParam1(ipItem);
        DebugMessage("  Item property param1 is " + IntToString(nParam1));
        int nParam1Value = GetItemPropertyParam1Value(ipItem);
        DebugMessage("  Item property param1 value is " + IntToString(nParam1Value));

        switch (nType)
        {
            // 10 prefix
            case ITEM_PROPERTY_HOLY_AVENGER:
                nPrefix = 10;
                break;
            case ITEM_PROPERTY_HASTE:
                if (nPrefix < 9)
                {
                    nPrefix = 9;
                }
                break;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
                if (nPrefix < 8)
                {
                    nPrefix = 8;
                }
                break;
            case ITEM_PROPERTY_KEEN:
                if (nPrefix < 7)
                {
                    nPrefix = 7;
                }
                break;
            case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
                if (nPrefix < 6)
                {
                    nPrefix = 6;
                }
                break;
            case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
                if (nPrefix < 5)
                {
                    nPrefix = 5;
                }
                break;
            case ITEM_PROPERTY_MASSIVE_CRITICALS:
                if (nPrefix < 4)
                {
                    nPrefix = 4;
                }
                break;
            case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
                if (nPrefix < 3)
                {
                    nPrefix = 3;
                    nPrefixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
                if (nPrefix < 2)
                {
                    nPrefix = 2;
                    nPrefixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
                if (nPrefix < 1)
                {
                    nPrefix = 1;
                }
                break;


            // 7 primary
            case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
                nBonusType = 2;
                nBonus = nCostValue; // label in iprp_redcost.2da
                break;
            case ITEM_PROPERTY_HEALERS_KIT:
                nBonusType = 1;
                nBonus = nCostValue;
                break;
            case ITEM_PROPERTY_THIEVES_TOOLS:
                nBonusType = 1;
                nBonus = nCostValue;
                break;
            case ITEM_PROPERTY_AC_BONUS:
                if (bArmor == TRUE)
                {
                    nBonusType = 1;
                    nBonus = nCostValue;
                } else
                {
                    if (nSuffix < 19)
                    {
                        nSuffix = 19;
                    }
                }
                break;
            case ITEM_PROPERTY_ATTACK_BONUS:
                if (bRanged == TRUE)
                {
                    nBonusType = 1;
                    nBonus = nCostValue;
                } else
                {
                    if (nSuffix < 21)
                    {
                        nSuffix = 21;
                    }
                }
                break;
            case ITEM_PROPERTY_DAMAGE_BONUS:
                if (bAmmo == TRUE)
                {
                    nBonusType = 3;
                    nBonus = nCostValue; // label in iprp_damagecost.2da
                } else
                {
                    if (nSuffix < 20)
                    {
                        nSuffix = 20;
                    }
                }
                break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS:
                if (bWeapon == TRUE)
                {
                    nBonusType = 1;
                    nBonus = nCostValue;
                } else
                {
                    if (nSuffix < 22)
                    {
                        nSuffix = 22;
                    }
                }
                break;

            // 36 suffix
            case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
                nSuffix = 36;
                break;
            case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
                if (nSuffix < 35)
                {
                    nSuffix = 35;
                }
                break;
            case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
                if (nSuffix < 34)
                {
                    nSuffix = 34;
                }
                break;
            case ITEM_PROPERTY_DAMAGE_REDUCTION:
                if (nSuffix < 33)
                {
                    nSuffix = 33;
                }
                break;
            case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
                if (nSuffix < 32)
                {
                    nSuffix = 32;
                }
                break;
            case ITEM_PROPERTY_REGENERATION:
                if (nSuffix < 31)
                {
                    nSuffix = 31;
                }
                break;
            case ITEM_PROPERTY_DAMAGE_RESISTANCE:
                if (nSuffix < 30)
                {
                    nSuffix = 30;
                }
                break;
            case ITEM_PROPERTY_SPELL_RESISTANCE:
                if (nSuffix < 29)
                {
                    nSuffix = 29;
                }
                break;
            case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
                if (nSuffix < 28)
                {
                    nSuffix = 28;
                }
                break;
            case ITEM_PROPERTY_TRUE_SEEING:
                if (nSuffix < 27)
                {
                    nSuffix = 27;
                }
                break;
            case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
                if (nSuffix < 26)
                {
                    nSuffix = 26;
                }
                break;
            case ITEM_PROPERTY_IMPROVED_EVASION:
                if (nSuffix < 25)
                {
                    nSuffix = 25;
                }
                break;
            case ITEM_PROPERTY_BONUS_FEAT:
                if (nSuffix < 24)
                {
                    nSuffix = 24;
                }
                break;
            case ITEM_PROPERTY_ABILITY_BONUS:
                if (nSuffix < 23)
                {
                    nSuffix = 23;
                    nSuffixSubType = nSubType; // ability
                }
                break;
            case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
                if (nSuffix < 18)
                {
                    nSuffix = 18;
                }
                break;
            case ITEM_PROPERTY_DARKVISION:
                if (nSuffix < 17)
                {
                    nSuffix = 17;
                }
                break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
                if (nSuffix < 16)
                {
                    nSuffix = 16;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
                if (nSuffix < 15)
                {
                    nSuffix = 15;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
                if (nSuffix < 14)
                {
                    nSuffix = 14;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
                if (nSuffix < 13)
                {
                    nSuffix = 13;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
                if (nSuffix < 12)
                {
                    nSuffix = 12;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
                if (nSuffix < 11)
                {
                    nSuffix = 11;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
                if (nSuffix < 10)
                {
                    nSuffix = 10;
                    nSuffixBonus = nCostValue; // label in iprp_damagecost.2da
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
                if (nSuffix < 9)
                {
                    nSuffix = 9;
                    nSuffixBonus = nCostValue; // label in iprp_damagecost.2da
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
                if (nSuffix < 8)
                {
                    nSuffix = 8;
                    nSuffixBonus = nCostValue; // label in iprp_damagecost.2da
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
                if (nSuffix < 7)
                {
                    nSuffix = 7;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
                if (nSuffix < 6)
                {
                    nSuffix = 6;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
                if (nSuffix < 5)
                {
                    nSuffix = 5;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
                if (nSuffix < 4)
                {
                    nSuffix = 4;
                    nSuffixBonus = nCostValue;
                    nSuffixSubType = nSubType;
                }
                break;
            case ITEM_PROPERTY_SAVING_THROW_BONUS:
                if (nSuffix < 3)
                {
                    nSuffix = 3;
                }
                break;
            case ITEM_PROPERTY_SKILL_BONUS:
                if (nSuffix < 2)
                {
                    nSuffix = 2;
                }
                break;
            case ITEM_PROPERTY_LIGHT:
                if (nSuffix < 1)
                {
                    nSuffix = 1;
                }
                break;
        }

        ipItem = GetNextItemProperty(oItem);
    }

    // prefix string
    if (nPrefix == 10)
    {
        sName = "Holy Avenger " + sName;
    }
    if (nPrefix == 9)
    {
        sName = "Hasted " + sName;
    }
    if (nPrefix == 8)
    {
        sName = "Vampiric " + sName;
    }
    if (nPrefix == 7)
    {
        sName = "Keen " + sName;
    }
    if (nPrefix == 6)
    {
        sName = "Spellcrafted " + sName;
    }
    if (nPrefix == 5)
    {
        sName = "Limitless " + sName;
    }
    if (nPrefix == 4)
    {
        sName = "Massive " + sName;
    }
    if ((nPrefix == 2) || (nPrefix == 3))
    {
        if (nPrefixSubType == IP_CONST_DAMAGETYPE_BLUDGEONING)
        {
            sName = "Bludgeoning " + sName;
        }
        if (nPrefixSubType == IP_CONST_DAMAGETYPE_PIERCING)
        {
            sName = "Piercing " + sName;
        }
        if (nPrefixSubType == IP_CONST_DAMAGETYPE_SLASHING)
        {
            sName = "Slashing " + sName;
        }
    }
    if (nPrefix == 1)
    {
        sName = "Weightless " + sName;
    }

    // bonus string
    if (nBonusType == 1)
    {
        sName = sName + " +" + IntToString(nBonus);
    }
    if (nBonusType == 2)
    {
        string sBonus = Get2DAString("iprp_redcost", "Label", nBonus);
        sName = sName + " " + sBonus;
    }
    if (nBonusType == 3)
    {
        string sBonus = Get2DAString("iprp_damagecost", "Label", nBonus);
        sName = sName + " +" + sBonus;
    }

    // suffix string
    if (nSuffix == 36)
    {
        sName = sName + " of Damage Immunity";
    }
    if (nSuffix == 35)
    {
        sName = sName + " of Spell Immunity";
    }
    if (nSuffix == 34)
    {
        sName = sName + " of School Immunity";
    }
    if (nSuffix == 33)
    {
        sName = sName + " of Damage Reduction";
    }
    if (nSuffix == 32)
    {
        sName = sName + " of Immunity";
    }
    if (nSuffix == 31)
    {
        sName = sName + " of Regeneration";
    }
    if (nSuffix == 30)
    {
        sName = sName + " of Damage Resistance";
    }
    if (nSuffix == 29)
    {
        sName = sName + " of Spell Resistance";
    }
    if (nSuffix == 28)
    {
        sName = sName + " of Spellcasting";
    }
    if (nSuffix == 27)
    {
        sName = sName + " of True Seeing";
    }
    if (nSuffix == 26)
    {
        sName = sName + " of Freedom";
    }
    if (nSuffix == 25)
    {
        sName = sName + " of Evasion";
    }
    if (nSuffix == 24)
    {
        sName = sName + " of Ability";
    }
    if (nSuffix == 23)
    {
        if (nSuffixSubType == IP_CONST_ABILITY_STR)
        {
            sName = sName + " of Strength";
        }
        if (nSuffixSubType == IP_CONST_ABILITY_DEX)
        {
            sName = sName + " of Dexterity";
        }
        if (nSuffixSubType == IP_CONST_ABILITY_CON)
        {
            sName = sName + " of Constitution";
        }
        if (nSuffixSubType == IP_CONST_ABILITY_INT)
        {
            sName = sName + " of Intelligence";
        }
        if (nSuffixSubType == IP_CONST_ABILITY_WIS)
        {
            sName = sName + " of Wisdom";
        }
        if (nSuffixSubType == IP_CONST_ABILITY_CHA)
        {
            sName = sName + " of Charisma";
        }
    }
    if (nSuffix == 22)
    {
        sName = sName + " of Slaying";
    }
    if (nSuffix == 21)
    {
        sName = sName + " of Seeking";
    }
    if (nSuffix == 20)
    {
        sName = sName + " of Biting";
    }
    if (nSuffix == 19)
    {
        sName = sName + " of Defense";
    }
    if (nSuffix == 18)
    {
        sName = sName + " of Safety";
    }
    if (nSuffix == 17)
    {
        sName = sName + " of Darkvision";
    }
    if (nSuffix == 16)
    {
        string sString = StringRacialType(nSuffixSubType);
        sName = sName + " of Racial Slaying";
    }
    if (nSuffix == 15)
    {
        string sString = StringAlignmentGroup(nSuffixSubType);
        sName = sName + " of Aligned Slaying";
    }
    if (nSuffix == 14)
    {
        string sString = StringAlignmentSpecific(nSuffixSubType);
        sName = sName + " of Aligned Slaying";
    }
    if (nSuffix == 13)
    {
        string sString = StringRacialType(nSuffixSubType);
        sName = sName + " of Racial Seeking";
    }
    if (nSuffix == 12)
    {
        string sString = StringAlignmentGroup(nSuffixSubType);
        sName = sName + " of Aligned Seeking";
    }
    if (nSuffix == 11)
    {
        string sString = StringAlignmentSpecific(nSuffixSubType);
        sName = sName + " of Aligned Seeking";
    }
    if (nSuffix == 10)
    {
        string sString = StringRacialType(nSuffixSubType);
        sName = sName + " of Racial Biting";
    }
    if (nSuffix == 9)
    {
        string sString = StringAlignmentGroup(nSuffixSubType);
        sName = sName + " of Aligned Biting";
    }
    if (nSuffix == 8)
    {
        string sString = StringAlignmentSpecific(nSuffixSubType);
        sName = sName + " of Aligned Biting";
    }
    if (nSuffix == 7)
    {
        sName = sName + " of Racial Defense";
    }
    if (nSuffix == 6)
    {
        string sString = StringDamageType(nSuffixSubType);
        sName = sName + " of Damage Defense";
    }
    if (nSuffix == 5)
    {
        sName = sName + " of Aligned Defense";
    }
    if (nSuffix == 4)
    {
        sName = sName + " of Aligned Defense";
    }
    if (nSuffix == 3)
    {
        sName = sName + " of Safety";
    }
    if (nSuffix == 2)
    {
        sName = sName + " of Skill";
    }
    if (nSuffix == 1)
    {
        sName = sName + " of Light";
    }

    SetName(oItem, sName);
}

string GetCategoryVariableName(int nCategory)
{
    if (nCategory == 1) // weapon
    {
        return "Weapon";
    } else if (nCategory == 2) // armor
    {
        return "Armor";
    } else if (nCategory == 3) // accessory
    {
        return "Accessory";
    } else if (nCategory == 4) // consumable
    {
        return "Consumable";
    } else // miscellaneous
    {
        return "Miscellaneous";
    }
}

int GetSubCategoryNum(int nCategory, int bGeneric = FALSE)
{
    if (nCategory == 1) // weapon
    {
        return 3;
    } else if (nCategory == 2) // armor
    {
        return 2;
    } else if (nCategory == 3) // accessory
    {
        return 8;
    } else if (nCategory == 4) // consumable
    {
        if (bGeneric == TRUE)
        {
            return 4;
        } else
        {
            return 5;
        }
    } else // miscellaneous
    {
        return 1;
    }
}

string GetSubCategoryVariableName(int nCategory, int nSubCategory)
{
    if (nCategory == 1) // weapon
    {
        if (nSubCategory == 1) // melee
        {
            return "Melee";
        } else if (nSubCategory == 2) // ranged
        {
            return "Ranged";
        } else // ammunition
        {
            return "Ammunition";
        }
    } else if (nCategory == 2) // armor
    {
        if (nSubCategory == 1) // body
        {
            return "Body";
        } else // shield
        {
            return "Shield";
        }
    } else if (nCategory == 3) // accessory
    {
        if (nSubCategory == 1)
        {
            return "Amulet";
        } else if (nSubCategory == 2)
        {
            return "Belt";
        } else if (nSubCategory == 3)
        {
            return "Boots";
        } else if (nSubCategory == 4)
        {
            return "Bracer";
        } else if (nSubCategory == 5)
        {
            return "Cloak";
        } else if (nSubCategory == 6)
        {
            return "Gloves";
        } else if (nSubCategory == 7)
        {
            return "Helmet";
        } else
        {
            return "Ring";
        }
    } else if (nCategory == 4) // consumable
    {
        if (nSubCategory == 1)
        {
            return "Grenade";
        } else if (nSubCategory == 2)
        {
            return "Wand";
        } else if (nSubCategory == 3)
        {
            return "Potion";
        } else if (nSubCategory == 4)
        {
            return "Scroll";
        } else
        {
            return "Rod";
        }
    } else // miscellaneous
    {
        return "Miscellaneous";
    }
}

int GetTypeNum(int nCategory, int nSubCategory)
{
    if (nCategory == 1) // weapon
    {
        if (nSubCategory == 1) // melee
        {
            return 30;
        } else if (nSubCategory == 2) // ranged
        {
            return 8;
        } else // ammunition
        {
            return 3;
        }
    } else if (nCategory == 2) // armor
    {
        if (nSubCategory == 1) // body
        {
            return 9;
        } else // shield
        {
            return 3;
        }
    } else // accessory, consumable, miscellaneous
    {
        return 1;
    }
}

string GetTypeVariableName(int nCategory, int nSubCategory, int nType)
{
    if (nCategory == 1) // weapon
    {
        if (nSubCategory == 1) // melee
        {
            if (nType == 1)
            {
                return "BastardSword";
            } else if (nType == 2)
            {
                return "BattleAxe";
            } else if (nType == 3)
            {
                return "Club";
            } else if (nType == 4)
            {
                return "Dagger";
            } else if (nType == 5)
            {
                return "DireMace";
            } else if (nType == 6)
            {
                return "DoubleAxe";
            } else if (nType == 7)
            {
                return "DwarvenWarAxe";
            } else if (nType == 8)
            {
                return "GreatAxe";
            } else if (nType == 9)
            {
                return "GreatSword";
            } else if (nType == 10)
            {
                return "Halberd";
            } else if (nType == 11)
            {
                return "HandAxe";
            } else if (nType == 12)
            {
                return "HeavyFlail";
            } else if (nType == 13)
            {
                return "Kama";
            } else if (nType == 14)
            {
                return "Katana";
            } else if (nType == 15)
            {
                return "Kukri";
            } else if (nType == 16)
            {
                return "LightFlail";
            } else if (nType == 17)
            {
                return "LightHammer";
            } else if (nType == 18)
            {
                return "LightMace";
            } else if (nType == 19)
            {
                return "LongSword";
            } else if (nType == 20)
            {
                return "Staff";
            } else if (nType == 21)
            {
                return "MorningStar";
            } else if (nType == 22)
            {
                return "Rapier";
            } else if (nType == 23)
            {
                return "Scimitar";
            } else if (nType == 24)
            {
                return "Scythe";
            } else if (nType == 25)
            {
                return "ShortSpear";
            } else if (nType == 26)
            {
                return "ShortSword";
            } else if (nType == 27)
            {
                return "Sickle";
            } else if (nType == 28)
            {
                return "TwoBladedSword";
            } else if (nType == 29)
            {
                return "WarHammer";
            } else
            {
                return "Whip";
            }
        } else if (nSubCategory == 2) // ranged
        {
            if (nType == 1)
            {
                return "Dart";
            } else if (nType == 2)
            {
                return "HeavyCrossbow";
            } else if (nType == 3)
            {
                return "LightCrossbow";
            } else if (nType == 4)
            {
                return "LongBow";
            } else if (nType == 5)
            {
                return "ShortBow";
            } else if (nType == 6)
            {
                return "Shuriken";
            } else if (nType == 7)
            {
                return "Sling";
            } else
            {
                return "ThrowingAxe";
            }
        } else // ammunition
        {
            if (nType == 1)
            {
                return "Arrow";
            } else if (nType == 2)
            {
                return "Bolt";
            } else
            {
                return "Bullet";
            }
        }
    } else if (nCategory == 2) // armor
    {
        if (nSubCategory == 1)
        {
            if (nType == 1)
            {
                return "ArmorCloth";
            } else if (nType == 2)
            {
                return "ArmorPadded";
            } else if (nType == 3)
            {
                return "ArmorLeather";
            } else if (nType == 4)
            {
                return "ArmorHide";
            } else if (nType == 5)
            {
                return "ArmorScale";
            } else if (nType == 6)
            {
                return "ArmorChainmail";
            } else if (nType == 7)
            {
                return "ArmorBanded";
            } else if (nType == 8)
            {
                return "ArmorHalfPlate";
            } else
            {
                return "ArmorFullPlate";
            }
        } else
        {
            if (nType == 1)
            {
                return "SmallShield";
            } else if (nType == 2)
            {
                return "LargeShield";
            } else
            {
                return "TowerShield";
            }
        }
    } else if (nCategory == 3) // accessory
    {
        if (nSubCategory == 1)
        {
            return "Amulet";
        } else if (nSubCategory == 2)
        {
            return "Belt";
        } else if (nSubCategory == 3)
        {
            return "Boots";
        } else if (nSubCategory == 4)
        {
            return "Bracer";
        } else if (nSubCategory == 5)
        {
            return "Cloak";
        } else if (nSubCategory == 6)
        {
            return "Gloves";
        } else if (nSubCategory == 7)
        {
            return "Helmet";
        } else
        {
            return "Ring";
        }
    } else if (nCategory == 4) // consumable
    {
        if (nSubCategory == 1)
        {
            return "Grenade";
        } else if (nSubCategory == 2)
        {
            return "Wand";
        } else if (nSubCategory == 3)
        {
            return "Potion";
        } else if (nSubCategory == 4)
        {
            return "Scroll";
        } else
        {
            return "Rod";
        }
    } else // miscellaneous
    {
        return "Miscellaneous";
    }
}

string ReturnBaseItemString(int nBaseType)
{
    string sBaseType;
    if (nBaseType == BASE_ITEM_AMULET)
    {
        sBaseType = "Amulet";
    } else if (nBaseType == BASE_ITEM_ARMOR)
    {
        sBaseType = "Armor";
    } else if (nBaseType == BASE_ITEM_ARROW)
    {
        sBaseType = "Arrow";
    } else if (nBaseType == BASE_ITEM_BASTARDSWORD)
    {
        sBaseType = "Bastard Sword";
    } else if (nBaseType == BASE_ITEM_BATTLEAXE)
    {
        sBaseType = "Battle Axe";
    } else if (nBaseType == BASE_ITEM_BELT)
    {
        sBaseType = "Belt";
    } else if (nBaseType == BASE_ITEM_BOLT)
    {
        sBaseType = "Bolt";
    } else if (nBaseType == BASE_ITEM_BOOTS)
    {
        sBaseType = "Boots";
    } else if (nBaseType == BASE_ITEM_BRACER)
    {
        sBaseType = "Bracer";
    } else if (nBaseType == BASE_ITEM_BULLET)
    {
        sBaseType = "Bullet";
    } else if (nBaseType == BASE_ITEM_CLOAK)
    {
        sBaseType = "Cloak";
    } else if (nBaseType == BASE_ITEM_CLUB)
    {
        sBaseType = "Club";
    } else if (nBaseType == BASE_ITEM_DAGGER)
    {
        sBaseType = "Dagger";
    } else if (nBaseType == BASE_ITEM_DART)
    {
        sBaseType = "Dart";
    } else if (nBaseType == BASE_ITEM_DIREMACE)
    {
        sBaseType = "Dire Mace";
    } else if (nBaseType == BASE_ITEM_DOUBLEAXE)
    {
        sBaseType = "Double Axe";
    } else if (nBaseType == BASE_ITEM_DWARVENWARAXE)
    {
        sBaseType = "Dwarven War Axe";
    } else if (nBaseType == BASE_ITEM_GLOVES)
    {
        sBaseType = "Gloves";
    } else if (nBaseType == BASE_ITEM_GREATAXE)
    {
        sBaseType = "Great Axe";
    } else if (nBaseType == BASE_ITEM_GREATSWORD)
    {
        sBaseType = "Great Sword";
    } else if (nBaseType == BASE_ITEM_HALBERD)
    {
        sBaseType = "Halberd";
    } else if (nBaseType == BASE_ITEM_HANDAXE)
    {
        sBaseType = "Hand Axe";
    } else if (nBaseType == BASE_ITEM_HEAVYCROSSBOW)
    {
        sBaseType = "Heavy Crossbow";
    } else if (nBaseType == BASE_ITEM_HEAVYFLAIL)
    {
        sBaseType = "Heavy Flail";
    } else if (nBaseType == BASE_ITEM_HELMET)
    {
        sBaseType = "Helmet";
    } else if (nBaseType == BASE_ITEM_KAMA)
    {
        sBaseType = "Kama";
    } else if (nBaseType == BASE_ITEM_KATANA)
    {
        sBaseType = "Katana";
    } else if (nBaseType == BASE_ITEM_KUKRI)
    {
        sBaseType = "Kukri";
    } else if (nBaseType == BASE_ITEM_LARGESHIELD)
    {
        sBaseType = "Large Shield";
    } else if (nBaseType == BASE_ITEM_LIGHTCROSSBOW)
    {
        sBaseType = "Light Crossbow";
    } else if (nBaseType == BASE_ITEM_LIGHTFLAIL)
    {
        sBaseType = "Light Flail";
    } else if (nBaseType == BASE_ITEM_LIGHTHAMMER)
    {
        sBaseType = "Light Hammer";
    } else if (nBaseType == BASE_ITEM_LIGHTMACE)
    {
        sBaseType = "Light Mace";
    } else if (nBaseType == BASE_ITEM_LONGBOW)
    {
        sBaseType = "Long Bow";
    } else if (nBaseType == BASE_ITEM_LONGSWORD)
    {
        sBaseType = "Long Sword";
    } else if (nBaseType == BASE_ITEM_MAGICROD)
    {
        sBaseType = "Rod";
    } else if (nBaseType == BASE_ITEM_MAGICSTAFF)
    {
        sBaseType = "Staff";
    } else if (nBaseType == BASE_ITEM_MORNINGSTAR)
    {
        sBaseType = "Morning Star";
    } else if (nBaseType == BASE_ITEM_QUARTERSTAFF)
    {
        sBaseType = "Staff";
    } else if (nBaseType == BASE_ITEM_RAPIER)
    {
        sBaseType = "Rapier";
    } else if (nBaseType == BASE_ITEM_RING)
    {
        sBaseType = "Ring";
    } else if (nBaseType == BASE_ITEM_SCIMITAR)
    {
        sBaseType = "Scimitar";
    } else if (nBaseType == BASE_ITEM_SCYTHE)
    {
        sBaseType = "Scythe";
    } else if (nBaseType == BASE_ITEM_SHORTBOW)
    {
        sBaseType = "Short Bow";
    } else if (nBaseType == BASE_ITEM_SHORTSPEAR)
    {
        sBaseType = "Short Spear";
    } else if (nBaseType == BASE_ITEM_SHORTSWORD)
    {
        sBaseType = "Short Sword";
    } else if (nBaseType == BASE_ITEM_SHURIKEN)
    {
        sBaseType = "Shuriken";
    } else if (nBaseType == BASE_ITEM_SICKLE)
    {
        sBaseType = "Sickle";
    } else if (nBaseType == BASE_ITEM_SLING)
    {
        sBaseType = "Sling";
    } else if (nBaseType == BASE_ITEM_SMALLSHIELD)
    {
        sBaseType = "Small Shield";
    } else if (nBaseType == BASE_ITEM_THROWINGAXE)
    {
        sBaseType = "Throwing Axe";
    } else if (nBaseType == BASE_ITEM_TOWERSHIELD)
    {
        sBaseType = "Tower Shield";
    } else if (nBaseType == BASE_ITEM_TWOBLADEDSWORD)
    {
        sBaseType = "Two Bladed Sword";
    } else if (nBaseType == BASE_ITEM_WARHAMMER)
    {
        sBaseType = "War Hammer";
    } else if (nBaseType == BASE_ITEM_WHIP)
    {
        sBaseType = "Whip";
    } else
    {
        sBaseType = "Miscellaneous";
    }

    return sBaseType;
}

string GetTypeGenericItem(int nCategory, int nSubCategory, int nType)
{
    if (nCategory == 1) // weapon
    {
        if (nSubCategory == 1) // melee
        {
            if (nType == 1)
            {
                return "id_mbsword";
            } else if (nType == 2)
            {
                return "id_mbaxe";
            } else if (nType == 3)
            {
                return "id_mclub";
            } else if (nType == 4)
            {
                return "id_mdagger";
            } else if (nType == 5)
            {
                return "id_mdmace";
            } else if (nType == 6)
            {
                return "id_mdaxe";
            } else if (nType == 7)
            {
                return "id_mdwaxe";
            } else if (nType == 8)
            {
                return "id_mgaxe";
            } else if (nType == 9)
            {
                return "id_mgsword";
            } else if (nType == 10)
            {
                return "id_mhalberd";
            } else if (nType == 11)
            {
                return "id_mhmaxe";
            } else if (nType == 12)
            {
                return "id_mhflail";
            } else if (nType == 13)
            {
                return "id_mkama";
            } else if (nType == 14)
            {
                return "id_mkatana";
            } else if (nType == 15)
            {
                return "id_mkukri";
            } else if (nType == 16)
            {
                return "id_mlflail";
            } else if (nType == 17)
            {
                return "id_mlhammer";
            } else if (nType == 18)
            {
                return "id_mmace";
            } else if (nType == 19)
            {
                return "id_mlsword";
            } else if (nType == 20)
            {
                return "id_mqstaff";
            } else if (nType == 21)
            {
                return "id_mmstar";
            } else if (nType == 22)
            {
                return "id_mrapier";
            } else if (nType == 23)
            {
                return "id_mscimitar";
            } else if (nType == 24)
            {
                return "id_mscythe";
            } else if (nType == 25)
            {
                return "id_mspear";
            } else if (nType == 26)
            {
                return "id_mssword";
            } else if (nType == 27)
            {
                return "id_msickle";
            } else if (nType == 28)
            {
                return "id_m2bsword";
            } else if (nType == 29)
            {
                return "id_mwhammer";
            } else
            {
                return "id_mwhip";
            }
        } else if (nSubCategory == 2) // ranged
        {
            if (nType == 1)
            {
                return "id_mdart";
            } else if (nType == 2)
            {
                return "id_mhxbow";
            } else if (nType == 3)
            {
                return "id_mlxbow";
            } else if (nType == 4)
            {
                return "id_mlbow";
            } else if (nType == 5)
            {
                return "id_msbow";
            } else if (nType == 6)
            {
                return "id_mshuriken";
            } else if (nType == 7)
            {
                return "id_msling";
            } else
            {
                return "id_mtaxe";
            }
        } else // ammunition
        {
            if (nType == 1)
            {
                return "id_marrow";
            } else if (nType == 2)
            {
                return "id_mbolt";
            } else
            {
                return "id_mbullet";
            }
        }
    } else if (nCategory == 2) // armor
    {
        if (nSubCategory == 1)
        {
            if (nType == 1)
            {
                return "id_mcloth";
            } else if (nType == 2)
            {
                return "id_mpadded";
            } else if (nType == 3)
            {
                return "id_mleather";
            } else if (nType == 4)
            {
                int nRandom = d100();
                if (nRandom <= 50)
                {
                    return "id_mstudded";
                } else
                {
                    return "id_mhide";
                }
            } else if (nType == 5)
            {
                int nRandom = d100();
                if (nRandom <= 50)
                {
                    return "id_mcshirt";
                } else
                {
                    return "id_mscale";
                }
            } else if (nType == 6)
            {
                int nRandom = d100();
                if (nRandom <= 50)
                {
                    return "id_mbreast";
                } else
                {
                    return "id_mchain";
                }
            } else if (nType == 7)
            {
                int nRandom = d100();
                if (nRandom <= 50)
                {
                    return "id_mbanded";
                } else
                {
                    return "id_msmail";
                }
            } else if (nType == 8)
            {
                return "id_mhplate";
            } else
            {
                return "id_mfplate";
            }
        } else
        {
            if (nType == 1)
            {
                return "id_msmall";
            } else if (nType == 2)
            {
                return "id_mlarge";
            } else
            {
                return "id_mtower";
            }
        }
    } else // accessory
    {
        if (nSubCategory == 1)
        {
            return "id_mamulet";
        } else if (nSubCategory == 2)
        {
            return "id_mbelt";
        } else if (nSubCategory == 3)
        {
            return "id_mboots";
        } else if (nSubCategory == 4)
        {
            return "id_mbracer";
        } else if (nSubCategory == 5)
        {
            return "id_mcloak";
        } else if (nSubCategory == 6)
        {
            return "id_mgloves";
        } else if (nSubCategory == 7)
        {
            return "id_mhelm";
        } else
        {
            return "id_mring";
        }
    }
}

void SetRecipeName(object oItem)
{
    string sName = "Gem Recipe: ";

    itemproperty ipRecipe = GetFirstItemProperty(oItem);
    while (GetItemPropertyType(ipRecipe) == ITEM_PROPERTY_CAST_SPELL)
    {
        ipRecipe = GetNextItemProperty(oItem);
    }
    sName += GetItemPropertyString(ipRecipe);

    SetName(oItem, sName);
}

int GetScrollNum(int nLevel)
{
    if (nLevel == 0)
    {
        return 10;
    } else if (nLevel == 1)
    {
        return 38;
    } else if (nLevel == 2)
    {
        return 45;
    } else if (nLevel == 3)
    {
        return 47;
    } else if (nLevel == 4)
    {
        return 29;
    } else if (nLevel == 5)
    {
        return 28;
    } else if (nLevel == 6)
    {
        return 27;
    } else if (nLevel == 7)
    {
        return 22;
    } else if (nLevel == 8)
    {
        return 18;
    } else if (nLevel == 9)
    {
        return 19;
    } else
    {
        return 0;
    }
}

string GetScrollResRef(int nSpellLevel, int nSpellID)
{
    string sResRef = "";

    if (nSpellLevel == 0) // 10
    {
        if (nSpellID == 1)
        {
            sResRef = "x1_it_sparscr002";
        } else if (nSpellID == 2)
        {
            sResRef = "X2_IT_SPDVSCR001";
        } else if (nSpellID == 3)
        {
            sResRef = "NW_IT_SPARSCR003";
        } else if (nSpellID == 4)
        {
            sResRef = "X1_IT_SPARSCR003";
        } else if (nSpellID == 5)
        {
            sResRef = "X1_IT_SPARSCR001";
        } else if (nSpellID == 6)
        {
            sResRef = "X1_IT_SPDVSCR001";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR004";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR002";
        } else if (nSpellID == 9)
        {
            sResRef = "NW_IT_SPARSCR001";
        } else if (nSpellID == 10)
        {
            sResRef = "X2_IT_SPDVSCR002";
        }
    } else if (nSpellLevel == 1) // 38
    {
        if (nSpellID == 1)
        {
            sResRef = "x1_it_sparscr102";
        } else if (nSpellID == 2)
        {
            sResRef = "x1_it_spdvscr101";
        } else if (nSpellID == 3)
        {
            sResRef = "x2_it_spdvscr103";
        } else if (nSpellID == 4)
        {
            sResRef = "x2_it_spdvscr102";
        } else if (nSpellID == 5)
        {
            sResRef = "nw_it_sparscr112";
        } else if (nSpellID == 6)
        {
            sResRef = "X1_IT_SPDVSCR107";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR107";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR110";
        } else if (nSpellID == 9)
        {
            sResRef = "X2_IT_SPDVSCR104";
        } else if (nSpellID == 10)
        {
            sResRef = "X2_IT_SPDVSCR101";
        } else if (nSpellID == 11)
        {
            sResRef = "X1_IT_SPDVSCR102";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR105";
        } else if (nSpellID == 13)
        {
            sResRef = "X2_IT_SPDVSCR106";
        } else if (nSpellID == 14)
        {
            sResRef = "X1_IT_SPDVSCR103";
        } else if (nSpellID == 15)
        {
            sResRef = "X1_IT_SPARSCR101";
        } else if (nSpellID == 16)
        {
            sResRef = "NW_IT_SPARSCR103";
        } else if (nSpellID == 17)
        {
            sResRef = "X2_IT_SPARSCR101";
        } else if (nSpellID == 18)
        {
            sResRef = "X2_IT_SPARSCR104";
        } else if (nSpellID == 19)
        {
            sResRef = "NW_IT_SPARSCR106";
        } else if (nSpellID == 20)
        {
            sResRef = "X1_IT_SPDVSCR104";
        } else if (nSpellID == 21)
        {
            sResRef = "X2_IT_SPARSCR102";
        } else if (nSpellID == 22)
        {
            sResRef = "NW_IT_SPARSCR218";
        } else if (nSpellID == 23)
        {
            sResRef = "NW_IT_SPARSCR104";
        } else if (nSpellID == 24)
        {
            sResRef = "X1_IT_SPDVSCR106";
        } else if (nSpellID == 25)
        {
            sResRef = "NW_IT_SPARSCR109";
        } else if (nSpellID == 26)
        {
            sResRef = "X2_IT_SPARSCR105";
        } else if (nSpellID == 27)
        {
            sResRef = "nw_it_sparscr113";
        } else if (nSpellID == 28)
        {
            sResRef = "X2_IT_SPARSCRAL";
        } else if (nSpellID == 29)
        {
            sResRef = "NW_IT_SPARSCR111";
        } else if (nSpellID == 30)
        {
            sResRef = "X2_IT_SPDVSCR107";
        } else if (nSpellID == 31)
        {
            sResRef = "X2_IT_SPDVSCR108";
        } else if (nSpellID == 32)
        {
            sResRef = "NW_IT_SPARSCR210";
        } else if (nSpellID == 33)
        {
            sResRef = "X2_IT_SPARSCR103";
        } else if (nSpellID == 34)
        {
            sResRef = "X1_IT_SPARSCR103";
        } else if (nSpellID == 35)
        {
            sResRef = "X1_IT_SPDVSCR105";
        } else if (nSpellID == 36)
        {
            sResRef = "NW_IT_SPARSCR108";
        } else if (nSpellID == 37)
        {
            sResRef = "NW_IT_SPARSCR105";
        } else if (nSpellID == 38)
        {
            sResRef = "X1_IT_SPARSCR104";
        }
    } else if (nSpellLevel == 2) // 45
    {
        if (nSpellID == 1)
        {
            sResRef = "x2_it_spdvscr201";
        } else if (nSpellID == 2)
        {
            sResRef = "x1_it_spdvscr204";
        } else if (nSpellID == 3)
        {
            sResRef = "x1_it_sparscr201";
        } else if (nSpellID == 4)
        {
            sResRef = "x2_it_spdvscr202";
        } else if (nSpellID == 5)
        {
            sResRef = "x1_it_spdvscr202";
        } else if (nSpellID == 6)
        {
            sResRef = "nw_it_sparscr212";
        } else if (nSpellID == 7)
        {
            sResRef = "X2_IT_SPARSCR207";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPDVSCR202";
        } else if (nSpellID == 9)
        {
            sResRef = "NW_IT_SPARSCR217";
        } else if (nSpellID == 10)
        {
            sResRef = "X2_IT_SPARSCR206";
        } else if (nSpellID == 11)
        {
            sResRef = "X2_IT_SPARSCR201";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR203";
        } else if (nSpellID == 13)
        {
            sResRef = "NW_IT_SPARSCR206";
        } else if (nSpellID == 14)
        {
            sResRef = "X2_IT_SPARSCR202";
        } else if (nSpellID == 15)
        {
            sResRef = "nw_it_sparscr219";
        } else if (nSpellID == 16)
        {
            sResRef = "NW_IT_SPARSCR215";
        } else if (nSpellID == 17)
        {
            sResRef = "NW_IT_SPARSCR101";
        } else if (nSpellID == 18)
        {
            sResRef = "X2_IT_SPARSCR305";
        } else if (nSpellID == 19)
        {
            sResRef = "X1_IT_SPDVSCR205";
        } else if (nSpellID == 20)
        {
            sResRef = "X2_IT_SPARSCR205";
        } else if (nSpellID == 21)
        {
            sResRef = "nw_it_sparscr220";
        } else if (nSpellID == 22)
        {
            sResRef = "X2_IT_SPARSCR203";
        } else if (nSpellID == 23)
        {
            sResRef = "NW_IT_SPARSCR208";
        } else if (nSpellID == 24)
        {
            sResRef = "NW_IT_SPARSCR209";
        } else if (nSpellID == 25)
        {
            sResRef = "X2_IT_SPDVSCR204";
        } else if (nSpellID == 26)
        {
            sResRef = "NW_IT_SPARSCR308";
        } else if (nSpellID == 27)
        {
            sResRef = "X1_IT_SPDVSCR201";
        } else if (nSpellID == 28)
        {
            sResRef = "NW_IT_SPARSCR207";
        } else if (nSpellID == 29)
        {
            sResRef = "NW_IT_SPARSCR216";
        } else if (nSpellID == 30)
        {
            sResRef = "NW_IT_SPDVSCR201";
        } else if (nSpellID == 31)
        {
            sResRef = "NW_IT_SPARSCR202";
        } else if (nSpellID == 32)
        {
            sResRef = "X1_IT_SPDVSCR203";
        } else if (nSpellID == 33)
        {
            sResRef = "X1_IT_SPDVSCR502";
        } else if (nSpellID == 34)
        {
            sResRef = "nw_it_sparscr221";
        } else if (nSpellID == 35)
        {
            sResRef = "NW_IT_SPARSCR303";
        } else if (nSpellID == 36)
        {
            sResRef = "X2_IT_SPDVSCR205";
        } else if (nSpellID == 37)
        {
            sResRef = "NW_IT_SPARSCR201";
        } else if (nSpellID == 38)
        {
            sResRef = "NW_IT_SPARSCR205";
        } else if (nSpellID == 39)
        {
            sResRef = "NW_IT_SPDVSCR203";
        } else if (nSpellID == 40)
        {
            sResRef = "NW_IT_SPDVSCR204";
        } else if (nSpellID == 41)
        {
            sResRef = "X2_IT_SPARSCR204";
        } else if (nSpellID == 42)
        {
            sResRef = "NW_IT_SPARSCR203";
        } else if (nSpellID == 43)
        {
            sResRef = "X1_IT_SPARSCR202";
        } else if (nSpellID == 44)
        {
            sResRef = "NW_IT_SPARSCR214";
        } else if (nSpellID == 45)
        {
            sResRef = "NW_IT_SPARSCR204";
        }
    } else if (nSpellLevel == 3) // 47
    {
        if (nSpellID == 1)
        {
            sResRef = "x2_it_spdvscr303";
        } else if (nSpellID == 2)
        {
            sResRef = "nw_it_sparscr211";
        } else if (nSpellID == 3)
        {
            sResRef = "X2_IT_SPDVSCR307";
        } else if (nSpellID == 4)
        {
            sResRef = "NW_IT_SPARSCR405";
        } else if (nSpellID == 5)
        {
            sResRef = "NW_IT_SPARSCR307";
        } else if (nSpellID == 6)
        {
            sResRef = "NW_IT_SPARSCR406";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR411";
        } else if (nSpellID == 8)
        {
            sResRef = "X1_IT_SPDVSCR301";
        } else if (nSpellID == 9)
        {
            sResRef = "X2_IT_SPDVSCR305";
        } else if (nSpellID == 10)
        {
            sResRef = "NW_IT_SPARSCR301";
        } else if (nSpellID == 11)
        {
            sResRef = "X1_IT_SPARSCR301";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR309";
        } else if (nSpellID == 13)
        {
            sResRef = "NW_IT_SPARSCR413";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR309";
        } else if (nSpellID == 15)
        {
            sResRef = "NW_IT_SPARSCR304";
        } else if (nSpellID == 16)
        {
            sResRef = "X2_IT_SPDVSCR306";
        } else if (nSpellID == 17)
        {
            sResRef = "X1_IT_SPDVSCR303";
        } else if (nSpellID == 18)
        {
            sResRef = "X2_IT_SPARSCR304";
        } else if (nSpellID == 19)
        {
            sResRef = "X1_IT_SPARSCR303";
        } else if (nSpellID == 20)
        {
            sResRef = "NW_IT_SPARSCR312";
        } else if (nSpellID == 21)
        {
            sResRef = "X2_IT_SPDVSCR302";
        } else if (nSpellID == 22)
        {
            sResRef = "X2_IT_SPDVSCR301";
        } else if (nSpellID == 23)
        {
            sResRef = "X1_IT_SPDVSCR302";
        } else if (nSpellID == 24)
        {
            sResRef = "X2_IT_SPDVSCR310";
        } else if (nSpellID == 25)
        {
            sResRef = "NW_IT_SPARSCR314";
        } else if (nSpellID == 26)
        {
            sResRef = "X2_IT_SPARSCR303";
        } else if (nSpellID == 27)
        {
            sResRef = "NW_IT_SPARSCR310";
        } else if (nSpellID == 28)
        {
            sResRef = "X2_IT_SPARSCRMC";
        } else if (nSpellID == 29)
        {
            sResRef = "X2_IT_SPDVSCR304";
        } else if (nSpellID == 30)
        {
            sResRef = "X2_IT_SPARSCR301";
        } else if (nSpellID == 31)
        {
            sResRef = "nw_it_sparscr315";
        } else if (nSpellID == 32)
        {
            sResRef = "X2_IT_SPDVSCR311";
        } else if (nSpellID == 33)
        {
            sResRef = "NW_IT_SPDVSCR402";
        } else if (nSpellID == 34)
        {
            sResRef = "X2_IT_SPDVSCR407";
        } else if (nSpellID == 35)
        {
            sResRef = "X2_IT_SPDVSCR312";
        } else if (nSpellID == 36)
        {
            sResRef = "X1_IT_SPDVSCR305";
        } else if (nSpellID == 37)
        {
            sResRef = "NW_IT_SPDVSCR301";
        } else if (nSpellID == 38)
        {
            sResRef = "NW_IT_SPARSCR402";
        } else if (nSpellID == 39)
        {
            sResRef = "NW_IT_SPDVSCR302";
        } else if (nSpellID == 40)
        {
            sResRef = "X2_IT_SPARSCR302";
        } else if (nSpellID == 41)
        {
            sResRef = "X2_IT_SPDVSCR313";
        } else if (nSpellID == 42)
        {
            sResRef = "NW_IT_SPARSCR313";
        } else if (nSpellID == 43)
        {
            sResRef = "X1_IT_SPDVSCR304";
        } else if (nSpellID == 44)
        {
            sResRef = "NW_IT_SPARSCR305";
        } else if (nSpellID == 45)
        {
            sResRef = "NW_IT_SPARSCR306";
        } else if (nSpellID == 46)
        {
            sResRef = "NW_IT_SPARSCR311";
        } else if (nSpellID == 47)
        {
            sResRef = "X1_IT_SPARSCR302";
        }
    } else if (nSpellLevel == 4) // 29
    {
        if (nSpellID == 1)
        {
            sResRef = "nw_it_sparscr414";
        } else if (nSpellID == 2)
        {
            sResRef = "X2_IT_SPDVSCR402";
        } else if (nSpellID == 3)
        {
            sResRef = "X2_IT_SPDVSCR308";
        } else if (nSpellID == 4)
        {
            sResRef = "X2_IT_SPDVSCR403";
        } else if (nSpellID == 5)
        {
            sResRef = "NW_IT_SPARSCR501";
        } else if (nSpellID == 6)
        {
            sResRef = "X2_IT_SPDVSCR404";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR503";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR416";
        } else if (nSpellID == 9)
        {
            sResRef = "NW_IT_SPARSCR412";
        } else if (nSpellID == 10)
        {
            sResRef = "NW_IT_SPARSCR418";
        } else if (nSpellID == 11)
        {
            sResRef = "X1_IT_SPDVSCR403";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR405";
        } else if (nSpellID == 13)
        {
            sResRef = "X2_IT_SPDVSCR406";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR505";
        } else if (nSpellID == 15)
        {
            sResRef = "X2_IT_SPDVSCR401";
        } else if (nSpellID == 16)
        {
            sResRef = "X2_IT_SPARSCR401";
        } else if (nSpellID == 17)
        {
            sResRef = "NW_IT_SPARSCR408";
        } else if (nSpellID == 18)
        {
            sResRef = "X1_IT_SPDVSCR401";
        } else if (nSpellID == 19)
        {
            sResRef = "X1_IT_SPARSCR401";
        } else if (nSpellID == 20)
        {
            sResRef = "NW_IT_SPARSCR417";
        } else if (nSpellID == 21)
        {
            sResRef = "X1_IT_SPDVSCR402";
        } else if (nSpellID == 22)
        {
            sResRef = "NW_IT_SPARSCR401";
        } else if (nSpellID == 23)
        {
            sResRef = "NW_IT_SPARSCR409";
        } else if (nSpellID == 24)
        {
            sResRef = "NW_IT_SPARSCR415";
        } else if (nSpellID == 25)
        {
            sResRef = "NW_IT_SPDVSCR401";
        } else if (nSpellID == 26)
        {
            sResRef = "NW_IT_SPARSCR410";
        } else if (nSpellID == 27)
        {
            sResRef = "NW_IT_SPARSCR403";
        } else if (nSpellID == 28)
        {
            sResRef = "NW_IT_SPARSCR404";
        } else if (nSpellID == 29)
        {
            sResRef = "NW_IT_SPARSCR407";
        }
    } else if (nSpellLevel == 5) // 28
    {
        if (nSpellID == 1)
        {
            sResRef = "nw_it_sparscr509";
        } else if (nSpellID == 2)
        {
            sResRef = "x2_it_spdvscr508";
        } else if (nSpellID == 3)
        {
            sResRef = "x2_it_sparscr501";
        } else if (nSpellID == 4)
        {
            sResRef = "x2_it_spdvscr501";
        } else if (nSpellID == 5)
        {
            sResRef = "x1_it_sparscr502";
        } else if (nSpellID == 6)
        {
            sResRef = "X2_IT_SPDVSCR504";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR502";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR507";
        } else if (nSpellID == 9)
        {
            sResRef = "X2_IT_SPARSCR503";
        } else if (nSpellID == 10)
        {
            sResRef = "NW_IT_SPARSCR608";
        } else if (nSpellID == 11)
        {
            sResRef = "X2_IT_SPDVSCR509";
        } else if (nSpellID == 12)
        {
            sResRef = "NW_IT_SPARSCR504";
        } else if (nSpellID == 13)
        {
            sResRef = "X1_IT_SPARSCR501";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR508";
        } else if (nSpellID == 15)
        {
            sResRef = "X2_IT_SPDVSCR505";
        } else if (nSpellID == 16)
        {
            sResRef = "X1_IT_SPDVSCR501";
        } else if (nSpellID == 17)
        {
            sResRef = "NW_IT_SPARSCR511";
        } else if (nSpellID == 18)
        {
            sResRef = "NW_IT_SPARSCR512";
        } else if (nSpellID == 19)
        {
            sResRef = "NW_IT_SPARSCR513";
        } else if (nSpellID == 20)
        {
            sResRef = "X2_IT_SPARSCR502";
        } else if (nSpellID == 21)
        {
            sResRef = "NW_IT_SPARSCR506";
        } else if (nSpellID == 22)
        {
            sResRef = "X2_IT_SPDVSCR502";
        } else if (nSpellID == 23)
        {
            sResRef = "NW_IT_SPDVSCR501";
        } else if (nSpellID == 24)
        {
            sResRef = "X2_IT_SPDVSCR506";
        } else if (nSpellID == 25)
        {
            sResRef = "X2_IT_SPDVSCR507";
        } else if (nSpellID == 26)
        {
            sResRef = "NW_IT_SPARSCR510";
        } else if (nSpellID == 27)
        {
            sResRef = "NW_IT_SPARSCR606";
        } else if (nSpellID == 28)
        {
            sResRef = "X2_IT_SPDVSCR503";
        }
    } else if (nSpellLevel == 6) // 27
    {
        if (nSpellID == 1)
        {
            sResRef = "nw_it_sparscr603";
        } else if (nSpellID == 2)
        {
            sResRef = "x1_it_sparscr602";
        } else if (nSpellID == 3)
        {
            sResRef = "x2_it_spdvscr603";
        } else if (nSpellID == 4)
        {
            sResRef = "NW_IT_SPARSCR607";
        } else if (nSpellID == 5)
        {
            sResRef = "NW_IT_SPARSCR610";
        } else if (nSpellID == 6)
        {
            sResRef = "X1_IT_SPDVSCR605";
        } else if (nSpellID == 7)
        {
            sResRef = "X2_IT_SPDVSCR601";
        } else if (nSpellID == 8)
        {
            sResRef = "X1_IT_SPARSCR601";
        } else if (nSpellID == 9)
        {
            sResRef = "X1_IT_SPDVSCR604";
        } else if (nSpellID == 10)
        {
            sResRef = "X1_IT_SPARSCR605";
        } else if (nSpellID == 11)
        {
            sResRef = "NW_IT_SPARSCR601";
        } else if (nSpellID == 12)
        {
            sResRef = "NW_IT_SPARSCR602";
        } else if (nSpellID == 13)
        {
            sResRef = "NW_IT_SPARSCR612";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR613";
        } else if (nSpellID == 15)
        {
            sResRef = "X2_IT_SPDVSCR604";
        } else if (nSpellID == 16)
        {
            sResRef = "X2_IT_SPDVSCR605";
        } else if (nSpellID == 17)
        {
            sResRef = "X1_IT_SPARSCR603";
        } else if (nSpellID == 18)
        {
            sResRef = "X2_IT_SPARSCR602";
        } else if (nSpellID == 19)
        {
            sResRef = "NW_IT_SPARSCR611";
        } else if (nSpellID == 20)
        {
            sResRef = "X1_IT_SPDVSCR603";
        } else if (nSpellID == 21)
        {
            sResRef = "NW_IT_SPARSCR604";
        } else if (nSpellID == 22)
        {
            sResRef = "NW_IT_SPARSCR609";
        } else if (nSpellID == 23)
        {
            sResRef = "X1_IT_SPARSCR604";
        } else if (nSpellID == 24)
        {
            sResRef = "X2_IT_SPDVSCR602";
        } else if (nSpellID == 25)
        {
            sResRef = "NW_IT_SPARSCR605";
        } else if (nSpellID == 26)
        {
            sResRef = "nw_it_sparscr614";
        } else if (nSpellID == 27)
        {
            sResRef = "X2_IT_SPARSCR601";
        }
    } else if (nSpellLevel == 7) // 22
    {
        if (nSpellID == 1)
        {
            sResRef = "x1_it_spdvscr701";
        } else if (nSpellID == 2)
        {
            sResRef = "x1_it_spdvscr601";
        } else if (nSpellID == 3)
        {
            sResRef = "x1_it_sparscr701";
        } else if (nSpellID == 4)
        {
            sResRef = "NW_IT_SPARSCR707";
        } else if (nSpellID == 5)
        {
            sResRef = "X1_IT_SPDVSCR702";
        } else if (nSpellID == 6)
        {
            sResRef = "NW_IT_SPARSCR704";
        } else if (nSpellID == 7)
        {
            sResRef = "X1_IT_SPDVSCR703";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR708";
        } else if (nSpellID == 9)
        {
            sResRef = "X1_IT_SPDVSCR704";
        } else if (nSpellID == 10)
        {
            sResRef = "X2_IT_SPARSCR701";
        } else if (nSpellID == 11)
        {
            sResRef = "NW_IT_SPDVSCR701";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR606";
        } else if (nSpellID == 13)
        {
            sResRef = "NW_IT_SPARSCR705";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR702";
        } else if (nSpellID == 15)
        {
            sResRef = "NW_IT_SPARSCR706";
        } else if (nSpellID == 16)
        {
            sResRef = "NW_IT_SPARSCR802";
        } else if (nSpellID == 17)
        {
            sResRef = "X2_IT_SPDVSCR702";
        } else if (nSpellID == 18)
        {
            sResRef = "NW_IT_SPDVSCR702";
        } else if (nSpellID == 19)
        {
            sResRef = "X2_IT_SPARSCR703";
        } else if (nSpellID == 20)
        {
            sResRef = "NW_IT_SPARSCR701";
        } else if (nSpellID == 21)
        {
            sResRef = "NW_IT_SPARSCR703";
        } else if (nSpellID == 22)
        {
            sResRef = "X2_IT_SPDVSCR701";
        }
    } else if (nSpellLevel == 8) // 18
    {
        if (nSpellID == 1)
        {
            sResRef = "x2_it_spdvscr804";
        } else if (nSpellID == 2)
        {
            sResRef = "x1_it_sparscr801";
        } else if (nSpellID == 3)
        {
            sResRef = "x2_it_sparscr801";
        } else if (nSpellID == 4)
        {
            sResRef = "x1_it_spdvscr803";
        } else if (nSpellID == 5)
        {
            sResRef = "X1_IT_SPDVSCR804";
        } else if (nSpellID == 6)
        {
            sResRef = "X1_IT_SPDVSCR801";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR803";
        } else if (nSpellID == 8)
        {
            sResRef = "NW_IT_SPARSCR809";
        } else if (nSpellID == 9)
        {
            sResRef = "NW_IT_SPARSCR804";
        } else if (nSpellID == 10)
        {
            sResRef = "NW_IT_SPARSCR807";
        } else if (nSpellID == 11)
        {
            sResRef = "NW_IT_SPARSCR806";
        } else if (nSpellID == 12)
        {
            sResRef = "X2_IT_SPDVSCR801";
        } else if (nSpellID == 13)
        {
            sResRef = "NW_IT_SPARSCR801";
        } else if (nSpellID == 14)
        {
            sResRef = "X2_IT_SPDVSCR802";
        } else if (nSpellID == 15)
        {
            sResRef = "NW_IT_SPARSCR808";
        } else if (nSpellID == 16)
        {
            sResRef = "NW_IT_SPARSCR805";
        } else if (nSpellID == 17)
        {
            sResRef = "X2_IT_SPDVSCR803";
        } else if (nSpellID == 18)
        {
            sResRef = "X1_IT_SPDVSCR802";
        }
    } else if (nSpellLevel == 9) // 19
    {
        if (nSpellID == 1)
        {
            sResRef = "x1_it_sparscr901";
        } else if (nSpellID == 2)
        {
            sResRef = "x2_it_sparscr901";
        } else if (nSpellID == 3)
        {
            sResRef = "NW_IT_SPARSCR905";
        } else if (nSpellID == 4)
        {
            sResRef = "X2_IT_SPDVSCR901";
        } else if (nSpellID == 5)
        {
            sResRef = "NW_IT_SPARSCR908";
        } else if (nSpellID == 6)
        {
            sResRef = "NW_IT_SPARSCR902";
        } else if (nSpellID == 7)
        {
            sResRef = "NW_IT_SPARSCR912";
        } else if (nSpellID == 8)
        {
            sResRef = "X2_IT_SPDVSCR902";
        } else if (nSpellID == 9)
        {
            sResRef = "NW_IT_SPARSCR906";
        } else if (nSpellID == 10)
        {
            sResRef = "NW_IT_SPARSCR901";
        } else if (nSpellID == 11)
        {
            sResRef = "NW_IT_SPARSCR903";
        } else if (nSpellID == 12)
        {
            sResRef = "NW_IT_SPARSCR910";
        } else if (nSpellID == 13)
        {
            sResRef = "X2_IT_SPDVSCR903";
        } else if (nSpellID == 14)
        {
            sResRef = "NW_IT_SPARSCR904";
        } else if (nSpellID == 15)
        {
            sResRef = "X2_IT_SPARSCR902";
        } else if (nSpellID == 16)
        {
            sResRef = "NW_IT_SPARSCR911";
        } else if (nSpellID == 17)
        {
            sResRef = "X1_IT_SPDVSCR901";
        } else if (nSpellID == 18)
        {
            sResRef = "NW_IT_SPARSCR909";
        } else if (nSpellID == 19)
        {
            sResRef = "NW_IT_SPARSCR907";
        }
    }

    return sResRef;
}

int GetPotionNum(int nLevel)
{
    if (nLevel <= 1)
    {
        return 18;
    } else if (nLevel == 2)
    {
        return 38;
    } else if (nLevel == 3)
    {
        return 33;
    } else if (nLevel == 4)
    {
        return 24;
    } else if (nLevel == 5)
    {
        return 20;
    } else if (nLevel == 6)
    {
        return 17;
    } else if (nLevel == 7)
    {
        return 14;
    } else if (nLevel == 8)
    {
        return 12;
    } else if (nLevel == 9)
    {
        return 13;
    } else
    {
        return 0;
    }
}

string GetPotionResRef(int nLevel, int nNum)
{
    string sResRef = "";

    if (nLevel <= 1) // 18
    {
        if (nNum == 1)
        {
            sResRef = "id_potion002";
        } else if (nNum == 2)
        {
            sResRef = "id_potion005";
        } else if (nNum == 3)
        {
            sResRef = "id_potion008";
        } else if (nNum == 4)
        {
            sResRef = "id_potion011";
        } else if (nNum == 5)
        {
            sResRef = "id_potion012";
        } else if (nNum == 6)
        {
            sResRef = "id_potion024";
        } else if (nNum == 7)
        {
            sResRef = "id_potion029";
        } else if (nNum == 8)
        {
            sResRef = "id_potion030";
        } else if (nNum == 9)
        {
            sResRef = "id_potion34";
        } else if (nNum == 10)
        {
            sResRef = "id_potion037";
        } else if (nNum == 11)
        {
            sResRef = "id_potion040";
        } else if (nNum == 12)
        {
            sResRef = "id_potion053";
        } else if (nNum == 13)
        {
            sResRef = "id_potion054";
        } else if (nNum == 14)
        {
            sResRef = "NW_IT_MPOTION009";
        } else if (nNum == 15)
        {
            sResRef = "NW_IT_MPOTION001";
        } else if (nNum == 16)
        {
            sResRef = "X2_IT_MPOTION001";
        } else if (nNum == 17)
        {
            sResRef = "NW_IT_MPOTION019";
        } else if (nNum == 18)
        {
            sResRef = "id_potion056";
        }
    } else if (nLevel == 2) // 38
    {
        if (nNum == 1)
        {
            sResRef = "id_potion002";
        } else if (nNum == 2)
        {
            sResRef = "id_potion005";
        } else if (nNum == 3)
        {
            sResRef = "id_potion009";
        } else if (nNum == 4)
        {
            sResRef = "id_potion011";
        } else if (nNum == 5)
        {
            sResRef = "id_potion012";
        } else if (nNum == 6)
        {
            sResRef = "id_potion013";
        } else if (nNum == 7)
        {
            sResRef = "id_potion024";
        } else if (nNum == 8)
        {
            sResRef = "id_potion029";
        } else if (nNum == 9)
        {
            sResRef = "id_potion030";
        } else if (nNum == 10)
        {
            sResRef = "id_potion032";
        } else if (nNum == 11)
        {
            sResRef = "id_potion034";
        } else if (nNum == 12)
        {
            sResRef = "id_potion037";
        } else if (nNum == 13)
        {
            sResRef = "id_potion038";
        } else if (nNum == 14)
        {
            sResRef = "id_potion039";
        } else if (nNum == 15)
        {
            sResRef = "id_potion040";
        } else if (nNum == 16)
        {
            sResRef = "id_potion043";
        } else if (nNum == 17)
        {
            sResRef = "id_potion053";
        } else if (nNum == 18)
        {
            sResRef = "id_potion054";
        } else if (nNum == 19)
        {
            sResRef = "id_potion055";
        } else if (nNum == 20)
        {
            sResRef = "NW_IT_MPOTION016";
        } else if (nNum == 21)
        {
            sResRef = "NW_IT_MPOTION006";
        } else if (nNum == 22)
        {
            sResRef = "NW_IT_MPOTION005";
        } else if (nNum == 23)
        {
            sResRef = "NW_IT_MPOTION009";
        } else if (nNum == 24)
        {
            sResRef = "NW_IT_MPOTION015";
        } else if (nNum == 25)
        {
            sResRef = "NW_IT_MPOTION014";
        } else if (nNum == 26)
        {
            sResRef = "NW_IT_MPOTION010";
        } else if (nNum == 27)
        {
            sResRef = "NW_IT_MPOTION013";
        } else if (nNum == 28)
        {
            sResRef = "NW_IT_MPOTION017";
        } else if (nNum == 29)
        {
            sResRef = "NW_IT_MPOTION018";
        } else if (nNum == 30)
        {
            sResRef = "NW_IT_MPOTION007";
        } else if (nNum == 31)
        {
            sResRef = "NW_IT_MPOTION020";
        } else if (nNum == 32)
        {
            sResRef = "X2_IT_MPOTION002";
        } else if (nNum == 33)
        {
            sResRef = "NW_IT_MPOTION008";
        } else if (nNum == 34)
        {
            sResRef = "X2_IT_MPOTION001";
        } else if (nNum == 35)
        {
            sResRef = "NW_IT_MPOTION011";
        } else if (nNum == 36)
        {
            sResRef = "NW_IT_MPOTION019";
        } else if (nNum == 37)
        {
            sResRef = "id_potion056";
        } else if (nNum == 38)
        {
            sResRef = "id_potion057";
        }
    } else if (nLevel == 3) // 33
    {
        if (nNum == 1)
        {
            sResRef = "id_potion001";
        } else if (nNum == 2)
        {
            sResRef = "id_potion003";
        } else if (nNum == 3)
        {
            sResRef = "id_potion006";
        } else if (nNum == 4)
        {
            sResRef = "id_potion010";
        } else if (nNum == 5)
        {
            sResRef = "id_potion013";
        } else if (nNum == 6)
        {
            sResRef = "id_potion029";
        } else if (nNum == 7)
        {
            sResRef = "id_potion030";
        } else if (nNum == 8)
        {
            sResRef = "id_potion032";
        } else if (nNum == 9)
        {
            sResRef = "id_potion037";
        } else if (nNum == 10)
        {
            sResRef = "id_potion038";
        } else if (nNum == 11)
        {
            sResRef = "id_potion039";
        } else if (nNum == 12)
        {
            sResRef = "id_potion040";
        } else if (nNum == 13)
        {
            sResRef = "id_potion043";
        } else if (nNum == 14)
        {
            sResRef = "id_potion050";
        } else if (nNum == 15)
        {
            sResRef = "id_potion055";
        } else if (nNum == 16)
        {
            sResRef = "NW_IT_MPOTION016";
        } else if (nNum == 17)
        {
            sResRef = "NW_IT_MPOTION006";
        } else if (nNum == 18)
        {
            sResRef = "NW_IT_MPOTION005";
        } else if (nNum == 19)
        {
            sResRef = "NW_IT_MPOTION015";
        } else if (nNum == 20)
        {
            sResRef = "NW_IT_MPOTION014";
        } else if (nNum == 21)
        {
            sResRef = "NW_IT_MPOTION010";
        } else if (nNum == 22)
        {
            sResRef = "NW_IT_MPOTION013";
        } else if (nNum == 23)
        {
            sResRef = "NW_IT_MPOTION017";
        } else if (nNum == 24)
        {
            sResRef = "NW_IT_MPOTION018";
        } else if (nNum == 25)
        {
            sResRef = "NW_IT_MPOTION007";
        } else if (nNum == 26)
        {
            sResRef = "NW_IT_MPOTION002";
        } else if (nNum == 27)
        {
            sResRef = "X2_IT_MPOTION002";
        } else if (nNum == 28)
        {
            sResRef = "NW_IT_MPOTION008";
        } else if (nNum == 29)
        {
            sResRef = "NW_IT_MPOTION011";
        } else if (nNum == 30)
        {
            sResRef = "NW_IT_MPOTION004";
        } else if (nNum == 31)
        {
            sResRef = "id_potion045";
        } else if (nNum == 32)
        {
            sResRef = "id_potion052";
        } else if (nNum == 33)
        {
            sResRef = "id_potion057";
        }
    } else if (nLevel == 4) // 24
    {
        if (nNum == 1)
        {
            sResRef = "id_potion003";
        } else if (nNum == 2)
        {
            sResRef = "id_potion006";
        } else if (nNum == 3)
        {
            sResRef = "id_potion007";
        } else if (nNum == 4)
        {
            sResRef = "id_potion010";
        } else if (nNum == 5)
        {
            sResRef = "id_potion013";
        } else if (nNum == 6)
        {
            sResRef = "id_potion015";
        } else if (nNum == 7)
        {
            sResRef = "id_potion021";
        } else if (nNum == 8)
        {
            sResRef = "id_potion026";
        } else if (nNum == 9)
        {
            sResRef = "id_potion032";
        } else if (nNum == 10)
        {
            sResRef = "id_potion042";
        } else if (nNum == 11)
        {
            sResRef = "id_potion043";
        } else if (nNum == 12)
        {
            sResRef = "id_potion047";
        } else if (nNum == 13)
        {
            sResRef = "id_potion050";
        } else if (nNum == 14)
        {
            sResRef = "id_potion055";
        } else if (nNum == 15)
        {
            sResRef = "NW_IT_MPOTION006";
        } else if (nNum == 16)
        {
            sResRef = "NW_IT_MPOTION007";
        } else if (nNum == 17)
        {
            sResRef = "NW_IT_MPOTION003";
        } else if (nNum == 18)
        {
            sResRef = "X2_IT_MPOTION002";
        } else if (nNum == 19)
        {
            sResRef = "NW_IT_MPOTION008";
        } else if (nNum == 20)
        {
            sResRef = "NW_IT_MPOTION004";
        } else if (nNum == 21)
        {
            sResRef = "id_potion048";
        } else if (nNum == 22)
        {
            sResRef = "id_potion031";
        } else if (nNum == 23)
        {
            sResRef = "id_potion045";
        } else if (nNum == 24)
        {
            sResRef = "id_potion052";
        }
    } else if (nLevel == 5) // 20
    {
        if (nNum == 1)
        {
            sResRef = "id_potion003";
        } else if (nNum == 2)
        {
            sResRef = "id_potion006";
        } else if (nNum == 3)
        {
            sResRef = "id_potion007";
        } else if (nNum == 4)
        {
            sResRef = "id_potion014";
        } else if (nNum == 5)
        {
            sResRef = "id_potion015";
        } else if (nNum == 6)
        {
            sResRef = "id_potion018";
        } else if (nNum == 7)
        {
            sResRef = "id_potion021";
        } else if (nNum == 8)
        {
            sResRef = "id_potion023";
        } else if (nNum == 9)
        {
            sResRef = "id_potion026";
        } else if (nNum == 10)
        {
            sResRef = "id_potion041";
        } else if (nNum == 11)
        {
            sResRef = "id_potion042";
        } else if (nNum == 12)
        {
            sResRef = "id_potion044";
        } else if (nNum == 13)
        {
            sResRef = "id_potion046";
        } else if (nNum == 14)
        {
            sResRef = "id_potion047";
        } else if (nNum == 15)
        {
            sResRef = "id_potion050";
        } else if (nNum == 16)
        {
            sResRef = "NW_IT_MPOTION003";
        } else if (nNum == 17)
        {
            sResRef = "NW_IT_MPOTION008";
        } else if (nNum == 18)
        {
            sResRef = "NW_IT_MPOTION004";
        } else if (nNum == 19)
        {
            sResRef = "id_potion048";
        } else if (nNum == 20)
        {
            sResRef = "id_potion031";
        }
    } else if (nLevel == 6) // 17
    {
        if (nNum == 1)
        {
            sResRef = "id_potion004";
        } else if (nNum == 2)
        {
            sResRef = "id_potion007";
        } else if (nNum == 3)
        {
            sResRef = "id_potion014";
        } else if (nNum == 4)
        {
            sResRef = "id_potion016";
        } else if (nNum == 5)
        {
            sResRef = "id_potion018";
        } else if (nNum == 6)
        {
            sResRef = "id_potion022";
        } else if (nNum == 7)
        {
            sResRef = "id_potion023";
        } else if (nNum == 8)
        {
            sResRef = "id_potion026";
        } else if (nNum == 9)
        {
            sResRef = "id_potion035";
        } else if (nNum == 10)
        {
            sResRef = "id_potion036";
        } else if (nNum == 11)
        {
            sResRef = "id_potion041";
        } else if (nNum == 12)
        {
            sResRef = "id_potion042";
        } else if (nNum == 13)
        {
            sResRef = "id_potion044";
        } else if (nNum == 14)
        {
            sResRef = "id_potion046";
        } else if (nNum == 15)
        {
            sResRef = "id_potion047";
        } else if (nNum == 16)
        {
            sResRef = "NW_IT_MPOTION012";
        } else if (nNum == 17)
        {
            sResRef = "id_potion048";
        }
    } else if (nLevel == 7) //14
    {
        if (nNum == 1)
        {
            sResRef = "id_potion004";
        } else if (nNum == 2)
        {
            sResRef = "id_potion058";
        } else if (nNum == 3)
        {
            sResRef = "id_potion016";
        } else if (nNum == 4)
        {
            sResRef = "id_potion019";
        } else if (nNum == 5)
        {
            sResRef = "id_potion022";
        } else if (nNum == 6)
        {
            sResRef = "id_potion023";
        } else if (nNum == 7)
        {
            sResRef = "id_potion033";
        } else if (nNum == 8)
        {
            sResRef = "id_potion035";
        } else if (nNum == 9)
        {
            sResRef = "id_potion036";
        } else if (nNum == 10)
        {
            sResRef = "id_potion041";
        } else if (nNum == 11)
        {
            sResRef = "id_potion042";
        } else if (nNum == 12)
        {
            sResRef = "id_potion044";
        } else if (nNum == 13)
        {
            sResRef = "id_potion049";
        } else if (nNum == 14)
        {
            sResRef = "NW_IT_MPOTION012";
        }
    } else if (nLevel == 8) // 12
    {
        if (nNum == 1)
        {
            sResRef = "id_potion004";
        } else if (nNum == 2)
        {
            sResRef = "id_potion017";
        } else if (nNum == 3)
        {
            sResRef = "id_potion058";
        } else if (nNum == 4)
        {
            sResRef = "id_potion019";
        } else if (nNum == 5)
        {
            sResRef = "id_potion022";
        } else if (nNum == 6)
        {
            sResRef = "id_potion023";
        } else if (nNum == 7)
        {
            sResRef = "id_potion028";
        } else if (nNum == 8)
        {
            sResRef = "id_potion033";
        } else if (nNum == 9)
        {
            sResRef = "id_potion035";
        } else if (nNum == 10)
        {
            sResRef = "id_potion036";
        } else if (nNum == 11)
        {
            sResRef = "id_potion049";
        } else if (nNum == 12)
        {
            sResRef = "NW_IT_MPOTION012";
        }
    } else if (nLevel == 9) // 13
    {
        if (nNum == 1)
        {
            sResRef = "id_potion025";
        } else if (nNum == 2)
        {
            sResRef = "id_potion017";
        } else if (nNum == 3)
        {
            sResRef = "id_potion058";
        } else if (nNum == 4)
        {
            sResRef = "id_potion020";
        } else if (nNum == 5)
        {
            sResRef = "id_potion022";
        } else if (nNum == 6)
        {
            sResRef = "id_potion023";
        } else if (nNum == 7)
        {
            sResRef = "id_potion027";
        } else if (nNum == 8)
        {
            sResRef = "id_potion028";
        } else if (nNum == 9)
        {
            sResRef = "id_potion033";
        } else if (nNum == 10)
        {
            sResRef = "id_potion035";
        } else if (nNum == 11)
        {
            sResRef = "id_potion036";
        } else if (nNum == 12)
        {
            sResRef = "id_potion049";
        } else if (nNum == 13)
        {
            sResRef = "NW_IT_MPOTION012";
        }
    }

    return sResRef;
}

int GetGrenadeNum(int nLevel)
{
    if (nLevel <= 10)
    {
        return 7;
    } else
    {
        return 2;
    }
}

string GetGrenadeResRef(int nLevel, int nNum)
{
    string sResRef = "";

    if (nLevel <= 10)
    {
        if (nNum == 1)
        {
            sResRef = "X1_WMGRENADE001";
        } else if (nNum == 2)
        {
            sResRef = "X1_WMGRENADE002";
        } else if (nNum == 3)
        {
            sResRef = "X1_WMGRENADE003";
        } else if (nNum == 4)
        {
            sResRef = "X1_WMGRENADE004";
        } else if (nNum == 5)
        {
            sResRef = "X1_WMGRENADE005";
        } else if (nNum == 6)
        {
            sResRef = "X1_WMGRENADE006";
        } else
        {
            sResRef = "X1_WMGRENADE007";
        }
    } else
    {
        if (nNum == 1)
        {
            sResRef = "x2_it_acidbomb";
        } else
        {
            sResRef = "x2_it_firebomb";
        }
    }

    return sResRef;
}

int GetWandNum(int nLevel)
{
    if (nLevel == 0)
    {
        return 5;
    } else if (nLevel == 1)
    {
        return 18;
    } else if (nLevel == 2)
    {
        return 24;
    } else if (nLevel == 3)
    {
        return 25;
    } else if (nLevel == 4)
    {
        return 23;
    } else if (nLevel == 5)
    {
        return 11;
    } else if (nLevel == 6)
    {
        return 13;
    } else if (nLevel == 7)
    {
        return 16;
    } else if (nLevel == 8)
    {
        return 19;
    } else if (nLevel == 9)
    {
        return 20;
    } else
    {
        return 0;
    }
}

string GetWandResRef(int nLevel, int nNum)
{
    string sResRef = "";

    if (nLevel <= 0) // 18
    {
        if (nNum == 1)
        {
            sResRef = "id_wand001";
        } else if (nNum == 2)
        {
            sResRef = "id_wand033";
        } else if (nNum == 3)
        {
            sResRef = "id_wand044";
        } else if (nNum == 4)
        {
            sResRef = "id_wand060";
        } else if (nNum == 5)
        {
            sResRef = "id_wand099";
        }
    } else if (nLevel == 1) // 38
    {
        if (nNum == 1)
        {
            sResRef = "id_wand007";
        } else if (nNum == 2)
        {
            sResRef = "id_wand017";
        } else if (nNum == 3)
        {
            sResRef = "id_wand024";
        } else if (nNum == 4)
        {
            sResRef = "id_wand028";
        } else if (nNum == 5)
        {
            sResRef = "id_wand041";
        } else if (nNum == 6)
        {
            sResRef = "id_wand046";
        } else if (nNum == 7)
        {
            sResRef = "id_wand062";
        } else if (nNum == 8)
        {
            sResRef = "id_wand071";
        } else if (nNum == 9)
        {
            sResRef = "id_wand072";
        } else if (nNum == 10)
        {
            sResRef = "id_wand077";
        } else if (nNum == 11)
        {
            sResRef = "id_wand082";
        } else if (nNum == 12)
        {
            sResRef = "id_wand091";
        } else if (nNum == 13)
        {
            sResRef = "id_wand092";
        } else if (nNum == 14)
        {
            sResRef = "id_wand098";
        } else if (nNum == 15)
        {
            sResRef = "id_wand100";
        } else if (nNum == 16)
        {
            sResRef = "id_wand105";
        } else if (nNum == 17)
        {
            sResRef = "id_wand112";
        } else if (nNum == 18)
        {
            sResRef = "id_wand113";
        }
    } else if (nLevel == 2) // 33
    {
        if (nNum == 1)
        {
            sResRef = "id_wand015";
        } else if (nNum == 2)
        {
            sResRef = "id_wand018";
        } else if (nNum == 3)
        {
            sResRef = "id_wand026";
        } else if (nNum == 4)
        {
            sResRef = "id_wand023";
        } else if (nNum == 5)
        {
            sResRef = "id_wand027";
        } else if (nNum == 6)
        {
            sResRef = "id_wand032";
        } else if (nNum == 7)
        {
            sResRef = "id_wand042";
        } else if (nNum == 8)
        {
            sResRef = "id_wand047";
        } else if (nNum == 9)
        {
            sResRef = "id_wand056";
        } else if (nNum == 10)
        {
            sResRef = "id_wand061";
        } else if (nNum == 11)
        {
            sResRef = "id_wand068";
        } else if (nNum == 12)
        {
            sResRef = "id_wand070";
        } else if (nNum == 13)
        {
            sResRef = "id_wand078";
        } else if (nNum == 14)
        {
            sResRef = "id_wand083";
        } else if (nNum == 15)
        {
            sResRef = "id_wand085";
        } else if (nNum == 16)
        {
            sResRef = "id_wand086";
        } else if (nNum == 17)
        {
            sResRef = "id_wand093";
        } else if (nNum == 18)
        {
            sResRef = "id_wand094";
        } else if (nNum == 19)
        {
            sResRef = "id_wand104";
        } else if (nNum == 20)
        {
            sResRef = "id_wand106";
        } else if (nNum == 21)
        {
            sResRef = "id_wand108";
        } else if (nNum == 22)
        {
            sResRef = "id_wand114";
        } else if (nNum == 23)
        {
            sResRef = "id_wand118";
        } else if (nNum == 24)
        {
            sResRef = "id_wand122";
        }
    } else if (nLevel == 3) // 24
    {
        if (nNum == 1)
        {
            sResRef = "id_wand004";
        } else if (nNum == 2)
        {
            sResRef = "id_wand020";
        } else if (nNum == 3)
        {
            sResRef = "id_wand022";
        } else if (nNum == 4)
        {
            sResRef = "id_wand025";
        } else if (nNum == 5)
        {
            sResRef = "id_wand030";
        } else if (nNum == 6)
        {
            sResRef = "id_wand038";
        } else if (nNum == 7)
        {
            sResRef = "id_wand039";
        } else if (nNum == 8)
        {
            sResRef = "id_wand048";
        } else if (nNum == 9)
        {
            sResRef = "id_wand050";
        } else if (nNum == 10)
        {
            sResRef = "id_wand052";
        } else if (nNum == 11)
        {
            sResRef = "id_wand054";
        } else if (nNum == 12)
        {
            sResRef = "id_wand055";
        } else if (nNum == 13)
        {
            sResRef = "id_wand064";
        } else if (nNum == 14)
        {
            sResRef = "id_wand081";
        } else if (nNum == 15)
        {
            sResRef = "id_wand084";
        } else if (nNum == 16)
        {
            sResRef = "id_wand087";
        } else if (nNum == 17)
        {
            sResRef = "id_wand090";
        } else if (nNum == 18)
        {
            sResRef = "id_wand095";
        } else if (nNum == 19)
        {
            sResRef = "id_wand097";
        } else if (nNum == 20)
        {
            sResRef = "id_wand102";
        } else if (nNum == 21)
        {
            sResRef = "id_wand103";
        } else if (nNum == 22)
        {
            sResRef = "id_wand107";
        } else if (nNum == 23)
        {
            sResRef = "id_wand109";
        } else if (nNum == 24)
        {
            sResRef = "id_wand110";
        } else if (nNum == 25)
        {
            sResRef = "id_wand115";
        }
    } else if (nLevel == 4) // 20
    {
        if (nNum == 1)
        {
            sResRef = "id_wand002";
        } else if (nNum == 2)
        {
            sResRef = "id_wand019";
        } else if (nNum == 3)
        {
            sResRef = "id_wand021";
        } else if (nNum == 4)
        {
            sResRef = "id_wand029";
        } else if (nNum == 5)
        {
            sResRef = "id_wand034";
        } else if (nNum == 6)
        {
            sResRef = "id_wand036";
        } else if (nNum == 7)
        {
            sResRef = "id_wand037";
        } else if (nNum == 8)
        {
            sResRef = "id_wand040";
        } else if (nNum == 9)
        {
            sResRef = "id_wand045";
        } else if (nNum == 10)
        {
            sResRef = "id_wand049";
        } else if (nNum == 11)
        {
            sResRef = "id_wand053";
        } else if (nNum == 12)
        {
            sResRef = "id_wand059";
        } else if (nNum == 13)
        {
            sResRef = "id_wand067";
        } else if (nNum == 14)
        {
            sResRef = "id_wand069";
        } else if (nNum == 15)
        {
            sResRef = "id_wand073";
        } else if (nNum == 16)
        {
            sResRef = "id_wand076";
        } else if (nNum == 17)
        {
            sResRef = "id_wand079";
        } else if (nNum == 18)
        {
            sResRef = "id_wand080";
        } else if (nNum == 19)
        {
            sResRef = "id_wand089";
        } else if (nNum == 20)
        {
            sResRef = "id_wand096";
        } else if (nNum == 21)
        {
            sResRef = "id_wand101";
        } else if (nNum == 22)
        {
            sResRef = "id_wand116";
        } else if (nNum == 23)
        {
            sResRef = "id_wand121";
        }
    } else if (nLevel == 5) // 17
    {
        if (nNum == 1)
        {
            sResRef = "id_wand003";
        } else if (nNum == 2)
        {
            sResRef = "id_wand006";
        } else if (nNum == 3)
        {
            sResRef = "id_wand009";
        } else if (nNum == 4)
        {
            sResRef = "id_wand014";
        } else if (nNum == 5)
        {
            sResRef = "id_wand035";
        } else if (nNum == 6)
        {
            sResRef = "id_wand051";
        } else if (nNum == 7)
        {
            sResRef = "id_wand057";
        } else if (nNum == 8)
        {
            sResRef = "id_wand065";
        } else if (nNum == 9)
        {
            sResRef = "id_wand074";
        } else if (nNum == 10)
        {
            sResRef = "id_wand088";
        } else if (nNum == 11)
        {
            sResRef = "id_wand120";
        }
    } else if (nLevel == 6) //14
    {
        if (nNum == 1)
        {
            sResRef = "id_wand003";
        } else if (nNum == 2)
        {
            sResRef = "id_wand006";
        } else if (nNum == 3)
        {
            sResRef = "id_wand009";
        } else if (nNum == 4)
        {
            sResRef = "id_wand014";
        } else if (nNum == 5)
        {
            sResRef = "id_wand035";
        } else if (nNum == 6)
        {
            sResRef = "id_wand051";
        } else if (nNum == 7)
        {
            sResRef = "id_wand057";
        } else if (nNum == 8)
        {
            sResRef = "id_wand065";
        } else if (nNum == 9)
        {
            sResRef = "id_wand074";
        } else if (nNum == 10)
        {
            sResRef = "id_wand088";
        } else if (nNum == 11)
        {
            sResRef = "id_wand120";
        } else if (nNum == 12)
        {
            sResRef = "id_wand008";
        } else if (nNum == 13)
        {
            sResRef = "id_wand012";
        } else if (nNum == 14)
        {
            sResRef = "id_wand031";
        } else if (nNum == 15)
        {
            sResRef = "id_wand043";
        } else if (nNum == 16)
        {
            sResRef = "id_wand058";
        } else if (nNum == 17)
        {
            sResRef = "id_wand066";
        } else if (nNum == 18)
        {
            sResRef = "id_wand075";
        } else if (nNum == 19)
        {
            sResRef = "id_wand111";
        } else if (nNum == 20)
        {
            sResRef = "id_wand119";
        } else if (nNum == 21)
        {
            sResRef = "id_wand123";
        }
    } else if (nLevel >= 7) // 12
    {
        if (nNum == 1)
        {
            sResRef = "id_wand008";
        } else if (nNum == 2)
        {
            sResRef = "id_wand012";
        } else if (nNum == 3)
        {
            sResRef = "id_wand031";
        } else if (nNum == 4)
        {
            sResRef = "id_wand043";
        } else if (nNum == 5)
        {
            sResRef = "id_wand058";
        } else if (nNum == 6)
        {
            sResRef = "id_wand066";
        } else if (nNum == 7)
        {
            sResRef = "id_wand075";
        } else if (nNum == 8)
        {
            sResRef = "id_wand111";
        } else if (nNum == 9)
        {
            sResRef = "id_wand119";
        } else if (nNum == 10)
        {
            sResRef = "id_wand123";
        } else if (nNum == 11)
        {
            sResRef = "id_wand005";
        } else if (nNum == 12)
        {
            sResRef = "id_wand013";
        } else if (nNum == 13)
        {
            sResRef = "id_wand063";
        } else if (nNum == 13)
        {
            sResRef = "id_wand010";
        } else if (nNum == 13)
        {
            sResRef = "id_wand016";
        } else if (nNum == 13)
        {
            sResRef = "id_wand117";
        } else if (nNum == 13)
        {
            sResRef = "id_wand011";
        }
    }

    return sResRef;
}

int GetMiscellaneousNum(int nLevel)
{
    if (nLevel <= 5)
    {
        return 11;
    } else if (nLevel <= 10)
    {
        return 11;
    } else if (nLevel <= 15)
    {
        return 11;
    } else if (nLevel <= 20)
    {
        return 11;
    } else
    {
        return 4;
    }
}

string GetMiscellaneousResRef(int nLevel, int nNum)
{
    string sResRef = "";

    if (nLevel <= 5)
    {
        if (nNum == 1)
        {
            sResRef = "NW_IT_TRAP033";
        } else if (nNum == 2)
        {
            sResRef = "NW_IT_TRAP013";
        } else if (nNum == 3)
        {
            sResRef = "NW_IT_TRAP021";
        } else if (nNum == 4)
        {
            sResRef = "NW_IT_TRAP021";
        } else if (nNum == 5)
        {
            sResRef = "NW_IT_TRAP029";
        } else if (nNum == 6)
        {
            sResRef = "NW_IT_TRAP025";
        } else if (nNum == 7)
        {
            sResRef = "NW_IT_TRAP005";
        } else if (nNum == 8)
        {
            sResRef = "NW_IT_TRAP041";
        } else if (nNum == 9)
        {
            sResRef = "NW_IT_TRAP037";
        } else if (nNum == 10)
        {
            sResRef = "NW_IT_TRAP001";
        } else if (nNum == 11)
        {
            sResRef = "NW_IT_TRAP009";
        }
    } else if (nLevel <= 10)
    {
        if (nNum == 1)
        {
            sResRef = "NW_IT_TRAP034";
        } else if (nNum == 2)
        {
            sResRef = "NW_IT_TRAP014";
        } else if (nNum == 3)
        {
            sResRef = "NW_IT_TRAP022";
        } else if (nNum == 4)
        {
            sResRef = "NW_IT_TRAP018";
        } else if (nNum == 5)
        {
            sResRef = "NW_IT_TRAP030";
        } else if (nNum == 6)
        {
            sResRef = "NW_IT_TRAP026";
        } else if (nNum == 7)
        {
            sResRef = "NW_IT_TRAP006";
        } else if (nNum == 8)
        {
            sResRef = "NW_IT_TRAP042";
        } else if (nNum == 9)
        {
            sResRef = "NW_IT_TRAP038";
        } else if (nNum == 10)
        {
            sResRef = "NW_IT_TRAP002";
        } else if (nNum == 11)
        {
            sResRef = "NW_IT_TRAP010";
        }
    } else if (nLevel <= 15)
    {
        if (nNum == 1)
        {
            sResRef = "NW_IT_TRAP035";
        } else if (nNum == 2)
        {
            sResRef = "NW_IT_TRAP015";
        } else if (nNum == 3)
        {
            sResRef = "NW_IT_TRAP023";
        } else if (nNum == 4)
        {
            sResRef = "NW_IT_TRAP019";
        } else if (nNum == 5)
        {
            sResRef = "NW_IT_TRAP031";
        } else if (nNum == 6)
        {
            sResRef = "NW_IT_TRAP027";
        } else if (nNum == 7)
        {
            sResRef = "NW_IT_TRAP007";
        } else if (nNum == 8)
        {
            sResRef = "NW_IT_TRAP043";
        } else if (nNum == 9)
        {
            sResRef = "NW_IT_TRAP039";
        } else if (nNum == 10)
        {
            sResRef = "NW_IT_TRAP003";
        } else if (nNum == 11)
        {
            sResRef = "NW_IT_TRAP011";
        }
    } else if (nLevel <= 20)
    {
        if (nNum == 1)
        {
            sResRef = "NW_IT_TRAP036";
        } else if (nNum == 2)
        {
            sResRef = "NW_IT_TRAP016";
        } else if (nNum == 3)
        {
            sResRef = "NW_IT_TRAP024";
        } else if (nNum == 4)
        {
            sResRef = "NW_IT_TRAP020";
        } else if (nNum == 5)
        {
            sResRef = "NW_IT_TRAP032";
        } else if (nNum == 6)
        {
            sResRef = "NW_IT_TRAP028";
        } else if (nNum == 7)
        {
            sResRef = "NW_IT_TRAP008";
        } else if (nNum == 8)
        {
            sResRef = "NW_IT_TRAP044";
        } else if (nNum == 9)
        {
            sResRef = "NW_IT_TRAP040";
        } else if (nNum == 10)
        {
            sResRef = "NW_IT_TRAP004";
        } else if (nNum == 11)
        {
            sResRef = "NW_IT_TRAP012";
        }
    } else if (nLevel > 20)
    {
        if (nNum == 1)
        {
            sResRef = "X2_IT_TRAP001";
        } else if (nNum == 2)
        {
            sResRef = "X2_IT_TRAP002";
        } else if (nNum == 3)
        {
            sResRef = "X2_IT_TRAP003";
        } else if (nNum == 4)
        {
            sResRef = "X2_IT_TRAP004";
        }
    }

    return sResRef;
}

//void main(){}

