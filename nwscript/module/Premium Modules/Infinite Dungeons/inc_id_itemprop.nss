//::///////////////////////////////////////////////
//:: Name: Item Property Library
//:: FileName: inc_id_item_prop
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This library file includes all the functions used to give item properties
to items. Most of these functions are stolen from RDG.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: July 14, 2005
//:://////////////////////////////////////////////
#include "inc_id_misctools"
#include "x2_inc_itemprop"
#include "x2_inc_craft"
// ---------------------------- PROTOTYPES ------------------------------------

// Returns the first valid item property of oItem.
// nItemPropertyType must be a ITEM_PROPERTY_* value.
itemproperty GetItemPropertyByType(object oItem, int nItemPropertyType);

// Copies the first valid item property on oItem to oTarget.
// nItemPropertyType must be a ITEM_PROPERTY_* value.
void CopyItemPropertyByType(object oSource, object oTarget, int nItemPropertyType, int nRemoveFromSource = TRUE);

// Attempts to copy all item properties from oSource to oTarget.
// This can partially fail if it will take oTarget above 8 item properties.
void CopyAllItemProperties(object oSource,object oTarget);

// Removes the first item property of a specified type from oItem.
// nItemPropertyType must be a ITEM_PROPERTY_* value.
void RemoveItemPropertyByType(object oItem, int nItemPropertyType);

// Returns TRUE if oItem is a Armor, Shield, or Helmet.
// iBaseType must be a BASE_ITEM_* if used.
// Only 1 perameter should be used.
int GetIsArmor(object oItem = OBJECT_INVALID,int iBaseType = BASE_ITEM_INVALID);

// Returns TRUE if oItem or iBaseType is a thrown weapon.
// iBaseType must be a BASE_ITEM_* if used.
// Only 1 perameter should be used.
int GetIsThrown(object oItem = OBJECT_INVALID,int iBaseType = BASE_ITEM_INVALID);

// Returns the enhancement type for Armor,Helmets,Shields and Weapons.
// Any other item passed to this will return ITEM_PROPERTY_TYPE_INVALID (-1).
int GetEnhancementTypeByBaseItem(object oItem);

// Returns a random itemproperty from oItem.
itemproperty GetRandomItemProperty(object oItem);

// Copies random item properties from oSource to oTarget.
//
// nIPToCopy is the number of item properties to copy.
// if nIPToCopy is higher than the number of item properties on oSource then
// all of oSources item properties are copied.
//
// Note: This function will misbehave if it attempts to put the number of item
// properties on oTarget above 8. This is due to the use of IPSafeAddItemProperty.
void CopyRandomItemProperty(object oSource, object oTarget, int nIPToCopy = 1, int nTreasureCat = TREASURE_CATAGORY_INVALID);

// Returns the 3 digit ID code attached to the end of an item Tag.
string GetID(object oObject = OBJECT_SELF);

// This function multiplies iBase by fMulti and returns the result.
// Basically just a wrapper to multiply an int by a float.
int Multiply (int iBase, float fMulti);

// This function will attempt to change the appearance of any item passed to it.
object RandomizeItemAppearance(object oItem);

// This function will return a IP_CONST_RACIALTYPE_*
// It is meant to be used for creating random Bane weapons as per page 186 of the DMG.
int GetBaneRace();

// Returns TRUE if oWeapon deals slashing damage.
int GetWeaponSlashing(object oWeapon);

// Returns TRUE if oWeapon deals blugeoning damage.
int GetWeaponBludgeoning(object oWeapon);

// Returns TRUE if oShield is a shield.
int GetIsShield(object oShield);

// Returns TRUE if oItem uses ammunition.
int GetUsesAmmo(object oItem);

// Returns TRUE is oItem is an ammunition type.
int GetIsAmmo(object oItem);

// Returns the Enchantment bonus of a melee or thrown weapon.
// Returns the Bonus AC of Armor.
// Returns the Attack bonus of a ammunition using weapon.
int GetEnchantmentBonus(object oItem);

// This funtion is used to put a simple bonus on an item.
// If the item is a Melee Weapon a Enhancement Bonus will be granted.
// If the item is a Ranged Weapon a Attack Bonus will be granted
// If the item is Armor a AC Bonus will be granted.
void SetEnchantmentBonus(object oWeapon,int iBonus);

// Armor/Shield Function.
// Give oItem Immunity to Knock Down.
void SetEnchantFortLight(object oItem);

// Armor/Shield Function.
// Give oItem Immunity to Back Stab.
void SetEnchantFortMod(object oItem);

// Armor/Shield Function.
// Give oItem Immunity to Critical Hits.
void SetEnchantFortHvy(object oItem);

// Armor/Shield Function.
// Change oItem's appearance to a robe.
// This function will only work on armor.
object SetEnchantGlammer(object oItem);

// Armor/Shield Function.
// Give +10 Tumble to the item
void SetEnchantSlick(object oItem);

// Armor/Shield Function.
// Give +10 Hide to the item
void SetEnchantShadow(object oItem);

// Armor/Shield Function.
// Give +10 Move Silently to the item
void SetEnchantSilent(object oItem);

// Armor/Shield Function.
// Gives oItem the Spell Resistance Item Property.
// iSR should be a IP_CONST_SPELLRESISTANCEBONUS_*
void SetEnchantSR(object oItem,int iSR);

// Armor/Shield Function.
// Grant Trueseeing to oItem.
void SetEnchantTrueSeeing(object oItem);
// Armor/Shield Function.
// Give oItem +1/5 Damage desistance.
void SetEnchantInvulnerability(object oItem);

// Armor/Shield Function.
// iDamageType should be IP_CONST_DAMAGETYPE_*
// iAmount is a valid IP_CONST_DAMAGERESIST_*
void SetEnchantDamageResistance(object oItem,int iDamageType, int iAmount = IP_CONST_DAMAGERESIST_10);

// Armor/Shield Function.
// Allows oItem to cast the spell Ethereal once per day.
void SetEnchantEthereal(object oItem);

// Armor/Shield Function.
// Gives oItem the Knock Down Feat.
void SetEnchantBashing(object oItem);

// Armor/Shield Function.
// Gives oItem the OnHit Cast Blind/Deaf at level 4.
void SetEnchantBlinding(object oItem);

// Armor/Shield Function.
// Gives oItem -/5 Piercing Damage Soak
void SetEnchantArrowDeflect(object oItem);

// Armor/Shield Function.
// Gives oItem -/10 Piercing Damage Soak
void SetEnchantAnimated(object oItem);

// Armor/Shield Function.
// Gives oItem the ability to cast Spell Mantle once per day
void SetEnchantReflection(object oItem);

// Weapon Function.
// Will add an AC mod to a weapon equal to it's Enchantment Bonus.
// iBonus can be used to change the AC mod to specified amount.
// Example a Long Sword +3 would become a Longsword +3 with +3 AC Bonus.
void SetEnchantDefending(object oWeapon, int iBonus = 0);

// Weapon Function.
// Will add damage to a weapon or ammunition.
// iDamageType is the Type of damage to deal.
// iBonus is the amount of damage to add.
void SetEnchantDamage(object oWeapon, int iDamageType = IP_CONST_DAMAGETYPE_MAGICAL, int iBonus = IP_CONST_DAMAGEBONUS_1d6);

// Adds the Keen property to the weapon.
void SetEnchantKeen(object oWeapon);

// Adds the Feat Cleave property to the weapon.
void SetEnchantCleave(object oWeapon);

// Adds Special properties vs. a specific race.
// If iRace is -1 a random Racial Type will be chosen. Any IP_CONST_RACIALTYPE_* can be used here.
// nBonus can be any value 1 to 20. Not used for Ammunition.
// nDamageBonus is only used for Ammunition. Must be a valid IP_CONST_DAMAGEBONUS_*
// nDamageType can be any valid DAMAGE_TYPE_*
void SetEnchantBane(object oWeapon, int iRace = -1, int iToHitBonus = 2, int iDamageBonus = IP_CONST_DAMAGEBONUS_2d6, int iDamageType = IP_CONST_DAMAGETYPE_MAGICAL);

// Blunt MeleeWeapon Property
// Adds Slay Undead DC 14 to oWeapon.
void SetEnchantDisruption(object oWeapon);

// Weapon Property
// Melee/Thrown Weapon: Adds 1d6 of iDamageType to the weapon. Adds massive Critical +1d10.
// Ammo Using Weapon: Unlimited Ammo iDamage Type can be FIRE,COLD, ELECTRICAL, or basic.
// Ammo Gives ammo +2d6 damage of iDamageType
void SetEnchantBurst(object oWeapon,int iDamageType);

// Gives a +2d6 damage vs the opposite alignment.
// iALignment is the alignment of the USER.
// Example: iAlignment = ALIGNMENT_GOOD. +2d6 damage vs ALIGNMENT_EVIL.
void SetEnchantAlignment(object oWeapon,int iAlignment);

// Slashing Melee Weapon Property
// Gives the weapon the wounding ability
void SetEnchantWounding(object oWeapon);

// Currently unable to do dancing properly.
// Gave the weapon an On-Hit Slow Property for now.
void SetEnchantDancing(object oWeapon);

// Gives the weapon a haste property.
void SetEnchantSpeed(object oWeapon);

// Slashing Melee Weapon Property
// Gives the weapon a Vorpal Property
void SetEnchantVorpal(object oWeapon);

// Ranged Weapon Function
// Sets the ranged weapon to have unlimited ammo.
void SetEnchantUnlimitedAmmo(object oWeapon,int iType);

// Weapon function
// Gives the weapon the haste property
void SetEnchantHaste(object oWeapon);

// Wand Function
// Adds iSpellID to the object at 1 charge per use.
// iSpellID must be a valid IP_CONST_CASTSPELL_*
// iCharges is a number between 1 and 50. If a invalid number is used charges will be set randomly
// iEraseOld is used if you want the old spell properties erased from the wand.
// This function will work with other items HOWEVER bioware has warned that not all spells will work with all items.
void SetEnchantWand(object oWand, int iSpellID, int iCharges = 0, int iEraseOld = TRUE);

// Subfunction of the forge system.
// NOT INTENDED FOR EXTERNAL USE!
// Returns the cost of adding ipIP to oItem.
int GetItemEnchancementCost(object oItem, itemproperty ipIP);

// Subfunction of the forge system.
// NOT INTENDED FOR EXTERNAL USE!
// Builds an itemproperty.
// Designer note:
// If used incorrectly this function will spout out all sorts of nonsense.
// I suggest reading the function code before using.
// As itemproperties are added to the ID system this will have to be updated,
// as not all IPs are supported.
itemproperty GetItemPropertyFromInt(int nType, int nSub = 0, int nBonus = 0, int nParam1 = 0);

// Returns TRUE if an IP has been disallowed by the forge system.
// This is to prevent unwanted 2da lookups.
int GetIsPowerTurnedOff(int nPower);

// Returns a IP from oItem
// This property must be set to DURATION_TYPE_PERMANENT
// Returns an invalid IP if none found.
itemproperty GetIPByTypeAndSub(object oItem, int nIPType, int nSub = 255, int nParam1 = 255);

// Stores an item property into a string format.
// This string can be broken back down using GetIPIntsFromString.
string StoreIPIntsToString(itemproperty ipIP);

// Returns a substring of sIP converted to an int.
// sIP is a created by StoreIPIntsToString
// nIP is which part of the item property you want to extract.
// Values are: 0 Power, 1 SubType, 2 Param1, 3 Bonus
// Illegal values return -1
int GetIPIntsFromString(string sIP, int nIP);

// Returns the max Bonus allowed for the item property.
// Setting nMin to TRUE will force the script to return the
// minimum setting instead. This is done because some are 0
// and others are 1.
// Returns -1 if no Bonus is used.
int GetBonusLimits(int nIPConstant, int nMin = FALSE);

// Returns the Max Sub Type allowed for the item property.
// Setting nMin to TRUE will force the script to return the
// minimum setting instead. This is done because some are 0
// and others are 1.
// Returns -1 if no Sub is used.
int GetSubLimits(int nIPConstant, int nMin = FALSE);

// Returns the max Param1 allowed for the item property.
// Setting nMin to TRUE will force the script to return the
// minimum setting instead. This is done because some are 0
// and others are 1.
// Returns -1 if no Param1 is used.
int GetParam1Limits(int nIPConstant, int nMin = FALSE);


// ---------------------- FORGE FUNCTIONS NOT MENT FOR EXTERNAL USE ---------

// Returns a ID gem tag based on sRecipeItemCode
// if nNumber is set to TRUE it will returnthe number required instead.
string IDDecode(string sRecipeItemCode, int nNumber = FALSE);

// Returns TRUE if the PC has all the objects required by oRecipe.
// If nDestroy is set to TRUE these objects will be destroyed as they are found.
int VerifyRecipeVsInventory(object oPC, object oRecipe, int nDestroy = FALSE);

// Converts a single char string to an int value 0 - 71;
// Returns a -1 if the character was one illegal for use in tags.
int ConvertCharStringToInt(string sString);

// Subfunction of SetRandomEnhancementBonus.
// NOT MEANT FOR EXTERNAL USE!
// Returns the proper 2da column to be referenced
// nType is a valid ITEM_PROPERTY_*
// nCatagory must be a valid TREASURE_CATAGORY_*
string Get2daBonusColumn(int nType, int nCatagory);

// Subfunction of SetRandomEnhancementBonus.
// NOT MEANT FOR EXTERNAL USE!
// nType mustbe a valid ITEM_PROPERTY_* used in GetEnhancementTypeByBaseItem.
// nBonus is a bonus to be added to an item 1 to 20.
// These values are pulled from the id_treasure.2da.
itemproperty GetProperItemProperty(int nType,int nBonus);

/* Designers Note: It seems even with the delays the "while" pointer still gets lost.
therefore a custom loop procedure will be required to make this work. See
ScaleItemPropertiesToCatagory for details.*/
// Replaces an old item property with a new one.
// This function has a built in delay to allow for use in loops.
void ReplaceItemProperty(object oItem, itemproperty ipOriginal, itemproperty ipNew);

// Subfunction of SetRandomEnhancements
// NOT MEANT FOR EXTERNAL USE!
// This function will scale the special item properties.
// It does not scale AC,Attack, or Enhancement bonuses.
// This was already done by SetRandomEnhancements.
itemproperty ScaleItemPropertyToCatagory(object oItem, itemproperty ipIP,int nCatagory);

// -------------------------- END FORGE FUNCTIONS -----------------------------
// ---------------------------- FUNCTIONS -------------------------------------

itemproperty GetItemPropertyByType(object oItem, int nItemPropertyType)
    {
    itemproperty ipIP = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipIP))
        {
        if (GetItemPropertyType(ipIP) == nItemPropertyType)
            {
            // Found a matching ItemPropertyType return it.
            return ipIP;
            }
        ipIP = GetNextItemProperty(oItem);
        }
    // Return the invalid item property (odd no constant for this)
    return ipIP;
    }


void CopyItemPropertyByType(object oSource, object oTarget, int nItemPropertyType, int nRemoveFromSource)
    {
    // Currently if the copy already has the IP we return out.
    // May want to change this to an addsafe. From the Hotu scripts.
    if (GetItemHasItemProperty(oTarget, nItemPropertyType))
        return;

    // Search for a matching item property type.
    itemproperty ipIP = GetItemPropertyByType(oSource, nItemPropertyType);

    if (GetIsItemPropertyValid(ipIP))
        {
        // Copy item property to the new item.
        IPSafeAddItemProperty(oTarget,ipIP);
        if (nRemoveFromSource)
            {
            RemoveItemProperty(oSource,ipIP);
            }
        }
    }


void CopyAllItemProperties(object oSource,object oTarget)
    {
    itemproperty ipIP = GetFirstItemProperty(oSource);
    while(GetIsItemPropertyValid(ipIP))
        {
        IPSafeAddItemProperty(oTarget,ipIP);
        ipIP = GetNextItemProperty(oSource);
        }
    }


void RemoveItemPropertyByType(object oItem, int nItemPropertyType)
    {
    itemproperty ipIP = GetItemPropertyByType(oItem, nItemPropertyType);
    while (GetIsItemPropertyValid(ipIP))
        {
        RemoveItemProperty(oItem,ipIP);
        ipIP = GetItemPropertyByType(oItem, nItemPropertyType);
        }
    }

itemproperty GetRandomItemProperty(object oItem)
    {
    int nMax = IPGetNumberOfItemProperties(oItem);
    int nRandom = Random(nMax)+1;
    int nCount = 1;
    itemproperty ipReturn;
    while (nCount <= nRandom)
        {
        if (nCount == 1)
            {
            ipReturn = GetFirstItemProperty(oItem);
            }
        else
            {
            ipReturn = GetNextItemProperty(oItem);
            }
        if (nCount == nRandom)
            {
            return ipReturn;
            }
        nCount += 1;
        }
    // THIS WILL NEVER HAPPEN.
    // Placed only for compile reasons.
    return ipReturn;
    }

void CopyRandomItemProperty(object oSource, object oTarget, int nIPToCopy, int nTreasureCat)
    {
    // Make sure the number of item properties to be copied is greater than 0.
    if (nIPToCopy < 1)
        {
        return;
        }

    int n,nIPType,nTMIFix;
    itemproperty ipIP;
    // ------------------------- Error Checking -----------------------------

    // Since we will be adding enhancement bonuses dynamically according to
    // level remove them from the original template.

    // NOTE TO ITEM DESIGNER DO NOT PUT GENERIC ENHANCEMENT BONUSES ON ITEMS.
    // See GetEnhancementTypeByBaseItem for details.
    RemoveItemPropertyByType(oSource,GetEnhancementTypeByBaseItem(oSource));

    // ---------------Copy random IPs from the source to the copy------------
    if (nIPToCopy < IPGetNumberOfItemProperties(oSource))
        {
        // Copy nIPToCopy worth of item properties from Source to Target.
        for (n = 1; n <= nIPToCopy; n+=1)
            {
            WriteTimestampedLogEntry("  IP COPY " + IntToString(n));
            ipIP = GetRandomItemProperty(oSource);
            // Scale the item property to the treasure cat.
            if (nTreasureCat != TREASURE_CATAGORY_INVALID)
            {
                ipIP = ScaleItemPropertyToCatagory(oTarget,ipIP,nTreasureCat);
            }
            // Copy the item property to the the target.
            IPSafeAddItemProperty(oTarget,ipIP);
            }
        }
    else
        {
        //If the number of IPs to copy is greater or equal to the number of IPs
        //the source has just copy all of them and be done with it.
        CopyAllItemProperties(oSource,oTarget);
        }
    }

string GetID(object oObject)
    {
    string sTag = GetTag(oObject);
    int iLen = GetStringLength(sTag)-iLen;
    return GetStringRight(sTag,3);
    }

int Multiply (int iBase, float fMulti)
    {
    return FloatToInt(IntToFloat(iBase) * fMulti);
    }

object RandomizeItemAppearance(object oItem)
    {
    int iType = GetBaseItemType(oItem);
    int iSimpleVariations = 0;
    // INSURE THIS GETS PLACED IN MODULE!
    object oModuleCache = GetObjectByTag(TAG_OBJECT_CREATION_CONTAINER);

    // Move the object to the Module Cache and play with it's appearance.
    object oCopy = CopyItem(oItem,oModuleCache,TRUE);
    if (IPGetIsMeleeWeapon(oItem)
        || GetWeaponRanged(oItem))
        {
        oCopy = IPGetModifiedWeapon(oCopy,ITEM_APPR_WEAPON_MODEL_TOP ,X2_IP_WEAPONTYPE_RANDOM,TRUE);
        oCopy = IPGetModifiedWeapon(oCopy,ITEM_APPR_WEAPON_MODEL_MIDDLE ,X2_IP_WEAPONTYPE_RANDOM,TRUE);
        oCopy = IPGetModifiedWeapon(oCopy,ITEM_APPR_WEAPON_MODEL_BOTTOM ,X2_IP_WEAPONTYPE_RANDOM,TRUE);
        }
    else
        {
        switch (iType)
            {
            case BASE_ITEM_SICKLE:
            case BASE_ITEM_SLING:
            case BASE_ITEM_WHIP:
                {
                // These types of items have no variable appearance but could cause further code to malfunction.
                return oItem;
                }

            case BASE_ITEM_ARMOR:
                {
                int i,iColor;
                object oCopy2;
                i = Random(3);
                if (i == 1)
                    {
                    oCopy = IPGetModifiedArmor(oCopy,ITEM_APPR_ARMOR_MODEL_TORSO,X2_IP_ARMORTYPE_NEXT,TRUE);
                    }
                else if (i == 2)
                    {
                    oCopy = IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_TORSO,X2_IP_ARMORTYPE_PREV,TRUE);
                    }
                else
                    {
                    // No Randomization done.
                    return oItem;
                    }
                for (i = 1; i <= 6; i++)
                    {
                    switch (i)
                        {
                        case 1:{iColor = ITEM_APPR_ARMOR_COLOR_CLOTH1;break;}
                        case 2:{iColor = ITEM_APPR_ARMOR_COLOR_CLOTH2;break;}
                        case 3:{iColor = ITEM_APPR_ARMOR_COLOR_LEATHER1;break;}
                        case 4:{iColor = ITEM_APPR_ARMOR_COLOR_LEATHER2;break;}
                        case 5:{iColor = ITEM_APPR_ARMOR_COLOR_METAL1;break;}
                        case 6:{iColor = ITEM_APPR_ARMOR_COLOR_METAL2;break;}
                        };
                    oCopy2 = CopyItemAndModify(oCopy,ITEM_APPR_TYPE_ARMOR_COLOR,iColor,Random(64),TRUE);
                    DestroyObject(oCopy);
                    oCopy = oCopy2;
                    }
                break;
                }
            case BASE_ITEM_LARGESHIELD:
            case BASE_ITEM_SMALLSHIELD:
            case BASE_ITEM_TOWERSHIELD:
            case BASE_ITEM_BULLET:
            case BASE_ITEM_DART:
            case BASE_ITEM_SHURIKEN:
                {iSimpleVariations = (d4()*10)+d3();break;}
            case BASE_ITEM_BELT:
                {iSimpleVariations = 9;break;}
            case BASE_ITEM_BOOK:
                {iSimpleVariations = 10;break;}
            case BASE_ITEM_GLOVES:
                {iSimpleVariations = 11;break;}
            case BASE_ITEM_BRACER:
                {iSimpleVariations = 12;break;}
            case BASE_ITEM_CLOAK:
                {iSimpleVariations = 14;break;}
            case BASE_ITEM_GEM:
                {iSimpleVariations = 17;break;}
            case BASE_ITEM_AMULET:
                {iSimpleVariations = 28;break;}
            case BASE_ITEM_HELMET:
                {iSimpleVariations = 32;break;}
            case BASE_ITEM_RING:
                {iSimpleVariations = 32;break;}
            }
        if (iSimpleVariations > 0)
            oCopy = CopyItemAndModify(oCopy,ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(iSimpleVariations)+1,TRUE);
        if (GetIsObjectValid(oCopy))
            {
            // Destroy the original item.
            DestroyObject(oItem);
            // Copy the new itemback to the original chest.
            oItem = CopyItem(oCopy,OBJECT_SELF,TRUE);
            // Destroy the copy from the Cache Chest.
            DestroyObject(oCopy);
            }
        }
    return oItem;
    }

int GetBaneRace()
    {
    int iRace;
    int iRoll = d100();
    if (iRoll <= 5) iRace = IP_CONST_RACIALTYPE_ABERRATION;
    else if (iRoll <= 8) iRace = IP_CONST_RACIALTYPE_ANIMAL;
    else if (iRoll <= 13) iRace = IP_CONST_RACIALTYPE_BEAST;
    else if (iRoll <= 20) iRace = IP_CONST_RACIALTYPE_CONSTRUCT;
    else if (iRoll <= 25) iRace = IP_CONST_RACIALTYPE_DRAGON;
    else if (iRoll <= 30) iRace = IP_CONST_RACIALTYPE_ELEMENTAL;
    else if (iRoll <= 35) iRace = IP_CONST_RACIALTYPE_FEY;
    else if (iRoll <= 40) iRace = IP_CONST_RACIALTYPE_GIANT;
    else if (iRoll <= 45) iRace = IP_CONST_RACIALTYPE_MAGICAL_BEAST;
    else if (iRoll <= 50)
        {
        iRoll = d4();
        if (iRoll = 1)      iRace = IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID;
        else if (iRoll = 2) iRace = IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS;
        else if (iRoll = 3) iRace = IP_CONST_RACIALTYPE_HUMANOID_ORC;
        else if (iRoll = 4) iRace = IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN;
        }
    else if (iRoll <= 77) iRace = IP_CONST_RACIALTYPE_OUTSIDER;
    else if (iRoll <= 85) iRace = IP_CONST_RACIALTYPE_SHAPECHANGER;
    else if (iRoll <= 92) iRace = IP_CONST_RACIALTYPE_UNDEAD;
    else if (iRoll <= 94) iRace = IP_CONST_RACIALTYPE_VERMIN;
    else
        {
        iRoll = Random(7)+1;
        if (iRoll = 1)      iRace = IP_CONST_RACIALTYPE_DWARF;
        else if (iRoll = 2) iRace = IP_CONST_RACIALTYPE_ELF;
        else if (iRoll = 3) iRace = IP_CONST_RACIALTYPE_GNOME;
        else if (iRoll = 4) iRace = IP_CONST_RACIALTYPE_HALFELF;
        else if (iRoll = 5) iRace = IP_CONST_RACIALTYPE_HALFLING;
        else if (iRoll = 6) iRace = IP_CONST_RACIALTYPE_HALFORC;
        else                iRace = IP_CONST_RACIALTYPE_HUMAN;
        }
    return iRace;
    }

int GetIsArmor(object oItem,int iBaseType)
    {
    switch (GetBaseItemType(oItem))
        {
        case BASE_ITEM_ARMOR:
        case BASE_ITEM_LARGESHIELD:
        case BASE_ITEM_SMALLSHIELD:
        case BASE_ITEM_TOWERSHIELD:
        case BASE_ITEM_HELMET:
            {
            return TRUE;
            }
        };
    return FALSE;
    }


int GetIsThrown(object oItem,int iBaseType)
    {
    switch (GetBaseItemType(oItem))
        {
        case BASE_ITEM_DART:
        case BASE_ITEM_HANDAXE:
        case BASE_ITEM_SHURIKEN:
            {
            return TRUE;
            }
        };
    return FALSE;
    }


int GetEnhancementTypeByBaseItem(object oItem)
{
    // Check if armor, helmet or shield.
    if (GetIsArmor(oItem))
    {
        return ITEM_PROPERTY_AC_BONUS;
    }
    // Check if melee or thrown weapon.
    else if (IPGetIsMeleeWeapon(oItem)
     || GetIsThrown(oItem))
    {
        return ITEM_PROPERTY_ENHANCEMENT_BONUS;
    }
    // Check if launcher weapon.
    else if (GetUsesAmmo(oItem))
    {
        return ITEM_PROPERTY_ATTACK_BONUS;
    }
    else if (GetIsAmmo(oItem))
    {
        return ITEM_PROPERTY_DAMAGE_BONUS;
    }
    else if (GetBaseItemType(oItem) == BASE_ITEM_HEALERSKIT)
    {
        return ITEM_PROPERTY_HEALERS_KIT;
    }
    else if (GetBaseItemType(oItem) == BASE_ITEM_THIEVESTOOLS)
    {
        return ITEM_PROPERTY_THIEVES_TOOLS;
    }
    else
    {
        return ITEM_PROPERTY_TYPE_INVALID;
    }
}

int GetWeaponSlashing(object oWeapon)
    {
    int iType = GetBaseItemType(oWeapon);
    if (iType == BASE_ITEM_BASTARDSWORD
     || iType == BASE_ITEM_BATTLEAXE
     || iType == BASE_ITEM_DOUBLEAXE
     || iType == BASE_ITEM_DWARVENWARAXE
     || iType == BASE_ITEM_GREATAXE
     || iType == BASE_ITEM_GREATSWORD
     || iType == BASE_ITEM_HALBERD
     || iType == BASE_ITEM_HANDAXE
     || iType == BASE_ITEM_KAMA
     || iType == BASE_ITEM_KATANA
     || iType == BASE_ITEM_KUKRI
     || iType == BASE_ITEM_LONGSWORD
     || iType == BASE_ITEM_SCIMITAR
     || iType == BASE_ITEM_SCYTHE
     || iType == BASE_ITEM_SICKLE
     || iType == BASE_ITEM_TWOBLADEDSWORD
     || iType == BASE_ITEM_WHIP
     || (IPGetItemHasProperty(oWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),-1)))
        return TRUE;
    return FALSE;
    }

int GetWeaponBludgeoning(object oWeapon)
    {
    int iType = GetBaseItemType(oWeapon);
    if (iType == BASE_ITEM_BULLET
     || iType == BASE_ITEM_CBLUDGWEAPON
     || iType == BASE_ITEM_CLUB
     || iType == BASE_ITEM_DIREMACE
     || iType == BASE_ITEM_HEAVYFLAIL
     || iType == BASE_ITEM_LIGHTFLAIL
     || iType == BASE_ITEM_LIGHTHAMMER
     || iType == BASE_ITEM_LIGHTMACE
     || iType == BASE_ITEM_MORNINGSTAR
     || iType == BASE_ITEM_QUARTERSTAFF
     || iType == BASE_ITEM_SLING
     || iType == BASE_ITEM_WARHAMMER
     || (IPGetItemHasProperty(oWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),-1)))
        return TRUE;
    return FALSE;
    }

int GetIsShield(object oShield)
    {
    int iType = GetBaseItemType(oShield);
    if (iType == BASE_ITEM_SMALLSHIELD
     || iType == BASE_ITEM_LARGESHIELD
     || iType == BASE_ITEM_TOWERSHIELD)
        return TRUE;
    return FALSE;
    }

int GetUsesAmmo(object oItem)
    {
    int iType = GetBaseItemType(oItem);
    if (iType == BASE_ITEM_HEAVYCROSSBOW
     || iType == BASE_ITEM_LIGHTCROSSBOW
     || iType == BASE_ITEM_LONGBOW
     || iType == BASE_ITEM_SHORTBOW
     || iType == BASE_ITEM_SLING)
        return TRUE;
    return FALSE;
    }

int GetIsAmmo(object oItem)
    {
    int iType = GetBaseItemType(oItem);
    if (iType == BASE_ITEM_ARROW
     || iType == BASE_ITEM_BOLT
     || iType == BASE_ITEM_BULLET)
        return TRUE;
    return FALSE;
    }
// ----------------------- Begin Item Enchantment Functions -------------------
int GetEnchantmentBonus(object oItem)
    {
    int iType = GetBaseItemType(oItem);
    int ipItem;
    if (iType == BASE_ITEM_ARMOR)
        ipItem = ITEM_PROPERTY_AC_BONUS;
    else if (GetUsesAmmo(oItem))
        ipItem = ITEM_PROPERTY_ATTACK_BONUS;
    else
        ipItem = ITEM_PROPERTY_ENHANCEMENT_BONUS;
    itemproperty ipIP = GetFirstItemProperty(oItem);
    int nBonus = 0;
    while (GetIsItemPropertyValid(ipIP))
        {
        if (GetItemPropertyType(ipIP) == ipItem)
            {
            nBonus = GetItemPropertyCostTableValue(ipIP);
            break;
            }
        ipIP = GetNextItemProperty(oItem);
        }
    return nBonus;
    }

void SetEnchantmentBonus(object oItem,int iBonus)
    {
    int iType = GetBaseItemType(oItem);
    itemproperty ipItem;
    if (iType == BASE_ITEM_ARMOR)
        ipItem = ItemPropertyACBonus(iBonus);
    else if (GetUsesAmmo(oItem))
        ipItem = ItemPropertyAttackBonus(iBonus);
    else if (GetIsAmmo(oItem))
        {
        if (iType == BASE_ITEM_BULLET)
            ipItem = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IPGetDamageBonusConstantFromNumber(iBonus));
        else
            ipItem = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IPGetDamageBonusConstantFromNumber(iBonus));
        }
    else
        ipItem = ItemPropertyEnhancementBonus(iBonus);
    IPSafeAddItemProperty(oItem,ipItem);
    if (IPGetIsMeleeWeapon(oItem))// Update Defending property if the item has it.
        {
        if (IPGetItemHasProperty(oItem,ItemPropertyACBonus(iBonus),DURATION_TYPE_PERMANENT,TRUE))
            SetEnchantDefending(oItem,iBonus);
        }
    }
//----------------------- Armor/Shield Enchantments ----------------------------
void SetEnchantFortLight(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN));}

void SetEnchantFortMod(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB));}

void SetEnchantFortHvy(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS));}

object SetEnchantGlammer(object oArmor)
    {
    object oArmor2 = CopyItemAndModify(oArmor,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE,d4());
    DestroyObject(oArmor);
    return oArmor2;
    }

void SetEnchantSlick(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertySkillBonus(SKILL_TUMBLE,10));}

void SetEnchantShadow(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertySkillBonus(SKILL_HIDE,10));}

void SetEnchantSilent(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,10));}

void SetEnchantSR(object oArmor, int iSR)
    {IPSafeAddItemProperty(oArmor,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14));}// SR 13 currently unavailable.

void SetEnchantTrueSeeing(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyTrueSeeing());} // Unable to do Ghost Touch Properly, gave True Seeing instead.

void SetEnchantInvulnerability(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP));}

void SetEnchantDamageResistance(object oArmor,int iDamageType, int iAmount)
    {IPSafeAddItemProperty(oArmor,ItemPropertyDamageResistance(iDamageType,iAmount));}

void SetEnchantEthereal(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyCastSpell(SPELL_ETHEREALNESS,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));}

void SetEnchantBashing(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyBonusFeat(IP_CONST_FEAT_KNOCKDOWN));}

void SetEnchantBlinding(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BLINDNESS_AND_DEAFNESS,4));}

void SetEnchantArrowDeflect(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP));}

void SetEnchantAnimated(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP));}

void SetEnchantReflection(object oArmor)
    {IPSafeAddItemProperty(oArmor,ItemPropertyCastSpell(IP_CONST_CASTSPELL_SPELL_MANTLE_13,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY));}

// ------------------------------ Weapon Enchantments --------------------------
void SetEnchantDefending(object oWeapon,int iBonus)
    {
    if (!iBonus)
        iBonus = GetEnchantmentBonus(oWeapon);
    if (iBonus < 1) iBonus = 1;
        IPSafeAddItemProperty(oWeapon,ItemPropertyACBonus(iBonus));
    }

void SetEnchantDamage(object oWeapon, int iDamageType, int iBonus)
    {
    if (GetUsesAmmo(oWeapon))
        {
        SetLocalInt(oWeapon,"SpecialAmmo",TRUE);
        SetLocalInt(oWeapon,"DamageType",iDamageType);
        IPSafeAddItemProperty(oWeapon,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE));
        }
    else
        IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonus(iDamageType,iBonus));
    }

void SetEnchantKeen(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyKeen());}

void SetEnchantCleave(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyBonusFeat(IP_CONST_FEAT_CLEAVE));}

void SetEnchantBane(object oWeapon, int nRace, int nBonus, int nDamageBonus, int nDamageType)
    {
    int nEnchant = GetEnchantmentBonus(oWeapon);
    if (nEnchant == 20)
        {
        // The weapon is already a +20. This is frivolous.
        return;
        }
    if (nRace = -1)
        {
        // Get a random race
        nRace = GetBaneRace();
        }

    // Update the bonus to be placed on weapon.
    nBonus += nEnchant;
    if (nBonus > 20)
        {
        // Make sure total bonus does not exceed 20.
        nBonus = 20;
        }

    if (GetUsesAmmo(oWeapon))
        {
        // Bows, Crossbows, Slings, etc.
        IPSafeAddItemProperty(oWeapon,ItemPropertyAttackBonusVsRace(nRace,nBonus));
        // NOTE: Make sure these work after the RDG conversion.
        SetLocalInt(oWeapon,"Bane",nRace);
        SetLocalInt(oWeapon,"SpecialAmmo",3);
        SetLocalInt(oWeapon,"DamageType",nDamageType);
        }
    else if (GetIsAmmo(oWeapon))
        {
        // Arrows, Bolts, Bullets.
        IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonusVsRace(nRace,nDamageType,nDamageBonus));
        }
    else
        {
        // Melee and thrown.
        IPSafeAddItemProperty(oWeapon,ItemPropertyEnhancementBonusVsRace(nRace,nBonus));
        }
    }
void SetEnchantDisruption(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_UNDEAD));}

void SetEnchantBurst(object oWeapon,int iDamageType)
    {
    if (GetUsesAmmo(oWeapon))
        {
        if (iDamageType == IP_CONST_DAMAGETYPE_FIRE)            iDamageType = IP_CONST_UNLIMITEDAMMO_1D6FIRE;
        else if (iDamageType == IP_CONST_DAMAGETYPE_COLD)       iDamageType = IP_CONST_UNLIMITEDAMMO_1D6COLD;
        else if (iDamageType == IP_CONST_DAMAGETYPE_ELECTRICAL) iDamageType = IP_CONST_UNLIMITEDAMMO_1D6LIGHT;
        else                                                    iDamageType = IP_CONST_UNLIMITEDAMMO_BASIC;
        SetEnchantUnlimitedAmmo(oWeapon,iDamageType);
        }
    else if (GetIsAmmo(oWeapon))
        IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonus(iDamageType,IP_CONST_DAMAGEBONUS_2d6));
    else
        {
        IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonus(iDamageType,IP_CONST_DAMAGEBONUS_1d6));
        IPSafeAddItemProperty(oWeapon,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10));
        }
    }
void SetEnchantWounding(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_20));}

void SetEnchantAlignment(object oWeapon,int iAlignment)
    {
    int iVs = -1;
    if (iAlignment == IP_CONST_ALIGNMENTGROUP_GOOD)         iVs = IP_CONST_ALIGNMENTGROUP_EVIL;
    else if (iAlignment == IP_CONST_ALIGNMENTGROUP_EVIL)    iVs = IP_CONST_ALIGNMENTGROUP_GOOD;
    else if (iAlignment == IP_CONST_ALIGNMENTGROUP_LAWFUL)  iVs = IP_CONST_ALIGNMENTGROUP_CHAOTIC;
    else if (iAlignment == IP_CONST_ALIGNMENTGROUP_CHAOTIC) iVs = IP_CONST_ALIGNMENTGROUP_LAWFUL;
    if (iVs == -1)
        return; // This function will not work with Neutral vs. Neutral.
    if (GetUsesAmmo(oWeapon))
        {
        SetLocalInt(oWeapon,"SpecialAmmo",2);
        SetLocalInt(oWeapon,"DamageType",IP_CONST_DAMAGETYPE_DIVINE);
        SetLocalInt(oWeapon,"AlignmentTarget",IP_CONST_ALIGNMENTGROUP_EVIL);
        }
    else
        IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonusVsAlign(iVs,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6));
    IPSafeAddItemProperty(oWeapon,ItemPropertyLimitUseByAlign(iAlignment));
    }
void SetEnchantDancing(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_SLOW,IP_CONST_SPELLLEVEL_5));}

void SetEnchantVorpal(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL,20));}

void SetEnchantUnlimitedAmmo(object oWeapon, int iType = IP_CONST_UNLIMITEDAMMO_BASIC)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyUnlimitedAmmo(iType));}

void SetEnchantSpeed(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyHaste());}

void SetEnchantHaste(object oWeapon)
    {IPSafeAddItemProperty(oWeapon,ItemPropertyHaste());}

void SetEnchantWand(object oWand, int iSpellID, int iCharges, int iEraseOld)
    {
    if (iEraseOld)
        {
        // Erase all the curent wand properties.
        itemproperty ipIP = GetFirstItemProperty(oWand);
        while (GetIsItemPropertyValid(ipIP))
            {
            RemoveItemProperty(oWand,ipIP);
            ipIP = GetNextItemProperty(oWand);
            }
        }
    // Set the wand spell.
    IPSafeAddItemProperty(oWand,ItemPropertyCastSpell(iSpellID,IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE));
    // Set the number of charges.
    if (iCharges < 1 || iCharges > 50)
        iCharges = Random(50)+1;
    SetItemCharges(oWand,iCharges);
    }

object GetMysticForgeTempInventory()
{
    object oBox = GetLocalObject(OBJECT_SELF,"ForgeInventory");
    if (GetIsObjectValid(oBox))
    {
        oBox = CreateObject(OBJECT_TYPE_PLACEABLE,"mfinventory",GetLocation(OBJECT_SELF));
        SetLocalObject(OBJECT_SELF,"ForgeInventory",oBox);
    }
    return oBox;
}

int GetItemEnchancementCost(object oItem, itemproperty ipIP)
{
    object oBox = GetMysticForgeTempInventory();
    object oCopy = CopyItem(oItem,oBox);
    IPSafeAddItemProperty(oCopy,ipIP);
    int nCost = GetGoldPieceValue(oCopy) - GetGoldPieceValue(oItem);
    DestroyObject(oCopy);
    return nCost;
}




int GetIsPowerTurnedOff(int nPower)
{
    if (nPower == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER
     || nPower == 14 // Boomerang?
     || nPower == ITEM_PROPERTY_CAST_SPELL //Turned off cast spell this list is HUGE!
     || nPower == ITEM_PROPERTY_DECREASED_DAMAGE
     || nPower == ITEM_PROPERTY_DAMAGE_VULNERABILITY
     || nPower == 25 // Dancing Scimitar?
     || nPower == ITEM_PROPERTY_DECREASED_ABILITY_SCORE
     || nPower == ITEM_PROPERTY_DECREASED_AC
     || nPower == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER
     || nPower == 30 // Double Stack?
     || nPower == 31 // Contaienr Bonus Slot?
     || nPower == 42 // Doesn't Exist
     || nPower == 46 // Mind Blank?
     || nPower == ITEM_PROPERTY_NO_DAMAGE
     || nPower == ITEM_PROPERTY_ON_HIT_PROPERTIES  // On Hit - LOTS of these may do later if have time
     || nPower == ITEM_PROPERTY_DECREASED_SAVING_THROWS
     || nPower == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC
     || nPower == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL// Immunity to specific spells, difficult at best over 800 currently.
     || nPower == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL // Why bother if not doing 53.
     || nPower == ITEM_PROPERTY_THIEVES_TOOLS
     || nPower == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER
     || nPower == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP
     || nPower == ITEM_PROPERTY_USE_LIMITATION_CLASS
     || nPower == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE
     || nPower == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT
     || nPower == ITEM_PROPERTY_USE_LIMITATION_TILESET
     || nPower == 68 // Moved to On Hit
     || nPower == 69 // Moved to On Hit
     || nPower == ITEM_PROPERTY_TRAP
     || nPower == ITEM_PROPERTY_ON_MONSTER_HIT
     || nPower == ITEM_PROPERTY_TURN_RESISTANCE
     || nPower == ITEM_PROPERTY_POISON
     || nPower == ITEM_PROPERTY_MONSTER_DAMAGE
     || nPower == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL // Hrm why did I do this? Add if have time.
     || nPower == ITEM_PROPERTY_SPECIAL_WALK
     || nPower == ITEM_PROPERTY_HEALERS_KIT
     || nPower == ITEM_PROPERTY_WEIGHT_INCREASE
     || nPower == ITEM_PROPERTY_ONHITCASTSPELL //On Hit Cast Spell Turned Off, If have time re-add.
     || nPower == ITEM_PROPERTY_VISUALEFFECT)
    {
        return TRUE;
    }
    return FALSE;
}

string StoreIPIntsToString(itemproperty ipIP)
{
    int nPower = GetItemPropertyType(ipIP);
    int nSub = GetItemPropertySubType(ipIP);
    if (GetSubLimits(nPower) == -1)
    {
        nSub = -1;
    }
    int nParam1 = GetItemPropertyParam1(ipIP);
    if (GetParam1Limits(nPower) == -1)
    {
        nParam1 = -1;
    }
    int nBonus = GetItemPropertyCostTableValue(ipIP);
    if (GetBonusLimits(nPower) == -1)
    {
        nBonus = -1;
    }
    return Convert3Digit(nPower)+Convert3Digit(nSub)+Convert3Digit(nParam1)+Convert3Digit(nBonus);
}

int GetIPIntsFromString(string sIP, int nIP)
{
    string sReturn = "-1";
    int nOffset = nIP * 3;
    if (nIP >= 0 && nIP <= 3)
    {
        sReturn = GetSubString(sIP,nOffset,3);
    }
    if (sReturn == "255")
        sReturn = "-1"; // IP illegal values are stored as 255 inside the IP.
    return StringToInt(sReturn);
}

itemproperty GetIPByTypeAndSub(object oItem, int nIPType, int nSub = 255, int nParam1 = 255)
{
    itemproperty ipIP = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipIP))
    {
        if (GetItemPropertyDurationType(ipIP) == DURATION_TYPE_PERMANENT)
        {
            if (GetItemPropertyType(ipIP) == nIPType)
            {
                if (GetItemPropertySubType(ipIP) == nSub)
                {
                    if (GetItemPropertyParam1(ipIP) == nParam1)
                    {
                        return ipIP;
                    }
                }
            }
        }
        ipIP = GetNextItemProperty(oItem);
    }
    return ipIP;
}

int GetBonusLimits(int nIPConstant, int nMin)
{
    switch (nIPConstant)
    {
        case ITEM_PROPERTY_SKILL_BONUS:
        {
            if (nMin)
                return 1;
            return 50;
        }

        case ITEM_PROPERTY_AC_BONUS:
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ATTACK_BONUS:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        case ITEM_PROPERTY_MIGHTY:
        case ITEM_PROPERTY_REGENERATION:
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
        {
            if (nMin)
                return 1;
            return 20;
        }

        case ITEM_PROPERTY_ABILITY_BONUS:
        {
            if (nMin)
                return 1;
            return 12;
        }

        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
        {
            if (nMin)
                return 1;
            return 10;
        }

        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
        {
            if (nMin)
                return 1;
            return 9; // These are labeled backwards!
        }

        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
        {
            if (nMin)
                return 1;
            return 7;
        }

        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
        {
            if (nMin)
                return 1;
            return 5;
        }

        case ITEM_PROPERTY_LIGHT:
        {
            if (nMin)
                return 1;
            return 4;
        }

        case ITEM_PROPERTY_DAMAGE_REDUCTION:
        {
            if (nMin)
                return 0;
            return 19;
        }

        case ITEM_PROPERTY_SPELL_RESISTANCE:
        {
            if (nMin)
                return 0;
            return 11;
        }

        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        {
            if (nMin)
                return 0;
            return 9;
        }
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        {
            if (nMin)
                return 1;
            return 15;
        }
        default: return -1;
        /*
        case ITEM_PROPERTY_BONUS_FEAT:
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
        case ITEM_PROPERTY_DARKVISION:
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
        case ITEM_PROPERTY_HASTE:
        case ITEM_PROPERTY_HOLY_AVENGER:
        case ITEM_PROPERTY_IMPROVED_EVASION:
        case ITEM_PROPERTY_KEEN:
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        case ITEM_PROPERTY_TRUE_SEEING:
        {
            // Property uses no bonuses.
            return -1;
        }

        case ITEM_PROPERTY_CAST_SPELL:
        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
        case ITEM_PROPERTY_DECREASED_AC:
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
        case ITEM_PROPERTY_DECREASED_DAMAGE:
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
        case ITEM_PROPERTY_HEALERS_KIT:
        case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
        case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
        case ITEM_PROPERTY_MIND_BLANK:
        case ITEM_PROPERTY_MONSTER_DAMAGE:
        case ITEM_PROPERTY_NO_DAMAGE:
        case ITEM_PROPERTY_ON_HIT_PROPERTIES:
        case ITEM_PROPERTY_ON_MONSTER_HIT:
        case ITEM_PROPERTY_ONHITCASTSPELL:
        case ITEM_PROPERTY_POISON:
        case ITEM_PROPERTY_SPECIAL_WALK:
        case ITEM_PROPERTY_THIEVES_TOOLS:
        case ITEM_PROPERTY_TRAP:
        case ITEM_PROPERTY_TURN_RESISTANCE:
        case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_USE_LIMITATION_CLASS:
        case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
        case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_USE_LIMITATION_TILESET:
        case ITEM_PROPERTY_VISUALEFFECT:
        case ITEM_PROPERTY_WEIGHT_INCREASE:
        {
            // Not used in ID, left for possible future expansion.
            return -1;
        }*/
    };
    return -1; // Never should happen left for compile reasons only.
}

int GetSubLimits(int nIPConstant, int nMin)
{
    switch (nIPConstant)
    {
        case ITEM_PROPERTY_ABILITY_BONUS:
        {//IPRP_ABILITIES
            if (nMin)
            {
                return 0;
            }
            return 5;
        }
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
        {//IPRP_ALIGNGRP
            if (nMin)
            {
                return 1; // Really 0 but 1 is lowest in ID.
            }
            return 5;
        }
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
        {//IPRP_COMBATDAM
            if (nMin)
            {
                return 0;
            }
            return 2;
        }
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
        {//racialtypes
            if (nMin)
            {
                return 0;
            }
            return 29;
        }
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
        {//IPRP_ALIGNMENT
            if (nMin)
            {
                return 0; // Really 0 but 1 is lowest in ID.
            }
            return 8;
        }
        case ITEM_PROPERTY_BONUS_FEAT:
        {//IPRP_FEATS
            if (nMin)
            {
                return 0;
            }
            return 40;
        }
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        {//Classes
            if (nMin)
            {
                return 0;
            }
            return 38;
        }
        case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
        {//IPRP_DAMAGETYPE
            if (nMin)
            {
                return 0;
            }
            return 13;
        }
         case ITEM_PROPERTY_DAMAGE_REDUCTION:
        {//IPRP_PROTECTION
            if (nMin)
            {
                return 0;
            }
            return 19;
        }
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS: // WARNING USES NO BONUS!
        {//IPRP_IMMUNITY
            if (nMin)
            {
                return 0;
            }
            return 9;
        }
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
        {//IPRP_SAVEELEMENT
            if (nMin)
            {
                return 0;
            }
            return 3;
        }
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
        {// IPRP_SAVINGTHROW
            if (nMin)
            {
                return 0;
            }
            return 15; // 21 Actually but not used as of ID
        }
        case ITEM_PROPERTY_SKILL_BONUS:
        {//skills
            if (nMin)
            {
                return 0;
            }
            return 26;
        }
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        {//IPRP_AMMOTYPE
            if (nMin)
            {
                return 0;
            }
            return 2;
        }
        default: return -1;
        /*
        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
        case ITEM_PROPERTY_AC_BONUS:
        case ITEM_PROPERTY_LIGHT: // USES A PARAM1 NOT A SUB
        case ITEM_PROPERTY_ATTACK_BONUS:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        case ITEM_PROPERTY_MIGHTY:
        case ITEM_PROPERTY_REGENERATION:
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
        case ITEM_PROPERTY_SPELL_RESISTANCE:
        case ITEM_PROPERTY_DARKVISION:
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
        case ITEM_PROPERTY_HASTE:
        case ITEM_PROPERTY_HOLY_AVENGER:
        case ITEM_PROPERTY_IMPROVED_EVASION:
        case ITEM_PROPERTY_KEEN:
        case ITEM_PROPERTY_TRUE_SEEING:
        {
            // Property uses no sub.
            return -1;
        }

        case ITEM_PROPERTY_CAST_SPELL:
        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
        case ITEM_PROPERTY_DECREASED_AC:
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
        case ITEM_PROPERTY_DECREASED_DAMAGE:
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
        case ITEM_PROPERTY_HEALERS_KIT:
        case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
        case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
        case ITEM_PROPERTY_MIND_BLANK:
        case ITEM_PROPERTY_MONSTER_DAMAGE:
        case ITEM_PROPERTY_NO_DAMAGE:
        case ITEM_PROPERTY_ON_HIT_PROPERTIES:
        case ITEM_PROPERTY_ON_MONSTER_HIT:
        case ITEM_PROPERTY_ONHITCASTSPELL:
        case ITEM_PROPERTY_POISON:
        case ITEM_PROPERTY_SPECIAL_WALK:
        case ITEM_PROPERTY_THIEVES_TOOLS:
        case ITEM_PROPERTY_TRAP:
        case ITEM_PROPERTY_TURN_RESISTANCE:
        case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_USE_LIMITATION_CLASS:
        case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
        case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_USE_LIMITATION_TILESET:
        case ITEM_PROPERTY_VISUALEFFECT:
        case ITEM_PROPERTY_WEIGHT_INCREASE:
        {
            // Not used in ID, left for possible future expansion.
            return -1;
        }*/

    };
    return -1; // Never should happen left for compile reasons only.
}


int GetParam1Limits(int nIPConstant, int nMin)
{
    switch (nIPConstant)
    {
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        {//IPRP_DAMAGETYPE
            if (nMin)
            {
                return 0;
            }
            return 13;
        }
        case ITEM_PROPERTY_LIGHT:
        {
            if (nMin)
            {
                return 0;
            }
            return 6;
        }
        default: return -1;
        /*
        case ITEM_PROPERTY_BONUS_FEAT:
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_SKILL_BONUS:
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
        case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE: // Really 19 is max but is lowest in ID.
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS: // WARNING USES NO BONUS!
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
        case ITEM_PROPERTY_ABILITY_BONUS:
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
        case ITEM_PROPERTY_DAMAGE_REDUCTION:
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_AC_BONUS:
        case ITEM_PROPERTY_ATTACK_BONUS:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        case ITEM_PROPERTY_MIGHTY:
        case ITEM_PROPERTY_REGENERATION:
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
        case ITEM_PROPERTY_SPELL_RESISTANCE:
        case ITEM_PROPERTY_DARKVISION:
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
        case ITEM_PROPERTY_HASTE:
        case ITEM_PROPERTY_HOLY_AVENGER:
        case ITEM_PROPERTY_IMPROVED_EVASION:
        case ITEM_PROPERTY_KEEN:
        case ITEM_PROPERTY_TRUE_SEEING:
        {
            // Property uses no param1.
            return -1;
        }

        case ITEM_PROPERTY_CAST_SPELL:
        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
        case ITEM_PROPERTY_DECREASED_AC:
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
        case ITEM_PROPERTY_DECREASED_DAMAGE:
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
        case ITEM_PROPERTY_HEALERS_KIT:
        case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
        case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
        case ITEM_PROPERTY_MIND_BLANK:
        case ITEM_PROPERTY_MONSTER_DAMAGE:
        case ITEM_PROPERTY_NO_DAMAGE:
        case ITEM_PROPERTY_ON_HIT_PROPERTIES:
        case ITEM_PROPERTY_ON_MONSTER_HIT:
        case ITEM_PROPERTY_ONHITCASTSPELL:
        case ITEM_PROPERTY_POISON:
        case ITEM_PROPERTY_SPECIAL_WALK:
        case ITEM_PROPERTY_THIEVES_TOOLS:
        case ITEM_PROPERTY_TRAP:
        case ITEM_PROPERTY_TURN_RESISTANCE:
        case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_USE_LIMITATION_CLASS:
        case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
        case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_USE_LIMITATION_TILESET:
        case ITEM_PROPERTY_VISUALEFFECT:
        case ITEM_PROPERTY_WEIGHT_INCREASE:
        {
            // Not used in ID, left for possible future expansion.
            return -1;
        }*/

    };
    return -1; // Never should happen left for compile reasons only.
}

itemproperty GetItemPropertyFromInt(int nType, int nSub, int nBonus, int nParam1)
{
    itemproperty ipIP;
    switch (nType)
    {
        case ITEM_PROPERTY_ABILITY_BONUS:
        {
            return ItemPropertyAbilityBonus(nSub,nBonus);
        }
        case ITEM_PROPERTY_AC_BONUS:
        {
            return ItemPropertyACBonus(nBonus);
        }
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
        {
            return ItemPropertyACBonusVsAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
        {
            return ItemPropertyACBonusVsDmgType(nSub,nBonus);
        }
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
        {
            return ItemPropertyACBonusVsRace(nSub,nBonus);
        }
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
        {
            return ItemPropertyACBonusVsSAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        {
            return ItemPropertyEnhancementBonus(nBonus);
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
        {
            return ItemPropertyEnhancementBonusVsAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
        {
            return ItemPropertyEnhancementBonusVsRace(nSub,nBonus);
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
        {
            return ItemPropertyEnhancementBonusVsSAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
        {
            return ItemPropertyWeightReduction(nBonus);
        }
        case ITEM_PROPERTY_BONUS_FEAT:
        {
            return ItemPropertyBonusFeat(nSub);
        }
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        {
            return ItemPropertyBonusLevelSpell(nSub,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_BONUS:
        {
            return ItemPropertyDamageBonus(nSub,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        {
            return ItemPropertyDamageBonusVsAlign(nSub,nParam1,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        {
            return ItemPropertyDamageBonusVsAlign(nSub,nParam1,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        {
            return ItemPropertyDamageBonusVsSAlign(nSub,nParam1,nBonus);
        }
        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
        {
            return ItemPropertyDamageImmunity(nSub,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_REDUCTION:
        {
            return ItemPropertyDamageReduction(nSub,nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
        {
            return ItemPropertyDamageResistance(nSub,nBonus);
        }
        case ITEM_PROPERTY_DARKVISION:
        {
            return ItemPropertyDarkvision();
        }
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
        {
            return ItemPropertyContainerReducedWeight(nBonus);
        }
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
        {
            return ItemPropertyExtraMeleeDamageType(nSub);
        }
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
        {
            return ItemPropertyExtraRangeDamageType(nSub);
        }
        case ITEM_PROPERTY_HASTE:
        {
            return ItemPropertyHaste();
        }
        case ITEM_PROPERTY_HOLY_AVENGER:
        {
            return ItemPropertyHolyAvenger();
        }
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
        {
            return ItemPropertyImmunityMisc(nSub);
        }
        case ITEM_PROPERTY_IMPROVED_EVASION:
        {
            return ItemPropertyImprovedEvasion();
        }
        case ITEM_PROPERTY_SPELL_RESISTANCE:
        {
            return ItemPropertyBonusSpellResistance(nBonus);
        }
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
        {
            return ItemPropertyBonusSavingThrow(nSub,nBonus);
        }
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
        {
            return ItemPropertyBonusSavingThrowVsX(nSub,nBonus);
        }
        case ITEM_PROPERTY_KEEN:
        {
            return ItemPropertyKeen();
        }
        case ITEM_PROPERTY_LIGHT:
        {
            return ItemPropertyLight(nBonus,nParam1);
        }
        case ITEM_PROPERTY_MIGHTY:
        {
            return ItemPropertyMaxRangeStrengthMod(nBonus);
        }
        case ITEM_PROPERTY_REGENERATION:
        {
            return ItemPropertyRegeneration(nBonus);
        }
        case ITEM_PROPERTY_SKILL_BONUS:
        {
            return ItemPropertySkillBonus(nSub,nBonus);
        }
        case ITEM_PROPERTY_ATTACK_BONUS:
        {
            return ItemPropertyAttackBonus(nBonus);
        }
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
        {
            return ItemPropertyAttackBonusVsAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
        {
            return ItemPropertyAttackBonusVsRace(nSub,nBonus);
        }
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
        {
            return ItemPropertyAttackBonusVsSAlign(nSub,nBonus);
        }
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        {
            return ItemPropertyUnlimitedAmmo(nBonus);
        }
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
        {
            return ItemPropertyVampiricRegeneration(nBonus);
        }
        case ITEM_PROPERTY_TRUE_SEEING:
        {
            return ItemPropertyTrueSeeing();
        }
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        {
            return ItemPropertyMassiveCritical(nBonus);
        }
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
        {
            return ItemPropertyFreeAction();
        }
        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
        {
            return ItemPropertyArcaneSpellFailure(nBonus);
        }
    };
    return ipIP;// Returns Invalid on error
}

int VerifyRecipeVsInventory(object oPC, object oRecipe, int nDestroy)
{
    string sRecipeTag,sRecipeCode,sRecipeItemTag,sNeeded;
    int n,nNumberRecipeItems,nCount,nNeeded,nTemp;
    object oItem;
    // Decode Recipe required
    sRecipeTag = GetTag(oRecipe);
    // Pull the code from the tag.
    sRecipeCode = GetStringRight(sRecipeTag,GetStringLength(sRecipeTag) - 11); //Assumes naming convention "ID1_RECIPE_" + Code
    // Determine number of items built into the code.
    nNumberRecipeItems = (GetStringLength(sRecipeCode)/3);
    // Cycle thru the items
    for (n = 1; n <= nNumberRecipeItems; n+= 1)
    {
        // Get the item code
        if (n < nNumberRecipeItems)
        {
            sRecipeItemTag = GetStringLeft(sRecipeCode,3);
            sRecipeCode = GetStringRight(sRecipeTag,GetStringLength(sRecipeTag) - 3);
        }
        else
        {
            sRecipeItemTag = sRecipeCode;
        }
        // Convert the item code into a tag and get teh number required.

        nNeeded = StringToInt(IDDecode(sRecipeItemTag,TRUE));
        sRecipeItemTag = IDDecode(sRecipeItemTag);
        // Determine if PC is missing a recipe component.
        if (!GetIsObjectValid(GetItemPossessedBy(oPC,sRecipeItemTag)))
        {
             // Return the missing recipe component token.
             return FALSE;
        }
        else
        {
            // At least 1 of the item was found. Now determine if there are enough.
            nCount = 0;
            oItem = GetFirstItemInInventory(oPC);
            while(GetIsObjectValid(oItem))
            {
                if (sRecipeItemTag == GetTag(oItem))
                {
                    // If we are marked to destroy recipe items do so now.
                    if (nDestroy == TRUE)
                    {
                        nCount += GetNumStackedItems(oItem);
                        if (nCount <= nNeeded)
                        {
                            DestroyObject(oItem);
                            if (nCount == nNeeded)
                            {
                                return TRUE;// We are done.
                            }
                        }
                        else if (nCount > nNeeded)
                        {
                            nTemp = nCount - nNeeded;
                            SetItemStackSize(oItem,nTemp);
                            return TRUE;//We are done.
                        }
                    }
                    else
                    {
                        nCount += GetNumStackedItems(oItem);
                    }
                }
                oItem = GetNextItemInInventory(oPC);
            }
            if (nCount < nNeeded)
            {
                // There was a shortage of at least 1 component.
                return FALSE;
            }
        }
    }
    // All components found.
    return TRUE;
}

int ConvertCharStringToInt(string sString)
{
    if (GetStringLength(sString) > 1)
    {
        // This function is meant for single character strings
        return -1;
    }
    if (sString == "_")
    {
        return 71;
    }
    else if (sString == "a")
    {
        return 10;
    }
    else if (sString == "b")
    {
        return 11;
    }
    else if (sString == "c")
    {
        return 12;
    }
    else if (sString == "d")
    {
        return 13;
    }
    else if (sString == "e")
    {
        return 14;
    }
    else if (sString == "f")
    {
        return 15;
    }
    else if (sString == "g")
    {
        return 16;
    }
    else if (sString == "h")
    {
        return 17;
    }
    else if (sString == "i")
    {
        return 18;
    }
    else if (sString == "j")
    {
        return 19;
    }
    else if (sString == "k")
    {
        return 20;
    }
    else if (sString == "l")
    {
        return 21;
    }
    else if (sString == "m")
    {
        return 22;
    }
    else if (sString == "n")
    {
        return 23;
    }
    else if (sString == "o")
    {
        return 24;
    }
    else if (sString == "p")
    {
        return 25;
    }
    else if (sString == "q")
    {
        return 26;
    }
    else if (sString == "r")
    {
        return 27;
    }
    else if (sString == "s")
    {
        return 28;
    }
    else if (sString == "t")
    {
        return 29;
    }
    else if (sString == "u")
    {
        return 30;
    }
    else if (sString == "v")
    {
        return 31;
    }
    else if (sString == "w")
    {
        return 32;
    }
    else if (sString == "x")
    {
        return 33;
    }
    else if (sString == "y")
    {
        return 34;
    }
    else if (sString == "z")
    {
        return 35;
    }
    else if (sString == "A")
    {
        return 36;
    }
    else if (sString == "B")
    {
        return 37;
    }
    else if (sString == "C")
    {
        return 38;
    }
    else if (sString == "D")
    {
        return 39;
    }
    else if (sString == "E")
    {
        return 40;
    }
    else if (sString == "F")
    {
        return 41;
    }
    else if (sString == "G")
    {
        return 42;
    }
    else if (sString == "H")
    {
        return 43;
    }
    else if (sString == "I")
    {
        return 44;
    }
    else if (sString == "J")
    {
        return 45;
    }
    else if (sString == "K")
    {
        return 46;
    }
    else if (sString == "L")
    {
        return 47;
    }
    else if (sString == "M")
    {
        return 48;
    }
    else if (sString == "N")
    {
        return 49;
    }
    else if (sString == "O")
    {
        return 50;
    }
    else if (sString == "P")
    {
        return 60;
    }
    else if (sString == "Q")
    {
        return 61;
    }
    else if (sString == "R")
    {
        return 62;
    }
    else if (sString == "S")
    {
        return 63;
    }
    else if (sString == "T")
    {
        return 64;
    }
    else if (sString == "U")
    {
        return 65;
    }
    else if (sString == "V")
    {
        return 66;
    }
    else if (sString == "W")
    {
        return 67;
    }
    else if (sString == "X")
    {
        return 68;
    }
    else if (sString == "Y")
    {
        return 69 ;
    }
    else if (sString == "Z")
    {
        return 70;
    }
    else if (sString == "0")
    {
        return 0;
    }
    else if ((StringToInt(sString) >= 1)
     && (StringToInt(sString) <= 9))
    {
        return StringToInt(sString);
    }
    else
        return -1; // This should never happen.
}

// Decode a recipe to find a recipe component tag.
string IDDecode(string sRecipeItemCode, int nNumber)
{
    string sReturn = TAG_PREFIX_GEM;
    if (nNumber)
    {
        string sNeeded = GetSubString(sRecipeItemCode,2,1);
        int nNeeded = ConvertCharStringToInt(sNeeded);
        sReturn = IntToString(nNeeded);
    }
    else
    {
        string sAppearance = GetSubString(sRecipeItemCode,0,1);
        string sValue = GetSubString(sRecipeItemCode,1,1);
        sReturn += Convert3Digit(ConvertCharStringToInt(sAppearance));
        sReturn += Convert3Digit(ConvertCharStringToInt(sValue));
    }
    return sReturn;
}

itemproperty ScaleItemPropertyToCatagory(object oItem, itemproperty ipIP,int nCatagory)
{
    int nType, nSub, nBonus, nFix, nCount, nParam1, nEnhancement;
    itemproperty ipINVALID;
    string sTable,sBonus;
    nType = GetItemPropertyType(ipIP);
    nSub = GetItemPropertySubType(ipIP);
    nParam1 = GetItemPropertyParam1(ipIP);
    sBonus == "";
    switch (nType)
    {
        case ITEM_PROPERTY_AC_BONUS:
        case ITEM_PROPERTY_ATTACK_BONUS:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        {
            // These item properties already handled by SetRandomEnhancements which should be called before this function is..
            break;
        }
        case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
        case ITEM_PROPERTY_BONUS_FEAT:
        case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
        case ITEM_PROPERTY_CAST_SPELL:
        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
        case ITEM_PROPERTY_DARKVISION:
        case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
        case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
        case ITEM_PROPERTY_HASTE:
        case ITEM_PROPERTY_HOLY_AVENGER:
        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
        case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
        case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
        case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
        case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
        case ITEM_PROPERTY_IMPROVED_EVASION:
        case ITEM_PROPERTY_KEEN:
        case ITEM_PROPERTY_LIGHT:
        case ITEM_PROPERTY_MIND_BLANK:
        case ITEM_PROPERTY_MONSTER_DAMAGE:
        case ITEM_PROPERTY_NO_DAMAGE:
        case ITEM_PROPERTY_ON_HIT_PROPERTIES:
        case ITEM_PROPERTY_ON_MONSTER_HIT:
        case ITEM_PROPERTY_ONHITCASTSPELL:
        case ITEM_PROPERTY_POISON:
        case ITEM_PROPERTY_SPECIAL_WALK:
        case ITEM_PROPERTY_TRAP:
        case ITEM_PROPERTY_TRUE_SEEING:
        case ITEM_PROPERTY_TYPE_INVALID:
        case ITEM_PROPERTY_USE_LIMITATION_TILESET:
        case ITEM_PROPERTY_VISUALEFFECT:
        case ITEM_PROPERTY_WEIGHT_INCREASE:
        case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_USE_LIMITATION_CLASS:
        case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
        case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_TURN_RESISTANCE:
        case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
        case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
        case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
        case ITEM_PROPERTY_MIGHTY: // FIX THIS!
        {
            //These abilities are unscaleable or should not be scaled.
            break;
        }
        case ITEM_PROPERTY_ABILITY_BONUS:                   // 1 - 12
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:       // 1 - 5
        case ITEM_PROPERTY_DECREASED_DAMAGE:                // 1 - 5
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:  // 1 - 5
        case ITEM_PROPERTY_DECREASED_AC:                    // 1 - 5
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:         // 1 - 5
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:        // 1 - 10
        case ITEM_PROPERTY_HEALERS_KIT:                     // 1 - 12
        case ITEM_PROPERTY_THIEVES_TOOLS:                   // 1 - 12
        case ITEM_PROPERTY_SPELL_RESISTANCE:                // 0 - 11
        {// Uses 1-12 tables.
            sTable = Get2daBonusColumn(nType,nCatagory);
            while (sBonus == "")
            {
                WriteTimestampedLogEntry("ScaleItemPropertyToCatagory LOOP 1");
                sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,sTable);
                WriteTimestampedLogEntry("LOOP 1 Table: " + sTable);
                WriteTimestampedLogEntry("LOOP 1 Type: " + IntToString(nType));
                if (sBonus == D100_TABLE_RESULT_EPIC_SPECIAL)
                {
                    if (nType == ITEM_PROPERTY_ABILITY_BONUS
                     || nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER
                     || nType == ITEM_PROPERTY_HEALERS_KIT
                     || nType == ITEM_PROPERTY_THIEVES_TOOLS
                     || nType == ITEM_PROPERTY_SPELL_RESISTANCE)
                    {
                        // A 6 to 12 bonus will be assigned to the item.
                        sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,EPIC_12_EB);
                        break;
                    }
                    else
                    {
                        // Item property does not support value above 5.
                        sBonus == "5";
                        break;
                    }
                }
                else if (StringToInt(sBonus) == 0)
                {
                    sBonus == "";
                }
            }
            nBonus = StringToInt(sBonus);
            // Make correction for these as they limit to 10.
            // The default tables allow for this with no dramatic skewing in odds.
            if (nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
            {
                if (nBonus > 10)
                {
                    nBonus = 10;
                }
            }
            // Make a correction for this props as it's constants run 0 - 11.
            else if (nType == ITEM_PROPERTY_SPELL_RESISTANCE)
            {
                nBonus -= 1;
            }
            break;
        }
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
        {
            // Bane Items "Enhancement Bonus" +2 (+4 if epic)
            // Tested. This also works with Attack and AC Bonuses.
            nBonus = IPGetWeaponEnhancementBonus(oItem,GetEnhancementTypeByBaseItem(oItem));
            if (nBonus == 20)
            {
                // Item already has a +20 enhancement this bane bonus is extranious remove it.
                return ipINVALID;
            }
            nBonus += 2;
            if (nCatagory == TREASURE_CATAGORY_EPIC)
            {
                // Epic Bane bonus is +4
                nBonus += 2;
            }
            if (nBonus > 20)
            {
                // Cannot exceed the +20 limit.
                nBonus = 20;
            }
            break;
        }
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        {   // Derived from the DMG scrolls tables.
            sTable = Get2daBonusColumn(nType,nCatagory);
            sBonus = GetD100TableResult(LOOT_SCROLL_2DA,sTable);
            nBonus = StringToInt(sBonus);
            break;
        }
        case ITEM_PROPERTY_DAMAGE_REDUCTION:
        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
        {   // 1- 10; 6-10 only thru special epic bonus.
            sTable = Get2daBonusColumn(nType,nCatagory);
            sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,sTable);
            if (sBonus == D100_TABLE_RESULT_EPIC_SPECIAL)
            {
                sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,EPIC_12_EB);
            }
            nBonus = StringToInt(sBonus);
            // The tables used can return return up to 12.
            // Since this property maxes at 10 we correct this now.
            if (nBonus > 10)
            {
                nBonus = 10;
            }
            break;
        }
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
        case ITEM_PROPERTY_REGENERATION:
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
        {   //1 - 20 bonus 6 to 20 epic, 1-5 otherwise
            if (GetIsArmor(oItem))
            {
                sTable = Get2daBonusColumn(ITEM_PROPERTY_AC_BONUS,nCatagory);
            }
            else //Assume a weapon, Non armors will use the weapons table
            {
                sTable = Get2daBonusColumn(ITEM_PROPERTY_ENHANCEMENT_BONUS,nCatagory);
            }
            while (sBonus == "")
            {
                WriteTimestampedLogEntry("ScaleItemPropertyToCatagory LOOP 2");
                sBonus = GetD100TableResult(LOOT_ITEM_BONUS2_2DA,sTable);
                if (sBonus == D100_TABLE_RESULT_EPIC_SPECIAL)
                {
                    sBonus = GetD100TableResult(LOOT_ITEM_BONUS2_2DA,D100_TABLE_RANDOM_SPECIAL_EPIC_WEAPON_ARMOR_BONUS);
                }
                WriteTimestampedLogEntry("    IP 20 Bonus: " +sBonus);
            }
            nBonus = StringToInt(sBonus);
            break;
        }
        case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        {
            sTable = Get2daBonusColumn(nType,nCatagory);
            sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,sTable);
            if (sBonus == D100_TABLE_RESULT_EPIC_SPECIAL)
            {
                sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,DAMAGE_BONUS_EPIC_EB);
            }
            nBonus = StringToInt(sBonus);
            break;
        }
        case ITEM_PROPERTY_SKILL_BONUS: //1-50
        {
            sTable = Get2daBonusColumn(nType,nCatagory);
            sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,sTable);
            if (sBonus == D100_TABLE_RESULT_EPIC_SPECIAL)
            {
                sBonus = GetD100TableResult(LOOT_ITEM_BONUS_2DA,SKILL_BONUS_EPIC_EB);
            }
            nBonus = StringToInt(sBonus);
            break;
        }
    };
    return GetItemPropertyFromInt(nType,nSub,nBonus,nParam1);
}

string Get2daBonusColumn(int nType, int nCatagory)
{
    string sReturn,sTable;
    switch(nType)
    {
        case ITEM_PROPERTY_AC_BONUS:
        {
            switch(nCatagory)
            {
                case TREASURE_CATAGORY_MINOR:
                {
                    sReturn = ARMOR_BONUS_MINOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MED:
                {
                    sReturn = ARMOR_BONUS_MEDIUM_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MAJOR:
                {
                    sReturn = ARMOR_BONUS_MAJOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_EPIC:
                {
                    sReturn = ARMOR_BONUS_EPIC_COLUMN;
                    break;
                }
            };
            break;
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        case ITEM_PROPERTY_ATTACK_BONUS:
        {
            switch(nCatagory)
            {
                case TREASURE_CATAGORY_MINOR:
                {
                    sReturn = WEAPON_BONUS_MINOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MED:
                {
                    sReturn = WEAPON_BONUS_MEDIUM_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MAJOR:
                {
                    sReturn = WEAPON_BONUS_MAJOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_EPIC:
                {
                    sReturn = WEAPON_BONUS_EPIC_COLUMN;
                    break;
                }
            };
            break;
        }
        case ITEM_PROPERTY_ABILITY_BONUS:
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
        case ITEM_PROPERTY_DECREASED_DAMAGE:
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
        case ITEM_PROPERTY_DECREASED_AC:
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
        case ITEM_PROPERTY_HEALERS_KIT:
        case ITEM_PROPERTY_THIEVES_TOOLS:
        case ITEM_PROPERTY_DAMAGE_REDUCTION:
        case ITEM_PROPERTY_SPELL_RESISTANCE:
        {
            switch(nCatagory)
            {
                case TREASURE_CATAGORY_MINOR:
                {
                    sReturn = SPECIAL_BONUS_12_MINOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MED:
                {
                    sReturn = SPECIAL_BONUS_12_MEDIUM_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MAJOR:
                {
                    sReturn = SPECIAL_BONUS_12_MAJOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_EPIC:
                {
                    // Epic items can return D100_TABLE_RESULT_EPIC_SPECIAL make
                    // sure to correct in function calling this one, as some
                    // item properties don't like it.
                    sReturn = SPECIAL_BONUS_12_EPIC_COLUMN;
                    break;
                }
            };
            break;
        }
        case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
        {
            switch(nCatagory)
            {
                case TREASURE_CATAGORY_MINOR:
                {
                    sReturn = SPELL_LEVEL_MINOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MED:
                {
                    sReturn = SPELL_LEVEL_MEDIUM_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MAJOR:
                {
                    sReturn = SPELL_LEVEL_MAJOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_EPIC:
                {
                    sReturn = SPELL_LEVEL_EPIC_COLUMN;
                    break;
                }
            };
            break;
        }
        case ITEM_PROPERTY_DAMAGE_BONUS:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
        case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
        case ITEM_PROPERTY_MASSIVE_CRITICALS:
        {
            switch(nCatagory)
            {
                case TREASURE_CATAGORY_MINOR:
                {
                    sReturn = DAMAGE_BONUS_MINOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MED:
                {
                    sReturn = DAMAGE_BONUS_MEDIUM_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_MAJOR:
                {
                    sReturn = DAMAGE_BONUS_MAJOR_COLUMN;
                    break;
                }
                case TREASURE_CATAGORY_EPIC:
                {
                    sReturn = DAMAGE_BONUS_EPIC_COLUMN;
                    break;
                }
            };
            break;
        }
        case ITEM_PROPERTY_SKILL_BONUS:
        {
            switch(nCatagory)
            {
            case TREASURE_CATAGORY_MINOR:
                {
                sReturn = SKILL_BONUS_MINOR_COLUMN;
                break;
                }
            case TREASURE_CATAGORY_MED:
                {
                sReturn = SKILL_BONUS_MEDIUM_COLUMN;
                break;
                }
            case TREASURE_CATAGORY_MAJOR:
                {
                sReturn = SKILL_BONUS_MAJOR_COLUMN;
                break;
                }
            case TREASURE_CATAGORY_EPIC:
                {
                sReturn = SKILL_BONUS_EPIC_COLUMN;
                break;
                }
            };
        break;
        }
    };
    return sReturn;
}

itemproperty GetProperItemProperty(int nType,int nBonus)
{
    itemproperty ipIP;
    switch (nType)
    {
        case ITEM_PROPERTY_AC_BONUS:
        {
            return ItemPropertyACBonus(nBonus);
        }
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
        {
            return ItemPropertyEnhancementBonus(nBonus);
        }
        case ITEM_PROPERTY_ATTACK_BONUS:
        {
            return ItemPropertyAttackBonus(nBonus);
        }
        case ITEM_PROPERTY_DAMAGE_BONUS:
        {
            return ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,nBonus);
        }
        case ITEM_PROPERTY_HEALERS_KIT:
        {
            return ItemPropertyHealersKit(nBonus);
        }
        case ITEM_PROPERTY_THIEVES_TOOLS:
        {
            return ItemPropertyThievesTools(nBonus);
        }
    };
    // This is here for compile reasons only.
    // If this happens an error log will be made.
    WriteTimestampedLogEntry("Invalid IP returned by GetProperItemProperty, inc_id_treasure");
    return ipIP;
}

void ReplaceItemProperty(object oItem, itemproperty ipOriginal, itemproperty ipNew)
{
    RemoveItemProperty(oItem,ipOriginal);
    AddItemProperty(DURATION_TYPE_PERMANENT,ipNew,oItem);
}
//void main (){} /*Added for compile reasons*/
