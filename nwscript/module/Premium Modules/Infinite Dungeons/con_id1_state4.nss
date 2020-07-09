#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_prop"

int StartingConditional()
{
    int nCustomNumber = GetLocalInt(OBJECT_SELF, "nCustomNumber");

    if (GetLocalInt(OBJECT_SELF, "nCustom" + IntToString(nCustomNumber) + "State") == 4)
    {
        // get number of recipes
        int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
        string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
        string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
        string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
        string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");

        SetCustomToken(5112, "");
        SetCustomToken(5113, "");
        SetCustomToken(5114, "");
        SetCustomToken(5115, "");
        SetCustomToken(5116, "");
        SetCustomToken(5117, "");
        SetCustomToken(5118, "");

        // get custom information
        int nRecipe = nRecipeOffset + nCustomNumber;

        DebugMessage("Getting o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
        object oRecipe = GetLocalObject(OBJECT_SELF, "o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
        string sTag = GetTag(oRecipe);
        DebugMessage("Tag is " + sTag);

        // get property
        itemproperty ipRecipe = GetFirstItemProperty(oRecipe);
        while (GetItemPropertyType(ipRecipe) == ITEM_PROPERTY_CAST_SPELL)
        {
            ipRecipe = GetNextItemProperty(oRecipe);
        }

        // 5111 - string
        string sString = GetItemPropertyString(ipRecipe);
        SetCustomToken(5111, sString);

        // 5112-8 component information
        int nCount = 1;
        int bPresent = TRUE;
        string sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
        int nGemType;
        int nGemQuality;
        int nGemNum;
        string sGemName;
        object oGem;
        while ((nCount <= 7) && (sSubTag != ""))
        {
            DebugMessage("String is " + sSubTag);

            // get component string
            sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
            DebugMessage("String is " + sSubTag);

            if (sSubTag != "")
            {
                // get component requirements
                nGemType = DecodeAlphaNumeric(GetSubString(sSubTag, 0, 1));
                nGemQuality = DecodeAlphaNumeric(GetSubString(sSubTag, 1, 1));
                nGemNum = DecodeAlphaNumeric(GetSubString(sSubTag, 2, 1));
                DebugMessage("Decoded numbers are " + IntToString(nGemType) + " " + IntToString(nGemQuality) + " " + IntToString(nGemNum));

                oGem = CreateItemOnObject("id1_gem_" + IntToStringDigits(nGemType, 2) + "_" + IntToStringDigits(nGemQuality, 2), OBJECT_SELF);
                sGemName = GetName(oGem);
                DestroyObject(oGem);

                sString = IntToString(nGemNum) + " " + sGemName + " (you currently have ";

                nGemNum = GetLocalInt(OBJECT_SELF, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality));
                sString += IntToString(nGemNum) + ")";

                SetCustomToken(5111 + nCount, sString);
            }

            // check next requirement
            nCount++;
            sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
        }

        return TRUE;
    } else
    {
        return FALSE;
    }
}
