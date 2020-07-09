#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id1_items"

void main()
{
    DebugMessage("");
    DebugMessage("Rebuilding percentages.");

    int nValue = GetLocalInt(OBJECT_SELF, "nValue");
    string sValue;
    if (nValue == 0)
    {
        sValue = "Ideal";
    } else
    {
        sValue = "Value" + IntToString(nValue);
    }
    DebugMessage("  sValue is " + sValue);

    int nTotal = 0;

    int nCategory;
    int nCategoryNum = 5;
    string sCategory;
    string sCategoryName;
    int nCategoryTotal;

    int nSubCategory;
    int nSubCategoryNum;
    string sSubCategory;
    string sSubCategoryName;
    int nSubCategoryTotal;

    int nType;
    int nTypeNum;
    int nTypeItems;
    string sType;
    string sTypeName;

    int nPercentage;

    // category 1
    nCategory = 1;
    while (nCategory <= nCategoryNum)
    {
        nCategoryTotal = 0;
        sCategory = sValue + "Category" + IntToString(nCategory);
        sCategoryName = GetCategoryVariableName(nCategory);
        DebugMessage("    sCategory is " + sCategory);
        DebugMessage("    sCategoryName is " + sCategoryName);

        nSubCategory = 1;
        if (nValue == 0)
        {
            nSubCategoryNum = GetSubCategoryNum(nCategory, TRUE);
        } else
        {
            nSubCategoryNum = GetSubCategoryNum(nCategory, FALSE);
        }
        DebugMessage("    There are " + IntToString(nSubCategoryNum) + " subcategories in this category.");
        while (nSubCategory <= nSubCategoryNum)
        {
            nSubCategoryTotal = 0;
            sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
            sSubCategoryName = GetSubCategoryVariableName(nCategory, nSubCategory);
            DebugMessage("      sSubCategory is " + sSubCategory);
            DebugMessage("      sSubCategoryName is " + sSubCategoryName);

            // sum types
            nType = 1;
            nTypeNum = GetTypeNum(nCategory, nSubCategory);
            DebugMessage("      There are " + IntToString(nTypeNum) + " types in this subcategory.");
            while (nType <= nTypeNum)
            {
                sType = sSubCategory + "Type" + IntToString(nType);
                sTypeName = GetTypeVariableName(nCategory, nSubCategory, nType);
                DebugMessage("        sType is " + sType);
                DebugMessage("        sTypeName is " + sTypeName);

                // if ideal or items present
                nTypeItems = GetLocalInt(GetModule(), "n" + sType + "Num");
                DebugMessage("        There are " + IntToString(nTypeItems) + " items of this type.");
                if ((nValue == 0) || (nTypeItems > 0))
                {
                    // add to subcategory total
                    nPercentage = GetModuleFlagValue("nFlagType" + sTypeName + "Percentage");
                    DebugMessage("          nFlagType" + sTypeName + "Percentage is " + IntToString(nPercentage));
                    nSubCategoryTotal += nPercentage;
                    SetLocalInt(GetModule(), "n" + sType + "Percentage", nPercentage);
                    DebugMessage("          Set n" + sType + "Percentage");
                    DebugMessage("          New subcategory total is " + IntToString(nSubCategoryTotal));
                }

                nType++;
            }

            // set the subcategory total
            SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nSubCategoryTotal);

            // if subcategory total > 0, add percentage to category total
            if (nSubCategoryTotal > 0)
            {
                nPercentage = GetModuleFlagValue("nFlagSubCategory" + sCategoryName + sSubCategoryName + "Percentage");
                DebugMessage("      nFlagSubCategory" + sCategoryName + sSubCategoryName + "Percentage is " + IntToString(nPercentage));
                nCategoryTotal += nPercentage;
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nPercentage);
                DebugMessage("      Set n" + sSubCategory + "Percentage");
            }
            DebugMessage("      New category total is " + IntToString(nCategoryTotal));

            nSubCategory++;
        }

        // set the category total
        SetLocalInt(GetModule(), "n" + sCategory + "Total", nCategoryTotal);

        // if category total > 0, add percentage to total
        if (nCategoryTotal > 0)
        {
            nPercentage = GetModuleFlagValue("nFlagCategory" + sCategoryName + "Percentage");
            DebugMessage("    nFlagCategory" + sCategoryName + "Percentage is " + IntToString(nPercentage));
            nTotal += nPercentage;
            SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nPercentage);
            DebugMessage("    Set n" + sCategory + "Percentage");
        }
        DebugMessage("    New total is " + IntToString(nTotal));

        nCategory++;
    }

    // record total
    SetLocalInt(GetModule(), "n" + sValue + "Total", nTotal);
    DebugMessage("  Final total is " + IntToString(nTotal));

    // category 2
        // subcategory 1
            // sum types
        // subcategory 2
            // sum types


    // category 3
        // subcategory 1
        // subcategory 2
        // subcategory 3
        // subcategory 4
        // subcategory 5
        // subcategory 6
        // subcategory 7
        // subcategory 8


    // category 4
        // subcategory 1
        // subcategory 2
        // subcategory 3
        // subcategory 4
        // subcategory 5


    // category 5


/*
    // for value categories 0-40 (0 is ideal category)
    string sValue;
    string sCategory;
    string sSubCategory;
    string sType;
    int nOldTotal;
    int nNewTotal;
    int nOldCategoryPercentage;
    int nNewCategoryPercentage;
    int nOldCategoryTotal;
    int nNewCategoryTotal;
    int nOldSubCategoryPercentage;
    int nNewSubCategoryPercentage;
    int nOldSubCategoryTotal;
    int nNewSubCategoryTotal;
    int nOldTypePercentage;
    int nNewTypePercentage;
    int nTypeNum;
    int nValue = 0;
    while (nValue <= 40)
    {
        if (nValue == 0)
        {
            sValue = "Ideal";
        } else
        {
            sValue = "Value" + IntToString(nValue);
        }

        nCategory = 1;
        while (nCategory <= 5)
        {
        }

        sCategory = sValue + "Category" + IntToString(nCategory);
        sSubCategory = sCategory + "SubCategory" + IntToString(nSubCategory);
        sType = sSubCategory + "Type" + IntToString(nType);
        DebugMessage("On " + sType);

        // get the number of items in this category
        nTypeNum = GetLocalInt(GetModule(), "n" + sType + "Num");
        DebugMessage("  There are " + IntToString(nTypeNum) + " items of this type.");
        if ((nTypeNum > 0) || (nValue == 0))
        {
            nOldTypePercentage = GetLocalInt(GetModule(), "n" + sType + "Percentage");
            nNewTypePercentage = nOldTypePercentage + nModifier;
            if (nNewTypePercentage < 0)
            {
                nNewTypePercentage = 0;
            }
            DebugMessage("  Old n" + sType + "Percentage was " + IntToString(nOldTypePercentage) + " and new is " + IntToString(nNewTypePercentage));
            SetLocalInt(GetModule(), "n" + sType + "Percentage", nNewTypePercentage);

            // if subcategory total is above 0
            nOldSubCategoryTotal = GetLocalInt(GetModule(), "n" + sSubCategory + "Total");
            nNewSubCategoryTotal = nOldSubCategoryTotal + nModifier;
            if (nNewSubCategoryTotal < 0)
            {
                nNewSubCategoryTotal = 0;
            }
            DebugMessage("  Old n" + sSubCategory + "Total was " + IntToString(nOldSubCategoryTotal) + " and new is " + IntToString(nNewSubCategoryTotal));
            SetLocalInt(GetModule(), "n" + sSubCategory + "Total", nNewSubCategoryTotal);

            // if the old was 0
            if ((nOldSubCategoryTotal == 0) && (nNewSubCategoryTotal != 0))
            {
                nNewSubCategoryPercentage = GetModuleFlagValue("nFlagSubCategory" + GetCategoryVariableName(nCategory) + GetSubCategoryVariableName(nCategory, nSubCategory) + "Percentage");
                if (nNewSubCategoryPercentage < 0)
                {
                    nNewSubCategoryPercentage = 0;
                }
                DebugMessage("  New n" + sSubCategory + "Percentage is " + IntToString(nNewSubCategoryPercentage));
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", nNewSubCategoryPercentage);

                // category totals
                nOldCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                nNewCategoryTotal = nOldCategoryTotal + nNewSubCategoryPercentage;
                if (nNewCategoryTotal < 0)
                {
                    nNewCategoryTotal = 0;
                }
                DebugMessage("  Old n" + sCategory + "Total was " + IntToString(nOldCategoryTotal) + " and new is " + IntToString(nNewCategoryTotal));
                SetLocalInt(GetModule(), "n" + sCategory + "Total", nNewCategoryTotal);

                // newly set to 0
                if ((nNewCategoryTotal == 0) && (nOldCategoryTotal != 0))
                {
                    // set category percentage to 0
                    nOldCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
                    DebugMessage("  Old n" + sCategory + "Percentage was " + IntToString(nOldCategoryPercentage) + " and new is set to 0");
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", 0);

                    // adjust total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal - nOldCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }

                // newly given a value
                if ((nNewCategoryTotal != 0) && (nOldCategoryTotal == 0))
                {
                    // set real percentage
                    nNewCategoryPercentage = GetLocalInt(GetModule(), "nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage");
                    DebugMessage("  nFlagCategory" + GetCategoryVariableName(nCategory) + "Percentage is " + IntToString(nNewCategoryPercentage));
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", nNewCategoryPercentage);

                    // add to total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal + nNewCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }
            } else if ((nOldSubCategoryTotal != 0) && (nNewSubCategoryTotal == 0)) // if the new is 0
            {
                // set subcategory percentage to 0
                nOldSubCategoryPercentage = GetLocalInt(GetModule(), "n" + sSubCategory + "Percentage");
                DebugMessage("  Old n" + sSubCategory + "Percentage was " + IntToString(nOldSubCategoryPercentage) + " and new is set to 0");
                SetLocalInt(GetModule(), "n" + sSubCategory + "Percentage", 0);

                // remove subcategory percentage from category total
                nOldCategoryTotal = GetLocalInt(GetModule(), "n" + sCategory + "Total");
                nNewCategoryTotal = nOldCategoryTotal - nOldSubCategoryPercentage;
                if (nNewCategoryTotal < 0)
                {
                    nNewCategoryTotal = 0;
                }
                DebugMessage("  Old n" + sCategory + "Total was " + IntToString(nOldCategoryTotal) + " and new is " + IntToString(nNewCategoryTotal));
                SetLocalInt(GetModule(), "n" + sCategory + "Total", nNewCategoryTotal);

                // if category total is 0
                if (nNewCategoryTotal == 0)
                {
                    // set category percentage to 0
                    nOldCategoryPercentage = GetLocalInt(GetModule(), "n" + sCategory + "Percentage");
                    DebugMessage("  Old n" + sCategory + "Percentage was " + IntToString(nOldCategoryPercentage) + " and new is set to 0");
                    SetLocalInt(GetModule(), "n" + sCategory + "Percentage", 0);

                    // adjust total
                    nOldTotal = GetLocalInt(GetModule(), "n" + sValue + "Total");
                    nNewTotal = nOldTotal - nOldCategoryPercentage;
                    if (nNewTotal < 0)
                    {
                        nNewTotal = 0;
                    }
                    DebugMessage("  Old n" + sValue + "Total was " + IntToString(nOldTotal) + " and new is " + IntToString(nNewTotal));
                    SetLocalInt(GetModule(), "n" + sValue + "Total", nNewTotal);
                }
            }
        }

        nValue++;
    }
*/

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

    // first 3 categories
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

                // if this type has items in it

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
/*
    // go to treasure level percentages
    if (nValue < 40)
    {
        object oParent = GetLocalObject(OBJECT_SELF, "oParent");
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU");
        SetLocalObject(oMicroCPU, "oParent", oParent);
        SetLocalInt(oMicroCPU, "nValue", nValue + 1);
        DelayCommand(0.01, ExecuteScript("exe_id1_micitp1", oMicroCPU));
    } else
    {
        object oParent = GetLocalObject(OBJECT_SELF, "oParent");
        AssignCommand(oParent, ActionResumeConversation());
    }*/

    DelayCommand(0.01, DestroyObject(OBJECT_SELF));
}

