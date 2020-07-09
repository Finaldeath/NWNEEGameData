#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id1_items"

void main()
{
    DebugMessage("");
    DebugMessage("Cataloging ideal percentages.");
/*
    string sType;
    string sTypeName;
    int nTypeNum;
    int nType;
    int nTypePercentage;

    string sSubCategory;
    string sSubCategoryName;
    int nSubCategoryNum;
    int nSubCategory;
    int nSubCategoryTotal;
    int nSubCategoryPercentage;

    string sCategory;
    string sCategoryName;
    int nCategoryNum = 5;
    int nCategory = 1;
    int nCategoryTotal;
    int nCategoryPercentage;

    string sTotal = "Ideal";
    int nTotal = 0;

    while (nCategory <= nCategoryNum)
    {
        sCategory = sTotal + "Category" + IntToString(nCategory);
//        DebugMessage("  sCategory is " + sCategory);
        sCategoryName = GetCategoryVariableName(nCategory);
//        DebugMessage("    sCategoryName is " + sCategoryName);

        nCategoryTotal = 0;

        nSubCategoryNum = GetSubCategoryNum(nCategory);
        nSubCategory = 1;
        while (nSubCategory <= nSubCategoryNum)
        {
            sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
//            DebugMessage("    sSubCategory is " + sSubCategory);
            sSubCategoryName = GetSubCategoryVariableName(nCategory, nSubCategory);
//            DebugMessage("      sSubCategoryName is " + sSubCategoryName);

            nSubCategoryTotal = 0;

            nTypeNum = GetTypeNum(nCategory, nSubCategory);
            nType = 1;
            while (nType <= nTypeNum)
            {
                sType = sSubCategory + "Type" + IntToString(nType);
//                DebugMessage("      sType is " + sType);
                sTypeName = GetTypeVariableName(nCategory, nSubCategory, nType);
//                DebugMessage("        sTypeName is " + sTypeName);

                // add type percentage to subcategory total
                nTypePercentage = GetModuleFlagValue("nFlagType" + sTypeName + "Percentage");
                nSubCategoryTotal += nTypePercentage;
                SetLocalInt(GetModule(), "n" + sType + "Percentage", nTypePercentage);
//                DebugMessage("        nFlagType" + sTypeName + "Percentage is " + IntToString(nTypePercentage) + " bringing total to " + IntToString(nSubCategoryTotal));

                // cycle to next type
                nType++;
            }

            // record subcategory total
            SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nSubCategoryTotal);
//            DebugMessage("      Set n" + sSubCategory + "Total to " + IntToString(nSubCategoryTotal));

            // add subcategory percentage to category total
            nSubCategoryPercentage = GetModuleFlagValue("nFlagSubCategory" + sCategoryName + sSubCategoryName + "Percentage");
            nCategoryTotal += nSubCategoryPercentage;
            SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nSubCategoryPercentage);
//            DebugMessage("      nFlagSubCategory" + sCategoryName + sSubCategoryName + "Percentage is " + IntToString(nSubCategoryPercentage) + " bringing total to " + IntToString(nCategoryTotal));

            // cycle to next subcategory
            nSubCategory++;
        }

        // record category total
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);
//        DebugMessage("    Set n" + sCategory + "Total to " + IntToString(nCategoryTotal));

        // add category percentage to total
        nCategoryPercentage = GetModuleFlagValue("nFlagCategory" + sCategoryName + "Percentage");
        nTotal += nCategoryPercentage;
        SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nCategoryPercentage);
//        DebugMessage("    nFlagCategory" + sCategoryName + "Percentage is " + IntToString(nCategoryPercentage) + " bringing total to " + IntToString(nTotal));

        // cycle to next category
        nCategory++;
    }

    // record total
    SetLocalInt(GetModule(), "n" + sTotal + "Total", nTotal);
//    DebugMessage("  Set n" + sTotal + "Total to " + IntToString(nTotal));

    // add value category exceptions for default items
    int nValue = 1;
    string sValue;
//    string sCategory;
//    string sSubCategory;
//    string sType;
    int nTemp;
//    int nSubCategoryPercentage;
//    int nCategoryTotal;
    while (nValue <= 40)
    {
//        DebugMessage("Setting defaults for value category " + IntToString(nValue));

        sValue = "Value" + IntToString(nValue);
        sCategory = sValue + "Category4";

        // grenade
        sSubCategory = sCategory + "SubCategory1";
        sType = sSubCategory + "Type1";
        SetLocalInt(GetModule(), "n" + sType + "Percentage", 1);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Total", 1);
        nSubCategoryPercentage = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_GRENADE_PERCENTAGE);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nSubCategoryPercentage);
        nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
        nCategoryTotal += nSubCategoryPercentage;
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);
        if (nCategoryTotal == nSubCategoryPercentage)
        {
            nCategoryPercentage = GetModuleFlagValue(ID1_FLAG_CATEGORY_CONSUMABLE_PERCENTAGE);
            SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nCategoryPercentage);
            nTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
            nTotal += nCategoryPercentage;
            SetLocalInt(GetModule(), "n" + sValue + "Total", nTotal);
        }

        // wand
        sSubCategory = sCategory + "SubCategory2";
        sType = sSubCategory + "Type1";
        SetLocalInt(GetModule(), "n" + sType + "Percentage", 1);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Total", 1);
        nSubCategoryPercentage = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_WAND_PERCENTAGE);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nSubCategoryPercentage);
        nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
        nCategoryTotal += nSubCategoryPercentage;
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);

        // potion
        sSubCategory = sCategory + "SubCategory3";
        sType = sSubCategory + "Type1";
        SetLocalInt(GetModule(), "n" + sType + "Percentage", 1);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Total", 1);
        nSubCategoryPercentage = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_POTION_PERCENTAGE);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nSubCategoryPercentage);
        nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
        nCategoryTotal += nSubCategoryPercentage;
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);

        // scroll
        sSubCategory = sCategory + "SubCategory4";
        sType = sSubCategory + "Type1";
        SetLocalInt(GetModule(), "n" + sType + "Percentage", 1);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Total", 1);
        nSubCategoryPercentage = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_CONSUMABLE_SCROLL_PERCENTAGE);
        SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nSubCategoryPercentage);
        nCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
        nCategoryTotal += nSubCategoryPercentage;
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);

        nValue++;
    }*/

    // rebuild item percentages
    object oMicroCPU;
    int nValue = 0;
    while (nValue <= 40)
    {
        oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU62");
        SetLocalObject(oMicroCPU, "oParent", OBJECT_SELF);
        SetLocalInt(oMicroCPU, "nValue", nValue);
        DelayCommand(0.01, ExecuteScript("exe_id1_micitp1", oMicroCPU));

        nValue++;
    }

    // return to the catalog
//    DebugMessage("Ideal percentages completed.");
    DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
}

