#include "dla_i0_joust"

void privateEquipBestArmor(object oPC)
{
    if (!GetIsObjectValid(oPC)) return;
    if (GetObjectType(oPC) != OBJECT_TYPE_CREATURE) return;

    object oItem = GetFirstItemInInventory(oPC);
    int nBestAC = -1;
    object oArmor;
    while(GetIsObjectValid(oItem))
    {
        if (GetBaseItemType(oItem)==BASE_ITEM_ARMOR)
        {
            int nAC = GetItemACValue(oItem);
            if (nAC > nBestAC)
            {
                nBestAC = nAC;
                oArmor = oItem;
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
    if (GetIsObjectValid(oArmor))
    {
        AssignCommand(oPC, ActionEquipItem(oArmor, INVENTORY_SLOT_CHEST));
    }
}
void main()
{
    object oPC = GetExitingObject();
    if (!GetIsPC(oPC)) return;

    object oChest = GetObjectByTag(DLA_TAG_JOUST_ARMOR_CHEST);
    if (GetLocalInt(oChest, "nUsed"))
//  if (GetLocalInt(oChest, "nUsed") && !GetLocalInt(oPC, "bIgnoreOnExit"))
    {
        object oHelm    = GetLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
        object oArmor   = GetLocalObject(oPC, DLA_VAR_BORROWED_ARMOR);
        object oShield  = GetLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
        if (GetIsObjectValid(oHelm))
        {
            AssignCommand(oChest, ActionTakeItem(oHelm, GetItemPossessor(oHelm)));
            DestroyObject(oHelm, 0.1);
        }
        if (GetIsObjectValid(oShield))
        {
            AssignCommand(oChest, ActionTakeItem(oShield, GetItemPossessor(oShield)));
            DestroyObject(oShield, 0.1);
            DelayCommand(0.2, AssignCommand(oPC, privateEquipBestArmor(oPC)));
        }
        if (GetIsObjectValid(oArmor))
        {
            AssignCommand(oChest, ActionTakeItem(oArmor, GetItemPossessor(oArmor)));
            DestroyObject(oArmor, 0.1);
        }
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_HELMET);
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_ARMOR);
        DeleteLocalObject(oPC, DLA_VAR_BORROWED_SHIELD);
        DeleteLocalInt(oChest, "nUsed");
//        SetLocked(oChest, TRUE);
    }
}
