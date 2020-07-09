#include "inc_id1_text"
#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_items"

void SetLineValue(int nOffset);
int SetLineString(int nOffset);
void AdjustCategoryValues(int nCategory, int nModifier);
void AdjustSubCategoryValues(int nCategory, int nSubCategory, int nModifier);
void AdjustTypeValues(int nCategory, int nSubCategory, int nType, int nModifier);

void SetLineValue(int nOffset)
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    int nMin = GetLocalInt(OBJECT_SELF, "nMin");
    int nCurrentValue = GetLocalInt(OBJECT_SELF, "nCurrentValue");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");

    int nLineValue = nMin + ((nCurrentPage - 1) * 10) + nOffset;

    int nTemp;

    SetLocalInt(OBJECT_SELF, "nCurrentValue", nLineValue);

    switch (nListType)
    {
        case -1:
            // nothing special for test case

            break;
        case 1:
        case 2:
            SetModuleFlag(ID1_FLAG_THEME_SELECTION, ID1_THEME_SELECTION_SPECIFIC);
            SetModuleFlagValue(ID1_FLAG_THEME_SELECTION, nLineValue);
            break;
        case 3:
            SetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER, nLineValue);
            break;
        case 4:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH, nLineValue);
            break;
        case 5:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X, nLineValue);
            break;
        case 6:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y, nLineValue);
            break;
        case 7:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT, nLineValue);
            break;
        case 8:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT, nLineValue);
            break;
        case 9:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT, nLineValue);
            break;
        case 10:
            SetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT, nLineValue);
            break;
        case 11:
            SetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY, nLineValue);
            break;
        case 12:
            SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY, nLineValue);
            break;
        case 13:
            SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION, ID1_SECRET_DOOR_DIFFICULTY_SELECTION_SET);
            SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION, nLineValue);
            break;
        case 14:
            SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM);
            SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, nLineValue);
            break;
        case 15:
            SetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY, nLineValue);
            break;
        case 16:
            SetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY, nLineValue);
            break;
        case 17:
            SetModuleFlagValue(ID1_FLAG_PUZZLE_FREQUENCY, nLineValue);
            break;
        case 18:
            SetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY, 100 - nLineValue);
            break;
        case 19:
            SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE, nLineValue);
            break;
        case 20:
            SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE, nLineValue);
            break;
        case 21:
            SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE, nLineValue);
            break;
        case 22:
            SetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY, nLineValue);
            break;
        case 23:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_REST_FREQUENCY, nLineValue);
            break;
        case 24:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY, nLineValue);
            break;
        case 25:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY, nLineValue);
            break;
        case 26:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY, nLineValue);
            break;
        case 27:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP, nLineValue);
            break;
        case 28:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN, nLineValue);
            break;
        case 29:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY, nLineValue);
            break;
        case 30:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY, nLineValue);
            break;
        case 31:
            SetModuleFlagValue(ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY, nLineValue);
            break;
        case 32:
            SetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY, nLineValue);
            break;
        case 33:
            SetModuleFlagValue(ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustCategoryValues(1, nTemp);
            }
            break;
        case 34:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_MELEE_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(1, 1, nTemp);
            }
            break;
        case 35:
        case 36:
        case 37:
        case 38:
        case 39:
        case 40:
        case 41:
        case 42:
        case 43:
        case 44:
        case 45:
        case 46:
        case 47:
        case 48:
        case 49:
        case 50:
        case 51:
        case 52:
        case 53:
        case 54:
        case 55:
        case 56:
        case 57:
        case 58:
        case 59:
        case 60:
        case 61:
        case 62:
        case 63:
        case 64:
            SetModuleFlagValue("nFlagType" + GetTypeVariableName(1, 1, nListType - 34) + "Percentage", nLineValue);
            DebugMessage("Setting flag nFlagType" + GetTypeVariableName(1, 1, nListType - 34) + "Percentage");
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustTypeValues(1, 1, nListType - 34, nTemp);
            }
            break;
        case 65:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_RANGED_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(1, 2, nTemp);
            }
            break;
        case 66:
        case 67:
        case 68:
        case 69:
        case 70:
        case 71:
        case 72:
        case 73:
            SetModuleFlagValue("nFlagType" + GetTypeVariableName(1, 2, nListType - 65) + "Percentage", nLineValue);
            DebugMessage("Setting flag nFlagType" + GetTypeVariableName(1, 2, nListType - 65) + "Percentage");
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustTypeValues(1, 2, nListType - 65, nTemp);
            }
            break;
        case 74:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_AMMUNITION_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(1, 3, nTemp);
            }
            break;
        case 75:
        case 76:
        case 77:
            SetModuleFlagValue("nFlagType" + GetTypeVariableName(1, 3, nListType - 74) + "Percentage", nLineValue);
            DebugMessage("Setting flag nFlagType" + GetTypeVariableName(1, 3, nListType - 74) + "Percentage");
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustTypeValues(1, 3, nListType - 74, nTemp);
            }
            break;
        case 78:
            SetModuleFlagValue(ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustCategoryValues(2, nTemp);
            }
            break;
        case 79:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_BODY_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(2, 1, nTemp);
            }
            break;
        case 80:
        case 81:
        case 82:
        case 83:
        case 84:
        case 85:
        case 86:
        case 87:
        case 88:
            SetModuleFlagValue("nFlagType" + GetTypeVariableName(2, 1, nListType - 79) + "Percentage", nLineValue);
            DebugMessage("Setting flag nFlagType" + GetTypeVariableName(2, 1, nListType - 79) + "Percentage");
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustTypeValues(2, 1, nListType - 79, nTemp);
            }
            break;
        case 89:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_SHIELD_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(2, 1, nTemp);
            }
            break;
        case 90:
        case 91:
        case 92:
            SetModuleFlagValue("nFlagType" + GetTypeVariableName(2, 2, nListType - 89) + "Percentage", nLineValue);
            DebugMessage("Setting flag nFlagType" + GetTypeVariableName(2, 2, nListType - 89) + "Percentage");
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustTypeValues(2, 2, nListType - 89, nTemp);
            }
            break;
        case 93:
            SetModuleFlagValue(ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustCategoryValues(3, nTemp);
            }
            break;
        case 94:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_AMULET_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 1, nTemp);
            }
            break;
        case 95:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BELT_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 2, nTemp);
            }
            break;
        case 96:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BOOTS_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 3, nTemp);
            }
            break;
        case 97:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BRACER_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 4, nTemp);
            }
            break;
        case 98:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_CLOAK_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 5, nTemp);
            }
            break;
        case 99:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_GLOVES_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 6, nTemp);
            }
            break;
        case 100:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_HELMET_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 7, nTemp);
            }
            break;
        case 101:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_RING_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(3, 8, nTemp);
            }
            break;
        case 102:
            SetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustCategoryValues(4, nTemp);
            }
            break;
        case 103:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(4, 1, nTemp);
            }
            break;
        case 104:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(4, 2, nTemp);
            }
            break;
        case 105:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(4, 3, nTemp);
            }
            break;
        case 106:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(4, 4, nTemp);
            }
            break;
        case 107:
            SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_ROD_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustSubCategoryValues(4, 5, nTemp);
            }
            break;
        case 108:
            SetModuleFlagValue(ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE, nLineValue);
            DebugMessage("Old value was " + IntToString(nCurrentValue) + " and new value is " + IntToString(nLineValue));
            nTemp = nLineValue - nCurrentValue;
            DebugMessage("Modifier to each is " + IntToString(nTemp));
            if (nTemp != 0)
            {
                AdjustCategoryValues(5, nTemp);
            }
            break;
        case 109:
            SetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL, nLineValue);
            break;
        case 110:
            SetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE, nLineValue);
            break;
        case 111:
            SetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY, nLineValue);
            break;
        case 112:
            SetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY, nLineValue);
            break;
        case 113:
            SetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY, nLineValue);
            break;
        case 114:
            SetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_SELECTION, ID1_LOCK_DIFFICULTY_SELECTION_SET);
            SetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_SELECTION, nLineValue);
            break;
        case 115:
            SetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_NUMBER, ID1_LOCK_DIFFICULTY_NUMBER_RANDOM);
            SetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_NUMBER, nLineValue);
            break;
        case 116:
            SetModuleFlagValue(ID1_FLAG_LOCK_DOOR_FREQUENCY, nLineValue);
            break;
        case 117:
            SetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY, nLineValue);
            break;
        case 118:
            SetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_SELECTION, ID1_TRAP_DIFFICULTY_SELECTION_SET);
            SetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_SELECTION, nLineValue);
            break;
        case 119:
            SetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER, ID1_TRAP_DIFFICULTY_NUMBER_RANDOM);
            SetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER, nLineValue);
            break;
        case 120:
            SetModuleFlagValue(ID1_FLAG_TRAP_FLOOR_FREQUENCY, nLineValue);
            break;
        case 121:
            SetModuleFlagValue(ID1_FLAG_TRAP_DOOR_FREQUENCY, nLineValue);
            break;
        case 122:
            SetModuleFlagValue(ID1_FLAG_TRAP_CHEST_FREQUENCY, nLineValue);
            break;
        case 123:
            SetModuleFlag(ID1_FLAG_TRAP_DETECT_SELECTION, ID1_TRAP_DETECT_SELECTION_SET);
            SetModuleFlagValue(ID1_FLAG_TRAP_DETECT_SELECTION, nLineValue);
            break;
        case 124:
            SetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER, ID1_TRAP_DETECT_NUMBER_RANDOM);
            SetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER, nLineValue);
            break;
        case 125:
            SetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION, ID1_TRAP_DAMAGE_SELECTION_SET);
            SetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION, nLineValue);
            break;
        case 126:
            SetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER, ID1_TRAP_DAMAGE_NUMBER_RANDOM);
            SetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER, nLineValue);
            break;
        case 127:
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_FREQUENCY, nLineValue);
            break;
        case 128:
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, nLineValue);
            break;
        case 129:
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, nLineValue);
            break;
        case 130:
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE, nLineValue);
            break;
        case 131:
            SetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE, ID1_ENCOUNTER_TYPE_CREATURE);
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE, nLineValue);
            break;
        case 132:
            SetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE, ID1_ENCOUNTER_TYPE_THEME);
            SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE, nLineValue);
            break;
        case 133:
            SetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION, ID1_BOSS_AREA_SELECTION_FIXED_SPECIFIC);
            SetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION, nLineValue);
            break;
        case 134:
            SetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION, ID1_BOSS_AREA_SELECTION_FIXED_THEMESET);
            SetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION, nLineValue);
            break;
        case 135:
            SetModuleFlagValue(ID1_FLAG_BOSS_MINIBOSS_FREQUENCY, nLineValue);
            break;
        case 136:
            SetModuleFlagValue(ID1_FLAG_BOSS_GUARD_FREQUENCY, nLineValue);
            break;
        case 137:
            SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY, nLineValue);
            break;
        case 138:
            SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE, nLineValue);
            break;
        case 139:
            SetModuleFlagValue(ID1_FLAG_PLOT_FREQUENCY, nLineValue);
            break;
        case 140:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY, nLineValue);
            break;
        case 141:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY, nLineValue);
            break;
        case 142:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY, nLineValue);
            break;
        case 143:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY, nLineValue);
            break;
        case 144:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY, nLineValue);
            break;
        case 145:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY, nLineValue);
            break;
        case 146:
            SetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY, nLineValue);
            break;
        case 147:
            SetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE, nLineValue);
            break;
        case 148:
            SetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY, nLineValue);
            break;
        case 149:
            SetModuleFlagValue(ID1_FLAG_PLAYER_RESPAWN_HEALTH, nLineValue);
            break;
        case 150:
            SetModuleFlagValue(ID1_FLAG_COMBAT_ONELINER_FREQUENCY, nLineValue);
            break;
        case 151:
            SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE, nLineValue);
            break;
    }
}

int SetLineString(int nOffset)
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    int nMin = GetLocalInt(OBJECT_SELF, "nMin");
    int nMax = GetLocalInt(OBJECT_SELF, "nMax");
    int nCurrentValue = GetLocalInt(OBJECT_SELF, "nCurrentValue");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    DebugMessage("  nListType = " + IntToString(nListType) + ", nMin = " + IntToString(nMin) + ", nMax = " + IntToString(nMax) + ", nCurrentValue = " + IntToString(nCurrentValue) + ", nCurrentPage = " + IntToString(nCurrentPage));

    int nLineValue = nMin + ((nCurrentPage - 1) * 10) + nOffset;
    DebugMessage("  nLineValue = " + IntToString(nLineValue));

    int nTemp;
    string sTemp;
    object oTemp;

    if (nLineValue <= nMax)
    {
        string sString;

        switch (nListType)
        {
            case -1:
                sString = IntToString(nLineValue);
                break;
            case 1:
                sString = GetLocalString(GetModule(), "sTheme" + IntToString(nLineValue) + "Name");
                break;
            case 2:
                sString = GetLocalString(GetModule(), "sThemeSet" + IntToString(nLineValue) + "Name");
                break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
            case 33:
            case 34:
            case 35:
            case 36:
            case 37:
            case 38:
            case 39:
            case 40:
            case 41:
            case 42:
            case 43:
            case 44:
            case 45:
            case 46:
            case 47:
            case 48:
            case 49:
            case 50:
            case 51:
            case 52:
            case 53:
            case 54:
            case 55:
            case 56:
            case 57:
            case 58:
            case 59:
            case 60:
            case 61:
            case 62:
            case 63:
            case 64:
            case 65:
            case 66:
            case 67:
            case 68:
            case 69:
            case 70:
            case 71:
            case 72:
            case 73:
            case 74:
            case 75:
            case 76:
            case 77:
            case 78:
            case 79:
            case 80:
            case 81:
            case 82:
            case 83:
            case 84:
            case 85:
            case 86:
            case 87:
            case 88:
            case 89:
            case 90:
            case 91:
            case 92:
            case 93:
            case 94:
            case 95:
            case 96:
            case 97:
            case 98:
            case 99:
            case 100:
            case 101:
            case 102:
            case 103:
            case 104:
            case 105:
            case 106:
            case 107:
            case 108:
            case 109:
            case 110:
            case 111:
            case 112:
            case 113:
            case 114:
            case 115:
            case 116:
            case 117:
            case 118:
            case 119:
            case 120:
            case 121:
            case 122:
            case 123:
            case 124:
            case 125:
            case 126:
            case 127:
            case 128:
            case 129:
            case 130:
                sString = IntToString(nLineValue);
                break;
            case 131:
                sString = GetLocalString(GetModule(), "sCreature" + IntToString(nLineValue) + "NamePlural");
                break;
            case 132:
                sString = GetLocalString(GetModule(), "sTheme" + IntToString(nLineValue) + "Name");
                break;
            case 133:
                DebugMessage("Getting nBossAreas" + IntToString(nLineValue));
                nTemp = GetLocalInt(GetModule(), "nBossAreas" + IntToString(nLineValue));
                DebugMessage("Getting oAreaIdentifier" + IntToString(nTemp));
                oTemp = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nTemp));
                sTemp = GetName(oTemp);
                sString += sTemp;
                sTemp = GetTag(oTemp);
                sString += " (" + sTemp + ")";
                break;
            case 134:
                DebugMessage("Getting nBossThemeSetAreas" + IntToString(nLineValue));
                nTemp = GetLocalInt(GetModule(), "nBossThemeSetAreas" + IntToString(nLineValue));
                DebugMessage("Getting oAreaIdentifier" + IntToString(nTemp));
                oTemp = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nTemp));
                sTemp = GetName(oTemp);
                sString += sTemp;
                sTemp = GetTag(oTemp);
                sString += " (" + sTemp + ")";
                break;
            case 135:
            case 136:
            case 137:
            case 138:
            case 139:
            case 140:
            case 141:
            case 142:
            case 143:
            case 144:
            case 145:
            case 146:
            case 147:
            case 148:
            case 149:
            case 150:
            case 151:
                sString = IntToString(nLineValue);
                break;
        }

        if (nLineValue == nCurrentValue)
        {
            sString += MakeTextGreen(" [Current]");
        }

        SetCustomToken(5101 + nOffset, sString);

        return TRUE;
    } else
    {
        return FALSE;
    }
}

void AdjustCategoryValues(int nCategory, int nModifier)
{
    DebugMessage("");
    DebugMessage("Category modifier is " + IntToString(nModifier));

    // for value categories 0-40 (0 is ideal category)
    string sValue;
    string sCategory;
    int nCategoryTotal;
    int nTotal;
    int nCategoryPercentage;
    int nValue = 0;
    while (nValue <= 40)
    {
        if (nValue == 0)
        {
            sValue = "Ideal";
        } else
        {
            sValue = "Value" + IntToString(nValue);
        }
        sCategory = sValue + "Category" + IntToString(nCategory);
        DebugMessage("On " + sCategory);

        // if category total is above zero
        nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
        DebugMessage("  Category total is " + IntToString(nCategoryTotal));
        if ((nCategoryTotal > 0) || (nValue == 0))
        {
            // apply the modifier to the percentage
            nCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
            DebugMessage("  Old n" + sCategory + "Percentage is " + IntToString(nCategoryPercentage));
            nCategoryPercentage += nModifier;
            if (nCategoryPercentage < 0)
            {
                nCategoryPercentage = 0;
            }
            DebugMessage("  New n" + sCategory + "Percentage is " + IntToString(nCategoryPercentage));
            SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nCategoryPercentage);

            // apply the modifier to the total
            nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
            DebugMessage("  Old n" + sValue + "Total is " + IntToString(nTotal));
            nTotal += nModifier;
            if (nTotal < 0)
            {
                nTotal = 0;
            }
            DebugMessage("  New n" + sValue + "Total is " + IntToString(nTotal));
            SetLocalInt(GetModule(), "n" + sValue + "Total", nTotal);
        }

        nValue++;
    }
}

void AdjustSubCategoryValues(int nCategory, int nSubCategory, int nModifier)
{
    DebugMessage("");
    DebugMessage("Subcategory modifier is " + IntToString(nModifier));

    // for value categories 0-40 (0 is ideal category)
    string sValue;
    string sCategory;
    string sSubCategory;
    int nOldTotal;
    int nNewTotal;
    int nOldCategoryPercentage;
    int nNewCategoryPercentage;
    int nOldCategoryTotal;
    int nNewCategoryTotal;
    int nOldSubCategoryPercentage;
    int nNewSubCategoryPercentage;
    int nOldSubCategoryTotal;
    int nNewSubCategoryTotal;
    int nValue = 0;
    while (nValue <= 40)
    {
        if (nValue == 0)
        {
            sValue = "Ideal";
        } else
        {
            sValue = "Value" + IntToString(nValue);
        }
        sCategory = sValue + "Category" + IntToString(nCategory);
        sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
        DebugMessage("On " + sSubCategory);

        // if subcategory total is above 0
        nNewSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
        DebugMessage("  SubCategory total is " + IntToString(nNewSubCategoryTotal));
        if ((nNewSubCategoryTotal > 0) || (nValue == 0))
        {
            // adjust the percentage
            nOldSubCategoryPercentage = GetLocalInt(GetModule(), "n" + sSubCategory + "Percentage");
            nNewSubCategoryPercentage = nOldSubCategoryPercentage + nModifier;
            if (nNewSubCategoryPercentage < 0)
            {
                nNewSubCategoryPercentage = 0;
            }
            DebugMessage("  Old n" + sSubCategory + "Percentage was " + IntToString(nOldSubCategoryPercentage) + " and new is " + IntToString(nNewSubCategoryPercentage));
            SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nNewSubCategoryPercentage);

            // category totals
            nOldCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
            nNewCategoryTotal = nOldCategoryTotal + nModifier;
            if (nNewCategoryTotal < 0)
            {
                nNewCategoryTotal = 0;
            }
            DebugMessage("  Old n" + sCategory + "Total was " + IntToString(nOldCategoryTotal) + " and new is " + IntToString(nNewCategoryTotal));
            SetLocalInt(GetModule(), "n" + sCategory + "Total", nNewCategoryTotal);

            // newly set to 0
            if ((nNewCategoryTotal == 0) && (nOldCategoryTotal != 0))
            {
                // set category percentage to 0
                nOldCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
                DebugMessage("  Old n" + sCategory + "Percentage was " + IntToString(nOldCategoryPercentage) + " and new is set to 0");
                SetLocalInt(GetModule(), "n" + sCategory + "Percentage", 0);

                // adjust total
                nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                nNewTotal = nOldTotal - nOldCategoryPercentage;
                if (nNewTotal < 0)
                {
                    nNewTotal = 0;
                }
                DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
            }

            // newly given a value
            if ((nNewCategoryTotal != 0) && (nOldCategoryTotal == 0))
            {
                // set real percentage
                nNewCategoryPercentage = GetLocalInt(GetModule(), "nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage");
                DebugMessage("  nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage is " + IntToString(nNewCategoryPercentage));
                SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nNewCategoryPercentage);

                // add to total
                nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                nNewTotal = nOldTotal + nNewCategoryPercentage;
                if (nNewTotal < 0)
                {
                    nNewTotal = 0;
                }
                DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
            }
        }

        nValue++;
    }
}

void AdjustTypeValues(int nCategory, int nSubCategory, int nType, int nModifier)
{
    DebugMessage("");
    DebugMessage("Type modifier is " + IntToString(nModifier));

    // for value categories 0-40 (0 is ideal category)
    string sValue;
    string sCategory;
    string sSubCategory;
    string sType;
    int nOldTotal;
    int nNewTotal;
    int nOldCategoryPercentage;
    int nNewCategoryPercentage;
    int nOldCategoryTotal;
    int nNewCategoryTotal;
    int nOldSubCategoryPercentage;
    int nNewSubCategoryPercentage;
    int nOldSubCategoryTotal;
    int nNewSubCategoryTotal;
    int nOldTypePercentage;
    int nNewTypePercentage;
    int nTypeNum;
    int nValue = 0;
    while (nValue <= 40)
    {
        if (nValue == 0)
        {
            sValue = "Ideal";
        } else
        {
            sValue = "Value" + IntToString(nValue);
        }
        sCategory = sValue + "Category" + IntToString(nCategory);
        sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
        sType = sSubCategory + "Type" + IntToString(nType);
        DebugMessage("On " + sType);

        // get the number of items in this category
        nTypeNum = GetLocalInt(GetModule(), "n" + sType + "Num");
        DebugMessage("  There are " + IntToString(nTypeNum) + " items of this type.");
        if ((nTypeNum > 0) || (nValue == 0))
        {
            nOldTypePercentage = GetLocalInt(GetModule(), "n" + sType + "Percentage");
            nNewTypePercentage = nOldTypePercentage + nModifier;
            if (nNewTypePercentage < 0)
            {
                nNewTypePercentage = 0;
            }
            DebugMessage("  Old n" + sType + "Percentage was " + IntToString(nOldTypePercentage) + " and new is " + IntToString(nNewTypePercentage));
            SetLocalInt(GetModule(), "n" + sType + "Percentage", nNewTypePercentage);

            // if subcategory total is above 0
            nOldSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
            nNewSubCategoryTotal = nOldSubCategoryTotal + nModifier;
            if (nNewSubCategoryTotal < 0)
            {
                nNewSubCategoryTotal = 0;
            }
            DebugMessage("  Old n" + sSubCategory + "Total was " + IntToString(nOldSubCategoryTotal) + " and new is " + IntToString(nNewSubCategoryTotal));
            SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nNewSubCategoryTotal);

            // if the old was 0
            if ((nOldSubCategoryTotal == 0) && (nNewSubCategoryTotal != 0))
            {
                nNewSubCategoryPercentage = GetModuleFlagValue("nFlagSubCategory" + GetCategoryVariableName(nCategory) + GetSubCategoryVariableName(nCategory, nSubCategory) + "Percentage");
                if (nNewSubCategoryPercentage < 0)
                {
                    nNewSubCategoryPercentage = 0;
                }
                DebugMessage("  New n" + sSubCategory + "Percentage is " + IntToString(nNewSubCategoryPercentage));
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nNewSubCategoryPercentage);

                // category totals
                nOldCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                nNewCategoryTotal = nOldCategoryTotal + nNewSubCategoryPercentage;
                if (nNewCategoryTotal < 0)
                {
                    nNewCategoryTotal = 0;
                }
                DebugMessage("  Old n" + sCategory + "Total was " + IntToString(nOldCategoryTotal) + " and new is " + IntToString(nNewCategoryTotal));
                SetLocalInt(GetModule(), "n" + sCategory + "Total", nNewCategoryTotal);

                // newly set to 0
                if ((nNewCategoryTotal == 0) && (nOldCategoryTotal != 0))
                {
                    // set category percentage to 0
                    nOldCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
                    DebugMessage("  Old n" + sCategory + "Percentage was " + IntToString(nOldCategoryPercentage) + " and new is set to 0");
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", 0);

                    // adjust total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal - nOldCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }

                // newly given a value
                if ((nNewCategoryTotal != 0) && (nOldCategoryTotal == 0))
                {
                    // set real percentage
                    nNewCategoryPercentage = GetLocalInt(GetModule(), "nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage");
                    DebugMessage("  nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage is " + IntToString(nNewCategoryPercentage));
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nNewCategoryPercentage);

                    // add to total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal + nNewCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }
            } else if ((nOldSubCategoryTotal != 0) && (nNewSubCategoryTotal == 0)) // if the new is 0
            {
                // set subcategory percentage to 0
                nOldSubCategoryPercentage = GetLocalInt(GetModule(), "n" + sSubCategory + "Percentage");
                DebugMessage("  Old n" + sSubCategory + "Percentage was " + IntToString(nOldSubCategoryPercentage) + " and new is set to 0");
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", 0);

                // remove subcategory percentage from category total
                nOldCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                nNewCategoryTotal = nOldCategoryTotal - nOldSubCategoryPercentage;
                if (nNewCategoryTotal < 0)
                {
                    nNewCategoryTotal = 0;
                }
                DebugMessage("  Old n" + sCategory + "Total was " + IntToString(nOldCategoryTotal) + " and new is " + IntToString(nNewCategoryTotal));
                SetLocalInt(GetModule(), "n" + sCategory + "Total", nNewCategoryTotal);

                // if category total is 0
                if (nNewCategoryTotal == 0)
                {
                    // set category percentage to 0
                    nOldCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
                    DebugMessage("  Old n" + sCategory + "Percentage was " + IntToString(nOldCategoryPercentage) + " and new is set to 0");
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", 0);

                    // adjust total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal - nOldCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }
            }
        }

        nValue++;
    }
}

//void main (){}

