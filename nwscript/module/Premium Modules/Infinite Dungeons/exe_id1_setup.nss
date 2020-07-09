//:://////////////////////////////////////////////////////////////
//:: mld_id1_setup                                              //
//:: Copyright (c) 2005 Bioware Corp.                           //
//:://////////////////////////////////////////////////////////////
/*
        This script sets the the default flags for the dungeon,
        creates the CPU set, and initiates the catalog script.

        Seek Strings:
    // Stairs                                               //
    // Map                                                  //
    // Dungeon Geometry                                     //
    // Boss                                                 //
    // Encounter                                            //

*/
//:://////////////////////////////////////////////////////////////
//:: Created By: Peter Thomas                                   //
//:: Created On: July 2005                                      //
//:://////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// Include Files                                                //
//////////////////////////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_var"
#include "inc_id1_store"


//////////////////////////////////////////////////////////////////
// Function Definitions                                         //
//////////////////////////////////////////////////////////////////

void main()
{
    DebugMessage("");
    DebugMessage("Starting dungeon setup.");

//    SetLocalInt(GetModule(), "bDebugMode", TRUE);
//    SetLocalInt(GetModule(), "bDebugModeT", TRUE);

    SetLocalInt(GetModule(), "bCataloging", TRUE);

    // lock the dungeon entrance
    SetLocked(GetObjectByTag("DungeonEntranceStairs"), TRUE);

    //////////////////////////////////////////////////////////////////
    // Module Specific                                              //
    //////////////////////////////////////////////////////////////////

    // set the maximum number of CPUs
    SetLocalInt(GetModule(), "nCPUMax", CPU_NUM);

    // create the CPU array
    int iTemp;
    string sTemp;
    int iCPU = GetLocalInt(GetModule(), "nCPUMax");
    object oCPU;

    // create the CPU grid
    for (iTemp = 1; iTemp <= iCPU; iTemp++)
    {
        sTemp = "CPU" + IntToString(iTemp);
        oCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, sTemp);

        // determine the next in the sequence
        if (iTemp < iCPU)
        {
            sTemp = "CPU" + IntToString(iTemp + 1);
        } else
        {
            sTemp = "CPU1";
        }
        SetLocalString(oCPU, "sNext", sTemp);
    }

    // create the temporary inventory item
    object oInventory = CreateObject(OBJECT_TYPE_PLACEABLE, "inventory", GetLocation(GetWaypointByTag("CPU")), FALSE, "DungeonInventory");
    if (oInventory == OBJECT_INVALID)
    {
        DebugMessage("Inventory was not created.");
    }


    //////////////////////////////////////////////////////////////////
    // Module Flags                                                 //
    //////////////////////////////////////////////////////////////////


    //////////////////////////////////////////////////////////
    // Theme                                                //
    //////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SINGLETHEME);
    SetModuleFlag(ID1_FLAG_THEME_SELECTION, ID1_THEME_SELECTION_RANDOM);


    //////////////////////////////////////////////////////////
    // Dungeon Layout                                       //
    //////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_STAIRS_NUMBER, ID1_STAIRS_NUMBER_FIXED);
    SetModuleFlagValue(ID1_FLAG_STAIRS_NUMBER, 1);
    SetModuleFlag(ID1_FLAG_DUNGEON_DEPTH, ID1_DUNGEON_DEPTH_FIXED);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_DEPTH, 3);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_X, 3);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_MAXIMUM_Y, 3);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_ONE_EXIT, 10);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_TWO_EXIT, 60);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_THREE_EXIT, 80);
    SetModuleFlagValue(ID1_FLAG_DUNGEON_FOUR_EXIT, 20);

    //////////////////////////////////////////////////////////
    // Map                                                  //
    //////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_MAP_AUTOCLEANUP, ID1_ACTIVE);
    SetModuleFlag(ID1_FLAG_MAP_DISPLAY, ID1_MAP_DISPLAY_PARTY);
    SetModuleFlag(ID1_FLAG_MAP_BOUNDARY, ID1_MAP_BOUNDARY_SHOW_FULL);

    //////////////////////////////////////////////////////////////////
    // Decor System                                                 //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_DECOR_FREQUENCY, 65);

    //////////////////////////////////////////////////////////////////
    // Secret Door System                                           //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY, 50);
    SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION, ID1_SECRET_DOOR_DIFFICULTY_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, 3);
    SetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_VALUE, 200);

    //////////////////////////////////////////////////////////////////
    // Safe Zone System                                             //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_PUZZLE_FREQUENCY, 80);
    SetModuleFlag(ID1_FLAG_PUZZLE_DIFFICULTY, ID1_PUZZLE_DIFFICULTY_NORMAL);
    SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_AREA_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_TREASURE_PERCENTAGE, 45);
    SetModuleFlagValue(ID1_FLAG_PUZZLE_REWARD_EXPERIENCE_PERCENTAGE, 35);
    SetModuleFlagValue(ID1_FLAG_CAMP_FREQUENCY, 75);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_REST_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY, 75);
    SetModuleFlag(ID1_FLAG_CAMP_NODE_STORE_GOLD, ID1_CAMP_NODE_STORE_GOLD_UNLIMITED);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKUP, 100);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_MARKDOWN, 65);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY, 100);

    //////////////////////////////////////////////////////////////////
    // Treasure                                                     //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY, 65);
    SetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL, -2);
    SetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE, 100);
    SetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY, 5);
    SetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY, 20);
    SetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY, 2);

    // categories
    SetModuleFlagValue(ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE, 25);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE, 25);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE, 10);

    // weapon subcategories
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_MELEE_PERCENTAGE, 55);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_RANGED_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_WEAPON_AMMUNITION_PERCENTAGE, 30);

    // armor subcategories
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_BODY_PERCENTAGE, 75);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ARMOR_SHIELD_PERCENTAGE, 25);

    // accessory subcategories
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_AMULET_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BELT_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BOOTS_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BRACER_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_CLOAK_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_GLOVES_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_HELMET_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_RING_PERCENTAGE, 15);

    // consumable subcategories
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE, 30);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_ROD_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE, 30);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE, 10);

    // miscellaneous subcategories
    SetModuleFlagValue(ID1_FLAG_SUBCATEGORY_MISCELLANEOUS_MISCELLANEOUS_PERCENTAGE, 1);

    // melee weapon types
    SetModuleFlagValue(ID1_FLAG_TYPE_BASTARDSWORD_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_BATTLEAXE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_CLUB_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_DAGGER_PERCENTAGE, 6);
    SetModuleFlagValue(ID1_FLAG_TYPE_DIREMACE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_DOUBLEAXE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_DWARVENWARAXE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_GREATAXE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_GREATSWORD_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_HALBERD_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_HANDAXE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_HEAVYFLAIL_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_KAMA_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_KATANA_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_KUKRI_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_LIGHTFLAIL_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_LIGHTHAMMER_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_LIGHTMACE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_LONGSWORD_PERCENTAGE, 7);
    SetModuleFlagValue(ID1_FLAG_TYPE_STAFF_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_MORNINGSTAR_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_RAPIER_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_SCIMITAR_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_SCYTHE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_SHORTSPEAR_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_SHORTSWORD_PERCENTAGE, 6);
    SetModuleFlagValue(ID1_FLAG_TYPE_SICKLE_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_TWOBLADEDSWORD_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_WARHAMMER_PERCENTAGE, 3);
    SetModuleFlagValue(ID1_FLAG_TYPE_WHIP_PERCENTAGE, 3);

    // ranged weapon types
    SetModuleFlagValue(ID1_FLAG_TYPE_DART_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_TYPE_HEAVYCROSSBOW_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_LIGHTCROSSBOW_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_LONGBOW_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_SHORTBOW_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_TYPE_SHURIKEN_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_TYPE_SLING_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_THROWINGAXE_PERCENTAGE, 15);

    // ammunition weapon types
    SetModuleFlagValue(ID1_FLAG_TYPE_ARROW_PERCENTAGE, 40);
    SetModuleFlagValue(ID1_FLAG_TYPE_BOLT_PERCENTAGE, 40);
    SetModuleFlagValue(ID1_FLAG_TYPE_BULLET_PERCENTAGE, 20);

    // armor body types
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CLOTH_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_PADDED_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_LEATHER_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HIDE_PERCENTAGE, 5);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_SCALE_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CHAINMAIL_PERCENTAGE, 5);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_BANDED_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HALFPLATE_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_FULLPLATE_PERCENTAGE, 5);

    // armor shield types
    SetModuleFlagValue(ID1_FLAG_TYPE_SMALLSHIELD_PERCENTAGE, 45);
    SetModuleFlagValue(ID1_FLAG_TYPE_LARGESHIELD_PERCENTAGE, 35);
    SetModuleFlagValue(ID1_FLAG_TYPE_TOWERSHIELD_PERCENTAGE, 20);

    // accessory types
    SetModuleFlagValue(ID1_FLAG_TYPE_AMULET_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_BELT_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_BOOTS_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_BRACER_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_CLOAK_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_GLOVES_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_HELMET_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_RING_PERCENTAGE, 1);

    // consumable types
    SetModuleFlagValue(ID1_FLAG_TYPE_GRENADE_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_WAND_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_POTION_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_SCROLL_PERCENTAGE, 1);
    SetModuleFlagValue(ID1_FLAG_TYPE_ROD_PERCENTAGE, 1);

    // miscellaneous types
    SetModuleFlagValue(ID1_FLAG_TYPE_MISCELLANEOUS_PERCENTAGE, 1);

    //////////////////////////////////////////////////////////////////
    // Locks                                                        //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_LOCK_DOOR_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_LOCK_CHEST_FREQUENCY, 10);
    SetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_SELECTION, ID1_LOCK_DIFFICULTY_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_LOCK_DIFFICULTY_NUMBER, ID1_LOCK_DIFFICULTY_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_LOCK_DIFFICULTY_NUMBER, 3);

    //////////////////////////////////////////////////////////////////
    // Traps                                                        //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_TRAP_FLOOR_FREQUENCY, 2);
    SetModuleFlagValue(ID1_FLAG_TRAP_DOOR_FREQUENCY, 2);
    SetModuleFlagValue(ID1_FLAG_TRAP_CHEST_FREQUENCY, 10);
    SetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_SELECTION, ID1_TRAP_DIFFICULTY_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_TRAP_DIFFICULTY_NUMBER, ID1_TRAP_DIFFICULTY_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_TRAP_DIFFICULTY_NUMBER, 3);
    SetModuleFlag(ID1_FLAG_TRAP_DETECT_SELECTION, ID1_TRAP_DETECT_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_TRAP_DETECT_NUMBER, ID1_TRAP_DETECT_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_TRAP_DETECT_NUMBER, 3);
    SetModuleFlag(ID1_FLAG_TRAP_DAMAGE_SELECTION, ID1_TRAP_DAMAGE_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_TRAP_DAMAGE_NUMBER, ID1_TRAP_DAMAGE_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_TRAP_DAMAGE_NUMBER, 3);

    //////////////////////////////////////////////////////////
    // Encounter                                            //
    //////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_ENCOUNTER_FREQUENCY, 65);
    SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, -2);
    SetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE, ID1_ENCOUNTER_SIZE_LARGE);
    SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, 75);
    SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE, 60);
    SetModuleFlag(ID1_FLAG_ENCOUNTER_CORPSE, ID1_ENCOUNTER_CORPSE_FADE);
    SetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE, ID1_ENCOUNTER_TYPE_DUNGEON);

    //////////////////////////////////////////////////////////
    // Boss                                                 //
    //////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION, ID1_BOSS_AREA_SELECTION_THEMESET);
    SetModuleFlagValue(ID1_FLAG_BOSS_MINIBOSS_FREQUENCY, 65);
    SetModuleFlagValue(ID1_FLAG_BOSS_GUARD_FREQUENCY, 80);
    SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE, 200);

    //////////////////////////////////////////////////////////
    // Plots                                                //
    //////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_PLOT_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE1_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE2_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE3_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE4_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE5_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE6_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_TYPE7_FREQUENCY, 10);
    SetModuleFlagValue(ID1_FLAG_PLOT_REWARD_VALUE, 200);

    //////////////////////////////////////////////////////////////////
    // Statistics                                                   //
    //////////////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_COUNTER, ID1_ACTIVE);
    SetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_AWARD, ID1_ACTIVE);
    SetModuleFlag(ID1_FLAG_STATISTICS_DISPLAY_POINT_TOTAL, ID1_ACTIVE);

    //////////////////////////////////////////////////////////////////
    // Death/Respawn                                                //
    //////////////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_DEATH_RESPAWN_PENALTY, ID1_DEATH_RESPAWN_PENALTY_GOLD);
    SetModuleFlagValue(ID1_FLAG_DEATH_RESPAWN_PENALTY, 25);
    SetModuleFlag(ID1_FLAG_DEATH_PLAYER, ID1_DEATH_PLAYER_RESPAWN_AREA);
    SetModuleFlagValue(ID1_FLAG_PLAYER_RESPAWN_HEALTH, 75);
    SetModuleFlag(ID1_FLAG_PLAYER_RESPAWN_RESTED, ID1_INACTIVE);
    SetModuleFlag(ID1_FLAG_DEATH_PLAYER_HENCHMEN, ID1_DEATH_PLAYER_HENCHMEN_DIE);

    //////////////////////////////////////////////////////////////////
    // Mescellaneous                                                //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_COMBAT_ONELINER_FREQUENCY, 10);




    //////////////////////////////////////////////////////////////////
    // Dungeon Specific Variables                                   //
    //////////////////////////////////////////////////////////////////

    // set the current level
    DebugMessage("Set nCurrentLevel to 0. Point 5.");
    SetLocalInt(GetModule(), "nCurrentLevel", 0);

    DestroyCampaignDatabase("ID_DATABASE");

//    object oItem = CreateObject(OBJECT_TYPE_ITEM, "id_temp", GetStartingLocation());
//    SetName(oItem, "Holy Avenger Two Bladed Sword +20 of Damage Resistance");
//    CreateObject(OBJECT_TYPE_PLACEABLE, "bossitemmarker", GetStartingLocation());


    //////////////////////////////////////////////////////////////////
    // Catalogue                                                    //
    //////////////////////////////////////////////////////////////////

    // catalogue resources
    DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetObjectByTag("CPU1")));
}

