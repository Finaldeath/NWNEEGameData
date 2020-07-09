#include "dla_i0_joust"

void main()
{
    object oPC = GetPCSpeaker();
    int nColors = DLA_JoustGetColors(oPC);
    if (nColors > 0)
    {
        object oChest = GetObjectByTag(DLA_TAG_JOUST_ARMOR_CHEST);
        int nUsed = GetLocalInt(oChest, "nUsed");
        if (!nUsed && !GetLocalInt(oPC, "bJoustArmorReturned"))
        {
//            SetLocked(oChest, FALSE);
            string sIndex  = IntToString(nColors);
            object oArmor  = CreateItemOnObject("wcjarmor"+sIndex, oChest, 1, "DLA_JOUST_ARMOR");
            object oHelmet = CreateItemOnObject("wcjhelmet"+sIndex, oChest, 1, "DLA_JOUST_HELMET");
            object oShield = CreateItemOnObject("wcjshield"+sIndex, oChest, 1, "DLA_JOUST_SHIELD");
            SetLocalObject(oPC, DLA_VAR_BORROWED_ARMOR, oArmor);
            SetLocalObject(oPC, DLA_VAR_BORROWED_HELMET, oHelmet);
            SetLocalObject(oPC, DLA_VAR_BORROWED_SHIELD, oShield);
            SetLocalInt(oChest, "nUsed", TRUE);
        }
    }
}
