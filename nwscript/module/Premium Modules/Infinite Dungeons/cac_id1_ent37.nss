#include "inc_id1_flags"

void main()
{
    ActionPauseConversation();

    // fighter prefab
    SetLocalInt(GetModule(), "nPreset", 1);

    //////////////////////////////////////////////////////////////////
    // Secret Door System                                           //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_FREQUENCY, 20);
    SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_SELECTION, ID1_SECRET_DOOR_DIFFICULTY_SELECTION_LEVEL);
    SetModuleFlag(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, ID1_SECRET_DOOR_DIFFICULTY_NUMBER_RANDOM);
    SetModuleFlagValue(ID1_FLAG_SECRET_DOOR_DIFFICULTY_NUMBER, 3);
    SetModuleFlagValue(ID1_FLAG_SECRET_ENCOUNTER_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_SECRET_TREASURE_FREQUENCY, 100);

    //////////////////////////////////////////////////////////////////
    // Treasure                                                     //
    //////////////////////////////////////////////////////////////////

    SetModuleFlagValue(ID1_FLAG_TREASURE_FREQUENCY, 50);
    SetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL, 0);
    SetModuleFlagValue(ID1_FLAG_TREASURE_CHEST_VALUE, 100);
    SetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY, 5);
    SetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY, 20);
    SetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY, 2);

    // categories
    SetModuleFlagValue(ID1_FLAG_CATEGORY_WEAPON_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_ARMOR_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_ACCESSORY_PERCENTAGE, 25);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE, 25);
    SetModuleFlagValue(ID1_FLAG_CATEGORY_MISCELLANEOUS_PERCENTAGE, 15);

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
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CLOTH_PERCENTAGE, 2);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_PADDED_PERCENTAGE, 2);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_LEATHER_PERCENTAGE, 8);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HIDE_PERCENTAGE, 8);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_SCALE_PERCENTAGE, 20);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_CHAINMAIL_PERCENTAGE, 10);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_BANDED_PERCENTAGE, 25);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_HALFPLATE_PERCENTAGE, 15);
    SetModuleFlagValue(ID1_FLAG_TYPE_ARMOR_FULLPLATE_PERCENTAGE, 10);

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
    if (GetLocalInt(GetModule(), "bMultiplayer") == TRUE)
    {
        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, 0);
        SetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE, ID1_ENCOUNTER_SIZE_NORMAL);
        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, 25);
    } else
    {
        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY, -1);
        SetModuleFlag(ID1_FLAG_ENCOUNTER_SIZE, ID1_ENCOUNTER_SIZE_LARGE);
        SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_FREQUENCY, 50);
    }
    SetModuleFlagValue(ID1_FLAG_ENCOUNTER_TREASURE_VALUE, 50);
    SetModuleFlag(ID1_FLAG_ENCOUNTER_CORPSE, ID1_ENCOUNTER_CORPSE_FADE);
    SetModuleFlag(ID1_FLAG_ENCOUNTER_TYPE, ID1_ENCOUNTER_TYPE_DUNGEON);

    //////////////////////////////////////////////////////////
    // Boss                                                 //
    //////////////////////////////////////////////////////////

    SetModuleFlag(ID1_FLAG_BOSS_AREA_SELECTION, ID1_BOSS_AREA_SELECTION_THEMESET);
    SetModuleFlagValue(ID1_FLAG_BOSS_MINIBOSS_FREQUENCY, 65);
    SetModuleFlagValue(ID1_FLAG_BOSS_GUARD_FREQUENCY, 80);
    SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_FREQUENCY, 100);
    SetModuleFlagValue(ID1_FLAG_BOSS_TREASURE_VALUE, 300);

    // rebuild item percentages
    object oMicroCPU;
    int nValue = 0;
    while (nValue <= 40)
    {
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU2");
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nValue", nValue);
        DelayCommand(0.01, ExecuteScript("exe_id1_micitp1", oMicroCPU));

        nValue++;
    }

    DelayCommand(2.0, ActionResumeConversation());
}
