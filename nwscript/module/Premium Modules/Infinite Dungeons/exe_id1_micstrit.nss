#include "inc_id1_debug"
#include "inc_id1_flags"
#include "inc_id1_items"
#include "inc_id1_prop"

const int ID1_PROPERTY_LIMIT = 2;

void main()
{
    // get store object
    object oStore = GetLocalObject(OBJECT_SELF, "oStore");

    // get item level
    int nItemLevel = GetLocalInt(OBJECT_SELF, "nLevel");
    DebugMessage("Level of store item is " + IntToString(nItemLevel));

    // find the appropriate maximum level range of treasure
    if (nItemLevel > 40)
    {
        nItemLevel = 40;
    }
    if (nItemLevel < 1)
    {
        nItemLevel = 1;
    }

    int nItemCategoryLevel = nItemLevel / 2;
    if (nItemCategoryLevel < 0)
    {
        nItemCategoryLevel = 0;
    }
    if (nItemCategoryLevel > 9)
    {
        nItemCategoryLevel = 9;
    }
    DebugMessage("      Item category level selected is " + IntToString(nItemCategoryLevel));

    string sResRef = "";

            // determine if this item is specific or generic
    int nSpecificItemPercentage = GetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY);
    int nRandom = Random(100) + 1;
    DebugMessage("      Random specific item number is " + IntToString(nRandom) + " vs " + IntToString(nSpecificItemPercentage));
    if (nRandom <= nSpecificItemPercentage) // specific item
    {
        string sValue = "Value" + IntToString(nItemLevel);
        DebugMessage("      Value category is " + sValue);

        // pick a category
        int nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
        DebugMessage("      Total of n" + sValue + "Total is " + IntToString(nTotal));
        if (nTotal > 0)
        {
            nRandom = Random(nTotal) + 1;
            int nCategory = 1;
            int nCurrentTotal = GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
            DebugMessage("        Checking random number " + IntToString(nRandom) + " against category " + IntToString(nCategory) + " total of " + IntToString(nCurrentTotal));
            while (nRandom > nCurrentTotal)
            {
                nCategory++;
                nCurrentTotal += GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                DebugMessage("        Checking random number " + IntToString(nRandom) + " against category " + IntToString(nCategory) + " total of " + IntToString(nCurrentTotal));
            }
            string sCategory = sValue + "Category" + IntToString(nCategory);
            DebugMessage("      Item category selected was " + sCategory);

            // pick a subcategory
            int nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
            DebugMessage("      Total for " + sCategory + " is " + IntToString(nCategoryTotal));
            nRandom = Random(nCategoryTotal) + 1;
            int nSubCategory = 1;
            nCurrentTotal = GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
            DebugMessage("        Checking random number " + IntToString(nRandom) + " against subcategory " + IntToString(nSubCategory) + " total of " + IntToString(nCurrentTotal));
            while (nRandom > nCurrentTotal)
            {
                nSubCategory++;
                nCurrentTotal += GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                DebugMessage("        Checking random number " + IntToString(nRandom) + " against subcategory " + IntToString(nSubCategory) + " total of " + IntToString(nCurrentTotal));
            }
            string sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
            DebugMessage("      Item subcategory selected was " + sSubCategory);

            // pick a type
            int nSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
            DebugMessage("      Total for " + sSubCategory + " is " + IntToString(nSubCategoryTotal));
            nRandom = Random(nSubCategoryTotal) + 1;
            int nType = 1;
            nCurrentTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
            DebugMessage("        Checking random number " + IntToString(nRandom) + " against type " + IntToString(nType) + " total of " + IntToString(nCurrentTotal));
            while (nRandom > nCurrentTotal)
            {
                nType++;
                nCurrentTotal += GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                DebugMessage("        Checking random number " + IntToString(nRandom) + " against type " + IntToString(nType) + " total of " + IntToString(nCurrentTotal));
            }
            string sType = sSubCategory + "Type" + IntToString(nType);
            DebugMessage("      Item type selected was " + sType);

            // if this is a specific item
            if ((nCategory != 4) || ((nCategory == 4) && (nSubCategory != 1) && (nSubCategory != 3) && (nSubCategory != 4) && (nSubCategory != 5)))
            {
                // get item from that type
                int nItemTypeNum = GetLocalInt(GetModule(), "n" + sType + "Num");
                DebugMessage("      There are " + IntToString(nItemTypeNum) + " items in n" + sType + "Num");

                // get a specific item
                nRandom = Random(nItemTypeNum) + 1;
                sResRef = GetLocalString(GetModule(), "s" + sType + "_" + IntToString(nRandom) + "ResRef");
                DebugMessage("      Selected item s" + sType + "_" + IntToString(nRandom) + "ResRef is " + sResRef);

                // create the item on the store
                int nStackSize = Random(89) + 11;
                CreateItemOnObject(sResRef, oStore, nStackSize);
            } else // basic nwn consumable
            {
                int nStackSize = 1;

                if (nSubCategory == 1) // grenade
                {
                    // pick from a list of grenades based on level
                    int nItemTypeNum = GetGrenadeNum(nItemLevel);
                    int nRandomItemType = Random(nItemTypeNum) + 1;
                    sResRef = GetGrenadeResRef(nItemLevel, nRandomItemType);
                    DebugMessage("      Selected grenade " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                    nStackSize = Random(6) + 5;
                } else if (nSubCategory == 2) // wand
                {
                    // pick from a list of wands based on level
                    int nItemTypeNum = GetWandNum(nItemCategoryLevel);
                    int nRandomItemType = Random(nItemTypeNum) + 1;
                    sResRef = GetWandResRef(nItemCategoryLevel, nRandomItemType);
                    DebugMessage("      Selected wand " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                } else if (nSubCategory == 3) // potions
                {
                    // pick from a list of potions based on level
                    int nItemTypeNum = GetPotionNum(nItemCategoryLevel);
                    int nRandomItemType = Random(nItemTypeNum) + 1;
                    sResRef = GetPotionResRef(nItemCategoryLevel, nRandomItemType);
                    DebugMessage("      Selected potion " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                } else if (nSubCategory == 4) // scroll
                {
                    // pick from a list of scrolls based on level
                    int nItemTypeNum = GetScrollNum(nItemCategoryLevel);
                    int nRandomItemType = Random(nItemTypeNum) + 1;
                    sResRef = GetScrollResRef(nItemCategoryLevel, nRandomItemType);
                    DebugMessage("      Selected scroll " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                }

                if (sResRef != "")
                {
                    CreateItemOnObject(sResRef, oStore, nStackSize);
                }
            }
        }
    } else // generic item
    {
        string sValue = "Ideal";
        DebugMessage("      Ideal category is " + sValue);

        // pick a category
        int nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
        DebugMessage("      Total of all categories is " + IntToString(nTotal));
        if (nTotal > 0)
        {
            nRandom = Random(nTotal) + 1;
            DebugMessage("      Random is " + IntToString(nRandom));
            int nCategory = 1;
            int nPercentageValue = GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
            DebugMessage("        Percentage value of n" + sValue + "Category" + IntToString(nCategory) + "Percentage is " + IntToString(nPercentageValue));
            while (nRandom > nPercentageValue)
            {
                nCategory++;
                nPercentageValue += GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                DebugMessage("        Percentage value of n" + sValue + "Category" + IntToString(nCategory) + "Percentage is " + IntToString(nPercentageValue));
            }
            string sCategory = sValue + "Category" + IntToString(nCategory);
            DebugMessage("      Item category selected was " + sCategory);

            // pick a subcategory
            int nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
            DebugMessage("      Total for " + sCategory + " is " + IntToString(nCategoryTotal));
            nRandom = Random(nCategoryTotal) + 1;
            DebugMessage("      Random is " + IntToString(nRandom));
            int nSubCategory = 1;
            nPercentageValue = GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
            DebugMessage("        Percentage value of n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage is " + IntToString(nPercentageValue));
            while (nRandom > nPercentageValue)
            {
                nSubCategory++;
                nPercentageValue += GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                DebugMessage("        Percentage value of n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage is " + IntToString(nPercentageValue));
            }
            string sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
            DebugMessage("      Item subcategory selected was " + sSubCategory);

            // pick a type
            int nSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
            DebugMessage("      Total for " + sSubCategory + " is " + IntToString(nSubCategoryTotal));
            nRandom = Random(nSubCategoryTotal) + 1;
            DebugMessage("      Random is " + IntToString(nRandom));
            int nType = 1;
            nPercentageValue = GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
            DebugMessage("        Percentage value of n" + sSubCategory + "Type" + IntToString(nType) + "Percentage is " + IntToString(nPercentageValue));
            while (nRandom > nPercentageValue)
            {
                nType++;
                nPercentageValue += GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                DebugMessage("        Percentage value of n" + sSubCategory + "Type" + IntToString(nType) + "Percentage is " + IntToString(nPercentageValue));
            }
            string sType = sSubCategory + "Type" + IntToString(nType);
            DebugMessage("      Item type selected was " + sType);

            // if this is a normal generic item
            if ((nCategory != 5) && (nCategory != 4))
            {
                // get the base template item
                sResRef = GetTypeGenericItem(nCategory, nSubCategory, nType);
                DebugMessage("      ResRef of item is " + sResRef);

                // create temporary item
                object oItem = CreateItemOnObject(sResRef, GetObjectByTag("DungeonInventory"));
                int nBaseType = GetBaseItemType(oItem);
                DebugMessage("      Base type of item is " + IntToString(nBaseType));

                // get base item multiplier
                float fItemMultiplier = StringToFloat(Get2DAString("baseitems", "ItemMultiplier", nBaseType));
                DebugMessage("      Initial item multiplier is " + FloatToString(fItemMultiplier));

                // if stacking, multiply by stack size
                int nStacking = StringToInt(Get2DAString("baseitems", "Stacking", nBaseType));
                if (nStacking > 1)
                {
                    fItemMultiplier *= nStacking;
                }
                DebugMessage("      Stacked item multiplier is " + FloatToString(fItemMultiplier));

                // get base item cost
                float fBaseCost;
                if (nBaseType != 16) // if not armor
                {
                    fBaseCost = StringToFloat(Get2DAString("baseitems", "BaseCost", nBaseType));
                } else
                {
                    SetIdentified(oItem, FALSE);
                    fBaseCost = IntToFloat(GetGoldPieceValue(oItem));
                }
                DebugMessage("      Base cost is " + FloatToString(fBaseCost));
                if (fItemMultiplier > 0.0)
                {
                    // determine maximum property multiplier
                    int nItemValue = nItemLevel * nItemLevel * 500;
                    float fMaxMultiplier = sqrt(((nItemValue / fItemMultiplier) - fBaseCost) / 1000.0);
                    float fCurrentMultiplier = 0.0;
                    float fInitialMultiplier = fMaxMultiplier / 5;
                    DebugMessage("      Base item value is " + IntToString(nItemValue) + " resulting in multiplier of " + FloatToString(fMaxMultiplier));

                    int nPropertyNum = 0;
                    int bAvailableProperty = TRUE;

                    // create holder object
                    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "oTempHolder3");

                    // if armor or a weapon
                    if ((nCategory == 1) || (nCategory == 2))
                    {
                        // EDIT: add an appropriate bonus
                        // weapon
                        if (nCategory == 1)
                        {
                            // melee
                            if (nSubCategory == 1)
                            {
                                DebugMessage("      This item is a melee weapon."); // enhancement (23)

                                float fFirstTableValue = GetLocalFloat(GetModule(), "fProperty23FirstCostTable1Cost");
                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                int nSecondTableMax = (nItemLevel / 5) + 1;
                                DebugMessage("      SecondTable max is " + IntToString(nSecondTableMax));

                                if (nSecondTableMax < 1)
                                {
                                    nSecondTableMax = 1;
                                }
                                if (nSecondTableMax > 20)
                                {
                                    nSecondTableMax = 20;
                                }
                                DebugMessage("      Revised SecondTable max is " + IntToString(nSecondTableMax));

                                int nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                if (nSecondTableMin < 1)
                                {
                                    nSecondTableMin = 1;
                                }
                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                int nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                float fSecondTableValue = GetLocalFloat(GetModule(), "fProperty23SecondCostTable" + IntToString(nSecondTable) + "Cost");
                                DebugMessage("      Second table entry selected is " + IntToString(nSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty23SecondCostTable" + IntToString(nSecondTable) + "Cost");

                                // add property
                                nPropertyNum++;
                                SetLocalInt(oTempHolder, "nPropertyNum", nPropertyNum);

                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "Property", 23);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "FirstTable", 1);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SecondTable", nSecondTable);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SubType", 0);
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "Property to 23");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "FirstTable to 1");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SecondTable to " + IntToString(nSecondTable));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SubType to 0");

                                fMaxMultiplier -= (fFirstTableValue * fSecondTableValue);
                                fCurrentMultiplier += (fFirstTableValue * fSecondTableValue);
                                DebugMessage("      Set MaxMultiplier to " + FloatToString(fMaxMultiplier));
                            }

                            // ranged
                            if (nSubCategory == 2)
                            {
                                DebugMessage("      This item is a ranged weapon."); // attack (8)

                                float fFirstTableValue = GetLocalFloat(GetModule(), "fProperty8FirstCostTable1Cost");
                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                int nSecondTableMax = (nItemLevel / 5) + 1;
                                DebugMessage("      SecondTable max is " + IntToString(nSecondTableMax));

                                if (nSecondTableMax < 1)
                                {
                                    nSecondTableMax = 1;
                                }
                                if (nSecondTableMax > 20)
                                {
                                    nSecondTableMax = 20;
                                }
                                DebugMessage("      Revised SecondTable max is " + IntToString(nSecondTableMax));

                                int nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                if (nSecondTableMin < 1)
                                {
                                    nSecondTableMin = 1;
                                }
                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                int nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                float fSecondTableValue = GetLocalFloat(GetModule(), "fProperty8SecondCostTable" + IntToString(nSecondTable) + "Cost");
                                DebugMessage("      Second table entry selected is " + IntToString(nSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty8SecondCostTable" + IntToString(nSecondTable) + "Cost");

                                // add property
                                nPropertyNum++;
                                SetLocalInt(oTempHolder, "nPropertyNum", nPropertyNum);

                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "Property", 8);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "FirstTable", 1);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SecondTable", nSecondTable);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SubType", 0);
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "Property to 8");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "FirstTable to 1");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SecondTable to " + IntToString(nSecondTable));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SubType to 0");

                                fMaxMultiplier -= (fFirstTableValue * fSecondTableValue);
                                fCurrentMultiplier += (fFirstTableValue * fSecondTableValue);
                                DebugMessage("      Set MaxMultiplier to " + FloatToString(fMaxMultiplier));
                            }

                            // ammunition
                            if (nSubCategory == 3)
                            {
                                DebugMessage("      This item is ammunition."); // damage piercing/bludegeoning (15)

                                float fFirstTableValue = GetLocalFloat(GetModule(), "fProperty15FirstCostTable1Cost");
                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                int nSecondTableMax = (nItemLevel / 5) + 1;
                                DebugMessage("      SecondTable max is " + IntToString(nSecondTableMax));

                                if (nSecondTableMax < 1)
                                {
                                    nSecondTableMax = 1;
                                }
                                if (nSecondTableMax > 20)
                                {
                                    nSecondTableMax = 20;
                                }
                                DebugMessage("      Revised SecondTable max is " + IntToString(nSecondTableMax));

                                int nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                if (nSecondTableMin < 1)
                                {
                                    nSecondTableMin = 1;
                                }
                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                int nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                int nActualSecondTable;
                                if (nSecondTable == 1)
                                {
                                    nActualSecondTable = 1;
                                } else if (nSecondTable == 2)
                                {
                                    nActualSecondTable = 2;
                                } else if (nSecondTable == 3)
                                {
                                    nActualSecondTable = 5;
                                } else if (nSecondTable == 4)
                                {
                                    nActualSecondTable = 7;
                                } else if (nSecondTable == 5)
                                {
                                    nActualSecondTable = 12;
                                } else if (nSecondTable == 6)
                                {
                                    nActualSecondTable = 13;
                                } else if (nSecondTable == 7)
                                {
                                    nActualSecondTable = 15;
                                } else if (nSecondTable == 8)
                                {
                                    nActualSecondTable = 17;
                                } else if (nSecondTable == 9)
                                {
                                    nActualSecondTable = 19;
                                } else if (nSecondTable == 10)
                                {
                                    nActualSecondTable = 20;
                                } else if (nSecondTable == 11)
                                {
                                    nActualSecondTable = 21;
                                } else if (nSecondTable == 12)
                                {
                                    nActualSecondTable = 22;
                                } else if (nSecondTable == 13)
                                {
                                    nActualSecondTable = 23;
                                } else if (nSecondTable == 14)
                                {
                                    nActualSecondTable = 24;
                                } else if (nSecondTable == 15)
                                {
                                    nActualSecondTable = 25;
                                } else if (nSecondTable == 16)
                                {
                                    nActualSecondTable = 26;
                                } else if (nSecondTable == 17)
                                {
                                    nActualSecondTable = 27;
                                } else if (nSecondTable == 18)
                                {
                                    nActualSecondTable = 28;
                                } else if (nSecondTable == 19)
                                {
                                    nActualSecondTable = 29;
                                } else if (nSecondTable == 20)
                                {
                                    nActualSecondTable = 30;
                                }

                                float fSecondTableValue = GetLocalFloat(GetModule(), "fProperty15SecondCostTable" + IntToString(nActualSecondTable) + "Cost");
                                DebugMessage("      Second table entry selected is " + IntToString(nActualSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty15SecondCostTable" + IntToString(nSecondTable) + "Cost");

                                int nSubType;
                                if (nBaseType == BASE_ITEM_BULLET)
                                {
                                    nSubType = 1;
                                } else
                                {
                                    nSubType = 2;
                                }

                                // add property
                                nPropertyNum++;
                                SetLocalInt(oTempHolder, "nPropertyNum", nPropertyNum);

                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "Property", 15);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "FirstTable", 1);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SecondTable", nActualSecondTable);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SubType", nSubType);
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "Property to 15");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "FirstTable to 1");
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SecondTable to " + IntToString(nActualSecondTable));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SubType to " + IntToString(nSubType));

                                fMaxMultiplier -= (fFirstTableValue * fSecondTableValue);
                                fCurrentMultiplier += (fFirstTableValue * fSecondTableValue);
                                DebugMessage("      Set MaxMultiplier to " + FloatToString(fMaxMultiplier));
                            }
                        }

                        // armor
                        if (nCategory == 2)
                        {
                            DebugMessage("      This item is armor."); // AC (2)

                            float fFirstTableValue = GetLocalFloat(GetModule(), "fProperty2FirstCostTable1Cost");
                            DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                            int nSecondTableMax = (nItemLevel / 5) + 1;
                            DebugMessage("      SecondTable max is " + IntToString(nSecondTableMax));

                            if (nSecondTableMax < 1)
                            {
                                nSecondTableMax = 1;
                            }
                            if (nSecondTableMax > 20)
                            {
                                nSecondTableMax = 20;
                            }
                            DebugMessage("      Revised SecondTable max is " + IntToString(nSecondTableMax));

                            int nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                            if (nSecondTableMin < 1)
                            {
                                nSecondTableMin = 1;
                            }
                            DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                            int nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                            float fSecondTableValue = GetLocalFloat(GetModule(), "fProperty2SecondCostTable" + IntToString(nSecondTable) + "Cost");
                            DebugMessage("      Second table entry selected is " + IntToString(nSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty2SecondCostTable" + IntToString(nSecondTable) + "Cost");

                            // add property
                            nPropertyNum++;
                            SetLocalInt(oTempHolder, "nPropertyNum", nPropertyNum);

                            SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "Property", 2);
                            SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "FirstTable", 1);
                            SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SecondTable", nSecondTable);
                            SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SubType", 0);
                            DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "Property to 2");
                            DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "FirstTable to 1");
                            DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SecondTable to " + IntToString(nSecondTable));
                            DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SubType to 0");

                            fMaxMultiplier -= (fFirstTableValue * fSecondTableValue);
                            fCurrentMultiplier += (fFirstTableValue * fSecondTableValue);
                            DebugMessage("      Set MaxMultiplier to " + FloatToString(fMaxMultiplier));
                        }
                    }

                    if (fMaxMultiplier < 0.0)
                    {
                        fMaxMultiplier = 0.0;
                        fInitialMultiplier = 1.0;
                    }

                    int nPropertyMinMax;
                    int nCurrentProperty;
                    int bItemPropertyPresent;
                    int bUp;
                    int bDown;
                    int nActualProperty;
                    int nItemPropertyNum;
                    int nItemProperty;
                    int nItemPropertyValue;
                    int nPropColumn;
                    string sPropColumn;
                    string sPropResult;
                    int bPropertyColumnPresent;
                    float fSecondTableMin;
                    float fFirstTableMax;
                    int nFirstTableNum;
                    int nFirstTableMax;
                    int nFirstTableMin;
                    int nFirstTable;
                    float fFirstTableValue;
                    float fSecondTableMax;
                    int nSecondTableNum;
                    int nSecondTableMax;
                    int nSecondTableMin;
                    int nSecondTable;
                    float fSecondTableValue;
                    int nSubTypeNum;
                    int nSubType;
                    while ((nPropertyNum < 2) && (bAvailableProperty == TRUE) && (fMaxMultiplier > fInitialMultiplier))
                    {
                        DebugMessage("      Current number of properties is " + IntToString(nPropertyNum));

                        // find maximum property that meets requirements
                        nPropertyMinMax = 0;
                        while ((GetLocalFloat(GetModule(), "fPropertyMin" + IntToString(nPropertyMinMax + 1) + "Value") <= fMaxMultiplier) && (nPropertyMinMax < 49))
                        {
                            nPropertyMinMax++;
                        }
                        DebugMessage("        Maximum possible property is " + IntToString(nPropertyMinMax));

                        if (nPropertyMinMax > 0)
                        {
                            nCurrentProperty = Random(nPropertyMinMax) + 1;
                            bItemPropertyPresent = TRUE;
                            bUp = FALSE;
                            bDown = FALSE;

                            // find an appropriate property to add
                            while ((bItemPropertyPresent == TRUE) && ((bUp == FALSE) || (bDown == FALSE)))
                            {
                                // get which property this is
                                nActualProperty = GetLocalInt(GetModule(), "nPropertyMin" + IntToString(nCurrentProperty) + "Property");
                                DebugMessage("        Selected property min " + IntToString(nCurrentProperty) + " which is internal property " + IntToString(nActualProperty) + " and external property " + IntToString(TranslateInternalToExternal(nActualProperty)));

                                // set property present to false
                                bItemPropertyPresent = FALSE;

                                // go from beginning up to current number
                                nItemPropertyNum = GetLocalInt(oTempHolder, "nPropertyNum");
                                nItemProperty = 1;
                                while ((nItemProperty <= nItemPropertyNum) && (bItemPropertyPresent == FALSE))
                                {
                                    nItemPropertyValue = GetLocalInt(oTempHolder, "nProperty" + IntToString(nItemProperty) + "Property");
                                    DebugMessage("          Property " + IntToString(nItemProperty) + " of " + IntToString(nItemPropertyNum) + " was " + IntToString(nItemPropertyValue));
                                    if (nItemPropertyValue == nActualProperty)
                                    {
                                        DebugMessage("            Property already present.");

                                        bItemPropertyPresent = TRUE;
                                    } else
                                    {
                                        nItemProperty++;
                                    }
                                }

                                // if property is not already used
                                if (bItemPropertyPresent == FALSE)
                                {
                                    // get propcolumn of the base type
                                    nPropColumn = StringToInt(Get2DAString("baseitems", "PropColumn", nBaseType));
                                    sPropColumn = GetItemPropertyColumn(nPropColumn);
                                    DebugMessage("      Property column is " + IntToString(nPropColumn) + " which is " + sPropColumn);

                                    // get if actual property is valid for this item
                                    sPropResult = Get2DAString("itemprops", sPropColumn, TranslateInternalToExternal(nActualProperty));
                                    bPropertyColumnPresent = StringToInt(sPropResult);
                                    DebugMessage("      sPropResult is " + sPropResult + " and bPropertyColumnPresent is " + IntToString(bPropertyColumnPresent));

                                    if (bPropertyColumnPresent == FALSE)
                                    {
                                        DebugMessage("        Item cannot have this property.");

                                        bItemPropertyPresent = TRUE;
                                    }
                                }

                                // property is already used
                                if (bItemPropertyPresent == TRUE)
                                {
                                    DebugMessage("      Property is present or invalid.");

                                    if (nCurrentProperty >= nPropertyMinMax)
                                    {
                                        DebugMessage("      Maximum property checked.");

                                        bUp = TRUE;
                                    }

                                    if (nCurrentProperty <= 1)
                                    {
                                        DebugMessage("      Minimum property checked.");

                                        bDown = TRUE;
                                    }

                                    if ((bUp == TRUE) && (bDown == TRUE))
                                    {
                                        DebugMessage("      All properties checked. No available property found.");

                                        bAvailableProperty = FALSE;
                                    } else if (bUp == TRUE)
                                    {
                                        nCurrentProperty--;
                                    } else
                                    {
                                        nCurrentProperty++;
                                    }
                                }
                            }

                            // if a valid property was found
                            if (bItemPropertyPresent == FALSE)
                            {
                                DebugMessage("      Valid property is min value " + IntToString(nCurrentProperty) + " and actual value " + IntToString(nActualProperty));

                                // find maximum first table value
                                fSecondTableMin = GetLocalFloat(GetModule(), "fProperty" + IntToString(nActualProperty) + "SecondCostTable1Cost");
                                fFirstTableMax = fMaxMultiplier / fSecondTableMin;
                                DebugMessage("      Second table min is " + FloatToString(fSecondTableMin) + " leaving first table max at " + FloatToString(fFirstTableMax));

                                nFirstTableNum = GetLocalInt(GetModule(), "nProperty" + IntToString(nActualProperty) + "FirstCostTableNum");
                                nFirstTableMax = 0;
                                while ((GetLocalFloat(GetModule(), "fProperty" + IntToString(nActualProperty) + "FirstCostTable" + IntToString(nFirstTableMax + 1) + "Cost") <= fFirstTableMax) && (nFirstTableMax < nFirstTableNum))
                                {
                                    nFirstTableMax++;
                                }

                                // check for damage reduction
                                if (nActualProperty == 19)
                                {
                                    if (nFirstTableMax > (nItemLevel / 4))
                                    {
                                        nFirstTableMax = (nItemLevel / 4);
                                        if (nFirstTableMax < 1)
                                        {
                                            nFirstTableMax = 1;
                                        }
                                    }
                                }

                                nFirstTableMin = Random(nFirstTableMax) + 1;
                                if (nFirstTableMin < 1)
                                {
                                    nFirstTableMin = 1;
                                }
                                DebugMessage("      First table min is " + IntToString(nFirstTableMin) + " and max is " + IntToString(nFirstTableMax));

                                // select random first table value
                                nFirstTable = Random(nFirstTableMax - nFirstTableMin + 1) + nFirstTableMin;
                                fFirstTableValue = GetLocalFloat(GetModule(), "fProperty" + IntToString(nActualProperty) + "FirstCostTable" + IntToString(nFirstTable) + "Cost");
                                DebugMessage("      First table entry selected is " + IntToString(nFirstTable) + " with value " + FloatToString(fFirstTableValue) + " at fProperty" + IntToString(nActualProperty) + "FirstCostTable" + IntToString(nFirstTable) + "Cost");

                                // find maximum second table value
                                fSecondTableMax = fMaxMultiplier / fFirstTableValue;
                                DebugMessage("      Second table max is " + FloatToString(fSecondTableMax));

                                nSecondTableNum = GetLocalInt(GetModule(), "nProperty" + IntToString(nActualProperty) + "SecondCostTableNum");
                                nSecondTableMax = 0;
                                while ((GetLocalFloat(GetModule(), "fProperty" + IntToString(nActualProperty) + "SecondCostTable" + IntToString(nSecondTableMax + 1) + "Cost") <= fSecondTableMax) && (nSecondTableMax < nSecondTableNum))
                                {
                                    nSecondTableMax++;
                                }

                                // create max exceptions
                                nSecondTableMax = LimitBonusMax(nActualProperty, nSecondTableMax, nItemLevel);

                                nSecondTableMin = nSecondTableMax - 2; // EDIT: altered
                                if (nSecondTableMin < 1)
                                {
                                    nSecondTableMin = 1;
                                }
                                DebugMessage("      Second table min is " + IntToString(nSecondTableMin) + " and max is " + IntToString(nSecondTableMax));

                                // select random second table value
                                nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                fSecondTableValue = GetLocalFloat(GetModule(), "fProperty" + IntToString(nActualProperty) + "SecondCostTable" + IntToString(nSecondTable) + "Cost");
                                DebugMessage("      Second table entry selected is " + IntToString(nSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty" + IntToString(nActualProperty) + "SecondCostTable" + IntToString(nSecondTable) + "Cost");

                                // get number of subtypes
                                nSubTypeNum = GetLocalInt(GetModule(), "nProperty" + IntToString(nActualProperty) + "SubTypeNum");
                                if (nSubTypeNum > 0)
                                {
                                    nSubType = Random(nSubTypeNum) + 1;
                                } else
                                {
                                    nSubType = 0;
                                }

                                // add property
                                nPropertyNum++;
                                SetLocalInt(oTempHolder, "nPropertyNum", nPropertyNum);

                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "Property", nActualProperty);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "FirstTable", nFirstTable);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SecondTable", nSecondTable);
                                SetLocalInt(oTempHolder, "nProperty" + IntToString(nPropertyNum) + "SubType", nSubType);
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + " to " + IntToString(nActualProperty));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "FirstTable to " + IntToString(nFirstTable));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SecondTable to " + IntToString(nSecondTable));
                                DebugMessage("      Set nProperty" + IntToString(nPropertyNum) + "SubType to " + IntToString(nSubType));

                                fMaxMultiplier -= (fFirstTableValue * fSecondTableValue);
                                fCurrentMultiplier += (fFirstTableValue * fSecondTableValue);
                                DebugMessage("      Set MaxMultiplier to " + FloatToString(fMaxMultiplier));
                            } else
                            {
                                // just in case
                                bAvailableProperty = FALSE;
                            }
                        } else
                        {
                            DebugMessage("      No available properties found.");

                            bAvailableProperty = FALSE;
                        }
                    }

                    // add data, or create item
                    if (fCurrentMultiplier > 0.0)
                    {
                        DebugMessage("    Properties could be added to this item with total multiplier " + FloatToString(fCurrentMultiplier));

                        // create the base item
                        DebugMessage("    Creating item with resref " + sResRef);
                        object oItem2 = CreateItemOnObject(sResRef, oStore, nStacking);
                        IPRemoveAllItemProperties(oItem2, DURATION_TYPE_PERMANENT);

                        if (oItem2 != OBJECT_INVALID)
                        {
                            DebugMessage("    Item created successfully.");
                        } else
                        {
                            DebugMessage("    Item not created.");
                        }
                        DebugMessage("    Item is named " + GetName(oItem2));

                        // add properties
                        nPropertyNum = GetLocalInt(oTempHolder, "nPropertyNum");
                        DebugMessage("  Item was created with " + IntToString(nPropertyNum) + " properties.");

                        string sProperty;
                        nCurrentProperty = 1;
                        while (nCurrentProperty <= nPropertyNum)
                        {
                            sProperty = "Property" + IntToString(nCurrentProperty);
                            nActualProperty = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "Property");
                            nFirstTable = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "FirstTable");
                            nSecondTable = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "SecondTable");
                            nSubType = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "SubType");
                            DebugMessage("  Property is at " + sProperty);
                            DebugMessage("    Property " + IntToString(nCurrentProperty) + " is " + IntToString(nActualProperty) + ", first table " + IntToString(nFirstTable) + ", second table " + IntToString(nSecondTable) + ", subtype " + IntToString(nSubType));

                            AddPropertyToItem(nActualProperty, nFirstTable, nSecondTable, nSubType, oItem2);

                            nCurrentProperty++;
                        }

                        SetItemName(oItem2);
                    } else
                    {
                        DebugMessage("    No properties could be added to this item.");
                    }

                    // destroy holder object
                    DestroyObject(oTempHolder);
                }

                // delete temporary item
                DestroyObject(oItem);
            } else // basic nwn consumable
            {
                int nStackSize = 1;

                if (nCategory == 4)
                {
                    if (nSubCategory == 1) // grenade
                    {
                        // pick from a list of grenades based on level
                        int nItemTypeNum = GetGrenadeNum(nItemLevel);
                        int nRandomItemType = Random(nItemTypeNum) + 1;
                        sResRef = GetGrenadeResRef(nItemLevel, nRandomItemType);
                        DebugMessage("      Selected grenade " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                        nStackSize = Random(6) + 5;
                    } else if (nSubCategory == 2) // wand
                    {
                        // pick from a list of wands based on level
                        int nItemTypeNum = GetWandNum(nItemCategoryLevel);
                        int nRandomItemType = Random(nItemTypeNum) + 1;
                        sResRef = GetWandResRef(nItemCategoryLevel, nRandomItemType);
                        DebugMessage("      Selected wand " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                    } else if (nSubCategory == 3) // potions
                    {
                        // pick from a list of potions based on level
                        int nItemTypeNum = GetPotionNum(nItemCategoryLevel);
                        int nRandomItemType = Random(nItemTypeNum) + 1;
                        sResRef = GetPotionResRef(nItemCategoryLevel, nRandomItemType);
                        DebugMessage("      Selected potion " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                    } else // scroll
                    {
                        // pick from a list of scrolls based on level
                        int nItemTypeNum = GetScrollNum(nItemCategoryLevel);
                        int nRandomItemType = Random(nItemTypeNum) + 1;
                        sResRef = GetScrollResRef(nItemCategoryLevel, nRandomItemType);
                        DebugMessage("      Selected scroll " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                    }
                } else if (nCategory == 5)
                {
                    // pick from list of miscellaneous items based on level
                    int nItemTypeNum = GetMiscellaneousNum(nItemLevel);
                    int nRandomItemType = Random(nItemTypeNum) + 1;
                    sResRef = GetMiscellaneousResRef(nItemLevel, nRandomItemType);
                    DebugMessage("      Selected miscellaneous " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                }

                if (sResRef != "")
                {
                    CreateItemOnObject(sResRef, oStore, nStackSize);
                }
            }
        }
    }

    DestroyObject(OBJECT_SELF);
}

