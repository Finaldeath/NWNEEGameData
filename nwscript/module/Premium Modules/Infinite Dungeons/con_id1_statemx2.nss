#include "inc_id1_utility"
#include "inc_id1_prop"

int StartingConditional()
{
    int nCustomNumber = GetLocalInt(OBJECT_SELF, "nCustomNumber");

    // get number of recipes
    int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");

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

    return TRUE;
}
