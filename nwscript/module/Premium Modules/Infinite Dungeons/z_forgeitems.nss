// give the player 1 of every forge recipe and lots of gems

#include "inc_id1_debug"
#include "x2_inc_itemprop"
#include "inc_id1_items"

void main()
{
    PrintString("");
    PrintString("Giving player forge recipes and gems.");

    object oPC = GetFirstPC();
    object oItem;

    // create gems
    oItem = CreateItemOnObject("id1_gem_01_01", oPC, 10);
    oItem = CreateItemOnObject("id1_gem_01_01", oPC, 10);
    oItem = CreateItemOnObject("id1_gem_01_01", oPC, 10);
    oItem = CreateItemOnObject("id1_gem_01_01", oPC, 10);
    oItem = CreateItemOnObject("id1_gem_01_01", oPC, 10);

    // create recipes
    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_BLUDGEONING, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsRace(RACIAL_TYPE_HUMAN, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyACBonusVsSAlign(IP_CONST_ALIGNMENT_CE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_25_PERCENT));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(RACIAL_TYPE_HUMAN, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsSAlign(IP_CONST_ALIGNMENT_CE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusFeat(IP_CONST_FEAT_SHIELD_PROFICIENCY));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD, IP_CONST_SPELLLEVEL_9));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGEBONUS_5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGEBONUS_5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(RACIAL_TYPE_HUMAN, IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGEBONUS_5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsSAlign(IP_CONST_ALIGNMENT_CE, IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGEBONUS_5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5, IP_CONST_DAMAGESOAK_25_HP));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGERESIST_25));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDarkvision());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyContainerReducedWeight(IP_CONST_CONTAINERWEIGHTRED_100_PERCENT));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsRace(RACIAL_TYPE_HUMAN, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonusVsSAlign(IP_CONST_ALIGNMENT_CE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyExtraMeleeDamageType(IP_CONST_DAMAGETYPE_BLUDGEONING));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyExtraRangeDamageType(IP_CONST_DAMAGETYPE_BLUDGEONING));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyFreeAction());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyHaste());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyHealersKit(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyHolyAvenger());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING, IP_CONST_DAMAGEIMMUNITY_50_PERCENT));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertySpellImmunitySchool(IP_CONST_SPELLSCHOOL_EVOCATION));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyImmunityToSpellLevel(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyImprovedEvasion());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyKeen());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT, IP_CONST_LIGHTCOLOR_WHITE));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyRegeneration(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyVampiricRegeneration(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_USE_MAGIC_DEVICE, 5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyThievesTools(5));
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyTrueSeeing());
    SetRecipeName(oItem);

    oItem = CreateItemOnObject("id1_recipe", oPC, 1, "id1_recipe_111");
        IPSafeAddItemProperty(oItem, ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_PLUS5));
    SetRecipeName(oItem);
}
