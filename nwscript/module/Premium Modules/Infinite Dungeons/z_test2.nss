#include "inc_id1_debug"
#include "x2_inc_itemprop"
#include "inc_id1_items"

void DisplayItemProperty(object oItem);

void main()
{
    object oPC = GetFirstPC();
    object oItem;

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);


    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POSITIVE, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);

    oItem = CreateItemOnObject("id_mbelt", oPC);
    IPRemoveAllItemProperties(oItem);
    IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, 5));
    SetIdentified(oItem, TRUE);
    SetItemName(oItem);
    DisplayItemProperty(oItem);
}

void DisplayItemProperty(object oItem)
{
    DebugMessage("Item is " + GetName(oItem));

    itemproperty ipItem = GetFirstItemProperty(oItem);
    while (GetIsItemPropertyValid(ipItem) == TRUE)
    {
        int nType = GetItemPropertyType(ipItem);
        DebugMessage("  Item property type is " + IntToString(nType));
        int nSubType = GetItemPropertySubType(ipItem);
        DebugMessage("    Item property subtype is " + IntToString(nSubType));
        int nCost = GetItemPropertyCostTable(ipItem);
        DebugMessage("    Item property cost table is " + IntToString(nCost));
        int nCostValue = GetItemPropertyCostTableValue(ipItem);
        DebugMessage("    Item property cost table value is " + IntToString(nCostValue));
        int nParam1 = GetItemPropertyParam1(ipItem);
        DebugMessage("    Item property param1 is " + IntToString(nParam1));
        int nParam1Value = GetItemPropertyParam1Value(ipItem);
        DebugMessage("    Item property param1 value is " + IntToString(nParam1Value));

        ipItem = GetNextItemProperty(oItem);
    }
}

