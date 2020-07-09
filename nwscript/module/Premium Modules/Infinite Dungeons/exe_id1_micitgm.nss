#include "inc_id1_utility"

void main()
{
    object oForge = GetLocalObject(OBJECT_SELF, "oForge");
    object oPC = GetLocalObject(OBJECT_SELF, "oPC");
    object oItem = GetLocalObject(OBJECT_SELF, "oItem");

    DebugMessage("");
    DebugMessage("Cataloging gem for forge.");

    string sTag = GetTag(oItem);
    DebugMessage("  Gem tag " + sTag);

    // get gem type
    string sSubTag = GetSubString(sTag, 8, 2);
    DebugMessage("  Gem type " + sSubTag);
    int nGemType = StringToInt(sSubTag);

    // get gem quality
    sSubTag = GetSubString(sTag, 11, 2);
    DebugMessage("  Gem quality " + sSubTag);
    int nGemQuality = StringToInt(sSubTag);

    // increment counter
    int nGemNum = GetLocalInt(oForge, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality));
    nGemNum += GetItemStackSize(oItem);
    SetLocalInt(oForge, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality), nGemNum);
    DebugMessage("  Setting nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality) + " to " + IntToString(nGemNum));

    // increment number of gems cataloged on forge
    int nForgeGemNum = GetLocalInt(oForge, "nGemNum");
    int nForgeGemCurrent = GetLocalInt(oForge, "nGemCurrent");
    int nForgeRecipeNum = GetLocalInt(oForge, "nRecipeNum");
    int nForgeRecipeCurrent = GetLocalInt(oForge, "nRecipeCurrent");

    nForgeGemCurrent++;
    SetLocalInt(oForge, "nGemCurrent", nForgeGemCurrent);

    DebugMessage("  Have cataloged " + IntToString(nForgeGemCurrent) + " out of " + IntToString(nForgeGemNum) + " gems.");
    DebugMessage("  Have cataloged " + IntToString(nForgeRecipeCurrent) + " out of " + IntToString(nForgeRecipeNum) + " recipes.");

    if ((nForgeGemCurrent >= nForgeGemNum) && (nForgeRecipeCurrent >= nForgeRecipeNum))
    {
        DebugMessage("Item catalog finished.");
        SetLocalInt(oForge, "bCataloging", FALSE);
        DelayCommand(0.01, AssignCommand(oPC, ActionStartConversation(oForge, "id1_forge", TRUE, FALSE)));
    }

    DelayCommand(0.02, DestroyObject(OBJECT_SELF));
}
