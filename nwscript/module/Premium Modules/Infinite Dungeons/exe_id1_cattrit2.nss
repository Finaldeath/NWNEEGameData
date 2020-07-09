#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id1_items"
#include "x2_inc_itemprop"

int GetCategorySubType(int nBaseType, int nCategorySubType);

void main()
{
    string sResRef = GetLocalString(OBJECT_SELF, "sResRef");

    // create the item in the module inventory
    object oContainer = GetObjectByTag("DungeonInventory");
    object oItem = CreateItemOnObject(sResRef, oContainer);
    DebugMessage("    Creating item " + sResRef);

    SetIdentified(oItem, TRUE);
    SetItemStackSize(oItem, 99);

    if (oItem != OBJECT_INVALID)
    {
        int nItemType = 0;

        // get the base item type
        int nBaseType = GetBaseItemType(oItem);
        string sBaseType = RemoveIllegalCharacters(ReturnBaseItemString(nBaseType));
        if (sBaseType == "Armor")
        {
            object oItem2 = CreateItemOnObject(sResRef, oContainer);

            SetIdentified(oItem2, FALSE);
            int nValue = GetGoldPieceValue(oItem2);
            DebugMessage("      Base value of created item is " + IntToString(nValue));

            DestroyObject(oItem2);

            if (nValue <= 1)
            {
                nItemType = 1;
                sBaseType += "Cloth";
            } else if (nValue == 5)
            {
                nItemType = 2;
                sBaseType += "Padded";
            } else if (nValue == 10)
            {
                nItemType = 3;
                sBaseType += "Leather";
            } else if (nValue == 15)
            {
                nItemType = 4;
                sBaseType += "Hide";
            } else if (nValue == 100)
            {
                nItemType = 5;
                sBaseType += "Scale";
            } else if (nValue == 150)
            {
                nItemType = 6;
                sBaseType += "Chainmail";
            } else if (nValue == 200)
            {
                nItemType = 7;
                sBaseType += "Banded";
            } else if (nValue == 600)
            {
                nItemType = 8;
                sBaseType += "HalfPlate";
            } else
            {
                nItemType = 9;
                sBaseType += "FullPlate";
            }
        }
        DebugMessage("      Base type is " + sBaseType);

        int nItemCategory = GetCategorySubType(nBaseType, 1);
        int nItemSubCategory = GetCategorySubType(nBaseType, 2);
        if (nItemType == 0)
        {
            nItemType = GetCategorySubType(nBaseType, 3);
        }
        DebugMessage("      Type is category " + IntToString(nItemCategory) + ", subcategory " + IntToString(nItemSubCategory) + ", type " + IntToString(nItemType));

        // get the gold value of the item
        int nValue = GetGoldPieceValue(oItem);
        string sValueCategory = "Value";
        int nCategory = 1;
        while ((nValue > (nCategory * nCategory * 500)) && (nCategory < 40))
        {
            nCategory++;
        }
        string sValue = "Value" + IntToString(nCategory);
        string sCategory = sValue + "Category" + IntToString(nItemCategory);
        string sSubCategory = sCategory + "SubCategory" + IntToString(nItemSubCategory);
        string sType = sSubCategory + "Type" + IntToString(nItemType);
        DebugMessage("      Value is " + IntToString(nValue) + " in " + sType);

        // add item to the appropriate list
        int nItemNum = GetLocalInt(GetModule(), "n" + sType + "Num");
        nItemNum++;
        SetLocalInt(GetModule(), "n" + sType + "Num", nItemNum);

        // set item resref
        SetLocalString(GetModule(), "s" + sType + "_"+ IntToString(nItemNum) + "ResRef", sResRef);
        DebugMessage("      Set s" + sType + "_" + IntToString(nItemNum) + "ResRef to " + sResRef);
/*
        // check to make sure percentages are correct
        if (nItemNum == 1)
        {
            DebugMessage("        This item was the first of its type in this value category. Adding percentage.");

            // get the percentage of this type
            int nItemTypePercentage = GetModuleFlagValue("nFlagType" + sBaseType + "Percentage");
            DebugMessage("        Module value for nFlagType" + sBaseType + "Percentage is " + IntToString(nItemTypePercentage));
            SetLocalInt(GetModule(), "n" + sType + "Percentage", nItemTypePercentage);
            DebugMessage("          Setting n" + sType + "Percentage to " + IntToString(nItemTypePercentage));

            // get old subcategory total
            int nSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
            DebugMessage("            Old n" + sSubCategory + "Total is " + IntToString(nSubCategoryTotal));
            if (nSubCategoryTotal == 0)
            {
                nSubCategoryTotal += nItemTypePercentage;
                SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nSubCategoryTotal);
                DebugMessage("            No previous subcategory value present. Setting new value to " + IntToString(nSubCategoryTotal));

                // get the percentage of this subcategory
                int nItemSubCategoryPercentage = GetModuleFlagValue("nFlagSubCategory" + GetCategoryVariableName(nItemCategory) + GetSubCategoryVariableName(nItemCategory, nItemSubCategory) + "Percentage");
                DebugMessage("            Module value for nFlagSubCategory" + GetCategoryVariableName(nItemCategory) + GetSubCategoryVariableName(nItemCategory, nItemSubCategory) + "Percentage is " + IntToString(nItemSubCategoryPercentage));
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nItemSubCategoryPercentage);
                DebugMessage("              Setting n" + sSubCategory + "Percentage to " + IntToString(nItemSubCategoryPercentage));

                // get old category total
                int nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                DebugMessage("                Old n" + sCategory + "Total is " + IntToString(nCategoryTotal));
                if (nCategoryTotal == 0)
                {
                    nCategoryTotal += nItemSubCategoryPercentage;
                    SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);
                    DebugMessage("                No previous category value present. Setting new value to " + IntToString(nCategoryTotal));

                    // get the percentage of this category
                    int nItemCategoryPercentage = GetModuleFlagValue("nFlagCategory" + GetCategoryVariableName(nItemCategory) + "Percentage");
                    DebugMessage("                Module value for nFlagCategory" + GetCategoryVariableName(nItemCategory) + "Percentage is " + IntToString(nItemCategoryPercentage));
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nItemCategoryPercentage);
                    DebugMessage("                  Setting n" + sCategory + "Percentage to " + IntToString(nItemCategoryPercentage));

                    // get old category total
                    int nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    DebugMessage("                    Old n" + sValue + "Total is " + IntToString(nTotal));
                    nTotal += nItemCategoryPercentage;
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nTotal);
                    DebugMessage("                    Setting new total value to " + IntToString(nTotal));
                } else
                {
                    nCategoryTotal += nItemSubCategoryPercentage;
                    SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);
                    DebugMessage("                Category value already present. Setting new total to " + IntToString(nCategoryTotal));
                }
            } else
            {
                nSubCategoryTotal += nItemTypePercentage;
                SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nSubCategoryTotal);
                DebugMessage("                SubCategory value already present. Setting new total to " + IntToString(nSubCategoryTotal));
            }
        }
*/
        // destroy the item
        DestroyObject(oItem);
    } else
    {
        DebugMessage("      Is not a valid object.");
    }

    DestroyObject(OBJECT_SELF);
}

int GetCategorySubType(int nBaseType, int nCategorySubType)
{
    int nCategory;
    int nSubCategory;
    int nType;

    if (nBaseType == BASE_ITEM_AMULET)
    {
        nCategory = 3;
        nSubCategory = 1;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_ARMOR)
    {
        nCategory = 2;
        nSubCategory = 1;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_ARROW)
    {
        nCategory = 1;
        nSubCategory = 3;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_BASTARDSWORD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_BATTLEAXE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 2;
    } else if (nBaseType == BASE_ITEM_BELT)
    {
        nCategory = 3;
        nSubCategory = 2;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_BOLT)
    {
        nCategory = 1;
        nSubCategory = 3;
        nType = 2;
    } else if (nBaseType == BASE_ITEM_BOOTS)
    {
        nCategory = 3;
        nSubCategory = 1;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_BRACER)
    {
        nCategory = 3;
        nSubCategory = 4;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_BULLET)
    {
        nCategory = 1;
        nSubCategory = 3;
        nType = 3;
    } else if (nBaseType == BASE_ITEM_CLOAK)
    {
        nCategory = 3;
        nSubCategory = 5;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_CLUB)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 3;
    } else if (nBaseType == BASE_ITEM_DAGGER)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 4;
    } else if (nBaseType == BASE_ITEM_DART)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_DIREMACE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 5;
    } else if (nBaseType == BASE_ITEM_DOUBLEAXE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 6;
    } else if (nBaseType == BASE_ITEM_DWARVENWARAXE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 7;
    } else if (nBaseType == BASE_ITEM_GLOVES)
    {
        nCategory = 3;
        nSubCategory = 6;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_GREATAXE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 8;
    } else if (nBaseType == BASE_ITEM_GREATSWORD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 9;
    } else if (nBaseType == BASE_ITEM_HALBERD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 10;
    } else if (nBaseType == BASE_ITEM_HANDAXE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 11;
    } else if (nBaseType == BASE_ITEM_HEAVYCROSSBOW)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 2;
    } else if (nBaseType == BASE_ITEM_HEAVYFLAIL)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 12;
    } else if (nBaseType == BASE_ITEM_HELMET)
    {
        nCategory = 3;
        nSubCategory = 7;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_KAMA)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 13;
    } else if (nBaseType == BASE_ITEM_KATANA)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 14;
    } else if (nBaseType == BASE_ITEM_KUKRI)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 15;
    } else if (nBaseType == BASE_ITEM_LARGESHIELD)
    {
        nCategory = 2;
        nSubCategory = 2;
        nType = 2;
    } else if (nBaseType == BASE_ITEM_LIGHTCROSSBOW)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 3;
    } else if (nBaseType == BASE_ITEM_LIGHTFLAIL)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 16;
    } else if (nBaseType == BASE_ITEM_LIGHTHAMMER)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 17;
    } else if (nBaseType == BASE_ITEM_LIGHTMACE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 18;
    } else if (nBaseType == BASE_ITEM_LONGBOW)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 4;
    } else if (nBaseType == BASE_ITEM_LONGSWORD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 19;
    } else if (nBaseType == BASE_ITEM_MAGICROD)
    {
        nCategory = 4;
        nSubCategory = 5;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_MAGICSTAFF)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 20;
    } else if (nBaseType == BASE_ITEM_MORNINGSTAR)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 21;
    } else if (nBaseType == BASE_ITEM_QUARTERSTAFF)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 20;
    } else if (nBaseType == BASE_ITEM_RAPIER)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 22;
    } else if (nBaseType == BASE_ITEM_RING)
    {
        nCategory = 3;
        nSubCategory = 8;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_SCIMITAR)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 23;
    } else if (nBaseType == BASE_ITEM_SCYTHE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 24;
    } else if (nBaseType == BASE_ITEM_SHORTBOW)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 5;
    } else if (nBaseType == BASE_ITEM_SHORTSPEAR)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 25;
    } else if (nBaseType == BASE_ITEM_SHORTSWORD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 26;
    } else if (nBaseType == BASE_ITEM_SHURIKEN)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 6;
    } else if (nBaseType == BASE_ITEM_SICKLE)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 27;
    } else if (nBaseType == BASE_ITEM_SLING)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 7;
    } else if (nBaseType == BASE_ITEM_SMALLSHIELD)
    {
        nCategory = 2;
        nSubCategory = 2;
        nType = 1;
    } else if (nBaseType == BASE_ITEM_THROWINGAXE)
    {
        nCategory = 1;
        nSubCategory = 2;
        nType = 8;
    } else if (nBaseType == BASE_ITEM_TOWERSHIELD)
    {
        nCategory = 2;
        nSubCategory = 2;
        nType = 3;
    } else if (nBaseType == BASE_ITEM_TWOBLADEDSWORD)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 28;
    } else if (nBaseType == BASE_ITEM_WARHAMMER)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 29;
    } else if (nBaseType == BASE_ITEM_WHIP)
    {
        nCategory = 1;
        nSubCategory = 1;
        nType = 30;
    } else
    {
        nCategory = 5;
        nSubCategory = 1;
        nType = 1;
    }

    if (nCategorySubType == 1)
    {
        return nCategory;
    } else if (nCategorySubType == 2)
    {
        return nSubCategory;
    } else if (nCategorySubType == 3)
    {
        return nType;
    } else
    {
        return -1;
    }
}

