//::///////////////////////////////////////////////
//:: Name Infinate Dungeon Sub System Constants
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This library file should contain every constant used in the module.
This is both for reference and easy modification of the entire module.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: July 14, 2005
//:://////////////////////////////////////////////

///////////////////////// ENCOUNTER TABLE CONSTANTS ////////////////////////////

const int MULTI_THIRD =                         -3;
const int MULTI_HALF =                          -2;
const int MULTI_TWO_THIRDS =                    -1;
const int MULTI_NONE  =                         0;
const int MULTI_THREE_HALVES =                  1;
const int MULTI_DOUBLE =                        2;
const int MULTI_TRIPLE =                        3;
const int MULTI_QUAD =                          4;
const int MULTI_OCTO =                          5;

const int CR_HALF =                             0;
const int CR_THIRD =                            -1;
const int CR_QUARTER =                          -2;
const int CR_EIGHTH =                           -3;

const int THEME_NONE =                          -1; // Creatures that really don't belong in a particular theme but could appear in any. Dire Animals as an example.
const int THEME_ALL =                           0;  // Everything.
const int THEME_BANDIT =                        1; // Pretty much PC playable classes fighting the PCs.
const int THEME_BEHOLDER =                      2; // Currently rounded out with playable races. Almost resembles cultists at low levels.
const int THEME_CONSTRUCT =                     3; // None exist below CR 3
const int THEME_CULTIST =                       4; // Resembles bandits.... Need to work on this somehow.
const int THEME_DARKFEY =                       5; // Currently resembles underdark. Make some dark fey templates.
const int THEME_DEMON =                         6; // Pretty much all the evil outsiders.
const int THEME_DRAGON =                        7; // None exist below CR 12.
const int THEME_GIANTS =                        8; // None exist below CR 3.
const int THEME_HUMANOIDS =                     9; // Goblins and Gnolls and Orcs Oh My!
const int THEME_ILLUSION =                      10; // CURRENTLY UNUSED! Not sure what to put here....
const int THEME_VERMIN =                        11; // Rats and bugs.
const int THEME_SHAPECHANGER =                  12; // THIS REALLY NEEDS SOME WORK
const int THEME_REPTILES =                      13; // Trogs and Lizardmen
const int THEME_UNDEAD_SKEL =                   14; // Long dead bodies and ghosts.
const int THEME_UNDEAD_FLESH =                  15; // Newer dead and ghosts.
const int THEME_UNDERDWELLERS =                 16; // Things that live in the underdark.

const string ENCOUNTER_2DA =                            "id_encounter";     // 2da name
//2da columns
const string ENCOUNTER2DA_COLUMN_NAME =                 "Name";
const string ENCOUNTER2DA_COLUMN_CR =                   "CR";
const string ENCOUNTER2DA_COLUMN_MAX_CR =               "Max_CR";
const string ENCOUNTER2DA_COLUMN_RESREF =               "ResRef";
const string ENCOUNTER2DA_COLUMN_MAX_HD =               "Max_HD";
const string ENCOUNTER2DA_COLUMN_BASE_HD =              "BaseHD";
const string ENCOUNTER2DA_COLUMN_THEME_NONE =           "NonTheme";         // Creatures that really don't belong in a particular theme but could appear in any. Dire Animals as an example.
const string ENCOUNTER2DA_COLUMN_THEME_ALL =            "MiscTheme";        // Everything.
const string ENCOUNTER2DA_COLUMN_THEME_BANDIT =         "BanditTheme";      // Pretty much PC playable classes fighting the PCs.
const string ENCOUNTER2DA_COLUMN_THEME_BEHOLDER =       "BeholderTheme";    // Currently rounded out with playable races. Almost resembles cultists at low levels.
const string ENCOUNTER2DA_COLUMN_THEME_CONSTRUCT =      "ConstructTheme";   // None exist below CR 3
const string ENCOUNTER2DA_COLUMN_THEME_CULTIST =        "CultistTheme";     // Resembles bandits.... Need to work on this somehow.
const string ENCOUNTER2DA_COLUMN_THEME_DARKFEY =        "DarkFeyTheme";     // Currently resembles underdark. Make some dark fey templates.
const string ENCOUNTER2DA_COLUMN_THEME_DEMON =          "DemonsTheme";      // Pretty much all the evil outsiders.
const string ENCOUNTER2DA_COLUMN_THEME_DRAGON =         "DragonsTheme";     // None exist below CR 12.
const string ENCOUNTER2DA_COLUMN_THEME_GIANTS =         "GiantsTheme";      // None exist below CR 3.
const string ENCOUNTER2DA_COLUMN_THEME_HUMANOIDS =      "HumanoidsTheme";   // Goblins and Gnolls and Orcs Oh My!
const string ENCOUNTER2DA_COLUMN_THEME_ILLUSION =       "IllusionTheme";    // CURRENTLY UNUSED! Not sure what to put here....
const string ENCOUNTER2DA_COLUMN_THEME_VERMIN =         "VermineTheme";     // Rats and bugs.
const string ENCOUNTER2DA_COLUMN_THEME_SHAPECHANGER =   "ShapechangerTheme";// THIS REALLY NEEDS SOME WORK
const string ENCOUNTER2DA_COLUMN_THEME_REPTILES =       "RetilesTheme";     // Trogs and Lizardmen
const string ENCOUNTER2DA_COLUMN_THEME_UNDEAD_SKEL =    "UndeadSkelTheme";  // Long dead bodies and ghosts.
const string ENCOUNTER2DA_COLUMN_THEME_UNDEAD_FLESH =   "UndeadFleshyTheme";// Newer dead and ghosts.
const string ENCOUNTER2DA_COLUMN_THEME_UNDERDWELLERS =  "UnderdwellersThere";


// Local Variables
const string CACHE_THEME =                              "THEME_CACHE";       //Module Local Variable
const string CACHE_ENCOUNTER2DA_MAX_ENTRY =             "ID_ENCOUNTER_MAX"; // Module Local Variable
const string CREATURE_EL =                              "CREATURE_EL";      // Creature Local Variable
const string CREATURE_2DA_ENTRY =                       "CREATURE_ENTRY";   // Creature Local Variable

//Obsolete Needs to removed from code and encounter 2da.
const string NAME_CON_COLUMN_LEVEL_UP_CLASS =   "LevelUpClass";
const string NAME_CON_COLUMN_LEVEL_UP_PACKAGE = "LevelUpPack";


// ------------------------------ Package Constants ----------------------------
// PC Class Packages
// These packages concentrate on combat skills.
const int PACKAGE_BARBARIAN_ENEMY =                     131;
const int PACKAGE_BARD_ENEMY =                          132;
const int PACKAGE_CLERIC_LLOTH =                        133;  // Underdark dwellers
const int PACKAGE_CLERIC_MAGLUBIYET =                   134;  // Goblins
const int PACKAGE_CLERIC_ERYTHNUL =                     135;  // Gnolls
const int PACKAGE_CLERIC_GRUUMSH =                      136;  // Orcs
const int PACKAGE_CLERIC_LAOGZED =                      137;  // Reptiles
const int PACKAGE_CLERIC_MERRSHAULK =                   138;  // Yaun-ti
const int PACKAGE_DRUID_ENEMY =                         139;
const int PACKAGE_FIGHTER_ENEMY =                       140;
const int PACKAGE_FIGHTER_DEX_ENEMY =                   141;
const int PACKAGE_MONK_ENEMY =                          142;
const int PACKAGE_PALADIN_ENEMY =                       143;
const int PACKAGE_RANGER_ENEMY =                        144;
const int PACKAGE_ROGUE_ENEMY =                         145;
const int PACKAGE_SORCERER_ENEMY =                      146;
const int PACKAGE_WIZARD_ENEMY =                        147;


// Non PC class packages.
// These packages concentrate on Spot and Listen.
const int PACKAGE_ABERATION_GUARDIAN =                  148;
const int PACKAGE_ANIMAL_GUARDIAN =                     149;
const int PACKAGE_CONSTRUCT_GUARDIAN =                  150;
const int PACKAGE_HUMANOID_GUARDIAN =                   151;
const int PACKAGE_MONTROUS_GUARDIAN =                   152;
const int PACKAGE_ELEMENTAL_GUARDIAN =                  153;
const int PACKAGE_FEY_GUARDIAN =                        154;
const int PACKAGE_DRAGON_GUARDIAN =                     155;
const int PACKAGE_UNDEAD_GUARDIAN =                     156;
const int PACKAGE_COMMONER_GUARDIAN =                   157;
const int PACKAGE_BEAST_GUARDIAN =                      158;
const int PACKAGE_GIANT_GUARDIAN =                      159;
const int PACKAGE_MAGICBEAST_GUARDIAN =                 160;
const int PACKAGE_OUTSIDER_GUARDIAN =                   161;
const int PACKAGE_SHAPECHANGER_GUARDIAN =               162;
const int PACKAGE_VERMIN_GUARDIAN =                     163;
const int PACKAGE_OOZE_GUARDIAN =                       164;

// Base class packages.
// Used to level up the creature back to it's base class.
const int PACKAGE_BARBARIAN_NONE =                      165;
const int PACKAGE_BARD_NONE =                           166;
const int PACKAGE_CLERIC_NONE =                         167;
const int PACKAGE_DRUID_NONE =                          168;
const int PACKAGE_FIGHTER_NONE =                        169;
const int PACKAGE_MONK_NONE =                           170;
const int PACKAGE_PALADIN_NONE =                        171;
const int PACKAGE_RANGER_NONE =                         172;
const int PACKAGE_ROGUE_NONE =                          173;
const int PACKAGE_SORCERER_NONE =                       174;
const int PACKAGE_WIZARD_NONE =                         175;
const int PACKAGE_ABERATION_NONE =                      176;
const int PACKAGE_ANIMAL_NONE =                         177;
const int PACKAGE_CONSTRUCT_NONE =                      178;
const int PACKAGE_HUMANOID_NONE =                       179;
const int PACKAGE_MONTROUS_NONE =                       180;
const int PACKAGE_ELEMENTAL_NONE =                      181;
const int PACKAGE_FEY_NONE =                            182;
const int PACKAGE_DRAGON_NONE =                         183;
const int PACKAGE_UNDEAD_NONE =                         184;
const int PACKAGE_COMMONER_NONE =                       185;
const int PACKAGE_BEAST_NONE =                          186;
const int PACKAGE_GIANT_NONE =                          187;
const int PACKAGE_MAGICBEAST_NONE =                     188;
const int PACKAGE_OUTSIDER_NONE =                       189;
const int PACKAGE_SHAPECHANGER_NONE =                   190;
const int PACKAGE_VERMIN_NONE =                         191;
const int PACKAGE_OOZE_NONE =                           192;

const string HAS_LEVEL_UP_CLASS =                       "HAS_LEVEL_UP_CLASS"; // This is a creature switch it can be set to TRUE or FALSE.
const string LEVEL_UP_CLASS =                           "LEVEL_UP_CLASS"; // This is that must be set if HAS_LEVEL_UP_CLASS been set to TRUE. This variable must match the int value of the class to be gained.
const string HAS_LEVEL_UP_CLASS_2 =                     "HAS_LEVEL_UP_CLASS"; // This is a creature switch it can be set to TRUE or FALSE.
const string LEVEL_UP_CLASS_2 =                         "LEVEL_UP_CLASS"; // This is that must be set if HAS_LEVEL_UP_CLASS been set to TRUE. This variable must match the int value of the class to be gained.

//////////////////////////// TREASURE TABLE CONSTANTS //////////////////////////

// ------------------------- TREASURE CATAGORIES ----------------------------
const int TREASURE_CATAGORY_INVALID     = 0;
const int TREASURE_CATAGORY_MINOR       = 1; // Levels 1 - 16
const int TREASURE_CATAGORY_MED         = 2; // Levels 6 - 21
const int TREASURE_CATAGORY_MAJOR       = 3; // Levels 10 - 25
const int TREASURE_CATAGORY_EPIC        = 4; // Levels 20 - 40

// ----------------------RANDOM ITEM CREATION 2DA CONSTANTS -------------------


const string RESREF_ITEM_GOLD = "nw_it_gold001";
const string RESREF_BLANK_SCROLL = "scroll";
const string RESREF_BLANK_WAND = "magicwand";// NOTE: Need to create this.
const string TAG_PREFIX_GEM = "ID_GEM_";

const string LOOT_ARMOR_2DA             = "ID_Armor";
const string LOOT_ITEM_BONUS_2DA        = "ID_ItemBonus";
const string LOOT_ITEM_BONUS2_2DA       = "id_enhance_bonus";
const string LOOT_MISC_MAGIC_2DA        = "ID_MiscMagic";
const string LOOT_MISC_MUNDANE_2DA      = "ID_MiscMundane";
const string LOOT_POTION_2DA            = "ID_Potions";
const string LOOT_RING_2DA              = "ID_Rings";
const string LOOT_ROD_2DA               = "ID_Rods";
const string LOOT_SCROLL_2DA            = "ID_Scrolls";
const string LOOT_STAFF_2DA             = "ID_Staff";
const string LOOT_WAND_2DA              = "ID_Wands";
const string LOOT_WEAPON_2DA            = "ID_Weapon";

const string D100_TABLE_RANDOM_GEM                              = "Table75";
//const string D100_TABLE_RANDOM_ART                              = "Table76";  //Consider dumping this completely.

const string D100_TABLE_RANDOM_MUNDANE_ITEM                     = "Table77";
const string D100_TABLE_RANDOM_MIGHTY_SHORT_BOW                 = "Table78";
const string D100_TABLE_RANDOM_MIGHTY_LONG_BOW                  = "Table79";

const string D100_TABLE_RANDOM_MAGIC_ARMOR                      = "Table83";
const string D100_TABLE_RANDOM_ARMOR_TYPE                       = "Table84";
const string D100_TABLE_RANDOM_MAGIC_ARMOR_TYPE                 = "Table84a";
const string D100_TABLE_RANDOM_SHIELD_TYPE                      = "Table85";
const string D100_TABLE_RANDOM_MAGIC_SHIELD_TYPE                = "Table85a";
const string D100_TABLE_RANDOM_MAGIC_WEAPON                     = "Table810";

const string D100_TABLE_RANDOM_WEAPON                           = "Table811";
const string D100_TABLE_RANDOM_WEAPON_MAGIC                     = "Table811a";
const string D100_TABLE_RANDOM_COMMON_MELEE_WEAPON              = "Table812";
const string D100_TABLE_RANDOM_MAGIC_COMMON_MELEE_WEAPON        = "Table812a";
// This actually includes thrown weapons
const string D100_TABLE_RANDOM_UNCOMMON_MELEE_WEAPON            = "Table813";
const string D100_TABLE_RANDOM_MAGIC_UNCOMMON_MELEE_WEAPON      = "Table813a";

// This actually includes thrown weapons
const string D100_TABLE_RANDOM_RANGED_WEAPON                    = "Table814";
const string D100_TABLE_RANDOM_AMMUNITION                       = "Table814a";// Subtable of 8-14
const string D100_TABLE_RANDOM_MAGIC_RANGED_WEAPON              = "Table814b";
const string D100_TABLE_RANDOM_MAGIC_AMMUNITION                 = "Table814c";// Sub Table of 8-14b
const string D100_TABLE_RANDOM_POTION                           = "Table818";
const string D100_TABLE_RANDOM_RING                             = "Table819";
const string D100_TABLE_RANDOM_ROD                              = "Table820";
const string D100_TABLE_RANDOM_SCROLL                           = "Table821";
const string D100_TABLE_RANDOM_ARCANE_SPELL                     = "Table824"; // NOTE: In order for this constant to work a String Int 1 to 9 must be added to right end.
const string D100_TABLE_RANDOM_DIVINE_SPELL                     = "Table825"; // NOTE: In order for this constant to work a String Int 1 to 9 must be added to right end.
const string D100_TABLE_RANDOM_STAFF                            = "Table826";
const string D100_TABLE_RANDOM_WAND                             = "Table827";
const string D100_TABLE_RANDOM_WONDEROUS_MINOR                  = "Table828";
const string D100_TABLE_RANDOM_WONDEROUS_MEDIUM                 = "Table829";
const string D100_TABLE_RANDOM_WONDEROUS_MAJOR                  = "Table830";
const string D100_TABLE_RANDOM_WONDEROUS_EPIC                   = "Table831";
// This is a special table used by both armor and weapons.
// It is very rarely used.
const string D100_TABLE_RANDOM_SPECIAL_EPIC_WEAPON_ARMOR_BONUS  = "Weapon_Armor_EB"; // Geez long constant name....

const string D100_TABLE_RESULT_RANDOM_SCROLL_TYPE_ARCANE        = "Arcane";


                    //////// LOOT SYSTEM 2 CONSTANTS ////////

const int ITEM_PROPERTY_TYPE_INVALID = -1;

// These constants are returned by the Get2daBonusColumn function.
// They are used to assign the proper scaled bonus to an item.

const string ARMOR_BONUS_MINOR_COLUMN       = "Armor_Minor";    // Bonus 1 - 2
const string ARMOR_BONUS_MEDIUM_COLUMN      = "Armor_Medium";   // Bonus 1 - 4
const string ARMOR_BONUS_MAJOR_COLUMN       = "Armor_Major";    // Bonus 3 - 5
const string ARMOR_BONUS_EPIC_COLUMN        = "Armor_Epic";     // Bonus 1 - 10

const string WEAPON_BONUS_MINOR_COLUMN      = "Weapon_Minor";   // Bonus 1 - 2
const string WEAPON_BONUS_MEDIUM_COLUMN     = "Weapon_Medium";  // Bonus 1 - 4
const string WEAPON_BONUS_MAJOR_COLUMN      = "Weapon_Major";   // Bonus 3 - 5
const string WEAPON_BONUS_EPIC_COLUMN       = "Weapon_Epic";    // Bonus 1 - 10

// Used by item properties that can have a range of 1-5, 1-10 and 1-12
const string SPECIAL_BONUS_12_MINOR_COLUMN  = "SB12_Low";       // Bonus 1 - 3
const string SPECIAL_BONUS_12_MEDIUM_COLUMN = "SB12_Medium";    // Bonus 1 - 5
const string SPECIAL_BONUS_12_MAJOR_COLUMN  = "SB12_Major";     // Bonus 2 - 5
const string SPECIAL_BONUS_12_EPIC_COLUMN   = "SB12_Epic";      // Bonus 3 - 5
const string EPIC_12_EB                     = "SB12_EB";        // Bonus 6 - 12

// Used to determine a spell level. Is meant for Bonus Spells but canbe used for scrolls.
const string SPELL_LEVEL_MINOR_COLUMN       = "Table823a";      // Levels 1 - 3
const string SPELL_LEVEL_MEDIUM_COLUMN      = "Table823b";      // Levels 2 - 5
const string SPELL_LEVEL_MAJOR_COLUMN       = "Table823c";      // Levels 4 - 9
const string SPELL_LEVEL_EPIC_COLUMN        = "Table823d";      // Levels 6 - 9  This table not canon. This is because NWN does not support 10+ level spells.

// These tables are used to return a damage constant.
const string DAMAGE_BONUS_MINOR_COLUMN      = "Damage_Minor";       // This table not supported by DMG
const string DAMAGE_BONUS_MEDIUM_COLUMN     = "Damage_Medium";      // This table not supported by DMG
const string DAMAGE_BONUS_MAJOR_COLUMN      = "Damage_Major";       // This table not supported by DMG
const string DAMAGE_BONUS_EPIC_COLUMN       = "Damage_Epic";        // This table not supported by DMG
const string DAMAGE_BONUS_EPIC_EB           = "Damage_Epic_EB";     // This table not supported by DMG

// These tables are used to return a skill bonus. These tables may need serious work.
const string SKILL_BONUS_MINOR_COLUMN       = "Skill_Bonus_Minor";  // This table not supported by DMG
const string SKILL_BONUS_MEDIUM_COLUMN      = "Skill_Bonus_Medium"; // This table not supported by DMG
const string SKILL_BONUS_MAJOR_COLUMN       = "Skill_Bonus_Major";  // This table not supported by DMG
const string SKILL_BONUS_EPIC_COLUMN        = "Skill_Bonus_Epic";   // This table not supported by DMG
const string SKILL_BONUS_EPIC_EB            = "Skill_Bonus_EB";     // This table not supported by DMG

// This constant is used in the tables to denote that a SPECIAL table should be used to determine the epic bonus.
const string D100_TABLE_RESULT_EPIC_SPECIAL = "EB";

///////////////////// MISC NAMING CONVENTION CONSTANTS /////////////////////////
const string NAME_CON_AREA              = "Area";
const string NAME_CON_MAP_TILE          = "tile";
const string NAME_CON_MAP_OBJECT_TAG    = "MapObject";
const string NAME_CON_DO_ONCE           = "DoOnce";
const string NAME_CON_2DA_RACIAL_CLASS  = "RacialClass_";
//////////////////////// TEMP VARIABLE CONSTANTS ///////////////////////////////
const string TEMPORARY                  = "Temp";
const string TEMPORARY2                 = "Temp2";
const string TEMPORARY_MULTIPLIER       = "TempMulti";
const string TEMPORARY_RESREF           = "TempResRef";
const string TEMPORARY_MAX_CR           = "TempMaxCR";
const string TEMPORARY_MAX_HD           = "TempMaxHD";
const string TEMPORARY_2DA_REF          = "Temp2daRef";
const string TEMPORARY_THEME            = "Theme";

///////////////// MYSTIC FORGE ITEM UPGRADE SYSTEM CONSTANTS /////////////////

//2das
const string ITEMPROPS_2DA                      = "itemprops";

//SetLocal GetLocal
const string MYSTIC_FORGE_POWER_CAT             = "CAT_";           //Int
const string MYSTIC_FORGE_TEMP                  = "MF_Temp";        //Int
const string MYSTIC_FORGE_POWER                 = "MF_Power";       //Int
const string MYSTIC_FORGE_SUBPOWER              = "MF_SubPower";    //Int
const string MYSTIC_FORGE_PARAM1                = "MF_Param1";      //Int
const string MYSTIC_FORGE_BONUS                 = "MF_Bonus";       //Int
const string MYSTIC_FORGE_ITEM                  = "MF_Item_Ref";    //Object
const string ID_FORGE_USES_LEFT                 = "nForgeUsesRemaining";//Int
const string ID_FORGE_IP_STRING                 = "sForgeIPString"; //String
const string ID_FORGE_RECIPES                   = "nRecipe";        //Int
const string ID_FORGE_RECIPE_OBJECT             = "oRecipe";        //Object
const string CUSTOM_TOKEN_USED                  = "sCTUsed";        //String
const string ID_FORGE_PREVIOUS                  = "nPrevious";
const int    CUSTOM_TOKEN_BASE                  = 1000;
const string TOKEN_MENU_NUMBER                  = "nMenuNumber"; // int
const string MYSTIC_FORGE_CONVERSATION          = "nMF_Conv";//Int
const string MYSTIC_FORGE_TOKEN_AVAILABLE       = "+++ ";
const string MYSTIC_FORGE_TOKEN_UNAVAILABLE     = "--- ";
const string MYSTIC_FORGE_TOKEN_MISSING         = "000 ";
const string TOKEN_MENU_ITEM_DISABLED           = "ForgeMenuItemDisabled";
const string TOKEN_MENU_ITEM_MISSING            = "ForgeMenuItemMissing";
//ResRefs
const string RESREF_OBJECT_CREATION_CONTAINER   = "item_creation";

//Tags
const string TAG_OBJECT_CREATION_CONTAINER      = "inventory";
const string ID_RECIPE_TAG_PREFIX = "ID_MFR_";
