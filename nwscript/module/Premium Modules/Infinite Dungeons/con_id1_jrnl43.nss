#include "inc_id1_utility"
#include "inc_id1_text"
#include "inc_id1_flags"

int StartingConditional()
{
    string sString = "";
    int nTemp;

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_AMULET_PERCENTAGE);
    sString += "Amulets have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BELT_PERCENTAGE);
    sString += "Belts have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BOOTS_PERCENTAGE);
    sString += "Boots have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_BRACER_PERCENTAGE);
    sString += "Bracers have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_CLOAK_PERCENTAGE);
    sString += "Cloaks have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_GLOVES_PERCENTAGE);
    sString += "Gloves have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_HELMET_PERCENTAGE);
    sString += "Helmets have a proportional chance of " + IntToString(nTemp) + ".";
    sString = AddLineBreak(sString);

    // accessory frequency
    nTemp = GetModuleFlagValue(ID1_FLAG_SUBCATEGORY_ACCESSORY_RING_PERCENTAGE);
    sString += "Rings have a proportional chance of " + IntToString(nTemp) + ".";

    SetCustomToken(5100, sString);

    return TRUE;
}
