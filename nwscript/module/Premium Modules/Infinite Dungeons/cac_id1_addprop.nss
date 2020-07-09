#include "inc_id1_debug"
#include "inc_id1_utility"
#include "x2_inc_itemprop"

void main()
{
    // get custom number
    int nCustomNumber = GetLocalInt(OBJECT_SELF, "nCustomNumber");

    // get recipe number
    int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");
    int nRecipe = nRecipeOffset + nCustomNumber;

    // get recipe
    DebugMessage("Getting o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
    object oRecipe = GetLocalObject(OBJECT_SELF, "o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
    string sTag = GetTag(oRecipe);
    DebugMessage("Tag is " + sTag);

    // get PC
    object oPC = GetLocalObject(OBJECT_SELF, "oUser");

    // get property
    itemproperty ipRecipe = GetFirstItemProperty(oRecipe);
    while (GetItemPropertyType(ipRecipe) == ITEM_PROPERTY_CAST_SPELL)
    {
        ipRecipe = GetNextItemProperty(oRecipe);
    }

    // get item to add to
    object oItem = GetFirstItemInInventory(OBJECT_SELF);

    // decode requirements
    int nCount = 1;
    string sString;
    string sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
    int nGemType;
    int nGemQuality;
    int nGemNum;
    int nPlayerGemNum;
    string sGemName;
    object oGem;
    int nStackSize;
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
            sGemName = "id1_gem_" + IntToStringDigits(nGemType, 2) + "_" + IntToStringDigits(nGemQuality, 2);

            nPlayerGemNum = GetLocalInt(OBJECT_SELF, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality));
            nPlayerGemNum -= nGemNum;
            SetLocalInt(OBJECT_SELF, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality), nPlayerGemNum);

            // subtract gems
            while (nGemNum > 0)
            {
                oGem = GetItemPossessedBy(oPC, sGemName);
                if (oGem != OBJECT_INVALID)
                {
                    nStackSize = GetItemStackSize(oGem);
                    if (nStackSize > nGemNum)
                    {
                        nStackSize -= nGemNum;
                        nGemNum = 0;
                        SetItemStackSize(oGem, nStackSize);
                    } else
                    {
                        nGemNum -= nStackSize;
                        DestroyObject(oGem);
                    }
                } else
                {
                    DebugMessage("Gem was invalid.");
                }
            }
        }

        // check next requirement
        nCount++;
        sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
    }

    // add property to item
    IPSafeAddItemProperty(oItem, ipRecipe);

    // destroy recipe
    DestroyObject(oRecipe);

    // EDIT: check variables leading up to this point

    // remove a charge
    object oDungeon = GetCurrentDungeon();
    string sVariable = GetLocalString(OBJECT_SELF, "sVariable"); // AreaXWaypointPuzzleYLevelZ
    int nCharges = GetLocalInt(oDungeon, "n" + sVariable + "ForgeCharges");
    nCharges--;
    SetLocalInt(oDungeon, "n" + sVariable + "ForgeCharges", nCharges);

    ActionPauseConversation();

    // enchantment effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(OBJECT_SELF),2.0);

    // EDIT: remove nearby sparks
    object oSpark = GetNearestObjectByTag("plc_magicwhite");
    DestroyObject(oSpark);

    DelayCommand(1.0, ActionResumeConversation());

    object oForge = OBJECT_SELF;
    DelayCommand(1.1, SetLocked(oForge, FALSE));
}
