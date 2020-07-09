#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    int nListType = GetLocalInt(OBJECT_SELF, "nListType");
    int nMin = GetLocalInt(OBJECT_SELF, "nMin");
    int nMax = GetLocalInt(OBJECT_SELF, "nMax");
    int nCurrentValue = GetLocalInt(OBJECT_SELF, "nCurrentValue");
    int nCurrentPage = GetLocalInt(OBJECT_SELF, "nCurrentPage");
    DebugMessage("nListType = " + IntToString(nListType) + ", nMin = " + IntToString(nMin) + ", nMax = " + IntToString(nMax) + ", nCurrentValue = " + IntToString(nCurrentValue) + ", nCurrentPage = " + IntToString(nCurrentPage));

    object oDungeon = GetCurrentDungeon();
    string sString = "";

    int nTemp;
    string sTemp;
    object oTemp;
    int bGold;
    int bExperience;
    int bItem;

    switch (nListType)
    {
        case -1:
            sString += "This is the test loop.";
            sString = AddLineBreak(sString);
            sString += "Min value: " + IntToString(nMin);
            sString = AddLineBreak(sString);
            sString += "Max value: " + IntToString(nMax);
            sString = AddLineBreak(sString);
            sString += "Current value: " + IntToString(nCurrentValue);
            sString = AddLineBreak(sString);
            sString += "Current page: " + IntToString(nCurrentPage);
            sString = AddLineBreak(sString);
            break;
        case 1: // theme
            sString += "The dungeon will be based around a single Theme.";
            sString = AddLineBreak(sString);
            sTemp = GetLocalString(GetModule(), "sTheme" + IntToString(nCurrentValue) + "Name");
            sString += "Specific Theme selected is " + sTemp + ".";
            break;
        case 2: // theme set
            sString += "The dungeon will be based around a Theme Set.";
            sString = AddLineBreak(sString);
            sTemp = GetLocalString(GetModule(), "sThemeSet" + IntToString(nCurrentValue) + "Name");
            sString += "Specific Theme Set selected is " + sTemp + ".";
            break;
        case 3: // staircases
            sString += "The dungeon has ";
            if (GetModuleFlag(ID1_FLAG_STAIRS_NUMBER) == ID1_STAIRS_NUMBER_RANDOM)
            {
                sString += "up to ";
            }
            nTemp = GetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER);
            sString += IntToString(nTemp) + " staircases down per level.";
            break;
        case 4: // dungeon depth
            sString += "The dungeon is ";
            if (GetModuleFlag(ID1_FLAG_DUNGEON_DEPTH) == ID1_DUNGEON_DEPTH_RANDOM)
            {
                sString += "up to ";
            }
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH);
            sString += IntToString(nTemp) + " ";
            if (nTemp == 1)
            {
                sString += "level deep.";
            } else
            {
                sString += "levels deep.";
            }
            break;
        case 5:
        case 6:
            sString += "The maximum size of a level is ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X);
            sString += IntToString(nTemp) + " areas wide by ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y);
            sString += IntToString(nTemp) + " areas long.";
            break;
        case 7:
        case 8:
        case 9:
        case 10:
            // get the chance of 1 exit
            sString += "The proportional chance of a one-exit area is ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT);
            sString += IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // get the chance of 2 exit
            sString += "The proportional chance of a two-exit area is ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT);
            sString += IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // get the chance of 3 exit
            sString += "The proportional chance of a three-exit area is ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT);
            sString += IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // get the chance of 4 exit
            sString += "The proportional chance of a four-exit area is ";
            nTemp = GetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT);
            sString += IntToString(nTemp) + ".";
            break;
        case 11:
            nTemp = GetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY);
            sString += "Each decor waypoint in an area has a " + IntToString(nTemp) + "% chance of being active.";
            break;
        case 12:
            nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY);
            sString += "Each secret area door has a " + IntToString(nTemp) + "% chance of being active.";
            break;
        case 13:
            nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION);
            sString += "Secret door base detection difficulty is set to " + IntToString(nTemp) + ".";
            break;
        case 14:
            nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER);
            sString += "Secret door detection difficulty varies within +/-" + IntToString(nTemp) + ".";
            break;
        case 15:
            nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY);
            sString += "The chance of an active encounter waypoint in a secret area is " + IntToString(nTemp) + "%.";
            break;
        case 16:
            nTemp = GetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY);
            sString += "The chance of a treasure chest being active in a secret area is " + IntToString(nTemp) + "%.";
            break;
        case 17:
            nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_FREQUENCY);
            sString += "Safe Zones have a " + IntToString(nTemp) + "% chance of being active.";
            break;
        case 18:
            nTemp = 100 - GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
            sString += "An active Safe Zone has a " + IntToString(nTemp) + "% chance of being a puzzle.";
            break;
        case 19:
        case 20:
        case 21:
            // secret area reward chance
            nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE);
            sString += "Proportional chance of a puzzle opening a secret area is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // treasure reward chance
            nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE);
            sString += "Proportional chance of a puzzle giving a treasure reward is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // experience reward chance
            nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE);
            sString += "Proportional chance of a puzzle giving an experience reward is " + IntToString(nTemp) + ".";
            break;
        case 22:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY);
            sString += "An active Safe Zone has a " + IntToString(nTemp) + "% chance of being a camp.";
            break;
        case 23:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_REST_FREQUENCY);
            sString += "A Rest Tent will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 24:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY);
            sString += "A Mystic Anvil will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 25:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY);
            sString += "A Spellcaster will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 26:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY);
            sString += "A Merchant will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 27:
        case 28:
            // markup
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP);
            sString += "Merchants will sell items at " + IntToString(nTemp) + "% of their value.";
            sString = AddLineBreak(sString);

            // markdown
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN);
            sString += "Merchants will buy items at " + IntToString(nTemp) + "% of their value.";
            break;
        case 29:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY);
            sString += "A Hireling will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 30:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY);
            sString += "A Monster Seller will appear in camp " + IntToString(nTemp) + "% of the time.";
            break;
        case 31:
            nTemp = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY);
            sString += "An unused spot in a camp will be decor " + IntToString(nTemp) + "% of the time.";
            break;
        case 32:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY);
            sString += "Treasure chests have a " + IntToString(nTemp) + "% chance of being active.";
            break;
        case 33:
        case 78:
        case 93:
        case 102:
        case 108:
            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE);
            sString += "Weapons have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE);
            sString += "Armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE);
            sString += "Accessories have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE);
            sString += "Consumables have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // miscellaneous frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE);
            sString += "Miscellaneous items have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 34:
        case 65:
        case 74:
            // melee weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_MELEE_PERCENTAGE);
            sString += "Melee weapons have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // ranged weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_RANGED_PERCENTAGE);
            sString += "Ranged weapons have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // ammunition frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_AMMUNITION_PERCENTAGE);
            sString += "Ammunition has a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 79:
        case 89:
            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_BODY_PERCENTAGE);
            sString += "Body armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // shield frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_SHIELD_PERCENTAGE);
            sString += "Shield have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 94:
        case 95:
        case 96:
        case 97:
        case 98:
        case 99:
        case 100:
        case 101:
            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_AMULET_PERCENTAGE);
            sString += "Amulets have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BELT_PERCENTAGE);
            sString += "Belts have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BOOTS_PERCENTAGE);
            sString += "Boots have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BRACER_PERCENTAGE);
            sString += "Bracers have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_CLOAK_PERCENTAGE);
            sString += "Cloaks have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_GLOVES_PERCENTAGE);
            sString += "Gloves have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_HELMET_PERCENTAGE);
            sString += "Helmets have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // accessory frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_RING_PERCENTAGE);
            sString += "Rings have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 103:
        case 104:
        case 105:
        case 106:
        case 107:
            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE);
            sString += "Grenades have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE);
            sString += "Wands have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE);
            sString += "Potions have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE);
            sString += "Scrolls have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // consumable frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_ROD_PERCENTAGE);
            sString += "Rods have a proportional chance of " + IntToString(nTemp) + ".";
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
            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BASTARDSWORD_PERCENTAGE);
            sString += "Bastard swords have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BATTLEAXE_PERCENTAGE);
            sString += "Battle axes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_CLUB_PERCENTAGE);
            sString += "Clubs have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DAGGER_PERCENTAGE);
            sString += "Daggers have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DIREMACE_PERCENTAGE);
            sString += "Dire maces have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DOUBLEAXE_PERCENTAGE);
            sString += "Double axes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DWARVENWARAXE_PERCENTAGE);
            sString += "Dwarven war axes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_GREATAXE_PERCENTAGE);
            sString += "Greataxes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_GREATSWORD_PERCENTAGE);
            sString += "Greatswords have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HALBERD_PERCENTAGE);
            sString += "Halberds have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HANDAXE_PERCENTAGE);
            sString += "Handaxes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HEAVYFLAIL_PERCENTAGE);
            sString += "Heavy flails have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KAMA_PERCENTAGE);
            sString += "Kamas have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KATANA_PERCENTAGE);
            sString += "Katanas have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_KUKRI_PERCENTAGE);
            sString += "Kukris have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTFLAIL_PERCENTAGE);
            sString += "Light flails have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTHAMMER_PERCENTAGE);
            sString += "Light hammers have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTMACE_PERCENTAGE);
            sString += "Light maces have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LONGSWORD_PERCENTAGE);
            sString += "Longswords have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_STAFF_PERCENTAGE);
            sString += "Staves have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_MORNINGSTAR_PERCENTAGE);
            sString += "Morningstars have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_RAPIER_PERCENTAGE);
            sString += "Rapiers have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SCIMITAR_PERCENTAGE);
            sString += "Scimitars have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SCYTHE_PERCENTAGE);
            sString += "Scythes have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTSPEAR_PERCENTAGE);
            sString += "Shortspears have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTSWORD_PERCENTAGE);
            sString += "Shortswords have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SICKLE_PERCENTAGE);
            sString += "Sickles have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_TWOBLADEDSWORD_PERCENTAGE);
            sString += "Two-bladed swords have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_WARHAMMER_PERCENTAGE);
            sString += "Warhammers have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_WHIP_PERCENTAGE);
            sString += "Whips have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 66:
        case 67:
        case 68:
        case 69:
        case 70:
        case 71:
        case 72:
        case 73:
            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_DART_PERCENTAGE);
            sString += "Darts have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_HEAVYCROSSBOW_PERCENTAGE);
            sString += "Heavy crossbows have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LIGHTCROSSBOW_PERCENTAGE);
            sString += "Light crossbows have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LONGBOW_PERCENTAGE);
            sString += "Longbows have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHORTBOW_PERCENTAGE);
            sString += "Shortbows have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SHURIKEN_PERCENTAGE);
            sString += "Shuriken have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SLING_PERCENTAGE);
            sString += "Slings have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_THROWINGAXE_PERCENTAGE);
            sString += "Throwing axes have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 75:
        case 76:
        case 77:
            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARROW_PERCENTAGE);
            sString += "Arrows have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BOLT_PERCENTAGE);
            sString += "Bolts have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // weapon frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_BULLET_PERCENTAGE);
            sString += "Bullets have a proportional chance of " + IntToString(nTemp) + ".";
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
            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CLOTH_PERCENTAGE);
            sString += "Cloth armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_PADDED_PERCENTAGE);
            sString += "Padded armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_LEATHER_PERCENTAGE);
            sString += "Leather armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HIDE_PERCENTAGE);
            sString += "Studded leather and hide armor have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_SCALE_PERCENTAGE);
            sString += "Chain shirts and scale mail have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CHAINMAIL_PERCENTAGE);
            sString += "Breastplates and chainmail have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_BANDED_PERCENTAGE);
            sString += "Splint mail and banded armor have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HALFPLATE_PERCENTAGE);
            sString += "Half-plate armor has a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // body armor frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_FULLPLATE_PERCENTAGE);
            sString += "Full-plate armor has a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 90:
        case 91:
        case 92:
            // shield frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_SMALLSHIELD_PERCENTAGE);
            sString += "Small shields have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // shield frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_LARGESHIELD_PERCENTAGE);
            sString += "Large shields have a proportional chance of " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // shield frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_TYPE_TOWERSHIELD_PERCENTAGE);
            sString += "Tower shields have a proportional chance of " + IntToString(nTemp) + ".";
            break;
        case 109:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL);
            sString += "Treasure is";
            if (nTemp != 0)
            {
                sString += " " + IntToString(nTemp);
                if ((nTemp == 1) || (nTemp == -1))
                {
                    sString += " level";
                } else
                {
                    sString += " levels";
                }
                if (nTemp < 0)
                {
                    sString += " lower than party level.";
                } else
                {
                    sString += " higher than party level.";
                }
            } else
            {
                sString += " equal to party level.";
            }
            break;
        case 110:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE);
            sString += "Treasure chests will drop treasure with " + IntToString(nTemp) + "% treasure value.";
            break;
        case 111:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY);
            sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a specific item.";
            break;
        case 112:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY);
            sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a recipe gem.";
            break;
        case 113:
            nTemp = GetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY);
            sString += "A treasure item has a " + IntToString(nTemp) + "% chance of being a gem recipe.";
            break;
        case 114:
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_SELECTION);
            sString += "Base unlock difficulty is set to " + IntToString(nTemp) + ".";
            break;
        case 115:
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_NUMBER);
            sString += "Unlock difficulty varies within +/-" + IntToString(nTemp) + ".";
            break;
        case 116:
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_DOOR_FREQUENCY);
            sString += "Each door has a " + IntToString(nTemp) + "% chance of being locked.";
            break;
        case 117:
            nTemp = GetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY);
            sString += "Each treasure chest has a " + IntToString(nTemp) + "% chance of being locked.";
            break;
        case 118:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_SELECTION);
            sString += "Base disarm difficulty is set to " + IntToString(nTemp) + ".";
            break;
        case 119:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER);
            sString += "Disarm difficulty varies within +/-" + IntToString(nTemp) + ".";
            break;
        case 120:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_FLOOR_FREQUENCY);
            sString += "Each floor trap has a " + IntToString(nTemp) + "% chance of being active.";
            break;
        case 121:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DOOR_FREQUENCY);
            sString += "Each door has a " + IntToString(nTemp) + "% chance of being trapped.";
            break;
        case 122:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_CHEST_FREQUENCY);
            sString += "Each treasure chest has a " + IntToString(nTemp) + "% chance of being trapped.";
            break;
        case 123:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_SELECTION);
            sString += "Base detect difficulty is set to " + IntToString(nTemp) + ".";
            break;
        case 124:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER);
            sString += "Detect difficulty varies within +/-" + IntToString(nTemp) + ".";
            break;
        case 125:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_SELECTION);
            sString += "Base saving throw difficulty is set to " + IntToString(nTemp) + ".";
            break;
        case 126:
            nTemp = GetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER);
            sString += "Saving throw difficulty varies within +/-" + IntToString(nTemp) + ".";
            break;
        case 127:
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_FREQUENCY);
            sString += "The chance of an active encounter waypoint is " + IntToString(nTemp) + "%.";
            break;
        case 128:
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
            sString += "Encounter difficulty is " + IntToString(nTemp) + " levels ";
            if (nTemp < 0)
            {
                sString += " lower than character level.";
            } else
            {
                sString += " higher than character level.";
            }
            break;
        case 129:
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY);
            sString += "Creatures will drop treasure " + IntToString(nTemp) + "% of the time.";
            break;
        case 130:
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE);
            sString += "Treasure dropped by creatures is " + IntToString(nTemp) + "% of normal treasure value.";
            break;
        case 131:
            sString += "Encounter creatures are always ";
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
            sString += GetLocalString(GetModule(), "sCreature" + IntToString(nTemp) + "NamePlural");
            sString += ".";
            break;
        case 132:
            sString += "Encounter creatures are always from ";
            nTemp = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_TYPE);
            sString += GetLocalString(GetModule(), "sTheme" + IntToString(nTemp) + "Name");
            sString += ".";
            break;
        case 133:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            if (nTemp > 0)
            {
                sString += "The final boss area for this dungeon is ";
                nTemp = GetLocalInt(GetModule(), "nBossAreas" + IntToString(nTemp));
                oTemp = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nTemp));
                sTemp = GetName(oTemp);
                sString += sTemp;
                sTemp = GetTag(oTemp);
                sString += " (" + sTemp + ").";
            } else
            {
                sString += "No final boss area selected for this dungeon.";
            }
            break;
        case 134:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_AREA_SELECTION);
            if (nTemp > 0)
            {
                sString += "The final boss area for this dungeon is ";
                nTemp = GetLocalInt(GetModule(), "nBossThemeSetAreas" + IntToString(nTemp));
                oTemp = GetLocalObject(GetModule(), "oAreaIdentifier" + IntToString(nTemp));
                sTemp = GetName(oTemp);
                sString += sTemp;
                sTemp = GetTag(oTemp);
                sString += " (" + sTemp + ").";
            } else
            {
                sString += "No final boss area selected for this dungeon.";
            }
            break;
        case 135:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_MINIBOSS_FREQUENCY);
            sString += "The chance of a miniboss waypoint being active is " + IntToString(nTemp) + "%.";
            break;
        case 136:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_GUARD_FREQUENCY);
            sString += "The chance of a boss guard waypoint being active is " + IntToString(nTemp) + "%.";
            break;
        case 137:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY);
            sString += "Bosses will drop treasure " + IntToString(nTemp) + "% of the time.";
            break;
        case 138:
            nTemp = GetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE);
            sString += "Treasure dropped by bosses is " + IntToString(nTemp) + "% of normal treasure value.";
            break;
        case 139:
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_FREQUENCY);
            sString += "The chance of a plot waypoint being active is " + IntToString(nTemp) + "%.";
            break;
        case 140:
        case 141:
        case 142:
        case 143:
        case 144:
        case 145:
        case 146:
            // type 1 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY);
            sString += "The proportional chance of a quest to kill creatures is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 2 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY);
            sString += "The proportional chance of a quest to clear areas of enemies is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 3 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY);
            sString += "The proportional chance of a quest to find items on creatures is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 4 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY);
            sString += "The proportional chance of a quest to find items in chests is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 5 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY);
            sString += "The proportional chance of a quest to explore areas is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 6 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY);
            sString += "The proportional chance of a quest to find a specific creature is " + IntToString(nTemp) + ".";
            sString = AddLineBreak(sString);

            // type 7 quest frequency
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY);
            sString += "The proportional chance of a quest to find a specific object is " + IntToString(nTemp) + ".";
            break;
        case 147:
            nTemp = GetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE);
            sString += "Plot rewards are " + IntToString(nTemp) + "% of normal reward value.";
            break;
        case 148:
            nTemp = GetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY);
            sString += "Players will lose " + IntToString(nTemp) + "% of their ";

            bGold;
            bExperience;
            bItem;

            nTemp = GetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY);
            if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD)
            {
                bGold = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE)
            {
                bExperience = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_INVENTORY)
            {
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD_EXPERIENCE)
            {
                bGold = TRUE;
                bExperience = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_GOLD_INVENTORY)
            {
                bGold = TRUE;
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE_INVENTORY)
            {
                bExperience = TRUE;
                bItem = TRUE;
            } else if (nTemp == ID1_DEATH_RESPAWN_PENALTY_ALL)
            {
                bGold = TRUE;
                bExperience = TRUE;
                bItem = TRUE;
            }

            if (bGold == TRUE)
            {
                sString += "gold";
                if ((bExperience == TRUE) && (bItem == TRUE))
                {
                    sString += ", ";
                } else if ((bExperience == TRUE) || (bItem == TRUE))
                {
                    sString += " and ";
                }
            }

            if (bExperience == TRUE)
            {
                sString += "experience";
                if (bItem == TRUE)
                {
                    sString += " and ";
                }
            }

            if (bItem == TRUE)
            {
                sString += "items";
            }
            sString += ".";
            break;
        case 149:
            nTemp = GetModuleFlagValue(ID1_FLAG_PLAYER_RESPAWN_HEALTH);
            sString += "Players who respawn will be restored to " + IntToString(nTemp) + "% of their health.";
            break;
        case 150:
            nTemp = GetModuleFlagValue(ID1_FLAG_COMBAT_ONELINER_FREQUENCY);
            sString += "Creatures have a " + IntToString(nTemp) + "% chance of saying a combat one-liner each round.";
            break;
        case 151:
            nTemp = GetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE);
            sString += "The value of a puzzle treasure reward is " + IntToString(nTemp) + "% of normal.";
            break;
    }

    SetCustomToken(5100, sString);

    return TRUE;
}
