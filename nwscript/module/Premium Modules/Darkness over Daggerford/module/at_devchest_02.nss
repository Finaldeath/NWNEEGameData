// player takes the first item in the chest of the wise

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory();
    ActionGiveItem(oItem, oPC);
}
