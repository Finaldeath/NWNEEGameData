// smith enhances an item, if working on one
// - brian watson

#include "x2_inc_itemprop"

void PopLid(object oChest);

void ReturnItem(object oItem, object oChest);

void main()
{
    ClearAllActions(TRUE);

    object oWorkItem = GetLocalObject(OBJECT_SELF, "oWorkItem");

    if (GetIsObjectValid(oWorkItem))
    {
        if (GetItemPossessor(oWorkItem) == OBJECT_SELF)
        {
            object oChest = GetNearestObjectByTag("bw_smith_chest");

            if (GetLocalInt(oWorkItem, "nIH_SmithWorked") == 1)
            {
                ActionMoveToObject(oChest);
                ActionDoCommand(PopLid(oChest));
                ActionGiveItem(oWorkItem, oChest);
                ActionDoCommand(SetPickpocketableFlag(oWorkItem, TRUE));
                ActionDoCommand(DeleteLocalObject(OBJECT_SELF, "oWorkItem"));
                return;
            }

            object oAnvil = GetNearestObjectByTag("bw_smith_anvil");

            effect eVFX = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oAnvil);

            int nItemType = GetBaseItemType(oWorkItem);
            int nItemCode = 0;

            if (IPGetIsMeleeWeapon(oWorkItem))
            {
                int nUpgrade = 1; // enhancement bonus to add to weapons

                // if we're enchancing a dwarven waraxe, get a bonus! ;)
                if (nItemType == BASE_ITEM_DWARVENWARAXE) nUpgrade = 2;

                if (!GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_KEEN))
                {
                    // add keen property to melee weapons!
                    itemproperty ipKeen = ItemPropertyKeen();
                    IPSafeAddItemProperty(oWorkItem, ipKeen);
                }

                IPUpgradeWeaponEnhancementBonus(oWorkItem, nUpgrade);
                nItemCode = 1; // melee weapon
            }
            else
            {
                int nBonus = 0;
                itemproperty ipNew;
                itemproperty ipProp;

                if (GetWeaponRanged(oWorkItem))
                {
                    if (GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_ATTACK_BONUS))
                    {
                        ipProp = GetFirstItemProperty(oWorkItem);
                        while (GetIsItemPropertyValid(ipProp) && (nBonus == 0))
                        {
                            if (GetItemPropertyType(ipProp) == ITEM_PROPERTY_ATTACK_BONUS)
                            {
                                nBonus = GetItemPropertyCostTableValue(ipProp);
                            }
                            ipProp = GetNextItemProperty(oWorkItem);
                        }
                    }

                    nBonus += 2; // increase attack value by 2 for ranged weapons!
                    ipNew = ItemPropertyAttackBonus(nBonus);

                    IPSafeAddItemProperty(oWorkItem, ipNew);

                    if (!GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_MIGHTY))
                    {
                        itemproperty ipMighty = ItemPropertyMaxRangeStrengthMod(2);
                        IPSafeAddItemProperty(oWorkItem, ipMighty);
                    }

                    nItemCode = 2; // missile weapon
                }
                else if (nItemType == BASE_ITEM_ARMOR)
                {
                    if (GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_AC_BONUS))
                    {
                        ipProp = GetFirstItemProperty(oWorkItem);
                        while (GetIsItemPropertyValid(ipProp) && (nBonus == 0))
                        {
                            if (GetItemPropertyType(ipProp) == ITEM_PROPERTY_AC_BONUS)
                            {
                                nBonus = GetItemPropertyCostTableValue(ipProp);
                            }
                            ipProp = GetNextItemProperty(oWorkItem);
                        }
                    }

                    nBonus += 1;
                    ipNew = ItemPropertyACBonus(nBonus);

                    IPSafeAddItemProperty(oWorkItem, ipNew);

                    if (!GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_DAMAGE_REDUCTION))
                    {
                        itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3, IP_CONST_DAMAGESOAK_5_HP);
                        IPSafeAddItemProperty(oWorkItem, ipDR);
                    }

                    nItemCode = 3; // armor
                }
                else if ((nItemType == BASE_ITEM_LARGESHIELD) ||
                         (nItemType == BASE_ITEM_SMALLSHIELD) ||
                         (nItemType == BASE_ITEM_TOWERSHIELD))
                {
                    if (GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_AC_BONUS))
                    {
                        ipProp = GetFirstItemProperty(oWorkItem);
                        while (GetIsItemPropertyValid(ipProp) && (nBonus == 0))
                        {
                            if (GetItemPropertyType(ipProp) == ITEM_PROPERTY_AC_BONUS)
                            {
                                nBonus = GetItemPropertyCostTableValue(ipProp);
                            }
                            ipProp = GetNextItemProperty(oWorkItem);
                        }
                    }

                    nBonus += 1;
                    ipNew = ItemPropertyACBonus(nBonus);

                    IPSafeAddItemProperty(oWorkItem, ipNew);

                    if (!GetItemHasItemProperty(oWorkItem, ITEM_PROPERTY_DAMAGE_REDUCTION))
                    {
                        itemproperty ipDR = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3, IP_CONST_DAMAGESOAK_5_HP);
                        IPSafeAddItemProperty(oWorkItem, ipDR);
                    }

                    nItemCode = 4; // shield
                }
            }

            if (nItemCode > 0) // valid item
            {
                SetLocalInt(oWorkItem, "nIH_SmithWorked", 1);

                itemproperty ipGlow = ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);

                string sItemType;

                // find type of armor, weapon
                if (nItemCode == 1)      // melee weapon
                {
                    if      (nItemType == BASE_ITEM_BASTARDSWORD) sItemType = "Bastard Sword";
                    else if (nItemType == BASE_ITEM_BATTLEAXE) sItemType = "Battleaxe";
                    else if (nItemType == BASE_ITEM_DAGGER) sItemType = "Dagger";
                    else if (nItemType == BASE_ITEM_DIREMACE) sItemType = "Dire Mace";
                    else if (nItemType == BASE_ITEM_DOUBLEAXE) sItemType = "Double Axe";
                    else if (nItemType == BASE_ITEM_DWARVENWARAXE) sItemType = "Dwarven Waraxe";
                    else if (nItemType == BASE_ITEM_GREATAXE) sItemType = "Greataxe";
                    else if (nItemType == BASE_ITEM_GREATSWORD) sItemType = "Greatsword";
                    else if (nItemType == BASE_ITEM_HALBERD) sItemType = "Halberd";
                    else if (nItemType == BASE_ITEM_HANDAXE) sItemType = "Handaxe";
                    else if (nItemType == BASE_ITEM_HEAVYFLAIL) sItemType = "Heavy Flail";
                    else if (nItemType == BASE_ITEM_HELMET) sItemType = "Helmet";
                    else if (nItemType == BASE_ITEM_KAMA) sItemType = "Kama";
                    else if (nItemType == BASE_ITEM_KATANA) sItemType = "Katana";
                    else if (nItemType == BASE_ITEM_KUKRI) sItemType = "Kukri";
                    else if (nItemType == BASE_ITEM_LIGHTFLAIL) sItemType = "Light Flail";
                    else if (nItemType == BASE_ITEM_LIGHTHAMMER) sItemType = "Light Hammer";
                    else if (nItemType == BASE_ITEM_LIGHTMACE) sItemType = "Light Mace";
                    else if (nItemType == BASE_ITEM_LONGSWORD) sItemType = "Longsword";
                    else if (nItemType == BASE_ITEM_MORNINGSTAR) sItemType = "Morningstar";
                    else if (nItemType == BASE_ITEM_QUARTERSTAFF) sItemType = "Quarterstaff";
                    else if (nItemType == BASE_ITEM_RAPIER) sItemType = "Rapier";
                    else if (nItemType == BASE_ITEM_SCIMITAR) sItemType = "Scimitar";
                    else if (nItemType == BASE_ITEM_SCYTHE) sItemType = "Scythe";
                    else if (nItemType == BASE_ITEM_SHORTSPEAR) sItemType = "Short Spear";
                    else if (nItemType == BASE_ITEM_SHORTSWORD) sItemType = "Short Sword";
                    else if (nItemType == BASE_ITEM_SICKLE) sItemType = "Sickle";
                    else if (nItemType == BASE_ITEM_TRIDENT) sItemType = "Trident";
                    else if (nItemType == BASE_ITEM_TWOBLADEDSWORD) sItemType = "Two-Bladed Sword";
                    else if (nItemType == BASE_ITEM_WARHAMMER) sItemType = "Warhammer";
                    else if (nItemType == BASE_ITEM_WHIP) sItemType = "Whip";

                    else sItemType = "Weapon";

                    // add glow for melee weapons
                    IPSafeAddItemProperty(oWorkItem, ipGlow);
                }
                else if (nItemCode == 2) // ranged weapon
                {
                    if      (nItemType == BASE_ITEM_HEAVYCROSSBOW) sItemType = "Heavy Crossbow";
                    else if (nItemType == BASE_ITEM_LIGHTCROSSBOW) sItemType = "Light Crossbow";
                    else if (nItemType == BASE_ITEM_LONGBOW) sItemType = "Longbow";
                    else if (nItemType == BASE_ITEM_SHORTBOW) sItemType = "Shortbow";
                    else if (nItemType == BASE_ITEM_SLING) sItemType = "Sling";

                    else sItemType = "Weapon";

                    // add glow for ranged weapons
                    IPSafeAddItemProperty(oWorkItem, ipGlow);
                }
                else if (nItemCode == 3) // armor
                {
                    sItemType = "Armor";
                }
                else if (nItemCode == 4) // shield
                {
                    if      (nItemType == BASE_ITEM_LARGESHIELD) sItemType = "Large Shield";
                    else if (nItemType == BASE_ITEM_SMALLSHIELD) sItemType = "Small Shield";
                    else if (nItemType == BASE_ITEM_TOWERSHIELD) sItemType = "Tower Shield";

                    else sItemType = "Shield";
                }

                string sNewName = ("Moradin's " + sItemType);
                SetName(oWorkItem, sNewName);
            }

            DelayCommand(1.0f, ReturnItem(oWorkItem, oChest));
        }
        else
        {
            DeleteLocalObject(OBJECT_SELF, "oWorkItem");
        }
    }
    else
    {
        DeleteLocalObject(OBJECT_SELF, "oWorkItem");
    }
}

void PopLid(object oChest)
{
    AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
    DelayCommand(1.0f, AssignCommand(oChest, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE)));
}

void ReturnItem(object oItem, object oChest)
{
    string q = GetLocalString(GetModule(), "QUOTE");

            ActionMoveToObject(oChest);
            ActionDoCommand(PopLid(oChest));
            ActionGiveItem(oItem, oChest);
            ActionDoCommand(SetPickpocketableFlag(oItem, TRUE));
            ActionDoCommand(DeleteLocalObject(OBJECT_SELF, "oWorkItem"));
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "iGhostSmithComplete", 1));
            ActionSpeakString(q+"There you are."+q);
}
