#include "inc_id1_debug"
#include "x2_inc_itemprop"

string StringAlignmentGroup(int nSubType);
string StringAlignmentSpecific(int nSubType);
string StringDamageType(int nSubType);
string StringRacialType(int nSubType);
string StringClass(int nSubType);
string StringFeat(int nSubType);
string StringSavingThrowType(int nSubType);
string StringSavingThrowAttackType(int nSubType);
string StringSkill(int nSubType);
string GetItemPropertyString(itemproperty ipProperty);
string StringSpellFailure(int nSubType);
string StringItemWeight(int nSubType);
string StringDamageReduction(int nSubType);
string StringDamageSoak(int nSubType);
string StringContainerWeight(int nSubType);
string StringLightBrightness(int nSubType);
string StringLightColor(int nSubType);
string StringDamageBonus(int nSubType);
string StringSpellResistance(int nSubType);
int TranslateInternalToExternal(int nProperty);
int TranslateExternalToInternal(int nProperty);
string GetItemPropertyColumn(int nPropertyColumn);
itemproperty GetSpecificProperty(int nProperty, object oItem);

void AddPropertyToItem(int nProperty, int nFirstTable, int nSecondTable, int nSubType, object oItem);
int GetRandomDamageType();
string GetUnlimitedAmmoType(int nSubType);

int LimitBonusMax(int nProperty, int nTableMax, int nItemLevel);

string StringAlignmentGroup(int nSubType)
{
    if (nSubType == IP_CONST_ALIGNMENTGROUP_CHAOTIC)
    {
        return "Chaotic";
    } else if (nSubType == IP_CONST_ALIGNMENTGROUP_EVIL)
    {
        return "Evil";
    } else if (nSubType == IP_CONST_ALIGNMENTGROUP_GOOD)
    {
        return "Good";
    } else if (nSubType == IP_CONST_ALIGNMENTGROUP_LAWFUL)
    {
        return "Lawful";
    } else if (nSubType == IP_CONST_ALIGNMENTGROUP_NEUTRAL)
    {
        return "Neutral";
    }

    return "";
}

string StringAlignmentSpecific(int nSubType)
{
    if (nSubType == IP_CONST_ALIGNMENT_CE)
    {
        return "Chaotic Evil";
    } else if (nSubType == IP_CONST_ALIGNMENT_CG)
    {
        return "Chaotic Good";
    } else if (nSubType == IP_CONST_ALIGNMENT_CN)
    {
        return "Chaotic Neutral";
    } else if (nSubType == IP_CONST_ALIGNMENT_LE)
    {
        return "Lawful Evil";
    } else if (nSubType == IP_CONST_ALIGNMENT_LG)
    {
        return "Lawful Good";
    } else if (nSubType == IP_CONST_ALIGNMENT_LN)
    {
        return "Lawful Neutral";
    } else if (nSubType == IP_CONST_ALIGNMENT_NE)
    {
        return "Neutral Evil";
    } else if (nSubType == IP_CONST_ALIGNMENT_NG)
    {
        return "Neutral Good";
    } else if (nSubType == IP_CONST_ALIGNMENT_TN)
    {
        return "True Neutral";
    }

    return "";
}

string StringDamageType(int nSubType)
{
    if (nSubType == IP_CONST_DAMAGETYPE_BLUDGEONING)
    {
        return "Bludgeoning";
    } else if (nSubType == IP_CONST_DAMAGETYPE_PIERCING)
    {
        return "Piercing";
    } else if (nSubType == IP_CONST_DAMAGETYPE_SLASHING)
    {
        return "Slashing";
    } else if (nSubType == IP_CONST_DAMAGETYPE_MAGICAL)
    {
        return "Magical";
    } else if (nSubType == IP_CONST_DAMAGETYPE_ACID)
    {
        return "Acid";
    } else if (nSubType == IP_CONST_DAMAGETYPE_COLD)
    {
        return "Cold";
    } else if (nSubType == IP_CONST_DAMAGETYPE_DIVINE)
    {
        return "Divine";
    } else if (nSubType == IP_CONST_DAMAGETYPE_ELECTRICAL)
    {
        return "Electrical";
    } else if (nSubType == IP_CONST_DAMAGETYPE_FIRE)
    {
        return "Fire";
    } else if (nSubType == IP_CONST_DAMAGETYPE_NEGATIVE)
    {
        return "Negative";
    } else if (nSubType == IP_CONST_DAMAGETYPE_POSITIVE)
    {
        return "Positive";
    } else if (nSubType == IP_CONST_DAMAGETYPE_SONIC)
    {
        return "Sonic";
    } else if (nSubType == IP_CONST_DAMAGETYPE_PHYSICAL)
    {
        return "Physical";
    } else if (nSubType == IP_CONST_DAMAGETYPE_SUBDUAL)
    {
        return "Subdual";
    }

    return "";
}

string StringRacialType(int nSubType)
{
    if (nSubType == RACIAL_TYPE_ABERRATION)
    {
        return "Aberration";
    } else if (nSubType == RACIAL_TYPE_ANIMAL)
    {
        return "Animal";
    } else if (nSubType == RACIAL_TYPE_BEAST)
    {
        return "Beast";
    } else if (nSubType == RACIAL_TYPE_CONSTRUCT)
    {
        return "Construct";
    } else if (nSubType == RACIAL_TYPE_DRAGON)
    {
        return "Dragon";
    } else if (nSubType == RACIAL_TYPE_DWARF)
    {
        return "Dwarf";
    } else if (nSubType == RACIAL_TYPE_ELEMENTAL)
    {
        return "Elemental";
    } else if (nSubType == RACIAL_TYPE_ELF)
    {
        return "Elf";
    } else if (nSubType == RACIAL_TYPE_FEY)
    {
        return "Fey";
    } else if (nSubType == RACIAL_TYPE_GIANT)
    {
        return "Giant";
    } else if (nSubType == RACIAL_TYPE_GNOME)
    {
        return "Gnome";
    } else if (nSubType == RACIAL_TYPE_HALFELF)
    {
        return "Half Elf";
    } else if (nSubType == RACIAL_TYPE_HALFLING)
    {
        return "Halfling";
    } else if (nSubType == RACIAL_TYPE_HALFORC)
    {
        return "Half Orc";
    } else if (nSubType == RACIAL_TYPE_HUMAN)
    {
        return "Human";
    } else if (nSubType == RACIAL_TYPE_HUMANOID_GOBLINOID)
    {
        return "Goblinoid";
    } else if (nSubType == RACIAL_TYPE_HUMANOID_MONSTROUS)
    {
        return "Monstrous Humanoid";
    } else if (nSubType == RACIAL_TYPE_HUMANOID_ORC)
    {
        return "Orc";
    } else if (nSubType == RACIAL_TYPE_HUMANOID_REPTILIAN)
    {
        return "Reptile";
    } else if (nSubType == RACIAL_TYPE_MAGICAL_BEAST)
    {
        return "Magical Beast";
    } else if (nSubType == RACIAL_TYPE_OUTSIDER)
    {
        return "Outsider";
    } else if (nSubType == RACIAL_TYPE_SHAPECHANGER)
    {
        return "Shapechanger";
    } else if (nSubType == RACIAL_TYPE_UNDEAD)
    {
        return "Undead";
    } else if (nSubType == RACIAL_TYPE_VERMIN)
    {
        return "Vermin";
    } else if (nSubType == RACIAL_TYPE_OOZE)
    {
        return "Ooze";
    }

    return "";
}

string StringClass(int nSubType)
{
    if (nSubType == IP_CONST_CLASS_BARBARIAN)
    {
        return "Barbarian";
    } else if (nSubType == IP_CONST_CLASS_BARD)
    {
        return "Bard";
    } else if (nSubType == IP_CONST_CLASS_CLERIC)
    {
        return "Cleric";
    } else if (nSubType == IP_CONST_CLASS_DRUID)
    {
        return "Druid";
    } else if (nSubType == IP_CONST_CLASS_FIGHTER)
    {
        return "Fighter";
    } else if (nSubType == IP_CONST_CLASS_MONK)
    {
        return "Monk";
    } else if (nSubType == IP_CONST_CLASS_PALADIN)
    {
        return "Paladin";
    } else if (nSubType == IP_CONST_CLASS_RANGER)
    {
        return "Ranger";
    } else if (nSubType == IP_CONST_CLASS_ROGUE)
    {
        return "Rogue";
    } else if (nSubType == IP_CONST_CLASS_SORCERER)
    {
        return "Sorcerer";
    } else if (nSubType == IP_CONST_CLASS_WIZARD)
    {
        return "Wizard";
    }

    return "";
}

string StringFeat(int nSubType)
{
    if (nSubType == IP_CONST_FEAT_ALERTNESS)
    {
        return "Alertness";
    } else if (nSubType == IP_CONST_FEAT_AMBIDEXTROUS)
    {
        return "Ambidextrous";
    } else if (nSubType == IP_CONST_FEAT_ARMOR_PROF_HEAVY)
    {
        return "Armor Proficiency [Heavy]";
    } else if (nSubType == IP_CONST_FEAT_ARMOR_PROF_LIGHT)
    {
        return "Armor Proficiency [Light]";
    } else if (nSubType == IP_CONST_FEAT_ARMOR_PROF_MEDIUM)
    {
        return "Armor Proficiency [Medium]";
    } else if (nSubType == IP_CONST_FEAT_CLEAVE)
    {
        return "Cleave";
    } else if (nSubType == IP_CONST_FEAT_COMBAT_CASTING)
    {
        return "Combat Casting";
    } else if (nSubType == IP_CONST_FEAT_DISARM)
    {
        return "Disarm";
    } else if (nSubType == IP_CONST_FEAT_DISARM_WHIP)
    {
        return "Disarm (Whip)";
    } else if (nSubType == IP_CONST_FEAT_DODGE)
    {
        return "Dodge";
    } else if (nSubType == IP_CONST_FEAT_EXTRA_TURNING)
    {
        return "Extra Turning";
    } else if (nSubType == IP_CONST_FEAT_HIDE_IN_PLAIN_SIGHT)
    {
        return "Hide In Plain Sight";
    } else if (nSubType == IP_CONST_FEAT_IMPCRITUNARM)
    {
        return "Improved Critical [Unarmed]";
    } else if (nSubType == IP_CONST_FEAT_KNOCKDOWN)
    {
        return "Knockdown";
    } else if (nSubType == IP_CONST_FEAT_MOBILITY)
    {
        return "Mobility";
    } else if (nSubType == IP_CONST_FEAT_POINTBLANK)
    {
        return "Point Blank Shot";
    } else if (nSubType == IP_CONST_FEAT_POWERATTACK)
    {
        return "Power Attack";
    } else if (nSubType == IP_CONST_FEAT_RAPID_SHOT)
    {
        return "Rapid Shot";
    } else if (nSubType == IP_CONST_FEAT_SHIELD_PROFICIENCY)
    {
        return "Armor Proficiency [Shield]";
    } else if (nSubType == IP_CONST_FEAT_SNEAK_ATTACK_1D6)
    {
        return "Sneak Attack 1D6";
    } else if (nSubType == IP_CONST_FEAT_SNEAK_ATTACK_2D6)
    {
        return "Sneak Attack 2D6";
    } else if (nSubType == IP_CONST_FEAT_SNEAK_ATTACK_3D6)
    {
        return "Sneak Attack 3D6";
    } else if (nSubType == IP_CONST_FEAT_SNEAK_ATTACK_5D6)
    {
        return "Sneak Attack 5D6";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSABJ)
    {
        return "Spell Focus [Abjuration]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSCON)
    {
        return "Spell Focus [Conjuration]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSDIV)
    {
        return "Spell Focus [Divination]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSENC)
    {
        return "Spell Focus [Enchantment]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSEVO)
    {
        return "Spell Focus [Evocation]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSILL)
    {
        return "Spell Focus [Illusion]";
    } else if (nSubType == IP_CONST_FEAT_SPELLFOCUSNEC)
    {
        return "Spell Focus [Necromancy]";
    } else if (nSubType == IP_CONST_FEAT_SPELLPENETRATION)
    {
        return "Spell Penetration";
    } else if (nSubType == IP_CONST_FEAT_TWO_WEAPON_FIGHTING)
    {
        return "Two Weapon Fighting";
    } else if (nSubType == IP_CONST_FEAT_USE_POISON)
    {
        return "Use Poison";
    } else if (nSubType == IP_CONST_FEAT_WEAPFINESSE)
    {
        return "Weapon Finesse";
    } else if (nSubType == IP_CONST_FEAT_WEAPON_PROF_EXOTIC)
    {
        return "Weapon Proficiency [Exotic]";
    } else if (nSubType == IP_CONST_FEAT_WEAPON_PROF_MARTIAL)
    {
        return "Weapon Proficiency [Martial]";
    } else if (nSubType == IP_CONST_FEAT_WEAPON_PROF_SIMPLE)
    {
        return "Weapon Proficiency [Simple]";
    } else if (nSubType == IP_CONST_FEAT_WEAPSPEUNARM)
    {
        return "Weapon Specialization [Unarmed]";
    } else if (nSubType == IP_CONST_FEAT_WHIRLWIND)
    {
        return "Whirlwind";
    }

    return "";
}

string StringSavingThrowType(int nSubType)
{
    if (nSubType == IP_CONST_SAVEBASETYPE_FORTITUDE)
    {
        return "Fortitude";
    } else if (nSubType == IP_CONST_SAVEBASETYPE_REFLEX)
    {
        return "Reflex";
    } else if (nSubType == IP_CONST_SAVEBASETYPE_WILL)
    {
        return "Willpower";
    }

    return "";
}

string StringSavingThrowAttackType(int nSubType)
{
    if (nSubType == IP_CONST_SAVEVS_ACID)
    {
        return "Acid";
    } else if (nSubType == IP_CONST_SAVEVS_COLD)
    {
        return "Cold";
    } else if (nSubType == IP_CONST_SAVEVS_DEATH)
    {
        return "Death";
    } else if (nSubType == IP_CONST_SAVEVS_DISEASE)
    {
        return "Disease";
    } else if (nSubType == IP_CONST_SAVEVS_DIVINE)
    {
        return "Divine";
    } else if (nSubType == IP_CONST_SAVEVS_ELECTRICAL)
    {
        return "Electrical";
    } else if (nSubType == IP_CONST_SAVEVS_FEAR)
    {
        return "Fear";
    } else if (nSubType == IP_CONST_SAVEVS_FIRE)
    {
        return "Fire";
    } else if (nSubType == IP_CONST_SAVEVS_MINDAFFECTING)
    {
        return "Mind Affecting";
    } else if (nSubType == IP_CONST_SAVEVS_NEGATIVE)
    {
        return "Negative";
    } else if (nSubType == IP_CONST_SAVEVS_POISON)
    {
        return "Poison";
    } else if (nSubType == IP_CONST_SAVEVS_POSITIVE)
    {
        return "Positive";
    } else if (nSubType == IP_CONST_SAVEVS_SONIC)
    {
        return "Sonic";
    } else if (nSubType == IP_CONST_SAVEVS_UNIVERSAL)
    {
        return "Universal";
    }

    return "";
}

string StringSkill(int nSubType)
{
    if (nSubType == SKILL_ANIMAL_EMPATHY)
    {
        return "Animal Empathy";
    } else if (nSubType == SKILL_APPRAISE)
    {
        return "Appraise";
    } else if (nSubType == SKILL_BLUFF)
    {
        return "Bluff";
    } else if (nSubType == SKILL_CONCENTRATION)
    {
        return "Concentration";
    } else if (nSubType == SKILL_CRAFT_ARMOR)
    {
        return "Craft Armor";
    } else if (nSubType == SKILL_CRAFT_TRAP)
    {
        return "Craft Trap";
    } else if (nSubType == SKILL_CRAFT_WEAPON)
    {
        return "Craft Weapon";
    } else if (nSubType == SKILL_DISABLE_TRAP)
    {
        return "Disable Trap";
    } else if (nSubType == SKILL_DISCIPLINE)
    {
        return "Discipline";
    } else if (nSubType == SKILL_HEAL)
    {
        return "Heal";
    } else if (nSubType == SKILL_HIDE)
    {
        return "Hide";
    } else if (nSubType == SKILL_INTIMIDATE)
    {
        return "Intimidate";
    } else if (nSubType == SKILL_LISTEN)
    {
        return "Listen";
    } else if (nSubType == SKILL_LORE)
    {
        return "Lore";
    } else if (nSubType == SKILL_MOVE_SILENTLY)
    {
        return "Move Silently";
    } else if (nSubType == SKILL_OPEN_LOCK)
    {
        return "Open Lock";
    } else if (nSubType == SKILL_PARRY)
    {
        return "Parry";
    } else if (nSubType == SKILL_PERFORM)
    {
        return "Perform";
    } else if (nSubType == SKILL_PERSUADE)
    {
        return "Persuade";
    } else if (nSubType == SKILL_PICK_POCKET)
    {
        return "Pick Pocket";
    } else if (nSubType == SKILL_SEARCH)
    {
        return "Search";
    } else if (nSubType == SKILL_SET_TRAP)
    {
        return "Set Trap";
    } else if (nSubType == SKILL_SPELLCRAFT)
    {
        return "Spellcraft";
    } else if (nSubType == SKILL_SPOT)
    {
        return "Spot";
    } else if (nSubType == SKILL_TAUNT)
    {
        return "Taunt";
    } else if (nSubType == SKILL_TUMBLE)
    {
        return "Tumble";
    } else if (nSubType == SKILL_USE_MAGIC_DEVICE)
    {
        return "Use Magic Device";
    }

    return "";
}

string GetItemPropertyString(itemproperty ipProperty)
{
    string sVariable = "";

    // get property type
    int nPropertyType = GetItemPropertyType(ipProperty);
    DebugMessage("Recipe type is " + IntToString(nPropertyType));

    // get property subtype
    int nPropertySubType = GetItemPropertySubType(ipProperty);
    DebugMessage("Recipe subtype is " + IntToString(nPropertySubType));

    // get property parameter
    int nPropertyParameter = GetItemPropertyParam1(ipProperty);
    DebugMessage("Recipe parameter is " + IntToString(nPropertyParameter));

    // get property parameter value
    int nPropertyParameterValue = GetItemPropertyParam1Value(ipProperty);
    DebugMessage("Recipe parameter value is " + IntToString(nPropertyParameterValue));

    // get property cost table
    int nPropertyCostTable = GetItemPropertyCostTable(ipProperty);
    DebugMessage("Recipe cost table is " + IntToString(nPropertyCostTable));

    // get property cost table value
    int nPropertyCostTableValue = GetItemPropertyCostTableValue(ipProperty);
    DebugMessage("Recipe cost table value is " + IntToString(nPropertyCostTableValue));

    if (nPropertyType == ITEM_PROPERTY_ABILITY_BONUS)
    {
        if (nPropertySubType == IP_CONST_ABILITY_STR)
        {
            sVariable = "Ability Bonus: Strength +" + IntToString(nPropertyCostTableValue);
        } else if (nPropertySubType == IP_CONST_ABILITY_DEX)
        {
            sVariable = "Ability Bonus: Dexterity +" + IntToString(nPropertyCostTableValue);
        } else if (nPropertySubType == IP_CONST_ABILITY_CON)
        {
            sVariable = "Ability Bonus: Constitution +" + IntToString(nPropertyCostTableValue);
        } else if (nPropertySubType == IP_CONST_ABILITY_INT)
        {
            sVariable = "Ability Bonus: Intelligence +" + IntToString(nPropertyCostTableValue);
        } else if (nPropertySubType == IP_CONST_ABILITY_WIS)
        {
            sVariable = "Ability Bonus: Wisdom +" + IntToString(nPropertyCostTableValue);
        } else if (nPropertySubType == IP_CONST_ABILITY_CHA)
        {
            sVariable = "Ability Bonus: Charisma +" + IntToString(nPropertyCostTableValue);
        }
    } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS)
    {
        sVariable = "AC Bonus +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
    {
        sVariable = "AC Bonus vs. " + StringAlignmentGroup(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
    {
        sVariable = "AC Bonus vs. " + StringDamageType(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
    {
        sVariable = "AC Bonus vs. " + StringRacialType(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        sVariable = "AC Bonus vs. " + StringAlignmentSpecific(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
    {
        sVariable = "Arcane Spell Failure " + StringSpellFailure(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS)
    {
        sVariable = "Attack Bonus +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
    {
        sVariable = "Attack Bonus vs. " + StringAlignmentGroup(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
    {
        sVariable = "Attack Bonus vs. " + StringRacialType(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        sVariable = "Attack Bonus vs. " + StringAlignmentSpecific(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
    {
        sVariable = "Reduced Item Weight " + StringItemWeight(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_BONUS_FEAT)
    {
        sVariable = "Bonus Feat: " + StringFeat(nPropertySubType);
    } else if (nPropertyType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
    {
        sVariable = "Bonus Spell Slot: " + StringClass(nPropertySubType) + " Level " + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS)
    {
        sVariable = "Damage Bonus +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)
    {
        sVariable = "Damage Bonus vs. " + StringAlignmentGroup(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)
    {
        sVariable = "Damage Bonus vs. " + StringRacialType(nPropertySubType) + "  +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        sVariable = "Damage Bonus vs. " + StringAlignmentSpecific(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_REDUCTION)
    {
        sVariable = "Damage Reduction +" + StringDamageReduction(nPropertySubType) + "/" + IntToString(nPropertyCostTableValue * 5);
    } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_RESISTANCE)
    {
        sVariable = "Damage Resistance vs. " + StringDamageType(nPropertySubType) + " " + StringDamageSoak(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_DARKVISION)
    {
        sVariable = "Darkvision";
    } else if (nPropertyType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)
    {
        sVariable = "Reduced Container Content Weight " + StringContainerWeight(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS)
    {
        sVariable = "Enhancement Bonus +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
    {
        sVariable = "Enhancement Bonus vs. " + StringAlignmentGroup(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)
    {
        sVariable = "Enhancement Bonus vs. " + StringRacialType(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)
    {
        sVariable = "Enhancement Bonus vs. " + StringAlignmentSpecific(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
    {
        sVariable = "Extra Damage Type: " + StringDamageType(nPropertySubType);
    } else if (nPropertyType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
    {
        sVariable = "Extra Damage Type: " + StringDamageType(nPropertySubType);
    } else if (nPropertyType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)
    {
        sVariable = "Freedom Of Movement";
    } else if (nPropertyType == ITEM_PROPERTY_HASTE)
    {
        sVariable = "Haste";
    } else if (nPropertyType == ITEM_PROPERTY_HEALERS_KIT)
    {
        sVariable = "Healer's Kit +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_HOLY_AVENGER)
    {
        sVariable = "Holy Avenger";
    } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
    {
        sVariable = "Damage Immunity: " + StringDamageType(nPropertySubType);
    } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
    {
        if (nPropertySubType == IP_CONST_IMMUNITYMISC_BACKSTAB)
        {
            sVariable = "Immunity: Backstab";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_CRITICAL_HITS)
        {
            sVariable = "Immunity: Critical Hits";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_DEATH_MAGIC)
        {
            sVariable = "Immunity: Death Magic";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_DISEASE)
        {
            sVariable = "Immunity: Disease";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_FEAR)
        {
            sVariable = "Immunity: Fear";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_KNOCKDOWN)
        {
            sVariable = "Immunity: Knockdown";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN)
        {
            sVariable = "Immunity: Level/Ability Drain";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_MINDSPELLS)
        {
            sVariable = "Immunity: Mind Affecting Spells";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_PARALYSIS)
        {
            sVariable = "Immunity: Paralysis";
        } else if (nPropertySubType == IP_CONST_IMMUNITYMISC_POISON)
        {
            sVariable = "Immunity: Poison";
        }
    } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
    {
        if (nPropertySubType == IP_CONST_SPELLSCHOOL_ABJURATION)
        {
            sVariable = "Immunity: Abjuration Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_CONJURATION)
        {
            sVariable = "Immunity: Conjuration Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_DIVINATION)
        {
            sVariable = "Immunity: Divination Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_ENCHANTMENT)
        {
            sVariable = "Immunity: Enchantment Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_EVOCATION)
        {
            sVariable = "Immunity: Evocation Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_ILLUSION)
        {
            sVariable = "Immunity: Illusion Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_NECROMANCY)
        {
            sVariable = "Immunity: Necromancy Spell School";
        } else if (nPropertySubType == IP_CONST_SPELLSCHOOL_TRANSMUTATION)
        {
            sVariable = "Immunity: Transmutation Spell School";
        }
    } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
    {
        sVariable = "Immunity: Spell Level " + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_IMPROVED_EVASION)
    {
        sVariable = "Improved Evasion";
    } else if (nPropertyType == ITEM_PROPERTY_KEEN)
    {
        sVariable = "Keen";
    } else if (nPropertyType == ITEM_PROPERTY_LIGHT)
    {
        sVariable = StringLightBrightness(nPropertyCostTableValue) + " " + StringLightColor(nPropertyParameterValue) + " Light";
    } else if (nPropertyType == ITEM_PROPERTY_MASSIVE_CRITICALS)
    {
        sVariable = "Massive Criticals " + StringDamageBonus(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_REGENERATION)
    {
        sVariable = "Regeneration +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_REGENERATION_VAMPIRIC)
    {
        sVariable = "Vampiric Regeneration +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_SAVING_THROW_BONUS)
    {
        sVariable = "Saving Throws vs. " + StringSavingThrowAttackType(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
    {
        sVariable = StringSavingThrowType(nPropertySubType) + " Save +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_SKILL_BONUS)
    {
        sVariable = "Skill Bonus: " + StringSkill(nPropertySubType) + " +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_SPELL_RESISTANCE)
    {
        sVariable = "Spell Resistance " + StringSpellResistance(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_THIEVES_TOOLS)
    {
        sVariable = "Thieves' Tools +" + IntToString(nPropertyCostTableValue);
    } else if (nPropertyType == ITEM_PROPERTY_TRUE_SEEING)
    {
        sVariable = "True Seeing";
    } else if (nPropertyType == ITEM_PROPERTY_UNLIMITED_AMMUNITION)
    {
        sVariable = "Unlimited " + GetUnlimitedAmmoType(nPropertyCostTableValue) + " Ammunition";
    }

    return sVariable;
}

string StringSpellFailure(int nSubType)
{
    if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT)
    {
        return "-10%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_15_PERCENT)
    {
        return "-15%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT)
    {
        return "-20%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_25_PERCENT)
    {
        return "-25%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT)
    {
        return "-30%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_35_PERCENT)
    {
        return "-35%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_40_PERCENT)
    {
        return "-40%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_45_PERCENT)
    {
        return "-45%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT)
    {
        return "-5%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_MINUS_50_PERCENT)
    {
        return "-50%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_10_PERCENT)
    {
        return "+10%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_15_PERCENT)
    {
        return "+15%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_20_PERCENT)
    {
        return "+20%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_25_PERCENT)
    {
        return "+25%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_30_PERCENT)
    {
        return "+30%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_35_PERCENT)
    {
        return "+35%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_40_PERCENT)
    {
        return "+40%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_45_PERCENT)
    {
        return "+45%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_5_PERCENT)
    {
        return "+5%";
    } else if (nSubType == IP_CONST_ARCANE_SPELL_FAILURE_PLUS_50_PERCENT)
    {
        return "+50%";
    }

    return "";
}

string StringItemWeight(int nSubType)
{
    if (nSubType == IP_CONST_REDUCEDWEIGHT_10_PERCENT)
    {
        return "-10%";
    } else if (nSubType == IP_CONST_REDUCEDWEIGHT_20_PERCENT)
    {
        return "-20%";
    } else if (nSubType == IP_CONST_REDUCEDWEIGHT_40_PERCENT)
    {
        return "-40%";
    } else if (nSubType == IP_CONST_REDUCEDWEIGHT_60_PERCENT)
    {
        return "-60%";
    } else if (nSubType == IP_CONST_REDUCEDWEIGHT_80_PERCENT)
    {
        return "-80%";
    }

    return "";
}

string StringDamageReduction(int nSubType)
{
    if (nSubType == IP_CONST_DAMAGEREDUCTION_1)
    {
        return "1";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_10)
    {
        return "10";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_11)
    {
        return "11";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_12)
    {
        return "12";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_13)
    {
        return "13";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_14)
    {
        return "14";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_15)
    {
        return "15";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_16)
    {
        return "16";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_17)
    {
        return "17";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_18)
    {
        return "18";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_19)
    {
        return "19";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_2)
    {
        return "2";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_20)
    {
        return "20";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_3)
    {
        return "3";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_4)
    {
        return "4";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_5)
    {
        return "5";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_6)
    {
        return "6";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_7)
    {
        return "7";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_8)
    {
        return "8";
    } else if (nSubType == IP_CONST_DAMAGEREDUCTION_9)
    {
        return "9";
    }

    return "";
}

string StringDamageSoak(int nSubType)
{
    if (nSubType == IP_CONST_DAMAGERESIST_10)
    {
        return "10";
    } else if (nSubType == IP_CONST_DAMAGERESIST_15)
    {
        return "15";
    } else if (nSubType == IP_CONST_DAMAGERESIST_20)
    {
        return "20";
    } else if (nSubType == IP_CONST_DAMAGERESIST_25)
    {
        return "25";
    } else if (nSubType == IP_CONST_DAMAGERESIST_30)
    {
        return "30";
    } else if (nSubType == IP_CONST_DAMAGERESIST_35)
    {
        return "35";
    } else if (nSubType == IP_CONST_DAMAGERESIST_40)
    {
        return "40";
    } else if (nSubType == IP_CONST_DAMAGERESIST_45)
    {
        return "45";
    } else if (nSubType == IP_CONST_DAMAGERESIST_5)
    {
        return "5";
    } else if (nSubType == IP_CONST_DAMAGERESIST_50)
    {
        return "50";
    }

    return "";
}

string StringContainerWeight(int nSubType)
{
    if (nSubType == IP_CONST_CONTAINERWEIGHTRED_100_PERCENT)
    {
        return "-100%";
    } else if (nSubType == IP_CONST_CONTAINERWEIGHTRED_20_PERCENT)
    {
        return "-20%";
    } else if (nSubType == IP_CONST_CONTAINERWEIGHTRED_40_PERCENT)
    {
        return "-40%";
    } else if (nSubType == IP_CONST_CONTAINERWEIGHTRED_60_PERCENT)
    {
        return "-60%";
    } else if (nSubType == IP_CONST_CONTAINERWEIGHTRED_80_PERCENT)
    {
        return "-80%";
    }

    return "";
}

string StringLightBrightness(int nSubType)
{
    if (nSubType == IP_CONST_LIGHTBRIGHTNESS_BRIGHT)
    {
        return "Bright";
    } else if (nSubType == IP_CONST_LIGHTBRIGHTNESS_DIM)
    {
        return "Dim";
    } else if (nSubType == IP_CONST_LIGHTBRIGHTNESS_LOW)
    {
        return "Low";
    } else if (nSubType == IP_CONST_LIGHTBRIGHTNESS_NORMAL)
    {
        return "Normal";
    }

    return "";
}

string StringLightColor(int nSubType)
{
    if (nSubType == IP_CONST_LIGHTCOLOR_BLUE)
    {
        return "Blue";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_GREEN)
    {
        return "Green";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_ORANGE)
    {
        return "Orange";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_PURPLE)
    {
        return "Purple";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_RED)
    {
        return "Red";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_WHITE)
    {
        return "White";
    } else if (nSubType == IP_CONST_LIGHTCOLOR_YELLOW)
    {
        return "Yellow";
    }

    return "";
}

string StringDamageBonus(int nSubType)
{
    if (nSubType == IP_CONST_DAMAGEBONUS_1)
    {
        return "+1";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_10)
    {
        return "+10";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_1d10)
    {
        return "+1D10";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_1d12)
    {
        return "+1D12";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_1d4)
    {
        return "+1D4";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_1d6)
    {
        return "+1D6";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_1d8)
    {
        return "+1D8";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2)
    {
        return "+2";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2d10)
    {
        return "+2D10";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2d12)
    {
        return "+2D12";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2d4)
    {
        return "+2D4";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2d6)
    {
        return "+2D6";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_2d8)
    {
        return "+2D8";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_3)
    {
        return "+3";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_4)
    {
        return "+4";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_5)
    {
        return "+5";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_6)
    {
        return "+6";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_7)
    {
        return "+7";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_8)
    {
        return "+8";
    } else if (nSubType == IP_CONST_DAMAGEBONUS_9)
    {
        return "+9";
    }

    return "";
}

string StringSpellResistance(int nSubType)
{
    if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_10)
    {
        return "10";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_12)
    {
        return "12";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_14)
    {
        return "14";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_16)
    {
        return "16";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_18)
    {
        return "18";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_20)
    {
        return "20";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_22)
    {
        return "22";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_24)
    {
        return "24";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_26)
    {
        return "26";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_28)
    {
        return "28";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_30)
    {
        return "30";
    } else if (nSubType == IP_CONST_SPELLRESISTANCEBONUS_32)
    {
        return "32";
    }

    return "";
}

int TranslateInternalToExternal(int nProperty)
{
    if (nProperty == 1)
    {
        return ITEM_PROPERTY_ABILITY_BONUS;
    } else if (nProperty == 2)
    {
        return ITEM_PROPERTY_AC_BONUS;
    } else if (nProperty == 3)
    {
        return ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP;
    } else if (nProperty == 4)
    {
        return ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE;
    } else if (nProperty == 5)
    {
        return ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP;
    } else if (nProperty == 6)
    {
        return ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT;
    } else if (nProperty == 7)
    {
        return ITEM_PROPERTY_ARCANE_SPELL_FAILURE;
    } else if (nProperty == 8)
    {
        return ITEM_PROPERTY_ATTACK_BONUS;
    } else if (nProperty == 9)
    {
        return ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP;
    } else if (nProperty == 10)
    {
        return ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP;
    } else if (nProperty == 11)
    {
        return ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT;
    } else if (nProperty == 12)
    {
        return ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION;
    } else if (nProperty == 13)
    {
        return ITEM_PROPERTY_BONUS_FEAT;
    } else if (nProperty == 14)
    {
        return ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N;
    } else if (nProperty == 15)
    {
        return ITEM_PROPERTY_DAMAGE_BONUS;
    } else if (nProperty == 16)
    {
        return ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP;
    } else if (nProperty == 17)
    {
        return ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP;
    } else if (nProperty == 18)
    {
        return ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT;
    } else if (nProperty == 19)
    {
        return ITEM_PROPERTY_DAMAGE_REDUCTION;
    } else if (nProperty == 20)
    {
        return ITEM_PROPERTY_DAMAGE_RESISTANCE;
    } else if (nProperty == 21)
    {
        return ITEM_PROPERTY_DARKVISION;
    } else if (nProperty == 22)
    {
        return ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT;
    } else if (nProperty == 23)
    {
        return ITEM_PROPERTY_ENHANCEMENT_BONUS;
    } else if (nProperty == 24)
    {
        return ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP;
    } else if (nProperty == 25)
    {
        return ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP;
    } else if (nProperty == 26)
    {
        return ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT;
    } else if (nProperty == 27)
    {
        return ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE;
    } else if (nProperty == 28)
    {
        return ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE;
    } else if (nProperty == 29)
    {
        return ITEM_PROPERTY_FREEDOM_OF_MOVEMENT;
    } else if (nProperty == 30)
    {
        return ITEM_PROPERTY_HASTE;
    } else if (nProperty == 31)
    {
        return ITEM_PROPERTY_HEALERS_KIT;
    } else if (nProperty == 32)
    {
        return ITEM_PROPERTY_HOLY_AVENGER;
    } else if (nProperty == 33)
    {
        return ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE;
    } else if (nProperty == 34)
    {
        return ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS;
    } else if (nProperty == 35)
    {
        return ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL;
    } else if (nProperty == 36)
    {
        return ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL;
    } else if (nProperty == 37)
    {
        return ITEM_PROPERTY_IMPROVED_EVASION;
    } else if (nProperty == 38)
    {
        return ITEM_PROPERTY_KEEN;
    } else if (nProperty == 39)
    {
        return ITEM_PROPERTY_LIGHT;
    } else if (nProperty == 40)
    {
        return ITEM_PROPERTY_MASSIVE_CRITICALS;
    } else if (nProperty == 41)
    {
        return ITEM_PROPERTY_REGENERATION;
    } else if (nProperty == 42)
    {
        return ITEM_PROPERTY_REGENERATION_VAMPIRIC;
    } else if (nProperty == 43)
    {
        return ITEM_PROPERTY_SAVING_THROW_BONUS;
    } else if (nProperty == 44)
    {
        return ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC;
    } else if (nProperty == 45)
    {
        return ITEM_PROPERTY_SKILL_BONUS;
    } else if (nProperty == 46)
    {
        return ITEM_PROPERTY_SPELL_RESISTANCE;
    } else if (nProperty == 47)
    {
        return ITEM_PROPERTY_THIEVES_TOOLS;
    } else if (nProperty == 48)
    {
        return ITEM_PROPERTY_TRUE_SEEING;
    } else if (nProperty == 49)
    {
        return ITEM_PROPERTY_UNLIMITED_AMMUNITION;
    } else
    {
        return -1;
    }
}

int TranslateExternalToInternal(int nProperty)
{
    if (nProperty == ITEM_PROPERTY_ABILITY_BONUS)
    {
        return 1;
    } else if (nProperty == ITEM_PROPERTY_AC_BONUS)
    {
        return 2;
    } else if (nProperty == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
    {
        return 3;
    } else if (nProperty == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
    {
        return 4;
    } else if (nProperty == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
    {
        return 5;
    } else if (nProperty == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        return 6;
    } else if (nProperty == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
    {
        return 7;
    } else if (nProperty == ITEM_PROPERTY_ATTACK_BONUS)
    {
        return 8;
    } else if (nProperty == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
    {
        return 9;
    } else if (nProperty == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
    {
        return 10;
    } else if (nProperty == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        return 11;
    } else if (nProperty == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
    {
        return 12;
    } else if (nProperty == ITEM_PROPERTY_BONUS_FEAT)
    {
        return 13;
    } else if (nProperty == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
    {
        return 14;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_BONUS)
    {
        return 15;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)
    {
        return 16;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)
    {
        return 17;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)
    {
        return 18;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_REDUCTION)
    {
        return 19;
    } else if (nProperty == ITEM_PROPERTY_DAMAGE_RESISTANCE)
    {
        return 20;
    } else if (nProperty == ITEM_PROPERTY_DARKVISION)
    {
        return 21;
    } else if (nProperty == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)
    {
        return 22;
    } else if (nProperty == ITEM_PROPERTY_ENHANCEMENT_BONUS)
    {
        return 23;
    } else if (nProperty == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
    {
        return 24;
    } else if (nProperty == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)
    {
        return 25;
    } else if (nProperty == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)
    {
        return 26;
    } else if (nProperty == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
    {
        return 27;
    } else if (nProperty == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
    {
        return 28;
    } else if (nProperty == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)
    {
        return 29;
    } else if (nProperty == ITEM_PROPERTY_HASTE)
    {
        return 30;
    } else if (nProperty == ITEM_PROPERTY_HEALERS_KIT)
    {
        return 31;
    } else if (nProperty == ITEM_PROPERTY_HOLY_AVENGER)
    {
        return 32;
    } else if (nProperty == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
    {
        return 33;
    } else if (nProperty == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
    {
        return 34;
    } else if (nProperty == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
    {
        return 35;
    } else if (nProperty == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
    {
        return 36;
    } else if (nProperty == ITEM_PROPERTY_IMPROVED_EVASION)
    {
        return 37;
    } else if (nProperty == ITEM_PROPERTY_KEEN)
    {
        return 38;
    } else if (nProperty == ITEM_PROPERTY_LIGHT)
    {
        return 39;
    } else if (nProperty == ITEM_PROPERTY_MASSIVE_CRITICALS)
    {
        return 40;
    } else if (nProperty == ITEM_PROPERTY_REGENERATION)
    {
        return 41;
    } else if (nProperty == ITEM_PROPERTY_REGENERATION_VAMPIRIC)
    {
        return 42;
    } else if (nProperty == ITEM_PROPERTY_SAVING_THROW_BONUS)
    {
        return 43;
    } else if (nProperty == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
    {
        return 44;
    } else if (nProperty == ITEM_PROPERTY_SKILL_BONUS)
    {
        return 45;
    } else if (nProperty == ITEM_PROPERTY_SPELL_RESISTANCE)
    {
        return 46;
    } else if (nProperty == ITEM_PROPERTY_THIEVES_TOOLS)
    {
        return 47;
    } else if (nProperty == ITEM_PROPERTY_TRUE_SEEING)
    {
        return 48;
    } else if (nProperty == ITEM_PROPERTY_UNLIMITED_AMMUNITION)
    {
        return 49;
    } else
    {
        return -1;
    }
}

/*
ITEM_PROPERTY_ABILITY_BONUS 0 1-12
ITEM_PROPERTY_AC_BONUS 0 1-20
ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP 0 1-20
ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE 0 1-20
ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP 0 1-20
ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT 0 1-20
ITEM_PROPERTY_ARCANE_SPELL_FAILURE
ITEM_PROPERTY_ATTACK_BONUS 0 1-20
ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP 0 1-20
ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP 0 1-20

ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT 0 1-20
ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION
ITEM_PROPERTY_BONUS_FEAT 0 *0-37,39
ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N
ITEM_PROPERTY_DAMAGE_BONUS
ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP
ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP
ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT
ITEM_PROPERTY_DAMAGE_REDUCTION 0-19 1-10
ITEM_PROPERTY_DAMAGE_RESISTANCE *0-2,5-13 1-10

ITEM_PROPERTY_DARKVISION
ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT
ITEM_PROPERTY_ENHANCEMENT_BONUS 0 1-20
ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP 0 1-20
ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP 0 1-20
ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT 0 1-20
ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE
ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE
ITEM_PROPERTY_FREEDOM_OF_MOVEMENT
ITEM_PROPERTY_HASTE

ITEM_PROPERTY_HEALERS_KIT
ITEM_PROPERTY_HOLY_AVENGER
ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE
ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS *0-9 0
ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL
ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL
ITEM_PROPERTY_IMPROVED_EVASION
ITEM_PROPERTY_KEEN
ITEM_PROPERTY_LIGHT
ITEM_PROPERTY_MASSIVE_CRITICALS

ITEM_PROPERTY_REGENERATION 0 1-20
ITEM_PROPERTY_REGENERATION_VAMPIRIC 0 1-20
ITEM_PROPERTY_SAVING_THROW_BONUS *0-1,3-9,11-15 1-20
ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC 0 1-20
ITEM_PROPERTY_SKILL_BONUS
ITEM_PROPERTY_SPELL_RESISTANCE
ITEM_PROPERTY_THIEVES_TOOLS
ITEM_PROPERTY_TRUE_SEEING
ITEM_PROPERTY_UNLIMITED_AMMUNITION
*/

string GetItemPropertyColumn(int nPropertyColumn)
{
    string sColumn = "";

    if (nPropertyColumn == 0) // melee
    {
        sColumn = "0_Melee";
    } else if (nPropertyColumn == 1) // ranged
    {
        sColumn = "1_Ranged";
    } else if (nPropertyColumn == 2) // thrown
    {
        sColumn = "2_Thrown";
    } else if (nPropertyColumn == 3) // staves
    {
        sColumn = "3_Staves";
    } else if (nPropertyColumn == 4) // rods
    {
        sColumn = "4_Rods";
    } else if (nPropertyColumn == 5) // ammo
    {
        sColumn = "5_Ammo";
    } else if (nPropertyColumn == 6) // armor or shield
    {
        sColumn = "6_Arm_Shld";
    } else if (nPropertyColumn == 7) // helms
    {
        sColumn = "7_Helm";
    } else if (nPropertyColumn == 8) // potions
    {
        sColumn = "8_Potions";
    } else if (nPropertyColumn == 9) // scrolls
    {
        sColumn = "9_Scrolls";
    } else if (nPropertyColumn == 10) // wands
    {
        sColumn = "10_Wands";
    } else if (nPropertyColumn == 11) // thieves tools
    {
        sColumn = "11_Thieves";
    } else if (nPropertyColumn == 12) // trap kits
    {
        sColumn = "12_TrapKits";
    } else if (nPropertyColumn == 13) // hides
    {
        sColumn = "13_Hide";
    } else if (nPropertyColumn == 14) // claws
    {
        sColumn = "14_Claw";
    } else if (nPropertyColumn == 15) // miscellaneous unequipped
    {
        sColumn = "15_Misc_Uneq";
    } else if (nPropertyColumn == 16) // miscellaneous
    {
        sColumn = "16_Misc";
    } else if (nPropertyColumn == 17) // no properties
    {
        sColumn = "17_No_Props";
    } else if (nPropertyColumn == 18) // containers
    {
        sColumn = "18_Containers";
    } else if (nPropertyColumn == 19) // healer kits
    {
        sColumn = "19_HealerKit";
    } else if (nPropertyColumn == 20) // torch
    {
        sColumn = "20_Torch";
    } else if (nPropertyColumn == 21) // gloves
    {
        sColumn = "21_Glove";
    } else if (nPropertyColumn == 22) // recipes
    {
        sColumn = "22_Recipe";
    }

    return sColumn;
}

itemproperty GetSpecificProperty(int nProperty, object oItem)
{
    int nCount = 1;
    itemproperty ipProperty = GetFirstItemProperty(oItem);

    while (nCount < nProperty)
    {
        nCount++;
        ipProperty = GetNextItemProperty(oItem);
    }

    return ipProperty;
}

void AddPropertyToItem(int nProperty, int nFirstTable, int nSecondTable, int nSubType, object oItem)
{
    // get actual values
    int nActualFirstTable = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable" + IntToString(nFirstTable) + "Line");
    int nActualSecondTable = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable" + IntToString(nSecondTable) + "Line");
    int nActualSubType = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType" + IntToString(nSubType));

    if (oItem == OBJECT_INVALID)
    {
        DebugMessage("  There is no valid item.");
    }

    if (nProperty == 1)
    {
        DebugMessage("    Adding ability bonus.");
        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(nActualSubType, nActualSecondTable));
    } else if (nProperty == 2)
    {
        DebugMessage("    Adding ac.");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nActualSecondTable));
    } else if (nProperty == 3)
    {
        DebugMessage("    Adding ac vs alignment group.");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 4)
    {
        DebugMessage("    Adding ac vs damage type.");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsDmgType(nActualSubType, nActualSecondTable));
    } else if (nProperty == 5)
    {
        DebugMessage("    Adding ac vs race.");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsRace(nActualSubType, nActualSecondTable));
    } else if (nProperty == 6)
    {
        DebugMessage("    Adding ac vs alignment.");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsSAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 7)
    {
        DebugMessage("    Adding arcane spell failure.");
        IPSafeAddItemProperty(oItem, ItemPropertyArcaneSpellFailure(nActualSecondTable));
    } else if (nProperty == 8)
    {
        DebugMessage("    Adding attack.");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nActualSecondTable));
    } else if (nProperty == 9)
    {
        DebugMessage("    Adding attack vs alignment group.");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 10)
    {
        DebugMessage("    Adding attack vs race.");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(nActualSubType, nActualSecondTable));
    } else if (nProperty == 11)
    {
        DebugMessage("    Adding attack vs alignment.");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsSAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 12)
    {
        DebugMessage("    Adding weight reduction.");
        IPSafeAddItemProperty(oItem, ItemPropertyWeightReduction(nActualSecondTable));
    } else if (nProperty == 13)
    {
        DebugMessage("    Adding bonus feat.");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusFeat(nActualFirstTable));
    } else if (nProperty == 14)
    {
        DebugMessage("    Adding bonus spell.");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusLevelSpell(nActualSubType, nActualSecondTable));
    } else if (nProperty == 15)
    {
        DebugMessage("    Adding damage.");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(nActualSubType, nActualSecondTable));
    } else if (nProperty == 16)
    {
        DebugMessage("    Adding damage vs alignment group.");
        int nDamageType = GetRandomDamageType(); // EDIT: damage exceptions
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(nActualSubType, nDamageType, nActualSecondTable));
    } else if (nProperty == 17)
    {
        DebugMessage("    Adding damage vs race.");
        int nDamageType = GetRandomDamageType(); // EDIT: damage exceptions
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(nActualSubType, nDamageType, nActualSecondTable));
    } else if (nProperty == 18)
    {
        DebugMessage("    Adding damage vs alignment.");
        int nDamageType = GetRandomDamageType(); // EDIT: damage exceptions
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsSAlign(nActualSubType, nDamageType, nActualSecondTable));
    } else if (nProperty == 19)
    {
        DebugMessage("    Adding damage reduction.");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageReduction(nActualFirstTable, nActualSecondTable));
    } else if (nProperty == 20)
    {
        DebugMessage("    Adding damage resistance.");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(nActualFirstTable, nActualSecondTable));
    } else if (nProperty == 21)
    {
        DebugMessage("    Adding darkvision.");
        IPSafeAddItemProperty(oItem, ItemPropertyDarkvision());
    } else if (nProperty == 22)
    {
        DebugMessage("    Adding container reduced weight.");
        IPSafeAddItemProperty(oItem, ItemPropertyContainerReducedWeight(nActualSecondTable));
    } else if (nProperty == 23)
    {
        DebugMessage("    Adding enhancement.");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nActualSecondTable));
    } else if (nProperty == 24)
    {
        DebugMessage("    Adding ehancement vs alignment group.");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 25)
    {
        DebugMessage("    Adding enhancement vs race.");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsRace(nActualSubType, nActualSecondTable));
    } else if (nProperty == 26)
    {
        DebugMessage("    Adding enhancement vs alignment.");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsSAlign(nActualSubType, nActualSecondTable));
    } else if (nProperty == 27)
    {
        DebugMessage("    Adding extra melee damage.");
        IPSafeAddItemProperty(oItem, ItemPropertyExtraMeleeDamageType(nActualSubType));
    } else if (nProperty == 28)
    {
        DebugMessage("    Adding extra ranged damage.");
        IPSafeAddItemProperty(oItem, ItemPropertyExtraRangeDamageType(nActualSubType));
    } else if (nProperty == 29)
    {
        DebugMessage("    Adding freedom of movement.");
        IPSafeAddItemProperty(oItem, ItemPropertyFreeAction());
    } else if (nProperty == 30)
    {
        DebugMessage("    Adding haste.");
        IPSafeAddItemProperty(oItem, ItemPropertyHaste());
    } else if (nProperty == 31)
    {
        DebugMessage("    Adding healer kit.");
        IPSafeAddItemProperty(oItem, ItemPropertyHealersKit(nActualSecondTable));
    } else if (nProperty == 32)
    {
        DebugMessage("    Adding holy avenger.");
        IPSafeAddItemProperty(oItem, ItemPropertyHolyAvenger());
    } else if (nProperty == 33)
    {
        DebugMessage("    Adding damage immunity.");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageImmunity(nSubType, nActualSecondTable));
    } else if (nProperty == 34)
    {
        DebugMessage("    Adding miscellaneous immunity.");
        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(nActualFirstTable));
    } else if (nProperty == 35)
    {
        DebugMessage("    Adding spell school immunity.");
        IPSafeAddItemProperty(oItem, ItemPropertySpellImmunitySchool(nActualSubType));
    } else if (nProperty == 36)
    {
        DebugMessage("    Adding spell level immunity.");
        IPSafeAddItemProperty(oItem, ItemPropertyImmunityToSpellLevel(nActualSecondTable));
    } else if (nProperty == 37)
    {
        DebugMessage("    Adding improved evasion.");
        IPSafeAddItemProperty(oItem, ItemPropertyImprovedEvasion());
    } else if (nProperty == 38)
    {
        DebugMessage("    Adding keen.");
        IPSafeAddItemProperty(oItem, ItemPropertyKeen());
    } else if (nProperty == 39)
    {
        DebugMessage("    Adding light.");
        int nRandom = Random(7) + 1;
        int nColor;
        if (nRandom == 1)
        {
            nColor = IP_CONST_LIGHTCOLOR_BLUE;
        } else if (nRandom == 2)
        {
            nColor = IP_CONST_LIGHTCOLOR_GREEN;
        } else if (nRandom == 3)
        {
            nColor = IP_CONST_LIGHTCOLOR_ORANGE;
        } else if (nRandom == 4)
        {
            nColor = IP_CONST_LIGHTCOLOR_PURPLE;
        } else if (nRandom == 5)
        {
            nColor = IP_CONST_LIGHTCOLOR_RED;
        } else if (nRandom == 6)
        {
            nColor = IP_CONST_LIGHTCOLOR_WHITE;
        } else if (nRandom == 7)
        {
            nColor = IP_CONST_LIGHTCOLOR_YELLOW;
        }
        IPSafeAddItemProperty(oItem, ItemPropertyLight(nActualSecondTable, nColor));
    } else if (nProperty == 40)
    {
        DebugMessage("    Adding massive criticals.");
        IPSafeAddItemProperty(oItem, ItemPropertyMassiveCritical(nActualSecondTable));
    } else if (nProperty == 41)
    {
        DebugMessage("    Adding regeneration.");
        IPSafeAddItemProperty(oItem, ItemPropertyRegeneration(nActualSecondTable));
    } else if (nProperty == 42)
    {
        DebugMessage("    Adding vampiric regeneration.");
        IPSafeAddItemProperty(oItem, ItemPropertyVampiricRegeneration(nActualSecondTable));
    } else if (nProperty == 43)
    {
        DebugMessage("    Adding saving throw.");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(nActualFirstTable, nActualSecondTable));
    } else if (nProperty == 44)
    {
        DebugMessage("    Adding specific saving throw.");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(nActualSubType, nActualSecondTable));
    } else if (nProperty == 45)
    {
        DebugMessage("    Adding skill bonus.");
        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(nActualSubType, nActualSecondTable));
    } else if (nProperty == 46)
    {
        DebugMessage("    Adding SR.");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(nActualSecondTable));
    } else if (nProperty == 47)
    {
        DebugMessage("    Adding thieves tools.");
        IPSafeAddItemProperty(oItem, ItemPropertyThievesTools(nActualSecondTable));
    } else if (nProperty == 48)
    {
        DebugMessage("    Adding true seeing.");
        IPSafeAddItemProperty(oItem, ItemPropertyTrueSeeing());
    } else if (nProperty == 49)
    {
        DebugMessage("    Adding unlimited ammo.");
        IPSafeAddItemProperty(oItem, ItemPropertyUnlimitedAmmo(nActualSecondTable));
    }
}

int GetRandomDamageType()
{
    int nRandom = Random(12) + 1;
    if (nRandom == 1)
    {
        return IP_CONST_DAMAGETYPE_ACID;
    } else if (nRandom == 2)
    {
        return IP_CONST_DAMAGETYPE_BLUDGEONING;
    } else if (nRandom == 3)
    {
        return IP_CONST_DAMAGETYPE_COLD;
    } else if (nRandom == 4)
    {
        return IP_CONST_DAMAGETYPE_DIVINE;
    } else if (nRandom == 5)
    {
        return IP_CONST_DAMAGETYPE_ELECTRICAL;
    } else if (nRandom == 6)
    {
        return IP_CONST_DAMAGETYPE_FIRE;
    } else if (nRandom == 7)
    {
        return IP_CONST_DAMAGETYPE_MAGICAL;
    } else if (nRandom == 8)
    {
        return IP_CONST_DAMAGETYPE_NEGATIVE;
    } else if (nRandom == 9)
    {
        return IP_CONST_DAMAGETYPE_PIERCING;
    } else if (nRandom == 10)
    {
        return IP_CONST_DAMAGETYPE_POSITIVE;
    } else if (nRandom == 11)
    {
        return IP_CONST_DAMAGETYPE_SLASHING;
    } else
    {
        return IP_CONST_DAMAGETYPE_SONIC;
    }
}

string GetUnlimitedAmmoType(int nSubType)
{
    if (nSubType == IP_CONST_UNLIMITEDAMMO_BASIC)
    {
        return "Basic";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_1D6COLD)
    {
        return "Cold";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_1D6FIRE)
    {
        return "Fire";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_1D6LIGHT)
    {
        return "Light";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_PLUS1)
    {
        return "+1";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_PLUS2)
    {
        return "+2";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_PLUS3)
    {
        return "+3";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_PLUS4)
    {
        return "+4";
    } else if (nSubType == IP_CONST_UNLIMITEDAMMO_PLUS5)
    {
        return "+5";
    } else
    {
        return "";
    }
}

int LimitBonusMax(int nProperty, int nTableMax, int nItemLevel)
{
    if (nProperty == 1) // ability score
    {
        if (nTableMax > (nItemLevel / 2))
        {
            nTableMax = nItemLevel / 2;
        }
    }
    if ((nProperty == 2) || (nProperty == 3) || (nProperty == 4) || (nProperty == 5) || (nProperty == 6)) // ac
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if ((nProperty == 8) || (nProperty == 9) || (nProperty == 10) || (nProperty == 11)) // attack
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if (nProperty == 14) // bonus spell
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if ((nProperty == 15) || (nProperty == 16) || (nProperty == 17) || (nProperty == 18)) // damage
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if ((nProperty == 23) || (nProperty == 24) || (nProperty == 25) || (nProperty == 26)) // enhancement
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if (nProperty == 31) // healer kit
    {
        if (nTableMax > (nItemLevel / 2))
        {
            nTableMax = nItemLevel / 2;
        }
    }
    if (nProperty == 36) // immunity to spell level
    {
        if (nTableMax > (nItemLevel / 3))
        {
            nTableMax = nItemLevel / 3;
        }
    }
    if (nProperty == 40) // massive criticals
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if (nProperty == 41) // regeneration
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if (nProperty == 42) // vampiric regeneration
    {
        if (nTableMax > (nItemLevel / 4))
        {
            nTableMax = nItemLevel / 4;
        }
    }
    if (nProperty == 43) // saving throw
    {
        if (nTableMax > (nItemLevel / 2))
        {
            nTableMax = nItemLevel / 2;
        }
    }
    if (nProperty == 44) // specific saving throw
    {
        if (nTableMax > (nItemLevel / 2))
        {
            nTableMax = nItemLevel / 2;
        }
    }
    if (nProperty == 45) // skills
    {
        if (nTableMax > nItemLevel)
        {
            nTableMax = nItemLevel;
        }
    }
    if (nProperty == 47) // thieves tools
    {
        if (nTableMax > (nItemLevel / 2))
        {
            nTableMax = nItemLevel / 2;
        }
    }

    if (nTableMax < 1)
    {
        nTableMax = 1;
    }

    return nTableMax;
}

// void main(){}
