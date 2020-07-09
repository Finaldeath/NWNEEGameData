#include "inc_id1_debug"
#include "inc_id1_prop"
#include "inc_id1_text"
#include "inc_id1_utility"


#include "x2_inc_itemprop"

int GetSubCostState(int nOldSubType, int nNewSubType, int nOldCostTableValue, int nNewCostTableValue, int nState, int bUnique = FALSE);
int GetCostState(int nOldCostTableValue, int nNewCostTableValue, int nState, int bUnique = FALSE);
int GetSubState(int nOldSubType, int nNewSubType, int nState, int bUnique = FALSE);

void main()
{
    // reset custom tokens
    SetCustomToken(5101, "");
    SetCustomToken(5102, "");
    SetCustomToken(5103, "");
    SetCustomToken(5104, "");
    SetCustomToken(5105, "");
    SetCustomToken(5106, "");
    SetCustomToken(5107, "");
    SetCustomToken(5108, "");
    SetCustomToken(5109, "");
    SetCustomToken(5110, "");
    SetLocalInt(OBJECT_SELF, "nCustom1State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom2State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom3State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom4State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom5State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom6State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom7State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom8State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom9State", 0);
    SetLocalInt(OBJECT_SELF, "nCustom10State", 0);
    SetLocalInt(OBJECT_SELF, "nCustomNumber", 0);

    // get number of recipes
    int nRecipeOffset = GetLocalInt(OBJECT_SELF, "nRecipeOffset");
    string sVariable1 = GetLocalString(OBJECT_SELF, "sVariable1");
    string sVariable2 = GetLocalString(OBJECT_SELF, "sVariable2");
    string sVariable3 = GetLocalString(OBJECT_SELF, "sVariable3");
    string sVariable4 = GetLocalString(OBJECT_SELF, "sVariable4");
    int nRecipeNum = GetLocalInt(OBJECT_SELF, "n" + sVariable1 + sVariable2 + sVariable3 + sVariable4);

    // get each recipe
    int nCount = 1;
    int nRecipe = nRecipeOffset + nCount;
    object oRecipe;
    string sTag;
    string sSubTag;
    string sString;
    int nState;
    itemproperty ipRecipe;
    int bPresent;
    int nGemType;
    int nGemQuality;
    int nGemNum;
    itemproperty ipProperty;
    object oItem = GetFirstItemInInventory();
    int nPropertyType;
    int nPropertySubType;
    int nPropertyParameter;
    int nPropertyParameterValue;
    int nPropertyCostTable;
    int nPropertyCostTableValue;
    int nRecipeType;
    int nRecipeSubType;
    int nRecipeParameter;
    int nRecipeParameterValue;
    int nRecipeCostTable;
    int nRecipeCostTableValue;
    int nTempState;
    int nCompCount;
    while ((nRecipe <= nRecipeNum) && (nCount <= 10))
    {
        DebugMessage("Getting o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
        oRecipe = GetLocalObject(OBJECT_SELF, "o" + sVariable1 + sVariable2 + sVariable3 + sVariable4 + IntToString(nRecipe));
        sTag = GetTag(oRecipe);
        DebugMessage("Tag is " + sTag);


        if (oRecipe != OBJECT_INVALID)
        {
            // get property
            ipRecipe = GetFirstItemProperty(oRecipe);
            while (GetItemPropertyType(ipRecipe) == ITEM_PROPERTY_CAST_SPELL)
            {
                ipRecipe = GetNextItemProperty(oRecipe);
            }

            nRecipeType = GetItemPropertyType(ipRecipe);
            nRecipeSubType = GetItemPropertySubType(ipRecipe);
            nRecipeParameter = GetItemPropertyParam1(ipRecipe);
            nRecipeParameterValue = GetItemPropertyParam1Value(ipRecipe);
            nRecipeCostTable = GetItemPropertyCostTable(ipRecipe);
            nRecipeCostTableValue = GetItemPropertyCostTableValue(ipRecipe);
            DebugMessage("Recipe is " + IntToString(nRecipeType) + " " + IntToString(nRecipeSubType) + " " + IntToString(nRecipeParameter) + " " + IntToString(nRecipeParameterValue) + " " + IntToString(nRecipeCostTable) + " " + IntToString(nRecipeCostTableValue));

            // decode components
            nCompCount = 1;
            bPresent = TRUE;
            while ((nCompCount <= 7) && (bPresent == TRUE))
            {
                // get component string
                sSubTag = GetSubString(sTag, 11 + (nCompCount - 1) * 3, 3);
                DebugMessage("String is " + sSubTag);

                if (sSubTag != "")
                {
                    // get component requirements
                    nGemType = DecodeAlphaNumeric(GetSubString(sSubTag, 0, 1));
                    nGemQuality = DecodeAlphaNumeric(GetSubString(sSubTag, 1, 1));
                    nGemNum = DecodeAlphaNumeric(GetSubString(sSubTag, 2, 1));
                    DebugMessage("Decoded numbers are " + IntToString(nGemType) + " " + IntToString(nGemQuality) + " " + IntToString(nGemNum));

                    // compare requirements
                    if (GetLocalInt(OBJECT_SELF, "nGem_" + IntToString(nGemType) + "_" + IntToString(nGemQuality)) < nGemNum)
                    {
                        // not enough components
                        bPresent = FALSE;
                        nState = 1;
                    }
                }

                // check next requirement
                nCompCount++;
            }

            // if there are enough components for this recipe
            if (bPresent == TRUE)
            {
                // set default as usable
                nState = 5;

                DebugMessage("Checking properties");

                // check properties
                ipProperty = GetFirstItemProperty(oItem);
                while ((GetIsItemPropertyValid(ipProperty) == TRUE) && (nState > 1))
                {
                    DebugMessage("Loop state is " + IntToString(nState));

                    // get property details
                    nPropertyType = GetItemPropertyType(ipProperty);
                    nPropertySubType = GetItemPropertySubType(ipProperty);
                    nPropertyParameter = GetItemPropertyParam1(ipProperty);
                    nPropertyParameterValue = GetItemPropertyParam1Value(ipProperty);
                    nPropertyCostTable = GetItemPropertyCostTable(ipProperty);
                    nPropertyCostTableValue = GetItemPropertyCostTableValue(ipProperty);
                    DebugMessage("Property is " + IntToString(nPropertyType) + " " + IntToString(nPropertySubType) + " " + IntToString(nPropertyParameter) + " " + IntToString(nPropertyParameterValue) + " " + IntToString(nPropertyCostTable) + " " + IntToString(nPropertyCostTableValue));

                    nTempState = 5;

                    // if they are the same type
                    if (nPropertyType == nRecipeType)
                    {
                        // if they are the same subtype
                        if (nPropertyType == ITEM_PROPERTY_ABILITY_BONUS)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_BONUS_FEAT)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_REDUCTION)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState);
                            if (nTempState == 3)
                            {
                                nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                            }
                        } else if (nPropertyType == ITEM_PROPERTY_DAMAGE_RESISTANCE)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_DARKVISION)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_HASTE)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_HEALERS_KIT)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_HOLY_AVENGER)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState, TRUE);
                        } else if (nPropertyType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_IMPROVED_EVASION)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_KEEN)
                        {
                            nTempState = 3;
                        } else if (nPropertyType == ITEM_PROPERTY_LIGHT)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_MASSIVE_CRITICALS)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_REGENERATION)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_REGENERATION_VAMPIRIC)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_SAVING_THROW_BONUS)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_SKILL_BONUS)
                        {
                            nTempState = GetSubCostState(nPropertySubType, nRecipeSubType, nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_SPELL_RESISTANCE)
                        {
                            nTempState = GetSubState(nPropertySubType, nRecipeSubType, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_THIEVES_TOOLS)
                        {
                            nTempState = GetCostState(nPropertyCostTableValue, nRecipeCostTableValue, nTempState);
                        } else if (nPropertyType == ITEM_PROPERTY_TRUE_SEEING)
                        {
                            nTempState = 3;
                        }
                    }

                    DebugMessage("Loop temp state is " + IntToString(nTempState));

                    // record state (0 = not usable, 1 = not enough components, 2 = better present, 3 = already present, 4 = lesser present, 5 = available)
                    if (nTempState < nState)
                    {
                        nState = nTempState;
                    }

                    // cycle to next property
                    ipProperty = GetNextItemProperty(oItem);
                }
            }

            // get state (0 = not usable, 1 = available, 2 = better present, 3 = lesser present, 4 = not enough components)
            DebugMessage("State is " + IntToString(nState));

            // add prefix
            sString = "";
            if (nState == 0)
            {
                sString = MakeTextRed("[Not Usable]");
            } else if (nState == 1)
            {
                sString = MakeTextOrange("[Not Enough Components]");
            } else if (nState == 2)
            {
                sString = MakeTextRed("[Better Present]");
            } else if (nState == 3)
            {
                sString = MakeTextOrange("[Already Present]");
            } else if (nState == 4)
            {
                sString = MakeTextYellow("[Lesser Present]");
            } else if (nState == 5)
            {
                sString = MakeTextGreen("[Usable]");
            }

            sString += " ";

            DebugMessage("Preliminary string is " + sString);

            // create string
            sString += GetItemPropertyString(ipRecipe);

            DebugMessage("Final string " + IntToString(5100 + nCount) + " is " + sString);

            // set the custom token
            SetCustomToken(5100 + nCount, sString);

            // set integer
            SetLocalInt(OBJECT_SELF, "nCustom" + IntToString(nCount) + "State", nState);
        } else
        {
            DebugMessage("Recipe is invalid.");
        }

        // get next recipe
        nCount++;
        nRecipe = nRecipeOffset + nCount;
    }
}

int GetSubCostState(int nOldSubType, int nNewSubType, int nOldCostTableValue, int nNewCostTableValue, int nState, int bUnique = FALSE)
{
    if (nOldSubType == nNewSubType)
    {
        DebugMessage("  Comparing " + IntToString(nOldCostTableValue) + " and " + IntToString(nNewCostTableValue));
        if ((nOldCostTableValue > nNewCostTableValue) && (bUnique == FALSE))
        {
            // greater present
            if (nState > 2)
            {
                return 2;
            }
        } else if (nOldCostTableValue == nNewCostTableValue)
        {
            // identical present
            if (nState > 3)
            {
                return 3;
            }
        } else if ((nOldCostTableValue < nNewCostTableValue) && (bUnique == FALSE))
        {
            // lesser present
            if (nState > 4)
            {
                return 4;
            }
        }
    }

    return nState;
}

int GetCostState(int nOldCostTableValue, int nNewCostTableValue, int nState, int bUnique = FALSE)
{
    if ((nOldCostTableValue > nNewCostTableValue) && (bUnique == FALSE))
    {
        // greater present
        if (nState > 2)
        {
            return 2;
        }
    } else if (nOldCostTableValue == nNewCostTableValue)
    {
        // identical present
        if (nState > 3)
        {
            return 3;
        }
    } else if ((nOldCostTableValue < nNewCostTableValue) && (bUnique == FALSE))
    {
        // lesser present
        if (nState > 4)
        {
            return 4;
        }
    }

    return nState;
}

int GetSubState(int nOldSubType, int nNewSubType, int nState, int bUnique = FALSE)
{
    if ((nOldSubType > nNewSubType) && (bUnique == FALSE))
    {
        // greater present
        if (nState > 2)
        {
            return 2;
        }
    } else if (nOldSubType == nNewSubType)
    {
        // identical present
        if (nState > 3)
        {
            return 3;
        }
    } else if ((nOldSubType < nNewSubType) && (bUnique == FALSE))
    {
        // lesser present
        if (nState > 4)
        {
            return 4;
        }
    }

    return nState;
}

