//:://////////////////////////////////////////////////////////////
//:: inc_id1_flags                                              //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
        This script is a collection of functions for manipulating
        module flags, as well as the constants defining those
        flags.
*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: August 2005                                    //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Dungeon Parameters                                           //
//////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////
    // Generic Values                                               //
    //////////////////////////////////////////////////////////////////

const int ID1_FREQUENCY_NONE = 10; // never occurs
const int ID1_FREQUENCY_RANDOM_PARTIAL = 20; // occurs a random percentage of times, up to a specified number
const int ID1_FREQUENCY_RANDOM_ALL = 25; // occurs a random percentage of times, up to 100%
const int ID1_FREQUENCY_FIXED_PARTIAL = 30; // occurs a specified percentage of the time
const int ID1_FREQUENCY_FIXED_ALL = 35; // occurs all the time
// Value: the specified percentage

const int ID1_ACTIVE = 10; // active
const int ID1_INACTIVE = 20; // inactive



    //////////////////////////////////////////////////////////////////
    // Theme                                                        //
    //////////////////////////////////////////////////////////////////

// type of theme
const string ID1_FLAG_THEME_TYPE = "nFlagThemeType";
const int ID1_THEME_TYPE_SINGLETHEME = 10; // a single theme for the dungeon is chosen
const int ID1_THEME_TYPE_THEMESET = 20; // a theme set for the dungeon is chosen

const string ID1_FLAG_THEME_SELECTION = "nFlagThemeSelection";
const int ID1_THEME_SELECTION_SPECIFIC = 10; // the theme or theme set is chosen specifically
const int ID1_THEME_SELECTION_RANDOM = 20; // the theme or theme set is chosen randomly
// value: the specific theme or theme set chosen (1-X)

    //////////////////////////////////////////////////////////////////
    // Dungeon Layout                                               //
    //////////////////////////////////////////////////////////////////

// number of stairs up and down
const string ID1_FLAG_STAIRS_NUMBER = "nFlagStairsNumber";
const int ID1_STAIRS_NUMBER_FIXED = 10; // the maximum number of stairs will always be spawned if possible
const int ID1_STAIRS_NUMBER_RANDOM = 20; // the number of stairs from the level will be anywhere up to the maximum
// Value: The maximum number of staircases per level. (1-10)

// dungeon depth
const string ID1_FLAG_DUNGEON_DEPTH = "nFlagDungeonDepth";
const int ID1_DUNGEON_DEPTH_FIXED = 10; // the dungeon depth is fixed to a specific number
const int ID1_DUNGEON_DEPTH_RANDOM = 20; // the dungeon depth a random number up to the specified number
// Value: The maximum depth of the dungeon. (1-20)

// maximum x coordinate
const string ID1_FLAG_DUNGEON_MAXIMUM_X = "nFlagDungeonMaximumX";
// Value: The maximum X extent of the dungeon. (1-20)

// maximum y coordinate
const string ID1_FLAG_DUNGEON_MAXIMUM_Y = "nFlagDungeonMaximumY";
// Value: The maximum Y extent of the dungeon. (1-20)

// one exit area chance
const string ID1_FLAG_DUNGEON_ONE_EXIT = "nFlagDungeonOneExit";
// Value: The proportional percentage chance of a one exit area. (1-100)

// two exit area chance
const string ID1_FLAG_DUNGEON_TWO_EXIT = "nFlagDungeonTwoExit";
// Value: The proportional percentage chance of a two exit area. (1-100)

// three exit area chance
const string ID1_FLAG_DUNGEON_THREE_EXIT = "nFlagDungeonThreeExit";
// Value: The proportional percentage chance of a three exit area. (1-100)

// four exit area chance
const string ID1_FLAG_DUNGEON_FOUR_EXIT = "nFlagDungeonFourExit";
// Value: The proportional percentage chance of a four exit area. (1-100)

    //////////////////////////////////////////////////////////////////
    // Map                                                          //
    //////////////////////////////////////////////////////////////////

// map item usage
const string ID1_FLAG_MAP_AUTOCLEANUP = "nFlagMapAutoCleanUp";
// active/inactive

// map display
const string ID1_FLAG_MAP_DISPLAY = "nFlagMapDisplay";
const int ID1_MAP_DISPLAY_ALL = 10; // show the entire map all the time
const int ID1_MAP_DISPLAY_PARTY = 20; // show everything your party has seen
const int ID1_MAP_DISPLAY_SELF = 30; // show only what you've seen

// map boundaries
const string ID1_FLAG_MAP_BOUNDARY = "nFlagMapBoundary";
const int ID1_MAP_BOUNDARY_HIDE = 10; // do not show the outside edge of the map
const int ID1_MAP_BOUNDARY_SHOW_FULL = 20; // show the full extent of the map
const int ID1_MAP_BOUNDARY_SHOW_EXTENTS = 25; // show unexplored areas on the map

    //////////////////////////////////////////////////////////////////
    // Decor                                                        //
    //////////////////////////////////////////////////////////////////

// decor spawn frequency
const string ID1_FLAG_DECOR_FREQUENCY = "nFlagDecorFrequency";
// Value: the percentage chance of any individual decor point being active (0-100)

    //////////////////////////////////////////////////////////////////
    // Secret Doors                                                 //
    //////////////////////////////////////////////////////////////////

// secret door frequency
const string ID1_FLAG_SECRET_DOOR_FREQUENCY = "nFlagSecretDoorFrequency";
// Value: the percentage chance of any individual secret door being active (0-100)

// secret door difficulty number
const string ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER = "nFlagSecretDoorDifficultyNumber";
const int ID1_SECRET_DOOR_DIFFICULTY_NUMBER_FIXED = 10;
const int ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM = 20;
// value: the amount the difficult number can vary by

// secret door difficulty number
const string ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION = "nFlagSecretDoorDifficultySelection";
const int ID1_SECRET_DOOR_DIFFICULTY_SELECTION_LEVEL = 10;
const int ID1_SECRET_DOOR_DIFFICULTY_SELECTION_SET = 20;
// Value: the set difficulty of secret door detection

// secret encounter frequency
const string ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY = "nFlagSecretEncounterFrequency";
// Value: the percentage chance of any individual secret encounter point being active (0-100)

// secret treasure frequency
const string ID1_FLAG_SECRET_TREASURE_FREQUENCY = "nFlagSecretTreasureFrequency";
// Value: the percentage chance of any individual secret treasure point being active (0-100)

    //////////////////////////////////////////////////////////////////
    // Puzzles                                                      //
    //////////////////////////////////////////////////////////////////

// puzzle frequency
const string ID1_FLAG_PUZZLE_FREQUENCY = "nFlagPuzzleFrequency";
// Value: the percentage chance of any individual puzzle point being active (0-100)

// puzzle difficulty
const string ID1_FLAG_PUZZLE_DIFFICULTY = "nFlagPuzzleDifficulty";
const int ID1_PUZZLE_DIFFICULTY_EASY = 10; // the puzzles that are spawned are of easy difficulty
const int ID1_PUZZLE_DIFFICULTY_NORMAL = 20; // the puzzles that are spawned are of normal difficulty
const int ID1_PUZZLE_DIFFICULTY_HARD = 30; // the puzzles that are spawned are of hard difficulty

// puzzle reward percentages
const string ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE = "nFlagPuzzleRewardAreaPercentage";
// Value: the percentage chance of any individual puzzle reward being activating a secret area (0-100)

const string ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE = "nFlagPuzzleRewardTreasurePercentage";
// Value: the percentage chance of any individual puzzle reward being treasure (0-100)

const string ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE = "nFlagPuzzleRewardExperiencePercentage";
// Value: the percentage chance of any individual puzzle reward being experience (1-100)

// treasure chest value percentage (0-500)
const string ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE = "nFlagPuzzleRewardTreasureValue";

    //////////////////////////////////////////////////////////////////
    // Camps                                                        //
    //////////////////////////////////////////////////////////////////

// encampment frequency
const string ID1_FLAG_CAMP_FREQUENCY = "nFlagCampFrequency";
// Value: the percentage chance of any individual active puzzle point being a camp (0-100)

// rest tent frequency
const string ID1_FLAG_CAMP_NODE_REST_FREQUENCY = "nFlagCampNodeRestFrequency";
// Value: the percentage chance of a camp containing a rest tent node (0-100)

// forge frequency
const string ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY = "nFlagCampNodeForgeFrequency";
// Value: the percentage chance of a camp containing a forge node (0-100)

// caster frequency
const string ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY = "nFlagCampNodeCasterFrequency";
// Value: the percentage chance of a camp containing a spellcaster node (0-100)

// store frequency
const string ID1_FLAG_CAMP_NODE_STORE_FREQUENCY = "nFlagCampNodeStoreFrequency";
// Value: the percentage chance of a camp containing a merchant node (0-100)

// store gold limit
const string ID1_FLAG_CAMP_NODE_STORE_GOLD = "nFlagCampNodeStoreGold";
const int ID1_CAMP_NODE_STORE_GOLD_LIMITED = 10; // limited according to player level
const int ID1_CAMP_NODE_STORE_GOLD_UNLIMITED = 20; // no limit

// store markup adjustment
const string ID1_FLAG_CAMP_NODE_STORE_MARKUP = "nFlagCampNodeStoreMarkUp";
// Value: the percentage of an items value that stores will sell at

// store markdown adjustment
const string ID1_FLAG_CAMP_NODE_STORE_MARKDOWN = "nFlagCampNodeStoreMarkDown";
// Value: the percentage of an items value that stores will buy at

// follower frequency
const string ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY = "nFlagCampNodeHirelingFrequency";
// Value: the percentage chance of a camp containing a hireling node (0-100)

// monster seller frequency
const string ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY = "nFlagCampNodeSellerFrequency";
// Value: the percentage chance of a camp containing a monster seller node (0-100)

// decor node frequency
const string ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY = "nFlagCampNodeDecorFrequency";
// Value: the percentage chance of an unused camp node being decor (0-100)

    //////////////////////////////////////////////////////////////////
    // Treasure                                                     //
    //////////////////////////////////////////////////////////////////

// treasure frequency (0-100)
const string ID1_FLAG_TREASURE_FREQUENCY = "nFlagTreasureFrequency";

// treasure level (-40 to 40)
const string ID1_FLAG_TREASURE_LEVEL = "nFlagTreasureLevel";

// treasure chest value percentage (0-500)
const string ID1_FLAG_TREASURE_CHEST_VALUE = "nFlagTreasureValue";

// specific item frequency (0-100)
const string ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY = "nFlagTreasureSpecificItemFrequency";

// gem frequency (0-100)
const string ID1_FLAG_TREASURE_GEM_FREQUENCY = "nFlagTreasureGemFrequency";

// recipe frequency (0-100)
const string ID1_FLAG_TREASURE_RECIPE_FREQUENCY = "nFlagTreasureRecipeFrequency";

// item type frequency flags
const string ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE = "nFlagCategoryWeaponPercentage"; // weapons
    const string ID1_FLAG_SUBCATEGORY_WEAPON_MELEE_PERCENTAGE = "nFlagSubCategoryWeaponMeleePercentage";
        const string ID1_FLAG_TYPE_BASTARDSWORD_PERCENTAGE = "nFlagTypeBastardSwordPercentage";
        const string ID1_FLAG_TYPE_BATTLEAXE_PERCENTAGE = "nFlagTypeBattleAxePercentage";
        const string ID1_FLAG_TYPE_CLUB_PERCENTAGE = "nFlagTypeClubPercentage";
        const string ID1_FLAG_TYPE_DAGGER_PERCENTAGE = "nFlagTypeDaggerPercentage";
        const string ID1_FLAG_TYPE_DIREMACE_PERCENTAGE = "nFlagTypeDireMacePercentage";
        const string ID1_FLAG_TYPE_DOUBLEAXE_PERCENTAGE = "nFlagTypeDoubleAxePercentage";
        const string ID1_FLAG_TYPE_DWARVENWARAXE_PERCENTAGE = "nFlagTypeDwarvenWarAxePercentage";
        const string ID1_FLAG_TYPE_GREATAXE_PERCENTAGE = "nFlagTypeGreatAxePercentage";
        const string ID1_FLAG_TYPE_GREATSWORD_PERCENTAGE = "nFlagTypeGreatSwordPercentage";
        const string ID1_FLAG_TYPE_HALBERD_PERCENTAGE = "nFlagTypeHalberdPercentage";
        const string ID1_FLAG_TYPE_HANDAXE_PERCENTAGE = "nFlagTypeHandAxePercentage";
        const string ID1_FLAG_TYPE_HEAVYFLAIL_PERCENTAGE = "nFlagTypeHeavyFlailPercentage";
        const string ID1_FLAG_TYPE_KAMA_PERCENTAGE = "nFlagTypeKamaPercentage";
        const string ID1_FLAG_TYPE_KATANA_PERCENTAGE = "nFlagTypeKatanaPercentage";
        const string ID1_FLAG_TYPE_KUKRI_PERCENTAGE = "nFlagTypeKukriPercentage";
        const string ID1_FLAG_TYPE_LIGHTFLAIL_PERCENTAGE = "nFlagTypeLightFlailPercentage";
        const string ID1_FLAG_TYPE_LIGHTHAMMER_PERCENTAGE = "nFlagTypeLightHammerPercentage";
        const string ID1_FLAG_TYPE_LIGHTMACE_PERCENTAGE = "nFlagTypeLightMacePercentage";
        const string ID1_FLAG_TYPE_LONGSWORD_PERCENTAGE = "nFlagTypeLongSwordPercentage";
        const string ID1_FLAG_TYPE_STAFF_PERCENTAGE = "nFlagTypeStaffPercentage";
        const string ID1_FLAG_TYPE_MORNINGSTAR_PERCENTAGE = "nFlagTypeMorningStarPercentage";
        const string ID1_FLAG_TYPE_RAPIER_PERCENTAGE = "nFlagTypeRapierPercentage";
        const string ID1_FLAG_TYPE_SCIMITAR_PERCENTAGE = "nFlagTypeScimitarPercentage";
        const string ID1_FLAG_TYPE_SCYTHE_PERCENTAGE = "nFlagTypeScythePercentage";
        const string ID1_FLAG_TYPE_SHORTSPEAR_PERCENTAGE = "nFlagTypeShortSpearPercentage";
        const string ID1_FLAG_TYPE_SHORTSWORD_PERCENTAGE = "nFlagTypeShortSwordPercentage";
        const string ID1_FLAG_TYPE_SICKLE_PERCENTAGE = "nFlagTypeSicklePercentage";
        const string ID1_FLAG_TYPE_TWOBLADEDSWORD_PERCENTAGE = "nFlagTypeTwoBladedSwordPercentage";
        const string ID1_FLAG_TYPE_WARHAMMER_PERCENTAGE = "nFlagTypeWarHammerPercentage";
        const string ID1_FLAG_TYPE_WHIP_PERCENTAGE = "nFlagTypeWhipPercentage";
    const string ID1_FLAG_SUBCATEGORY_WEAPON_RANGED_PERCENTAGE = "nFlagSubCategoryWeaponRangedPercentage";
        const string ID1_FLAG_TYPE_DART_PERCENTAGE = "nFlagTypeDartPercentage";
        const string ID1_FLAG_TYPE_HEAVYCROSSBOW_PERCENTAGE = "nFlagTypeHeavyCrossbowPercentage";
        const string ID1_FLAG_TYPE_LIGHTCROSSBOW_PERCENTAGE = "nFlagTypeLightCrossbowPercentage";
        const string ID1_FLAG_TYPE_LONGBOW_PERCENTAGE = "nFlagTypeLongBowPercentage";
        const string ID1_FLAG_TYPE_SHORTBOW_PERCENTAGE = "nFlagTypeShortBowPercentage";
        const string ID1_FLAG_TYPE_SHURIKEN_PERCENTAGE = "nFlagTypeShurikenPercentage";
        const string ID1_FLAG_TYPE_SLING_PERCENTAGE = "nFlagTypeSlingPercentage";
        const string ID1_FLAG_TYPE_THROWINGAXE_PERCENTAGE = "nFlagTypeThrowingAxePercentage";
    const string ID1_FLAG_SUBCATEGORY_WEAPON_AMMUNITION_PERCENTAGE = "nFlagSubCategoryWeaponAmmunitionPercentage";
        const string ID1_FLAG_TYPE_ARROW_PERCENTAGE = "nFlagTypeArrowPercentage";
        const string ID1_FLAG_TYPE_BOLT_PERCENTAGE = "nFlagTypeBoltPercentage";
        const string ID1_FLAG_TYPE_BULLET_PERCENTAGE = "nFlagTypeBulletPercentage";
const string ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE = "nFlagCategoryArmorPercentage"; // armor
    const string ID1_FLAG_SUBCATEGORY_ARMOR_BODY_PERCENTAGE = "nFlagSubCategoryArmorBodyPercentage";
        const string ID1_FLAG_TYPE_ARMOR_CLOTH_PERCENTAGE = "nFlagTypeArmorClothPercentage";
        const string ID1_FLAG_TYPE_ARMOR_PADDED_PERCENTAGE = "nFlagTypeArmorPaddedPercentage";
        const string ID1_FLAG_TYPE_ARMOR_LEATHER_PERCENTAGE = "nFlagTypeArmorLeatherPercentage";
        const string ID1_FLAG_TYPE_ARMOR_HIDE_PERCENTAGE = "nFlagTypeArmorHidePercentage";
        const string ID1_FLAG_TYPE_ARMOR_SCALE_PERCENTAGE = "nFlagTypeArmorScalePercentage";
        const string ID1_FLAG_TYPE_ARMOR_CHAINMAIL_PERCENTAGE = "nFlagTypeArmorChainmailPercentage";
        const string ID1_FLAG_TYPE_ARMOR_BANDED_PERCENTAGE = "nFlagTypeArmorBandedPercentage";
        const string ID1_FLAG_TYPE_ARMOR_HALFPLATE_PERCENTAGE = "nFlagTypeArmorHalfPlatePercentage";
        const string ID1_FLAG_TYPE_ARMOR_FULLPLATE_PERCENTAGE = "nFlagTypeArmorFullPlatePercentage";
    const string ID1_FLAG_SUBCATEGORY_ARMOR_SHIELD_PERCENTAGE = "nFlagSubCategoryArmorShieldPercentage";
        const string ID1_FLAG_TYPE_SMALLSHIELD_PERCENTAGE = "nFlagTypeSmallShieldPercentage";
        const string ID1_FLAG_TYPE_LARGESHIELD_PERCENTAGE = "nFlagTypeLargeShieldPercentage";
        const string ID1_FLAG_TYPE_TOWERSHIELD_PERCENTAGE = "nFlagTypeTowerShieldPercentage";
const string ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE = "nFlagCategoryAccessoryPercentage"; // equipable items
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_AMULET_PERCENTAGE = "nFlagSubCategoryAccessoryAmuletPercentage";
        const string ID1_FLAG_TYPE_AMULET_PERCENTAGE = "nFlagTypeAmuletPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_BELT_PERCENTAGE = "nFlagSubCategoryAccessoryBeltPercentage";
        const string ID1_FLAG_TYPE_BELT_PERCENTAGE = "nFlagTypeBeltPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_BOOTS_PERCENTAGE = "nFlagSubCategoryAccessoryBootsPercentage";
        const string ID1_FLAG_TYPE_BOOTS_PERCENTAGE = "nFlagTypeBootsPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_BRACER_PERCENTAGE = "nFlagSubCategoryAccessoryBracerPercentage";
        const string ID1_FLAG_TYPE_BRACER_PERCENTAGE = "nFlagTypeBracerPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_CLOAK_PERCENTAGE = "nFlagSubCategoryAccessoryCloakPercentage";
        const string ID1_FLAG_TYPE_CLOAK_PERCENTAGE = "nFlagTypeCloakPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_GLOVES_PERCENTAGE = "nFlagSubCategoryAccessoryGlovesPercentage";
        const string ID1_FLAG_TYPE_GLOVES_PERCENTAGE = "nFlagTypeGlovesPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_HELMET_PERCENTAGE = "nFlagSubCategoryAccessoryHelmetPercentage";
        const string ID1_FLAG_TYPE_HELMET_PERCENTAGE = "nFlagTypeHelmetPercentage";
    const string ID1_FLAG_SUBCATEGORY_ACCESSORY_RING_PERCENTAGE = "nFlagSubCategoryAccessoryRingPercentage";
        const string ID1_FLAG_TYPE_RING_PERCENTAGE = "nFlagTypeRingPercentage";
const string ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE = "nFlagCategoryConsumablePercentage"; // useable items
    const string ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE = "nFlagSubCategoryConsumableGrenadePercentage"; // artificial
        const string ID1_FLAG_TYPE_GRENADE_PERCENTAGE = "nFlagTypeGrenadePercentage";
    const string ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE = "nFlagSubCategoryConsumableWandPercentage"; // artificial
        const string ID1_FLAG_TYPE_WAND_PERCENTAGE = "nFlagTypeWandPercentage";
    const string ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE = "nFlagSubCategoryConsumablePotionPercentage"; // artificial
        const string ID1_FLAG_TYPE_POTION_PERCENTAGE = "nFlagTypePotionPercentage";
    const string ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE = "nFlagSubCategoryConsumableScrollPercentage"; // artificial
        const string ID1_FLAG_TYPE_SCROLL_PERCENTAGE = "nFlagTypeScrollPercentage";
    const string ID1_FLAG_SUBCATEGORY_CONSUMABLE_ROD_PERCENTAGE = "nFlagSubCategoryConsumableRodPercentage";
        const string ID1_FLAG_TYPE_ROD_PERCENTAGE = "nFlagTypeRodPercentage";
const string ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE = "nFlagCategoryMiscellaneousPercentage"; // other items
    const string ID1_FLAG_SUBCATEGORY_MISCELLANEOUS_MISCELLANEOUS_PERCENTAGE = "nFlagSubCategoryMiscellaneousMiscellaneousPercentage"; // artificial
        const string ID1_FLAG_TYPE_MISCELLANEOUS_PERCENTAGE = "nFlagTypeMiscellaneousPercentage"; // artificial

    //////////////////////////////////////////////////////////////////
    // Locks                                                        //
    //////////////////////////////////////////////////////////////////

// lock difficulty selection
const string ID1_FLAG_LOCK_DIFFICULTY_SELECTION = "nFlagLockDifficultySelection";
const int ID1_LOCK_DIFFICULTY_SELECTION_LEVEL = 10;
const int ID1_LOCK_DIFFICULTY_SELECTION_SET = 20;

// lock difficulty number
const string ID1_FLAG_LOCK_DIFFICULTY_NUMBER = "nFlagLockDifficultyNumber";
const int ID1_LOCK_DIFFICULTY_NUMBER_FIXED = 10;
const int ID1_LOCK_DIFFICULTY_NUMBER_RANDOM = 20;

// door lock frequency
const string ID1_FLAG_LOCK_DOOR_FREQUENCY = "nFlagLockDoorFrequency";

// chest lock frequency
const string ID1_FLAG_LOCK_CHEST_FREQUENCY = "nFlagLockChestFrequency";

    //////////////////////////////////////////////////////////////////
    // Traps                                                        //
    //////////////////////////////////////////////////////////////////

// trap disarm difficulty selection
const string ID1_FLAG_TRAP_DIFFICULTY_SELECTION = "nFlagTrapDifficultySelection";
const int ID1_TRAP_DIFFICULTY_SELECTION_LEVEL = 10;
const int ID1_TRAP_DIFFICULTY_SELECTION_SET = 20;

// trap disarm difficulty number
const string ID1_FLAG_TRAP_DIFFICULTY_NUMBER = "nFlagTrapDifficultyNumber";
const int ID1_TRAP_DIFFICULTY_NUMBER_FIXED = 10;
const int ID1_TRAP_DIFFICULTY_NUMBER_RANDOM = 20;

// floor trap frequency
const string ID1_FLAG_TRAP_FLOOR_FREQUENCY = "nFlagTrapFloorFrequency";

// door trap frequency
const string ID1_FLAG_TRAP_DOOR_FREQUENCY = "nFlagTrapDoorFrequency";

// chest trap frequency
const string ID1_FLAG_TRAP_CHEST_FREQUENCY = "nFlagTrapChestFrequency";

// trap detect difficulty selection
const string ID1_FLAG_TRAP_DETECT_SELECTION = "nFlagTrapDetectSelection";
const int ID1_TRAP_DETECT_SELECTION_LEVEL = 10;
const int ID1_TRAP_DETECT_SELECTION_SET = 20;

// trap detect difficulty number
const string ID1_FLAG_TRAP_DETECT_NUMBER = "nFlagTrapDetectNumber";
const int ID1_TRAP_DETECT_NUMBER_FIXED = 10;
const int ID1_TRAP_DETECT_NUMBER_RANDOM = 20;

// trap damage difficulty selection
const string ID1_FLAG_TRAP_DAMAGE_SELECTION = "nFlagTrapDamageSelection";
const int ID1_TRAP_DAMAGE_SELECTION_LEVEL = 10;
const int ID1_TRAP_DAMAGE_SELECTION_SET = 20;

// trap damage difficulty number
const string ID1_FLAG_TRAP_DAMAGE_NUMBER = "nFlagTrapDamageNumber";
const int ID1_TRAP_DAMAGE_NUMBER_FIXED = 10;
const int ID1_TRAP_DAMAGE_NUMBER_RANDOM = 20;

    //////////////////////////////////////////////////////////////////
    // Encounter                                                    //
    //////////////////////////////////////////////////////////////////

// encounter frequency (0-100)
const string ID1_FLAG_ENCOUNTER_FREQUENCY = "nFlagEncounterFrequency";

// encounter difficulty (-40-40)
const string ID1_FLAG_ENCOUNTER_DIFFICULTY = "nFlagEncounterDifficulty";

// encounter size
const string ID1_FLAG_ENCOUNTER_SIZE = "nFlagEncounterSize";
const int ID1_ENCOUNTER_SIZE_SINGLE = 10; // the spawned encounter will be only a single creature, within the proper CR limits
const int ID1_ENCOUNTER_SIZE_NORMAL = 20; // the spawned encounter will be of the normally determined size
const int ID1_ENCOUNTER_SIZE_LARGE = 30; // the spawned encounter will be of a large number of lower level creatures
const int ID1_ENCOUNTER_SIZE_HORDE = 40; // the spawned encounter will be a huge number of much lower level creatures

// encounter treasure frequency (0-100)
const string ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY = "nFlagEncounterTreasureFrequency";

// encounter treasure value (0-500)
const string ID1_FLAG_ENCOUNTER_TREASURE_VALUE = "nFlagEncounterTreasureValue";

// monster corpses
const string ID1_FLAG_ENCOUNTER_CORPSE = "nFlagEncounterCorpse";
const int ID1_ENCOUNTER_CORPSE_FADE = 10; // corpses fade away normally, leaving treasure behind
const int ID1_ENCOUNTER_CORPSE_PERMANENT = 20; // corpses stay on the ground

// encounter type
const string ID1_FLAG_ENCOUNTER_TYPE = "nFlagEncounterType";
const int ID1_ENCOUNTER_TYPE_DUNGEON = 10; // monsters are chosen for the dungeon based on its theme and settings
const int ID1_ENCOUNTER_TYPE_CREATURE = 20; // a single chosen monster type is the only creature used
const int ID1_ENCOUNTER_TYPE_THEME = 30; // monsters are only chosen from a specific theme
const int ID1_ENCOUNTER_TYPE_RANDOM = 40; // any monster can be chosen anywhere

    //////////////////////////////////////////////////////////////////
    // Boss                                                         //
    //////////////////////////////////////////////////////////////////

// boss area selection
const string ID1_FLAG_BOSS_AREA_SELECTION = "nFlagBossAreaSelection";
const int ID1_BOSS_AREA_SELECTION_NONE = 10; // no boss area will be selected
const int ID1_BOSS_AREA_SELECTION_RANDOM = 20; // a random boss area will be chosen
const int ID1_BOSS_AREA_SELECTION_THEMESET = 30; // the specific boss area for the chosen themeset will be used
const int ID1_BOSS_AREA_SELECTION_FIXED_SPECIFIC = 40; // a specific normal boss area will be used
const int ID1_BOSS_AREA_SELECTION_FIXED_THEMESET = 45; // a specific themeset boss area will be used

// miniboss frequency
const string ID1_FLAG_BOSS_MINIBOSS_FREQUENCY = "nFlagBossMiniBossFrequency";

// guard frequency
const string ID1_FLAG_BOSS_GUARD_FREQUENCY = "nFlagBossGuardFrequency";

// boss treasure frequency
const string ID1_FLAG_BOSS_TREASURE_FREQUENCY = "nFlagBossTreasureFrequency";

// boss treasure value
const string ID1_FLAG_BOSS_TREASURE_VALUE = "nFlagBossTreasureValue";

    //////////////////////////////////////////////////////////////////
    // Plots                                                        //
    //////////////////////////////////////////////////////////////////

// plot frequency
const string ID1_FLAG_PLOT_FREQUENCY = "nFlagPlotFrequency";

// kill creatures quest frequency
const string ID1_FLAG_PLOT_TYPE1_FREQUENCY = "nFlagPlotType1Frequency";

// clear areas quest frequency
const string ID1_FLAG_PLOT_TYPE2_FREQUENCY = "nFlagPlotType2Frequency";

// collect items on creatures quest frequency
const string ID1_FLAG_PLOT_TYPE3_FREQUENCY = "nFlagPlotType3Frequency";

// collect items on chests quest frequency
const string ID1_FLAG_PLOT_TYPE4_FREQUENCY = "nFlagPlotType4Frequency";

// explore areas quest frequency
const string ID1_FLAG_PLOT_TYPE5_FREQUENCY = "nFlagPlotType5Frequency";

// find a creature quest frequency
const string ID1_FLAG_PLOT_TYPE6_FREQUENCY = "nFlagPlotType6Frequency";

// find a placeable quest frequency
const string ID1_FLAG_PLOT_TYPE7_FREQUENCY = "nFlagPlotType7Frequency";

// plot frequency
const string ID1_FLAG_PLOT_REWARD_VALUE = "nFlagPlotRewardValue";

    //////////////////////////////////////////////////////////////////
    // Statistics                                                   //
    //////////////////////////////////////////////////////////////////

// display statistics counter
const string ID1_FLAG_STATISTICS_DISPLAY_COUNTER = "nFlagScoreDisplayCounter";

// display point award
const string ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD = "nFlagScoreDisplayPointAward";

// display point total
const string ID1_FLAG_STATISTICS_DISPLAY_POINT_TOTAL = "nFlagScoreDisplayPointTotal";

    //////////////////////////////////////////////////////////////////
    // Death                                                        //
    //////////////////////////////////////////////////////////////////

// respawn penalty (0-100)
const string ID1_FLAG_DEATH_RESPAWN_PENALTY = "nFlagDeathRespawnPenalty";
const int ID1_DEATH_RESPAWN_PENALTY_NONE = 10; // there is no penalty for dying
const int ID1_DEATH_RESPAWN_PENALTY_GOLD = 20; // the player loses a percentage of his gold when he dies (round down)
const int ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE = 30; // the player loses a percentage of his experience when he dies (round down)
const int ID1_DEATH_RESPAWN_PENALTY_INVENTORY = 40; // the player loses a percentage of his non-plot items from his inventory (randomly determined; round down)
const int ID1_DEATH_RESPAWN_PENALTY_GOLD_EXPERIENCE = 50; // the player loses both gold and experience
const int ID1_DEATH_RESPAWN_PENALTY_GOLD_INVENTORY = 60; // the player loses gold and items
const int ID1_DEATH_RESPAWN_PENALTY_EXPERIENCE_INVENTORY = 70; // the player loses experience and items
const int ID1_DEATH_RESPAWN_PENALTY_ALL = 80; // the player loses gold, experience, and items

// player death
const string ID1_FLAG_DEATH_PLAYER = "nFlagDeathPlayer";
const int ID1_DEATH_PLAYER_PERMANENT = 10; // player death is permanent, with only resurrection as a possibility
const int ID1_DEATH_PLAYER_RESPAWN_INSTANT = 20; // the player will be able to respawn right where he died
const int ID1_DEATH_PLAYER_RESPAWN_AREA = 30; // the player will be able to respawn and will appear in the area where he died
const int ID1_DEATH_PLAYER_RESPAWN_LEVEL = 40; // the player respawns back at the staircase he entered the level from
const int ID1_DEATH_PLAYER_RESPAWN_DUNGEON = 50; // the player respawns back just outside the dungeon entrance (outside, because of possible level loading issues)

// player health (1-100)
const string ID1_FLAG_PLAYER_RESPAWN_HEALTH = "nFlagPlayerRespawnHealth";

// if the player respawns rested
const string ID1_FLAG_PLAYER_RESPAWN_RESTED = "nFlagPlayerRespawnRested";

// henchmen on player death
const string ID1_FLAG_DEATH_PLAYER_HENCHMEN = "nFlagDeathPlayerHenchmen";
const int ID1_DEATH_PLAYER_HENCHMEN_PERSIST = 10; // the henchmen stick around in that area, fighting and waiting for the player
const int ID1_DEATH_PLAYER_HENCHMEN_DIE = 20; // the henchmen die when the player dies







    //////////////////////////////////////////////////////////////////
    // Importing                                                    //
    //////////////////////////////////////////////////////////////////

// detail
const string ID1_FLAG_IMPORT_DETAIL = "nFlagImportDetail";
const int ID1_IMPORT_DETAIL_LAYOUT = 10; // retrieves only the layout of the dungeon from importing
const int ID1_IMPORT_DETAIL_POINT_PRESENCE = 20; // retrieves the layout and the presence of used waypoints, but not their contents
const int ID1_IMPORT_DETAIL_FULL_RESET = 30; // retrieves all information about the imported dungeon, with all creatures
const int ID1_IMPORT_DETAIL_FULL_DETAILED = 40; // retrieves all the information about the imported dungeon at the state in which it was stored

// player statistic information
const string ID1_FLAG_IMPORT_PLAYER_STATISTICS = "nFlagImportPlayerStatistics";
const int ID1_IMPORT_PLAYER_STATISTICS_NONE = 10; // does not retrieve any statistics for this dungeon
const int ID1_IMPORT_PLAYER_STATISTICS_SELF = 20; // retrieves the statistics for the player importing only
const int ID1_IMPORT_PLAYER_STATISTICS_PARTY = 30; // retrieves the statistics for the entire party of the player importing
const int ID1_IMPORT_PLAYER_STATISTICS_CURRENT = 40; // retrieves the statistics for each PC currently in the module
const int ID1_IMPORT_PLAYER_STATISTICS_FULL = 50; // retrieves all statistics for this dungeon

// player map information
const string ID1_FLAG_IMPORT_PLAYER_MAPS = "nFlagImportPlayerMaps";
const int ID1_IMPORT_PLAYER_MAPS_NONE = 10; // does not retrieve any map information
const int ID1_IMPORT_PLAYER_MAPS_SELF = 20; // retrieves the map information for the player importing the dungeon
const int ID1_IMPORT_PLAYER_MAPS_PARTY = 30; // retrieves map information for each party member of the player importing the dungeon
const int ID1_IMPORT_PLAYER_MAPS_CURRENT = 40; // retrieves map information for each PC in the module
const int ID1_IMPORT_PLAYER_MAPS_FULL = 50; // retrieves all map information for this dungeon

// player score information
const string ID1_FLAG_IMPORT_PLAYER_SCORE = "nFlagImportPlayerScore";
const int ID1_IMPORT_PLAYER_SCORE_NONE = 10; // retrieves no score information for this dungeon
const int ID1_IMPORT_PLAYER_SCORE_SELF = 20; // retrieves score information for the player importing the dungeon
const int ID1_IMPORT_PLAYER_SCORE_PARTY = 30; // retrieves score information for each party member of the player importing the dungeon
const int ID1_IMPORT_PLAYER_SCORE_CURRENT = 40; // retrieves score information for each PC in the module
const int ID1_IMPORT_PLAYER_SCORE_FULL = 50; // retrieves all score information for this dungeon

// player high score information
const string ID1_FLAG_IMPORT_PLAYER_HIGH_SCORE = "nFlagImportPlayerHighScore";
const int ID1_IMPORT_PLAYER_HIGH_SCORE_NONE = 10; // retrieves no specific highscore information
const int ID1_IMPORT_PLAYER_HIGH_SCORE_TOP_ONE = 20; // retrieves the top score for this dungeon
const int ID1_IMPORT_PLAYER_HIGH_SCORE_TOP_FIVE = 30; // retrieves the top 5 highscores for this dungeon
const int ID1_IMPORT_PLAYER_HIGH_SCORE_TOP_TEN = 40; // retrieves the top 10 highscores for this dungeon
const int ID1_IMPORT_PLAYER_HIGH_SCORE_TOP_NUMBER = 50; // retrieves a player-set number of highscores for this dungeon
// Value: The value for this node is the number of highest scores to extract





// EDIT: to add to control conversation

// combat one-liners
const string ID1_FLAG_COMBAT_ONELINER_FREQUENCY = "nFlagCombatOneLinerFrequency";



//////////////////////////////////////////////////////////////////
// Function Prototypes                                          //
//////////////////////////////////////////////////////////////////

// Sets the chosen flag on the module to the given value.
// - sFlag: The flag being set.
// - nValue: The value the flag is being set to.
// * No return value.
void SetModuleFlag(string sFlag, int nValue);

// Sets the stored variable for the chosen flag on the module.
// - sFlag: The flag value being set.
// - nValue: The number the flag value is being set to.
// * No return value.
void SetModuleFlagValue(string sFlag, int nValue);

void SetModuleFlagString(string sFlag, string sString);

// Gets the state of the chosen flag on the module.
// - sFlag: The flag being set.
// * Returns the integer value of the chosen flag.
int GetModuleFlag(string sFlag);

// Gets the stored variable for the chosen flag on the module.
// - sFlag: The flag being set.
// * Returns the integer value of the chosen flag.
int GetModuleFlagValue(string sFlag);

string GetModuleFlagString(string sFlag);


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

// Sets the chosen flag on the module to the given value.
// - sFlag: The flag being set.
// - nValue: The value the flag is being set to.
// * No return value.
void SetModuleFlag(string sFlag, int nValue)
{
    SetLocalInt(GetModule(), sFlag, nValue);
}

// Sets the stored variable for the chosen flag on the module.
// - sFlag: The flag value being set.
// - nValue: The number the flag value is being set to.
// * No return value.
void SetModuleFlagValue(string sFlag, int nValue)
{
    SetLocalInt(GetModule(), sFlag + "Value", nValue);
}

void SetModuleFlagString(string sFlag, string sString)
{
    SetLocalString(GetModule(), sFlag + "String", sString);
}

// Gets the state of the chosen flag on the module.
// - sFlag: The flag being set.
// * Returns the integer value of the chosen flag.
int GetModuleFlag(string sFlag)
{
    return GetLocalInt(GetModule(), sFlag);
}

// Gets the stored variable for the chosen flag on the module.
// - sFlag: The flag being set.
// * Returns the integer value of the chosen flag.
int GetModuleFlagValue(string sFlag)
{
    return GetLocalInt(GetModule(), sFlag + "Value");
}

string GetModuleFlagString(string sFlag)
{
    return GetLocalString(GetModule(), sFlag + "String");
}

// void main(){}

