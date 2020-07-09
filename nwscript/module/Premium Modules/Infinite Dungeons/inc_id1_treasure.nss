#include "inc_id1_debug"
#include "inc_id1_utility"
#include "inc_id1_items"
#include "inc_id1_prop"


const int ID1_PROPERTY_LIMIT = 2;

void GenerateTreasure(int nLevel, int nItemMinLevelAdjustment, int nItemMaxLevelAdjustment, float fValueMultiplier, int bGoldPresent, int bGemPresent, int bItemPresent, int bCreateTreasure, string sContainer, object oContainer, object oDungeon);
object CreateItemInContainer(string sItem, object oContainer, object oDungeon);

void GenerateTreasure(int nLevel, int nItemMinLevelAdjustment, int nItemMaxLevelAdjustment, float fValueMultiplier, int bGoldPresent, int bGemPresent, int bItemPresent, int bCreateTreasure, string sContainer, object oContainer, object oDungeon)
{
    DebugMessage("");
    DebugMessage("Generating treasure.");

    // modify treasure level according to flags
    int nLevelModifier = GetModuleFlagValue(ID1_FLAG_TREASURE_LEVEL);
    DebugMessage("Desired level of treasure is " + IntToString(nLevel) + " with flag modifier " + IntToString(nLevelModifier));
    nLevel += nLevelModifier;

    // minimum treasure level is 1
    if (nLevel < 1)
    {
        nLevel = 1;
    }

    // cap at level 40 treasure
    if (nLevel > 40)
    {
        nLevel = 40;
    }
    DebugMessage("Final level of treasure is " + IntToString(nLevel));

    int nGemPercentage = GetModuleFlagValue(ID1_FLAG_TREASURE_GEM_FREQUENCY);
    int nRecipePercentage = GetModuleFlagValue(ID1_FLAG_TREASURE_RECIPE_FREQUENCY);
    int nSpecificItemPercentage = GetModuleFlagValue(ID1_FLAG_TREASURE_SPECIFIC_ITEM_FREQUENCY);
    DebugMessage("nGemPercentage is " + IntToString(nGemPercentage));
    DebugMessage("nRecipePercentage is " + IntToString(nRecipePercentage));
    DebugMessage("nSpecificItemPercentage is " + IntToString(nSpecificItemPercentage));

    int nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
    DebugMessage("There are " + IntToString(nItemNum) + " initial items in the container.");

    int nDungeonItem;
    int nDungeonItemNum;

    int nItemCategoryLevel;
    int nRandomItemType;

    DebugMessage("  Value Multiplier is " + FloatToString(fValueMultiplier));
    if (fValueMultiplier > 0.0)
    {
        // calculate value of treasure
        int nValue = nLevel * nLevel * 1000;
        DebugMessage("  Initial GP max of treasure is " + IntToString(nValue));

        // determine final value of treasure
        nValue = FloatToInt(nValue * fValueMultiplier);
        DebugMessage("  Final GP of treasure is " + IntToString(nValue));


        // if this treasure can have gems
        if (bGemPresent == TRUE)
        {
            DebugMessage("  Gems are possible in this treasure.");

            // check to see if there is a gem in this treasure
            int nRandom = d100();
            DebugMessage("    nRandom is " + IntToString(nRandom) + " vs " + IntToString(nGemPercentage));
            if (nRandom <= nGemPercentage)
            {
                string sGemResRef = "id1_gem_";

                // determine gem type
                int nRandom = Random(16) + 1;
                sGemResRef += IntToStringDigits(nRandom, 2);

                // determine gem quality based on level
                int nQualityMax = nLevel / 4;
                if (nQualityMax * 4 < nLevel)
                {
                    nQualityMax++;
                }
                if (nQualityMax < 1)
                {
                    nQualityMax = 1;
                }
                if (nQualityMax > 5)
                {
                    nQualityMax = 5;
                }
                nRandom = Random(nQualityMax) + 1;
                sGemResRef += "_" + IntToStringDigits(nRandom, 2);

                // add gem item to list
                nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                nItemNum++;
                SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 2); // item
                SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", 1); // only 1
                SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);

                // add item to dungeon
                nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sGemResRef);
                if (nDungeonItem == 0)
                {
                    nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                    nDungeonItem++;
                    SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                    SetLocalInt(oDungeon, "nListItem_" + sGemResRef, nDungeonItem);
                    SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sGemResRef);
                }
                SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);
                DebugMessage("Adding n" + sContainer + "Item" + IntToString(nItemNum) + " to " + IntToString(nDungeonItem));
            }
        } else
        {
            DebugMessage("  No gems in this treasure.");
        }


        // if an item can be spawned
        if (bItemPresent == TRUE)
        {
            DebugMessage("  Items are possible in this treasure.");

            // find the appropriate maximum level range of treasure
            int nMaxLevel = nLevel + nItemMaxLevelAdjustment;
            if (nMaxLevel > 40)
            {
                nMaxLevel = 40;
            }

            // find the appropriate minimum level range of treasure
            int nMinLevel = nLevel - nItemMinLevelAdjustment;
            if (nMinLevel < 1)
            {
                nMinLevel = 1;
            }

            DebugMessage("    Initial minimum level is " + IntToString(nMinLevel) + " and maximum level is " + IntToString(nMaxLevel));

            int nItemLevel;
            string sValue;
            string sCategory;
            string sSubCategory;
            string sType;
            int nRandom;
            int nTotal;
            int nCategory;
            int nCategoryTotal;
            int nSubCategory;
            int nSubCategoryTotal;
            int nType;
            string sItemTypeName;
            int nItemTypeNum;
            string sResRef;
            object oItem;
            int nStackSize;
            int nItemValue;
            int nBaseType;
            float fItemMultiplier;
            float fBaseCost;
            float fMaxMultiplier;
            int nStacking;
            int nGeneratedItems = 0;
            int nPropertyNum;
            int bAvailableProperty;
            int nPropertyMinMax;
            int nCurrentProperty;
            int nActualProperty;
            int nItemPropertyNum;
            int nItemProperty;
            int bItemPropertyPresent;
            int bUp;
            int bDown;
            int nItemPropertyValue;
            int nPropColumn;
            string sPropColumn;
            int bPropertyColumnPresent;
            int nFirstTableMax;
            int nFirstTableMin;
            int nFirstTableNum;
            float fFirstTableMax;
            float fFirstTableValue;
            int nSecondTableMax;
            int nSecondTableMin;
            int nSecondTableNum;
            float fSecondTableMax;
            float fSecondTableMin;
            float fSecondTableValue;
            int nFirstTable;
            int nSecondTable;
            float fCurrentMultiplier;
            int nPercentageValue;
            string sPropResult;
            int nSubTypeNum;
            int nSubType;
            string sProperty;
            float fInitialMultiplier;
            string sTag;
            int nGemTotal;
            int nGemMax;
            int nGemNum;
            int nGemType;
            object oItem2;
            int nCurrentTotal;

            // while there is enough gold for a minimum range item
            while ((nValue >= (nMinLevel * nMinLevel * 500)) && (nGeneratedItems < 5))
            {
                nGeneratedItems++;

                DebugMessage("    Remaining value is " + IntToString(nValue));

                // set new max level
                while ((nValue < (nMaxLevel * nMaxLevel * 500)) && (nMaxLevel > nMinLevel))
                {
                    nMaxLevel--;
                }
                DebugMessage("      Maximum level set to " + IntToString(nMaxLevel));

                // pick a random level to choose treasure from
                nItemLevel = Random(nMaxLevel - nMinLevel + 1) + nMinLevel;
                DebugMessage("      Level selected is " + IntToString(nItemLevel));

                nItemCategoryLevel = nItemLevel / 2;
                if (nItemCategoryLevel < 0)
                {
                    nItemCategoryLevel = 0;
                }
                if (nItemCategoryLevel > 9)
                {
                    nItemCategoryLevel = 9;
                }
                DebugMessage("      Item category level selected is " + IntToString(nItemCategoryLevel));

                sResRef = "";

                // determine if this item is replaced by a recipe
                nRandom = Random(100) + 1;
                DebugMessage("      Random recipe number is " + IntToString(nRandom) + " vs " + IntToString(nRecipePercentage));
                if (nRandom <= nRecipePercentage) // recipe
                {
                    DebugMessage("      Recipe selected.");

                    sResRef = "id1_recipe";
                    fItemMultiplier = 1.0;
                    fBaseCost = 0.0;
                    DebugMessage("      Initial item multiplier is 1.0 and base cost is 0.0");

                    // determine maximum property multiplier
                    nItemValue = nItemLevel * nItemLevel * 500;
                    fMaxMultiplier = sqrt(((nItemValue / fItemMultiplier) - fBaseCost) / 1000.0);
                    fCurrentMultiplier = 0.0;
                    fInitialMultiplier = fMaxMultiplier / 5;
                    DebugMessage("      Base item value is " + IntToString(nItemValue) + " resulting in multiplier of " + FloatToString(fMaxMultiplier));

                    // create holder object
                    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "oTempHolder4");

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
                        nActualProperty = GetLocalInt(GetModule(), "nPropertyMin" + IntToString(nCurrentProperty) + "Property");
                        DebugMessage("      Selected property min " + IntToString(nCurrentProperty) + " which is internal property " + IntToString(nActualProperty) + " and external property " + IntToString(TranslateInternalToExternal(nActualProperty)));

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

                        SetLocalInt(oTempHolder, "nProperty1Property", nActualProperty);
                        SetLocalInt(oTempHolder, "nProperty1FirstTable", nFirstTable);
                        SetLocalInt(oTempHolder, "nProperty1SecondTable", nSecondTable);
                        SetLocalInt(oTempHolder, "nProperty1SubType", nSubType);
                        DebugMessage("      Set nProperty1Property to " + IntToString(nActualProperty));
                        DebugMessage("      Set nProperty1FirstTable to " + IntToString(nFirstTable));
                        DebugMessage("      Set nProperty1SecondTable to " + IntToString(nSecondTable));
                        DebugMessage("      Set nProperty1SubType to " + IntToString(nSubType));

                        fCurrentMultiplier = (fFirstTableValue * fSecondTableValue);
                        DebugMessage("      Set fCurrentMultiplier to " + FloatToString(fCurrentMultiplier));

                        nItemValue = FloatToInt(fItemMultiplier * (fBaseCost + (fCurrentMultiplier * fCurrentMultiplier * 1000)));
                        DebugMessage("    Total item value is " + IntToString(nItemValue));

                        nValue -= nItemValue;
                        DebugMessage("    Remaining value is " + IntToString(nValue));

                        // determine tag from multiplier value
                        sTag = "id1_recipe_";
                        nGemTotal = FloatToInt(fCurrentMultiplier / 0.7);
                        if (nGemTotal * 0.7 < fCurrentMultiplier) // this should always be true only once for everything under level 100 or so
                        {
                            nGemTotal++;
                        }
                        nGemNum = 0;
                        if (nGemTotal > 16)
                        {
                            nGemMax = nGemTotal / 16;
                            nGemNum = Random(nGemMax) + 1;
                            nGemType = Random(16) + 1;
                            sTag += EncodeAlphaNumeric(nGemType) + EncodeAlphaNumeric(5) + EncodeAlphaNumeric(nGemNum);
                            DebugMessage("    Selected " + IntToString(nGemNum) + " category 5 gems of type " + IntToString(nGemType) + ". sTag is " + sTag);
                        }
                        if (nGemTotal > 12)
                        {
                            if (nGemNum == 0)
                            {
                                nGemNum = 1;
                                nGemMax = 1;
                            } else
                            {
                                nGemNum = Random(nGemMax * 2) + 1;
                            }
                            nGemType = Random(16) + 1;
                            sTag += EncodeAlphaNumeric(nGemType) + EncodeAlphaNumeric(4) + EncodeAlphaNumeric(nGemNum);
                            DebugMessage("    Selected " + IntToString(nGemNum) + " category 4 gems of type " + IntToString(nGemType) + ". sTag is " + sTag);
                        }
                        if (nGemTotal > 8)
                        {
                            if (nGemNum == 0)
                            {
                                nGemNum = 1;
                                nGemMax = 1;
                            } else
                            {
                                nGemNum = Random(nGemMax * 2) + 1;
                            }
                            nGemType = Random(16) + 1;
                            sTag += EncodeAlphaNumeric(nGemType) + EncodeAlphaNumeric(3) + EncodeAlphaNumeric(nGemNum);
                            DebugMessage("    Selected " + IntToString(nGemNum) + " category 3 gems of type " + IntToString(nGemType) + ". sTag is " + sTag);
                        }
                        if (nGemTotal > 4)
                        {
                            if (nGemNum == 0)
                            {
                                nGemNum = 1;
                                nGemMax = 1;
                            } else
                            {
                                nGemNum = Random(nGemMax * 2) + 1;
                            }
                            nGemType = Random(16) + 1;
                            sTag += EncodeAlphaNumeric(nGemType) + EncodeAlphaNumeric(2) + EncodeAlphaNumeric(nGemNum);
                            DebugMessage("    Selected " + IntToString(nGemNum) + " category 2 gems of type " + IntToString(nGemType) + ". sTag is " + sTag);
                        }
                        if (nGemNum == 0)
                        {
                            nGemNum = 1;
                            nGemMax = 1;
                        } else
                        {
                            nGemNum = Random(nGemMax * 2) + 1;
                        }
                        nGemType = Random(16) + 1;
                        sTag += EncodeAlphaNumeric(nGemType) + EncodeAlphaNumeric(1) + EncodeAlphaNumeric(nGemNum);
                        DebugMessage("    Selected " + IntToString(nGemNum) + " category 1 gems of type " + IntToString(nGemType) + ". sTag is " + sTag);

                        // if this is purely data
                        if (bCreateTreasure == FALSE)
                        {
                            // record item information
                            nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                            nItemNum++;
                            SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 4); // recipe
                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", 1);
                            SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);
                            SetLocalString(oDungeon, "s" + sContainer + "Item" + IntToString(nItemNum) + "Tag", sTag);
                            DebugMessage("    Recording item at " + sContainer + "Item" + IntToString(nItemNum));
                            DebugMessage("      ItemType is 4");
                            DebugMessage("      Stack size is 1");
                            DebugMessage("      sTag is " + sTag);

                            // add item to dungeon
                            nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                            if (nDungeonItem == 0)
                            {
                                nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                                nDungeonItem++;
                                SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                                SetLocalInt(oDungeon, "nListItem_" + sResRef, nDungeonItem);
                                SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sResRef);
                            }
                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);

                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "PropertyNum", 1);
                            nActualProperty = GetLocalInt(oTempHolder, "nProperty1Property");
                            nFirstTable = GetLocalInt(oTempHolder, "nProperty1FirstTable");
                            nSecondTable = GetLocalInt(oTempHolder, "nProperty1SecondTable");
                            nSubType = GetLocalInt(oTempHolder, "nProperty1SubType");
                            sProperty = sContainer + "Item" + IntToString(nItemNum) + "Property1";

                            SetLocalInt(oDungeon, "n" + sProperty + "Property", nActualProperty);
                            SetLocalInt(oDungeon, "n" + sProperty + "FirstTable", nFirstTable);
                            SetLocalInt(oDungeon, "n" + sProperty + "SecondTable", nSecondTable);
                            SetLocalInt(oDungeon, "n" + sProperty + "SubType", nSubType);
                            DebugMessage("      Created property at " + sProperty);
                            DebugMessage("        Property is " + IntToString(nActualProperty));
                            DebugMessage("        First table is " + IntToString(nFirstTable));
                            DebugMessage("        Second table is " + IntToString(nSecondTable));
                            DebugMessage("        Subtype is " + IntToString(nSubType));
                        } else // if this is created at runtime
                        {
                            // create the base item
                            oItem = CreateItemOnObject(sResRef, oContainer, 1, sTag);

                            // add properties
                            sProperty = "Property1";
                            nActualProperty = GetLocalInt(oTempHolder, "nProperty1Property");
                            nFirstTable = GetLocalInt(oTempHolder, "nProperty1FirstTable");
                            nSecondTable = GetLocalInt(oTempHolder, "nProperty1SecondTable");
                            nSubType = GetLocalInt(oTempHolder, "nProperty1SubType");
                            DebugMessage("  Property is at " + sProperty);
                            DebugMessage("    Property " + IntToString(nCurrentProperty) + " is " + IntToString(nActualProperty) + ", first table " + IntToString(nFirstTable) + ", second table " + IntToString(nSecondTable) + ", subtype " + IntToString(nSubType));

                            AddPropertyToItem(nActualProperty, nFirstTable, nSecondTable, nSubType, oItem);

                            SetRecipeName(oItem);
                        }
                    } else
                    {
                        DebugMessage("    No properties could be added to this item.");
                    }

                    // destroy holder object
                    DestroyObject(oTempHolder);
                } else
                {
                    DebugMessage("      Item selected.");

                    // determine if this item is specific or generic
                    nRandom = Random(100) + 1;
                    DebugMessage("      Random specific item number is " + IntToString(nRandom) + " vs " + IntToString(nSpecificItemPercentage));
                    if (nRandom <= nSpecificItemPercentage) // specific item
                    {
                        sValue = "Value" + IntToString(nItemLevel);
                        DebugMessage("      Value category is " + sValue);

                        // pick a category
                        nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                        DebugMessage("      Total of n" + sValue + "Total is " + IntToString(nTotal));
                        if (nTotal > 0)
                        {
                            nRandom = Random(nTotal) + 1;
                            nCategory = 1;
                            nCurrentTotal = GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                            DebugMessage("        Checking random number " + IntToString(nRandom) + " against category " + IntToString(nCategory) + " total of " + IntToString(nCurrentTotal));
                            while (nRandom > nCurrentTotal)
                            {
                                nCategory++;
                                nCurrentTotal += GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                                DebugMessage("        Checking random number " + IntToString(nRandom) + " against category " + IntToString(nCategory) + " total of " + IntToString(nCurrentTotal));
                            }
                            sCategory = sValue + "Category" + IntToString(nCategory);
                            DebugMessage("      Item category selected was " + sCategory);

                            // pick a subcategory
                            nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                            DebugMessage("      Total for " + sCategory + " is " + IntToString(nCategoryTotal));
                            nRandom = Random(nCategoryTotal) + 1;
                            nSubCategory = 1;
                            nCurrentTotal = GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                            DebugMessage("        Checking random number " + IntToString(nRandom) + " against subcategory " + IntToString(nSubCategory) + " total of " + IntToString(nCurrentTotal));
                            while (nRandom > nCurrentTotal)
                            {
                                nSubCategory++;
                                nCurrentTotal += GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                                DebugMessage("        Checking random number " + IntToString(nRandom) + " against subcategory " + IntToString(nSubCategory) + " total of " + IntToString(nCurrentTotal));
                            }
                            sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
                            DebugMessage("      Item subcategory selected was " + sSubCategory);

                            // pick a type
                            nSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
                            DebugMessage("      Total for " + sSubCategory + " is " + IntToString(nSubCategoryTotal));
                            nRandom = Random(nSubCategoryTotal) + 1;
                            nType = 1;
                            nCurrentTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                            DebugMessage("        Checking random number " + IntToString(nRandom) + " against type " + IntToString(nType) + " total of " + IntToString(nCurrentTotal));
                            while (nRandom > nCurrentTotal)
                            {
                                nType++;
                                nCurrentTotal += GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                                DebugMessage("        Checking random number " + IntToString(nRandom) + " against type " + IntToString(nType) + " total of " + IntToString(nCurrentTotal));
                            }
                            sType = sSubCategory + "Type" + IntToString(nType);
                            DebugMessage("      Item type selected was " + sType);

                            // if this is a specific item
                            if ((nCategory != 4) || ((nCategory == 4) && (nSubCategory != 1) && (nSubCategory != 3) && (nSubCategory != 4) && (nSubCategory != 5)))
                            {
                                // get item from that type
                                nItemTypeNum = GetLocalInt(GetModule(), "n" + sType + "Num");
                                DebugMessage("      There are " + IntToString(nItemTypeNum) + " items in n" + sType + "Num");

                                // get a specific item
                                nRandom = Random(nItemTypeNum) + 1;
                                sResRef = GetLocalString(GetModule(), "s" + sType + "_" + IntToString(nRandom) + "ResRef");
                                DebugMessage("      Selected item s" + sType + "_" + IntToString(nRandom) + "ResRef is " + sResRef);

                                // create the object
                                nStackSize = Random(89) + 11;
                                oItem = CreateItemOnObject(sResRef, GetObjectByTag("DungeonInventory"), 99);
                                SetIdentified(oItem, TRUE);
                                nItemValue = GetGoldPieceValue(oItem);
                                DebugMessage("      Item value is " + IntToString(nItemValue));

                                // reduce the treasure value by the item value
                                nValue -= nItemValue;

                                // if this is purely data
                                if (bCreateTreasure == FALSE)
                                {
                                    // record item information
                                    nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                                    nItemNum++;
                                    SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                                    SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 2); // unaltered item
                                    nStackSize = GetItemStackSize(oItem);
                                    SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", nStackSize);
                                    SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);

                                    // add item to dungeon
                                    nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                                    if (nDungeonItem == 0)
                                    {
                                        nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                                        nDungeonItem++;
                                        SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                                        SetLocalInt(oDungeon, "nListItem_" + sResRef, nDungeonItem);
                                        SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sResRef);
                                    }
                                    SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);
                                } else // if this is created at runtime
                                {
                                    CreateItemOnObject(sResRef, oContainer, nStackSize);
                                }

                                // clean up the item
                                DestroyObject(oItem);
                            } else // basic nwn consumable
                            {
                                if (nSubCategory == 1) // grenade
                                {
                                    // pick from a list of grenades based on level
                                    nItemTypeNum = GetGrenadeNum(nItemLevel);
                                    nRandomItemType = Random(nItemTypeNum) + 1;
                                    sResRef = GetGrenadeResRef(nItemLevel, nRandomItemType);
                                    DebugMessage("      Selected grenade " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                                } else if (nSubCategory == 2) // wand
                                {
                                    // pick from a list of wands based on level
                                    nItemTypeNum = GetWandNum(nItemCategoryLevel);
                                    nRandomItemType = Random(nItemTypeNum) + 1;
                                    sResRef = GetWandResRef(nItemCategoryLevel, nRandomItemType);
                                    DebugMessage("      Selected wand " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                } else if (nSubCategory == 3) // potions
                                {
                                    // pick from a list of potions based on level
                                    nItemTypeNum = GetPotionNum(nItemCategoryLevel);
                                    nRandomItemType = Random(nItemTypeNum) + 1;
                                    sResRef = GetPotionResRef(nItemCategoryLevel, nRandomItemType);
                                    DebugMessage("      Selected potion " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                } else if (nSubCategory == 4) // scroll
                                {
                                    // pick from a list of scrolls based on level
                                    nItemTypeNum = GetScrollNum(nItemCategoryLevel);
                                    nRandomItemType = Random(nItemTypeNum) + 1;
                                    sResRef = GetScrollResRef(nItemCategoryLevel, nRandomItemType);
                                    DebugMessage("      Selected scroll " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                }

                                if (sResRef != "")
                                {
                                    oItem = CreateItemOnObject(sResRef, GetObjectByTag("DungeonInventory"));
                                    SetIdentified(oItem, TRUE);
                                    nItemValue = GetGoldPieceValue(oItem);
                                    DebugMessage("      Item value is " + IntToString(nItemValue));

                                    // reduce the treasure value by the item value
                                    nValue -= nItemValue;

                                    // if this is purely data
                                    if (bCreateTreasure == FALSE)
                                    {
                                        // record item information
                                        nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                                        nItemNum++;
                                        SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 2); // unaltered item
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", 1);
                                        SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);

                                        // add item to dungeon
                                        nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                                        if (nDungeonItem == 0)
                                        {
                                            nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                                            nDungeonItem++;
                                            SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                                            SetLocalInt(oDungeon, "nListItem_" + sResRef, nDungeonItem);
                                            SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sResRef);
                                        }
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);
                                    } else // if this is created at runtime
                                    {
                                        CreateItemOnObject(sResRef, oContainer, nStackSize);
                                    }

                                    // clean up the item
                                    DestroyObject(oItem);
                                }
                            }
                        }
                    } else // generic item
                    {
                        sValue = "Ideal";
                        DebugMessage("      Ideal category is " + sValue);

                        // pick a category
                        nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                        DebugMessage("      Total of all categories is " + IntToString(nTotal));
                        if (nTotal > 0)
                        {
                            nRandom = Random(nTotal) + 1;
                            DebugMessage("      Random is " + IntToString(nRandom));
                            nCategory = 1;
                            nPercentageValue = GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                            DebugMessage("        Percentage value of n" + sValue + "Category" + IntToString(nCategory) + "Percentage is " + IntToString(nPercentageValue));
                            while (nRandom > nPercentageValue)
                            {
                                nCategory++;
                                nPercentageValue += GetLocalInt(GetModule(), "n" + sValue + "Category" + IntToString(nCategory) + "Percentage");
                                DebugMessage("        Percentage value of n" + sValue + "Category" + IntToString(nCategory) + "Percentage is " + IntToString(nPercentageValue));
                            }
                            sCategory = sValue + "Category" + IntToString(nCategory);
                            DebugMessage("      Item category selected was " + sCategory);

                            // pick a subcategory
                            nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                            DebugMessage("      Total for " + sCategory + " is " + IntToString(nCategoryTotal));
                            nRandom = Random(nCategoryTotal) + 1;
                            DebugMessage("      Random is " + IntToString(nRandom));
                            nSubCategory = 1;
                            nPercentageValue = GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                            DebugMessage("        Percentage value of n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage is " + IntToString(nPercentageValue));
                            while (nRandom > nPercentageValue)
                            {
                                nSubCategory++;
                                nPercentageValue += GetLocalInt(GetModule(), "n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage");
                                DebugMessage("        Percentage value of n" + sCategory + "SubCategory" + IntToString(nSubCategory) + "Percentage is " + IntToString(nPercentageValue));
                            }
                            sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
                            DebugMessage("      Item subcategory selected was " + sSubCategory);

                            // pick a type
                            nSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
                            DebugMessage("      Total for " + sSubCategory + " is " + IntToString(nSubCategoryTotal));
                            nRandom = Random(nSubCategoryTotal) + 1;
                            DebugMessage("      Random is " + IntToString(nRandom));
                            nType = 1;
                            nPercentageValue = GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                            DebugMessage("        Percentage value of n" + sSubCategory + "Type" + IntToString(nType) + "Percentage is " + IntToString(nPercentageValue));
                            while (nRandom > nPercentageValue)
                            {
                                nType++;
                                nPercentageValue += GetLocalInt(GetModule(), "n" + sSubCategory + "Type" + IntToString(nType) + "Percentage");
                                DebugMessage("        Percentage value of n" + sSubCategory + "Type" + IntToString(nType) + "Percentage is " + IntToString(nPercentageValue));
                            }
                            sType = sSubCategory + "Type" + IntToString(nType);
                            DebugMessage("      Item type selected was " + sType);

                            // if this is a normal generic item
                            if ((nCategory != 5) && (nCategory != 4))
                            {
                                // get the base template item
                                sResRef = GetTypeGenericItem(nCategory, nSubCategory, nType);
                                DebugMessage("      ResRef of item is " + sResRef);

                                // create temporary item
                                oItem = CreateItemOnObject(sResRef, GetObjectByTag("DungeonInventory"));
                                nBaseType = GetBaseItemType(oItem);
                                DebugMessage("      Base type of item is " + IntToString(nBaseType));

                                // get base item multiplier
                                fItemMultiplier = StringToFloat(Get2DAString("baseitems", "ItemMultiplier", nBaseType));
                                DebugMessage("      Initial item multiplier is " + FloatToString(fItemMultiplier));

                                // if stacking, multiply by stack size
                                nStacking = StringToInt(Get2DAString("baseitems", "Stacking", nBaseType));
                                if (nStacking > 1)
                                {
                                    fItemMultiplier *= nStacking;
                                }
                                DebugMessage("      Stacked item multiplier is " + FloatToString(fItemMultiplier));

                                // get base item cost
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
                                    nItemValue = nItemLevel * nItemLevel * 500;
                                    fMaxMultiplier = sqrt(((nItemValue / fItemMultiplier) - fBaseCost) / 1000.0);
                                    fCurrentMultiplier = 0.0;
                                    fInitialMultiplier = fMaxMultiplier / 5;
                                    DebugMessage("      Base item value is " + IntToString(nItemValue) + " resulting in multiplier of " + FloatToString(fMaxMultiplier));

                                    nPropertyNum = 0;
                                    bAvailableProperty = TRUE;

                                    // create holder object
                                    object oTempHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "oTempHolder5");

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

                                                fFirstTableValue = GetLocalFloat(GetModule(), "fProperty23FirstCostTable1Cost");
                                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                                nSecondTableMax = (nItemLevel / 5) + 1;
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

                                                nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                                if (nSecondTableMin < 1)
                                                {
                                                    nSecondTableMin = 1;
                                                }
                                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                                nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                                fSecondTableValue = GetLocalFloat(GetModule(), "fProperty23SecondCostTable" + IntToString(nSecondTable) + "Cost");
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

                                                fFirstTableValue = GetLocalFloat(GetModule(), "fProperty8FirstCostTable1Cost");
                                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                                nSecondTableMax = (nItemLevel / 5) + 1;
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

                                                nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                                if (nSecondTableMin < 1)
                                                {
                                                    nSecondTableMin = 1;
                                                }
                                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                                nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                                fSecondTableValue = GetLocalFloat(GetModule(), "fProperty8SecondCostTable" + IntToString(nSecondTable) + "Cost");
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

                                                fFirstTableValue = GetLocalFloat(GetModule(), "fProperty15FirstCostTable1Cost");
                                                DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                                nSecondTableMax = (nItemLevel / 5) + 1;
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

                                                nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                                if (nSecondTableMin < 1)
                                                {
                                                    nSecondTableMin = 1;
                                                }
                                                DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                                nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
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

                                                fSecondTableValue = GetLocalFloat(GetModule(), "fProperty15SecondCostTable" + IntToString(nActualSecondTable) + "Cost");
                                                DebugMessage("      Second table entry selected is " + IntToString(nActualSecondTable) + " with value " + FloatToString(fSecondTableValue) + " at fProperty15SecondCostTable" + IntToString(nSecondTable) + "Cost");

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

                                            fFirstTableValue = GetLocalFloat(GetModule(), "fProperty2FirstCostTable1Cost");
                                            DebugMessage("      First table value is " + FloatToString(fFirstTableValue));

                                            nSecondTableMax = (nItemLevel / 5) + 1;
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

                                            nSecondTableMin = nSecondTableMax - 2; // EDIT: adjust for range?
                                            if (nSecondTableMin < 1)
                                            {
                                                nSecondTableMin = 1;
                                            }
                                            DebugMessage("      SecondTable min is " + IntToString(nSecondTableMin));

                                            nSecondTable = Random(nSecondTableMax - nSecondTableMin + 1) + nSecondTableMin;
                                            fSecondTableValue = GetLocalFloat(GetModule(), "fProperty2SecondCostTable" + IntToString(nSecondTable) + "Cost");
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

                                        nItemValue = FloatToInt(fItemMultiplier * (fBaseCost + (fCurrentMultiplier * fCurrentMultiplier * 1000)));
                                        DebugMessage("    Total item value is " + IntToString(nItemValue));

                                        nValue -= nItemValue;
                                        DebugMessage("    Remaining value is " + IntToString(nValue));

                                        // if this is purely data
                                        if (bCreateTreasure == FALSE)
                                        {
                                            // record item information
                                            nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                                            nItemNum++;
                                            SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 3); // item with properties added
                                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", nStacking);
                                            SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);

                                            // add item to dungeon
                                            nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                                            if (nDungeonItem == 0)
                                            {
                                                nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                                                nDungeonItem++;
                                                SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                                                SetLocalInt(oDungeon, "nListItem_" + sResRef, nDungeonItem);
                                                SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sResRef);
                                            }
                                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);

                                            DebugMessage("    Recording item at " + sContainer + "Item" + IntToString(nItemNum));
                                            DebugMessage("      ItemType is 3");
                                            DebugMessage("      Stack size is " + IntToString(nStacking));
                                            DebugMessage("      Resref is " + sResRef);
                                            nPropertyNum = GetLocalInt(oTempHolder, "nPropertyNum");
                                            SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "PropertyNum", nPropertyNum);
                                            nCurrentProperty = 1;
                                            while (nCurrentProperty <= nPropertyNum)
                                            {
                                                nActualProperty = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "Property");
                                                nFirstTable = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "FirstTable");
                                                nSecondTable = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "SecondTable");
                                                nSubType = GetLocalInt(oTempHolder, "nProperty" + IntToString(nCurrentProperty) + "SubType");
                                                sProperty = sContainer + "Item" + IntToString(nItemNum) + "Property" + IntToString(nCurrentProperty);
                                                SetLocalInt(oDungeon, "n" + sProperty + "Property", nActualProperty);
                                                SetLocalInt(oDungeon, "n" + sProperty + "FirstTable", nFirstTable);
                                                SetLocalInt(oDungeon, "n" + sProperty + "SecondTable", nSecondTable);
                                                SetLocalInt(oDungeon, "n" + sProperty + "SubType", nSubType);
                                                DebugMessage("      Created property at " + sProperty);
                                                DebugMessage("        Property is " + IntToString(nActualProperty));
                                                DebugMessage("        First table is " + IntToString(nFirstTable));
                                                DebugMessage("        Second table is " + IntToString(nSecondTable));
                                                DebugMessage("        Subtype is " + IntToString(nSubType));

                                                nCurrentProperty++;
                                            }
                                        } else // if this is created at runtime
                                        {
            //                                CreateItemOnObject(sResRef, oContainer, nStackSize);
                                            // create the base item
                                            oItem2 = CreateItemOnObject(sResRef, oContainer, nStacking);
                                            IPRemoveAllItemProperties(oItem2, DURATION_TYPE_PERMANENT);

                                            // add properties
                                            nPropertyNum = GetLocalInt(oTempHolder, "nPropertyNum");

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
                                        }
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
                                if (nCategory == 4)
                                {
                                    if (nSubCategory == 1) // grenade
                                    {
                                        // pick from a list of grenades based on level
                                        nItemTypeNum = GetGrenadeNum(nItemLevel);
                                        nRandomItemType = Random(nItemTypeNum) + 1;
                                        sResRef = GetGrenadeResRef(nItemLevel, nRandomItemType);
                                        DebugMessage("      Selected grenade " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                                    } else if (nSubCategory == 2) // wand
                                    {
                                        // pick from a list of wands based on level
                                        nItemTypeNum = GetWandNum(nItemCategoryLevel);
                                        nRandomItemType = Random(nItemTypeNum) + 1;
                                        sResRef = GetWandResRef(nItemCategoryLevel, nRandomItemType);
                                        DebugMessage("      Selected wand " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                    } else if (nSubCategory == 3) // potions
                                    {
                                        // pick from a list of potions based on level
                                        nItemTypeNum = GetPotionNum(nItemCategoryLevel);
                                        nRandomItemType = Random(nItemTypeNum) + 1;
                                        sResRef = GetPotionResRef(nItemCategoryLevel, nRandomItemType);
                                        DebugMessage("      Selected potion " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                    } else // scroll
                                    {
                                        // pick from a list of scrolls based on level
                                        nItemTypeNum = GetScrollNum(nItemCategoryLevel);
                                        nRandomItemType = Random(nItemTypeNum) + 1;
                                        sResRef = GetScrollResRef(nItemCategoryLevel, nRandomItemType);
                                        DebugMessage("      Selected scroll " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemCategoryLevel));
                                    }
                                } else if (nCategory == 5)
                                {
                                    // pick from list of miscellaneous items based on level
                                    nItemTypeNum = GetMiscellaneousNum(nItemLevel);
                                    nRandomItemType = Random(nItemTypeNum) + 1;
                                    sResRef = GetMiscellaneousResRef(nItemLevel, nRandomItemType);
                                    DebugMessage("      Selected miscellaneous " + sResRef + " which is item " + IntToString(nRandomItemType) + " at level " + IntToString(nItemLevel));
                                }

                                if (sResRef != "")
                                {
                                    oItem = CreateItemOnObject(sResRef, GetObjectByTag("DungeonInventory"));
                                    SetIdentified(oItem, TRUE);
                                    nItemValue = GetGoldPieceValue(oItem);
                                    DebugMessage("      Item value is " + IntToString(nItemValue));

                                    // reduce the treasure value by the item value
                                    nValue -= nItemValue;

                                    // if this is purely data
                                    if (bCreateTreasure == FALSE)
                                    {
                                        // record item information
                                        nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                                        nItemNum++;
                                        SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 2); // unaltered item
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", 1);
                                        SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);

                                        // add item to dungeon
                                        nDungeonItem = GetLocalInt(oDungeon, "nListItem_" + sResRef);
                                        if (nDungeonItem == 0)
                                        {
                                            nDungeonItem = GetLocalInt(oDungeon, "nListItemNum");
                                            nDungeonItem++;
                                            SetLocalInt(oDungeon, "nListItemNum", nDungeonItem);
                                            SetLocalInt(oDungeon, "nListItem_" + sResRef, nDungeonItem);
                                            SetLocalString(oDungeon, "sListItem" + IntToString(nDungeonItem) + "ResRef", sResRef);
                                        }
                                        SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Item", nDungeonItem);
                                    } else // if this is created at runtime
                                    {
                                        CreateItemOnObject(sResRef, oContainer, nStackSize);
                                    }

                                    // clean up the item
                                    DestroyObject(oItem);
                                }
                            }
                        }
                    }
                }
            }
        } else
        {
            DebugMessage("  No items in this treasure.");
        }


        // if there is gold in this treasure
        if (bGoldPresent == TRUE)
        {
            DebugMessage("  Gold is possible in this treasure. Remaining value is " + IntToString(nValue));

            int nGoldSize;
            if (nValue > nLevel * 100)
            {
                nGoldSize = Random(nLevel * 100) + 1;
            } else
            {
                nGoldSize = Random(nValue) + 1;
            }
            DebugMessage("  Actual gold stack is " + IntToString(nGoldSize));

            // if this is purely data
            if (bCreateTreasure == FALSE)
            {
                // record item information
                nItemNum = GetLocalInt(oDungeon, "n" + sContainer + "ItemNum");
                nItemNum++;
                SetLocalInt(oDungeon, "n" + sContainer + "ItemNum", nItemNum);
                SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "ItemType", 1); // gold
                SetLocalInt(oDungeon, "n" + sContainer + "Item" + IntToString(nItemNum) + "Size", nGoldSize);
                SetLocalInt(oDungeon, "b" + sContainer + "Item" + IntToString(nItemNum) + "Taken", FALSE);
            } else // if this is created at runtime
            {
                CreateItemOnObject("nw_it_gold001", oContainer, nGoldSize);
            }
        } else
        {
            DebugMessage("  No gold in this treasure.");
        }
    } else
    {
        DebugMessage("  Value multiplier is too low.");
    }
}

object CreateItemInContainer(string sItem, object oContainer, object oDungeon)
{
    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    object oItem;

    int nItemType = GetLocalInt(oDungeon, "n" + sItem + "ItemType"); // item type
    int nSize = GetLocalInt(oDungeon, "n" + sItem + "Size"); // number of items to create
    int nItem = GetLocalInt(oDungeon, "n" + sItem + "Item"); // the number of the item in the dungeon list
    string sResRef = GetLocalString(oDungeon, "sListItem" + IntToString(nItem) + "ResRef"); // resref
    string sTag = GetLocalString(oDungeon, "s" + sItem + "Tag"); // tag

    DebugMessage("Item is in location " + sItem);
    DebugMessage("  Item is type " + IntToString(nItemType));
    DebugMessage("  Stack size is " + IntToString(nSize));
    DebugMessage("  ResRef is " + sResRef);
    DebugMessage("  Tag of container is " + GetTag(oContainer));

    // get item type
    if (nItemType == 1) // gold
    {
        // create the gold
        oItem = CreateItemOnObject("nw_it_gold001", oContainer, nSize, sTag);
    } else if (nItemType == 2) // unaltered item
    {
        // create the unaltered item
        oItem = CreateItemOnObject(sResRef, oContainer, nSize, sTag);
    } else if (nItemType == 3) // item with properties
    {
        // create the base item
        oItem = CreateItemOnObject(sResRef, oContainer, nSize, sTag);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);

        // add properties
        int nPropertyNum = GetLocalInt(oDungeon, "n" + sItem + "PropertyNum");
        int nInternalProperty;
        int nFirstTable;
        int nSecondTable;
        int nSubType;
        string sProperty;

        int nProperty = 1;
        while (nProperty <= nPropertyNum)
        {
            sProperty = sItem + "Property" + IntToString(nProperty);
            nInternalProperty = GetLocalInt(oDungeon, "n" + sProperty + "Property");
            nFirstTable = GetLocalInt(oDungeon, "n" + sProperty + "FirstTable");
            nSecondTable = GetLocalInt(oDungeon, "n" + sProperty + "SecondTable");
            nSubType = GetLocalInt(oDungeon, "n" + sProperty + "SubType");
            DebugMessage("  Property is at " + sProperty);
            DebugMessage("    Property " + IntToString(nProperty) + " is " + IntToString(nInternalProperty) + ", first table " + IntToString(nFirstTable) + ", second table " + IntToString(nSecondTable) + ", subtype " + IntToString(nSubType));

            AddPropertyToItem(nInternalProperty, nFirstTable, nSecondTable, nSubType, oItem);

            nProperty++;
        }

//        DebugMessage("Creating naming subprocess.");
//        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU");
//        SetLocalObject(oMicroCPU, "oItem", oItem);
//        DelayCommand(0.1, ExecuteScript("exe_id1_micitnm", oMicroCPU));
        SetItemName(oItem);
    } else if (nItemType == 4)
    {
        // create the base item
        oItem = CreateItemOnObject(sResRef, oContainer, nSize, sTag);

        // add properties
        int nInternalProperty;
        int nFirstTable;
        int nSecondTable;
        int nSubType;
        string sProperty;

        sProperty = sItem + "Property1";
        nInternalProperty = GetLocalInt(oDungeon, "n" + sProperty + "Property");
        nFirstTable = GetLocalInt(oDungeon, "n" + sProperty + "FirstTable");
        nSecondTable = GetLocalInt(oDungeon, "n" + sProperty + "SecondTable");
        nSubType = GetLocalInt(oDungeon, "n" + sProperty + "SubType");
        DebugMessage("  Property is at " + sProperty);
        DebugMessage("    Property 1 is " + IntToString(nInternalProperty) + ", first table " + IntToString(nFirstTable) + ", second table " + IntToString(nSecondTable) + ", subtype " + IntToString(nSubType));

        AddPropertyToItem(nInternalProperty, nFirstTable, nSecondTable, nSubType, oItem);

        SetRecipeName(oItem);
    }

    return oItem;
}

//void main(){}

