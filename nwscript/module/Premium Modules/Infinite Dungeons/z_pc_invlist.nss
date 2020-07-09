// lists the name and tag of every item in the first player's inventory

#include "inc_id1_debug"

void main()
{
    PrintString("");
    PrintString("Dumping player inventory names.");

    object oPC = GetFirstPC();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    string sName;
    while (oItem != OBJECT_INVALID)
    {
        sTag = GetTag(oItem);
        sName = GetName(oItem);
        PrintString("Item is named " + sName + " with tag " + sTag);

        oItem = GetNextItemInInventory(oPC);
    }
}
