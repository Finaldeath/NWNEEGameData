//::///////////////////////////////////////////////
//:: inc_potscforge
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Main include file for the weapon upgrade smith.

    * Nov 5th 2003 (BK)
     - Unlimited ammo property is now +5 not +3
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

//****************************************************
// * Constants
//****************************************************
#include "x2_inc_itemprop"

// Tokens
const int WeaponToken = 9809;
const int CostOfAcid = 9711;  // All elemental damages use this.
const int CostOfKeen = 9713;
const int CostOfSpellResistance = 9715;
const int CostOfRegeneration2 = 9716;
const int CostOfEnhancement = 9717;

// * Ranged
const int CostOfAttackBonus = 9611;
const int CostOfMighty = 9612;
const int CostOfUnlimited3 = 9614;

// * Shield/Armour
const int CostOfACBonus = 9911;
const int CostOfSavingThrow = 9912;
const int CostOfRegeneration1 = 9913;
const int CostOfDamageReduction = 9914;


// Prices
const int WS_COST_ACID_PROPERTY = 7500; // All elemental damages use this.
const int WS_COST_ATTACK_BONUS = 5000;
const int WS_COST_ENHANCEMENT_BONUS = 5000;
const int WS_COST_KEEN = 7500;
const int WS_COST_SPELLRESISTANCE = 7500;
const int WS_COST_REGENERATION2 = 7500;
const int WS_COST_MIGHTY = 5000;
const int WS_COST_UNLIMITED_1 = 5000;
const int WS_COST_REGENERATION1 = 3500;
const int WS_COST_SAVING_THROW = 5000;
const int WS_COST_AC_BONUS = 5000;
const int WS_COST_DAMAGE_REDUCTION = 5000;

// * Other Constants -- needed to make "fake" constants for some item property
const int IP_CONST_WS_ATTACK_BONUS = 19000;
const int IP_CONST_WS_ENHANCEMENT_BONUS = 19001;
const int IP_CONST_WS_HASTE = 19002;
const int IP_CONST_WS_KEEN = 19003;
const int IP_CONST_WS_TRUESEEING = 19005;
const int IP_CONST_WS_SPELLRESISTANCE = 19006;
const int IP_CONST_WS_REGENERATION = 19007;
const int IP_CONST_WS_MIGHTY = 19008;
const int IP_CONST_WS_UNLIMITED_1 = 19010;
const int IP_CONST_WS_REGENERATION1 = 19011;
const int IP_CONST_WS_AC_BONUS = 19012;
const int IP_CONST_WS_SAVING_THROW = 19013;
const int IP_CONST_WS_DAMAGE_REDUCTION = 19014;

const int MAX_ENHANCEMENT_BONUS = 5;
const int MAX_ATTACK_BONUS = 5;
const int MAX_MIGHTY_BONUS = 5;
const int MAX_AC_BONUS = 5;
const int MAX_DAMAGE_REDUCTION = 1;

const string S_CURRENT_WEAPON = "POTSC_FORGE_WEAPON";

//****************************************************
// * Declaration
//****************************************************
void SetWeaponToken(object oPC);
// * Function checks against WS_ properties to
// * see if its okay to add this item property
int IsOkToAdd(object oItem, int nPropertyCode);
object GetRightHandWeapon(object oPC);
// * Register's and protects the selected item.
void wsRegisterItem(object oItem);
// * Returns the Registered Item;
object wsGetRegisteredItem();
// * De-Register's and protects the selected item.
void wsDeRegisterItem();
// * sets all custom tokens for the prices of services
void wsSetupPrices();
// * A variable has been set earlier to indicate
// * which item property you want to add
// * now it tests to see if you have enough
// * gold for that item property
int wsHaveEnoughGoldForCurrentItemProperty(object oPC);
// * MAJOR
// * Actual function to add the enhancement to the item
void wsEnhanceItem(object oItem, object oPC);
// * Returns the correct item proeprty based upon nType
// * oItem is passed in to find specific information about the
// * current item
itemproperty ReturnItemPropertyToUse(int nType, object oItem);
// * Returns total attack bonus for the item
int ReturnAttackBonus(object oItem);
// * Returns total enhancement bonus for the item
int ReturnEnhancementBonus(object oItem);
// * Returns total Mighty bonus for the item
int ReturnMightyBonus(object oItem);
// * Returns total Armour Class bonus for the item
int ReturnACBonus(object oItem);
// * Returns total Damage reduction bonus for the item
int ReturnDamageReduction(object oItem);
//****************************************************
// * Implementation
//****************************************************

void SetWeaponToken(object oPC)
{
    // * Get Name of weapon
    // * Assumption -- a weapon is being held
    // * in the main hand
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sWeaponName = "";
    if (GetIsObjectValid(oItem) == TRUE)
    {
        sWeaponName = GetName(oItem);
    }
    else
    {
        return;
    }
    SetCustomToken(WeaponToken, sWeaponName);
}
object GetRightHandWeapon(object oPC)
{
    return  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
}
// * Function checks against WS_ properties to
// * see if its okay to add this item property
int IsOkToAdd(object oItem, int nPropertyCode)
{
    // * Always okay to add attack or enhancement bonuses, up to +10
    if (nPropertyCode ==  IP_CONST_WS_ATTACK_BONUS)
    {
        if (ReturnAttackBonus(oItem) < MAX_ATTACK_BONUS)
            return TRUE;
        else
            return FALSE;
    }
    else
    if (nPropertyCode == IP_CONST_WS_ENHANCEMENT_BONUS)
    {
        if (ReturnEnhancementBonus(oItem) < MAX_ENHANCEMENT_BONUS)
            return TRUE;
        else
            return FALSE;
    }
    else
    if (nPropertyCode == IP_CONST_WS_MIGHTY)
    {
        if (ReturnMightyBonus(oItem) < MAX_MIGHTY_BONUS)
            return TRUE;
        else
            return FALSE;
    }
    //armour class bonus check, for armour and shields
    else
    if (nPropertyCode == IP_CONST_WS_AC_BONUS)
    {
        if (ReturnACBonus(oItem) < MAX_AC_BONUS)
            return TRUE;
        else
            return FALSE;
    }

    else
    if (nPropertyCode == IP_CONST_WS_DAMAGE_REDUCTION)
    {
        if (ReturnDamageReduction(oItem) < MAX_DAMAGE_REDUCTION)
            return TRUE;
        else
            return FALSE;
    }
    itemproperty ip = ReturnItemPropertyToUse(nPropertyCode, oItem);
    // * Its okay to add these item properties as long as the subtype does not match
    int bOkToAdd = IPGetItemHasProperty(oItem, ip, -1, FALSE);
    if (bOkToAdd == FALSE)
    {
        return TRUE;
    }
    return FALSE;
}
// * this function added to balance out cost of very high magical item
// * modification (so its not super cheat to get a +10 weapon)
int InflateCost(int nGoldNeed, int iProperty)
{
    // * Modifier (November 5 2003 -- Up the price if this item already
    // * has numerous other enchancement bonuses
        object oItem = wsGetRegisteredItem();
        int iExtra = 0;
        int nBonus = 0;

        if (iProperty == IP_CONST_WS_ENHANCEMENT_BONUS)
            nBonus = ReturnEnhancementBonus(oItem);
        else if (iProperty == IP_CONST_WS_ATTACK_BONUS)
            nBonus = ReturnAttackBonus(oItem);
        else if (iProperty == IP_CONST_WS_MIGHTY)
            nBonus = ReturnMightyBonus(oItem);
        else if (iProperty == IP_CONST_WS_AC_BONUS)
            nBonus = ReturnACBonus(oItem);

        if (nBonus > 0)
        {
            iExtra = 500 * (nBonus + nBonus); // * this is extra cost to add
            nGoldNeed = nGoldNeed + iExtra;
        }
    return nGoldNeed;
}


// * sets all custom tokens for the prices of services
void wsSetupPrices()
{
    //checking if costs are set
/*    SendMessageToPC(GetFirstPC(),"AC bonus:" + IntToString(WS_COST_AC_BONUS));
    SendMessageToPC(GetFirstPC(),"Saving:" + IntToString(WS_COST_SAVING_THROW));
    SendMessageToPC(GetFirstPC(),"Regeneration:" + IntToString(WS_COST_REGENERATION1));
*/
    SetCustomToken(CostOfAttackBonus,
        IntToString(InflateCost(WS_COST_ATTACK_BONUS, IP_CONST_WS_ATTACK_BONUS)));
    SetCustomToken(CostOfEnhancement,
        IntToString(InflateCost(WS_COST_ENHANCEMENT_BONUS, IP_CONST_WS_ENHANCEMENT_BONUS)));
    SetCustomToken(CostOfMighty,
        IntToString(InflateCost(WS_COST_MIGHTY, IP_CONST_WS_MIGHTY)));
    SetCustomToken(CostOfACBonus,
        IntToString(InflateCost(WS_COST_AC_BONUS, IP_CONST_WS_AC_BONUS)));

    SetCustomToken(CostOfAcid, IntToString(WS_COST_ACID_PROPERTY)); // * All elemental damages use this
    SetCustomToken(CostOfKeen, IntToString(WS_COST_KEEN));
    SetCustomToken(CostOfSpellResistance, IntToString(WS_COST_SPELLRESISTANCE));
    SetCustomToken(CostOfRegeneration2, IntToString(WS_COST_REGENERATION2));
    SetCustomToken(CostOfUnlimited3, IntToString(WS_COST_UNLIMITED_1));
    SetCustomToken(CostOfRegeneration1, IntToString(WS_COST_REGENERATION1));
    SetCustomToken(CostOfSavingThrow, IntToString(WS_COST_SAVING_THROW));
    SetCustomToken(CostOfDamageReduction, IntToString(WS_COST_DAMAGE_REDUCTION));
}


int GetGoldValueForService(int nService)
{
    int nGoldNeed = 0;
    switch (nService)
    {
        case IP_CONST_DAMAGETYPE_ACID:
        case IP_CONST_DAMAGETYPE_FIRE:
        case IP_CONST_DAMAGETYPE_COLD:
        case IP_CONST_DAMAGETYPE_ELECTRICAL:
            nGoldNeed = WS_COST_ACID_PROPERTY; break;

        case IP_CONST_WS_ATTACK_BONUS:
        {
            nGoldNeed = WS_COST_ATTACK_BONUS;
            nGoldNeed = InflateCost(nGoldNeed, IP_CONST_WS_ATTACK_BONUS);
            break;
        }
        case IP_CONST_WS_ENHANCEMENT_BONUS:
        {
            nGoldNeed = WS_COST_ENHANCEMENT_BONUS;
            nGoldNeed = InflateCost(nGoldNeed, IP_CONST_WS_ENHANCEMENT_BONUS);
            break;
        }
        case IP_CONST_WS_KEEN: nGoldNeed = WS_COST_KEEN;break;
        case IP_CONST_WS_SPELLRESISTANCE: nGoldNeed = WS_COST_SPELLRESISTANCE; break;
        case IP_CONST_WS_REGENERATION: nGoldNeed = WS_COST_REGENERATION2; break;
        case IP_CONST_WS_MIGHTY:
        {   nGoldNeed = WS_COST_MIGHTY;
            nGoldNeed = InflateCost(nGoldNeed, IP_CONST_WS_MIGHTY);
            break;
        }
        case IP_CONST_WS_UNLIMITED_1: nGoldNeed = WS_COST_UNLIMITED_1; break;
        case IP_CONST_WS_AC_BONUS:
        {
            nGoldNeed = WS_COST_AC_BONUS;
            nGoldNeed = InflateCost(nGoldNeed, IP_CONST_WS_AC_BONUS);
            break;
        }
        case IP_CONST_WS_SAVING_THROW: nGoldNeed = WS_COST_SAVING_THROW; break;
        case IP_CONST_WS_REGENERATION1: nGoldNeed = WS_COST_REGENERATION1; break;
        case IP_CONST_WS_DAMAGE_REDUCTION: nGoldNeed = WS_COST_DAMAGE_REDUCTION; break;
    }
    return nGoldNeed;
}
// * A variable has been set earlier to indicate
// * which item property you want to add
// * now it tests to see if you have enough
// * gold for that item property
int wsHaveEnoughGoldForCurrentItemProperty(object oPC)
{
    int nGoldHave = GetGold(oPC);
    int nCurrentItemProperty = GetLocalInt(OBJECT_SELF, "X2_LAST_PROPERTY");
    int nGoldNeed = GetGoldValueForService(nCurrentItemProperty);
    if (nGoldHave >= nGoldNeed)
    {
        return TRUE;
    }
    return FALSE;
}

// * Returns total attack bonus for the item
int ReturnAttackBonus(object oItem)
{
    itemproperty ipFirst = GetFirstItemProperty(oItem);
    int nBonus = 0;
    while (GetIsItemPropertyValid(ipFirst) == TRUE)
    {
        if (GetItemPropertyType(ipFirst) == ITEM_PROPERTY_ATTACK_BONUS)
        {
            int nSubType = GetItemPropertyCostTableValue(ipFirst);
            //SpeakString("Found an attack bonus! SubType = " + IntToString(nSubType));
            nBonus = nBonus + (nSubType);
            return nBonus; // * Quick exit. Got what I need
        }
        ipFirst = GetNextItemProperty(oItem);
    }
    //SpeakString("Attack Bonus = " + IntToString(nBonus));
    return nBonus;
}
// * Returns total enhancement bonus for the item
int ReturnEnhancementBonus(object oItem)
{
    itemproperty ipFirst = GetFirstItemProperty(oItem);
    int nBonus = 0;
    while (GetIsItemPropertyValid(ipFirst) == TRUE)
    {
        if (GetItemPropertyType(ipFirst) == ITEM_PROPERTY_ENHANCEMENT_BONUS)
        {
            int nSubType = GetItemPropertyCostTableValue(ipFirst);
            //SpeakString("Found an attack bonus! SubType = " + IntToString(nSubType));
            nBonus = nBonus + (nSubType);
            return nBonus; // * Quick exit. Got what I need
        }
        ipFirst = GetNextItemProperty(oItem);
    }
    //SpeakString("Attack Bonus = " + IntToString(nBonus));
    return nBonus;
}
// * Returns total Mighty bonus for the item
int ReturnMightyBonus(object oItem)
{
    itemproperty ipFirst = GetFirstItemProperty(oItem);
    int nBonus = 0;
    while (GetIsItemPropertyValid(ipFirst) == TRUE)
    {
        if (GetItemPropertyType(ipFirst) == ITEM_PROPERTY_MIGHTY)
        {
            int nSubType = GetItemPropertyCostTableValue(ipFirst);
            SpeakString("Found an Mighty bonus! SubType = " + IntToString(nSubType));
            nBonus = nBonus + (nSubType);
            return nBonus; // * Quick exit. Got what I need
        }
        ipFirst = GetNextItemProperty(oItem);
    }
    //SpeakString("Attack Bonus = " + IntToString(nBonus));
    return nBonus;
}

// *returns the present armour class bonus of the item
int ReturnACBonus(object oItem)
{
    itemproperty ipFirst = GetFirstItemProperty(oItem);
    int nBonus = 0;
    while (GetIsItemPropertyValid(ipFirst) == TRUE)
    {
        if (GetItemPropertyType(ipFirst) == ITEM_PROPERTY_AC_BONUS)
        {
            int nSubType = GetItemPropertyCostTableValue(ipFirst);
            //SpeakString("Found an armor bonus! SubType = " + IntToString(nSubType));
            nBonus = nBonus + (nSubType);
            return nBonus; // * Quick exit. Got what I need
        }
        ipFirst = GetNextItemProperty(oItem);
    }
    //SpeakString("Attack Bonus = " + IntToString(nBonus));
    return nBonus;
}

// * returns the present damage reduction of the item
int ReturnDamageReduction(object oItem)
{
    itemproperty ipFirst = GetFirstItemProperty(oItem);
    int nBonus = 0;

    while (GetIsItemPropertyValid(ipFirst) == TRUE)
    {
        if (GetItemPropertyType(ipFirst) == ITEM_PROPERTY_DAMAGE_REDUCTION)
        {
            int nSubType = GetItemPropertyCostTableValue(ipFirst);
            //SpeakString("Found an armor bonus! SubType = " + IntToString(nSubType));
            nBonus = nBonus + (nSubType);
            return nBonus; // * Quick exit. Got what I need
        }
        ipFirst = GetNextItemProperty(oItem);
    }
    //SpeakString("Attack Bonus = " + IntToString(nBonus));
    return nBonus;
}

// * Returns the correct item proeprty based upon nType
// * oItem is passed in to find specific information about the
// * current item
itemproperty ReturnItemPropertyToUse(int nType, object oItem)
{
    itemproperty ip;
    int nNewBonus;

    switch(nType)
    {
        case IP_CONST_DAMAGETYPE_ACID:
        case IP_CONST_DAMAGETYPE_FIRE:
        case IP_CONST_DAMAGETYPE_COLD:
        case IP_CONST_DAMAGETYPE_ELECTRICAL:
        {
            ip =ItemPropertyDamageBonus(nType, IP_CONST_DAMAGEBONUS_1d6);
            break;
        }
        case IP_CONST_WS_ATTACK_BONUS:
        {
            nNewBonus = ReturnAttackBonus(oItem) + 1;

            ip = ItemPropertyAttackBonus(nNewBonus);
            break;
        }
        case IP_CONST_WS_ENHANCEMENT_BONUS:
        {

            nNewBonus = ReturnEnhancementBonus(oItem) + 1;

            ip = ItemPropertyEnhancementBonus(nNewBonus);
            break;
        }
        case IP_CONST_WS_HASTE:
        {
            ip = ItemPropertyHaste();
            break;
        }
        case IP_CONST_WS_KEEN:
        {
            ip = ItemPropertyKeen();
            break;
        }
        case IP_CONST_WS_TRUESEEING:
        {
            ip = ItemPropertyTrueSeeing();
            break;
        }
        case IP_CONST_WS_SPELLRESISTANCE:
        {
            ip = ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_10);
            break;
        }
        case IP_CONST_WS_REGENERATION:
        {
            ip = ItemPropertyVampiricRegeneration(2);
            break;
        }
        case IP_CONST_WS_MIGHTY:
        {
            nNewBonus = ReturnMightyBonus(oItem) + 1;

            ip = ItemPropertyMaxRangeStrengthMod(nNewBonus);
            break;
        }
        case IP_CONST_WS_UNLIMITED_1:
        {
            ip = ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_PLUS1);
            break;
        }
        case IP_CONST_WS_AC_BONUS:
        {

            nNewBonus = ReturnACBonus(oItem) + 1;

            ip = ItemPropertyACBonus(nNewBonus);
            break;
        }
        case IP_CONST_WS_REGENERATION1:
        {
            ip = ItemPropertyRegeneration(1);
            break;
        }
        case IP_CONST_WS_SAVING_THROW:
        {
            ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,2);
            break;
        }
        case IP_CONST_WS_DAMAGE_REDUCTION:
        {
            ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP);
            break;
        }

    }
    return ip;

}
// * MAJOR
// * Actual function to add the enhancement to the item
// * Also takes the gold
void wsEnhanceItem(object oItem, object oPC)
{
    int nCurrentItemProperty = GetLocalInt(OBJECT_SELF, "X2_LAST_PROPERTY");
    int nGoldToTake = GetGoldValueForService(nCurrentItemProperty);
//    SpeakString("Enhance " + GetName(oItem));

    // * if player tries to cheat just abort the item creation. (You can only have
    // * this happen by moving your gold out of your inventory as you are talking).
    if (GetGold(oPC) < nGoldToTake)
    {
        return;
    }
    TakeGoldFromCreature(nGoldToTake, oPC, FALSE);
    // * GZ: Remove all temporary item properties from oItem to counter bug #35259
    IPRemoveAllItemProperties(oItem, DURATION_TYPE_TEMPORARY);
    itemproperty ip =  ReturnItemPropertyToUse(nCurrentItemProperty, oItem);
    IPSafeAddItemProperty(oItem, ip, 0.0f, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
}

// * Register's and protects the selected item.
void wsRegisterItem(object oItem)
{
    object oModule = GetModule();
    SetLocalObject(oModule, S_CURRENT_WEAPON, oItem);
    SetItemCursedFlag(oItem, TRUE);
}

// * Returns the Registered Item;
object wsGetRegisteredItem()
{
    object oModule = GetModule();
    object oItem = GetLocalObject(oModule, S_CURRENT_WEAPON);

    return oItem;
}

// * De-Register's and protects the selected item.
void wsDeRegisterItem()
{
    object oModule = GetModule();
    object oItem = GetLocalObject(oModule, S_CURRENT_WEAPON);

    SetItemCursedFlag(oItem, FALSE);
    SetLocalObject(oModule, S_CURRENT_WEAPON, OBJECT_INVALID);
}

