// functions related to the altar of blessings in hillsfar
//
//  HF_ARG  - selects the blessing category
//   1 = general aid blessing
//   2 = enhancement
//   3 = bonus versus type
//   4 = damage bonus
//
//  HF_PLOT - selects the blessing type within that category

#include "x2_inc_itemprop"
#include "hf_in_plot"

// returns the altar object
object AltarGetAltar()
{
    return GetObjectByTag("pl_altar_of_blessings");
}

// returns the altar conversation object
object AltarGetAltarStool()
{
    return GetObjectByTag("pl_altar_of_blessings_stool");
}

// returns the first item in the altar
object AltarGetItem()
{
    object oAltar = AltarGetAltar();
    if (GetIsObjectValid(oAltar))
    {
        return GetFirstItemInInventory(oAltar);
    }
    return OBJECT_INVALID;
}

// returns the number of items on the altar
int AltarGetItemCount()
{
    int nCount = 0;
    object oAltar = AltarGetAltar();
    if (GetIsObjectValid(oAltar))
    {
        object oItem = GetFirstItemInInventory(oAltar);
        while(GetIsObjectValid(oItem))
        {
            nCount++;
            oItem = GetNextItemInInventory(oAltar);
        }
    }
    return nCount;
}

// returns true when the altar contains a ranged weapon
int AltarIsItemRanged()
{
    object oAltar = AltarGetAltar();
    if (GetIsObjectValid(oAltar))
    {
        object oItem = GetFirstItemInInventory(oAltar);
        while(GetIsObjectValid(oItem))
        {
            if (IPGetIsRangedWeapon(oItem))
            {
                return TRUE;
            }
            oItem = GetNextItemInInventory(oAltar);
        }
    }
    return FALSE;
}

// returns true when the altar contains a single melee weapon
int AltarIsItemValid()
{
    object oAltar = AltarGetAltar();
    if (GetIsObjectValid(oAltar))
    {
        int nCount = AltarGetItemCount();
        if (nCount == 1)
        {
            object oItem = GetFirstItemInInventory(oAltar);
            if (GetIsObjectValid(oItem))
            {
                if (IPGetIsMeleeWeapon(oItem))
                {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

// returns the selected blessing category
int AltarGetSelectedBlessingCategory()
{
    object oAltar = AltarGetAltarStool();
    if (GetIsObjectValid(oAltar))
    {
        return GetLocalInt(oAltar, "HF_ARG");
    }
    return -1;
}

// returns the selected blessing number within the category
int AltarGetSelectedBlessingNumber()
{
    object oAltar = AltarGetAltarStool();
    if (GetIsObjectValid(oAltar))
    {
        return PlotLevelGet(GetTag(oAltar));
    }
    return -1;
}

// returns the cost of the requested blessing
int AltarGetBlessingCost()
{
    int nCategory = AltarGetSelectedBlessingCategory();
    int nNum = AltarGetSelectedBlessingNumber();

    // general blessing
    if (nCategory == 1)
    {
        return 100;
    }

    // enhancement
    if (nCategory == 2)
    {
        if (nNum == 1) return 1000;
        if (nNum == 2) return 5000;
        if (nNum == 3) return 15000;
        if (nNum == 4) return 30000;
        if (nNum == 5) return 50000;
    }

    // damage vs type
    if (nCategory == 3)
    {
        if (nNum <= 10) return 5000;
        return 30000;
    }

    // damage type bonus
    if (nCategory == 4)
    {
        return 15000;
    }

    return -1;
}

// returns true if the player can pay for the requested blessing
int AltarCanPlayerPay(object oPC)
{
    int nCost = AltarGetBlessingCost();
    int nGold = GetGold(oPC);
    return (nGold >= nCost);
}

// returns the item's existing enhancement bonus
int AltarGetItemEnhancementBonus()
{
    object oItem = AltarGetItem();
    if (GetIsObjectValid(oItem))
    {
        return IPGetWeaponEnhancementBonus(oItem);
    }
    return 0;
}

// --------------------------------------------------------------------------
// BLESSINGS
// --------------------------------------------------------------------------

// vfx when a weapon is successfully blessed on the altar
void AltarApplyBlessingWeaponVfx()
{
    object oAltar = AltarGetAltar();
    if (GetIsObjectValid(oAltar))
    {
        location lLoc = GetLocation(oAltar);
        effect eGlow = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGlow, oAltar);
        effect ePillar = EffectVisualEffect(VFX_IMP_DEATH_L);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePillar, oAltar);
        effect eFloor = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFloor, oAltar);
        effect eDust = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDust, oAltar, 5.0f);
    }
}

// maximized aid cast at level 20
void AltarApplyAid(object oTarget)
{
    int nDuration = 20;
    int nHeal = 13;

    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eHP = EffectTemporaryHitpoints(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(nDuration));
}

// vfx when the party is successfully blessed
void AltarApplyBlessingPartyVfx()
{
    AltarApplyBlessingWeaponVfx();
}

// applies a general blessing to the party
void AltarApplyBlessingGeneral(object oPC)
{
    object oParty = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        AltarApplyAid(oParty);
        oParty = GetNextFactionMember(oPC, TRUE);
    }
    AltarApplyBlessingPartyVfx();
}

// applies an enhancement to the weapon
void AltarApplyBlessingEnhancement(object oItem, int nBonus)
{
    IPSetWeaponEnhancementBonus(oItem, nBonus);
    AltarApplyBlessingWeaponVfx();
}

// applies an enhancement bonus vs racial type to the weapon
void AltarApplyBlessingEnhancementVsRace(object oItem, int nBonus, int nRace)
{
    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP, -1, -1);
    itemproperty ip = ItemPropertyEnhancementBonusVsRace(nRace, nBonus);
    AddItemProperty(DURATION_TYPE_PERMANENT, ip, oItem);
    AltarApplyBlessingWeaponVfx();
}

// applies a damage bonus to the weapon
void AltarApplyBlessingDamageBonus(object oItem, int nDamageType)
{
    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_DAMAGE_BONUS, -1, -1);
    itemproperty ip = ItemPropertyDamageBonus(nDamageType, IP_CONST_DAMAGETYPE_DIVINE);
    AddItemProperty(DURATION_TYPE_PERMANENT, ip, oItem);
    AltarApplyBlessingWeaponVfx();
}

// applies the requested enhancement blessing
void AltarApplyBlessing(object oPC)
{
    int nCost = AltarGetBlessingCost();
    int nGold = GetGold(oPC);
    if (nGold < nCost)
    {
        return;
    }
    TakeGoldFromCreature(nCost, oPC);

    int nCategory = AltarGetSelectedBlessingCategory();
    int nNum = AltarGetSelectedBlessingNumber();

    // general blessing
    if (nCategory == 1)
    {
        AltarApplyBlessingGeneral(oPC);
    }

    // abort if we do not have a valid item on the altar
    object oItem = AltarGetItem();
    if (!GetIsObjectValid(oItem))
    {
        return;
    }

    // enhancement
    if (nCategory == 2)
    {
        if (nNum == 1) AltarApplyBlessingEnhancement(oItem, 1);
        if (nNum == 2) AltarApplyBlessingEnhancement(oItem, 2);
        if (nNum == 3) AltarApplyBlessingEnhancement(oItem, 3);
        if (nNum == 4) AltarApplyBlessingEnhancement(oItem, 4);
        if (nNum == 5) AltarApplyBlessingEnhancement(oItem, 5);
    }

    // damage vs type
    if (nCategory == 3)
    {
        if (nNum ==  1) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_ABERRATION);
        if (nNum ==  2) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_CONSTRUCT);
        if (nNum ==  3) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_DRAGON);
        if (nNum ==  4) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_ELEMENTAL);
        if (nNum ==  5) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_GIANT);
        if (nNum ==  6) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_MAGICAL_BEAST);
        if (nNum ==  7) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS);
        if (nNum ==  8) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_OUTSIDER);
        if (nNum ==  9) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_SHAPECHANGER);
        if (nNum == 10) AltarApplyBlessingEnhancementVsRace(oItem, 4, IP_CONST_RACIALTYPE_UNDEAD);
        if (nNum == 11) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_ABERRATION);
        if (nNum == 12) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_CONSTRUCT);
        if (nNum == 13) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_DRAGON);
        if (nNum == 14) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_ELEMENTAL);
        if (nNum == 15) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_GIANT);
        if (nNum == 16) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_MAGICAL_BEAST);
        if (nNum == 17) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS);
        if (nNum == 18) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_OUTSIDER);
        if (nNum == 19) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_SHAPECHANGER);
        if (nNum == 20) AltarApplyBlessingEnhancementVsRace(oItem, 7, IP_CONST_RACIALTYPE_UNDEAD);
    }

    // damage type bonus
    if (nCategory == 4)
    {
        if (nNum == 1) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_ACID);
        if (nNum == 2) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_COLD);
        if (nNum == 3) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_DIVINE);
        if (nNum == 4) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_ELECTRICAL);
        if (nNum == 5) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_FIRE);
        if (nNum == 6) AltarApplyBlessingDamageBonus(oItem, IP_CONST_DAMAGETYPE_SONIC);
    }
}
