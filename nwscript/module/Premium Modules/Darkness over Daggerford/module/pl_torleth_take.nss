// player has removed an item from torleth's table
// .. take gold

void main()
{
    object oPC = GetLastDisturbed();
    if (GetIsPC(oPC))
    {
        object oItem = GetInventoryDisturbItem();
        int nType = GetInventoryDisturbType();
        if (nType == INVENTORY_DISTURB_TYPE_ADDED)
        {
            AssignCommand(oPC, PlaySound("gui_error"));
            AssignCommand(oPC, SpeakString("... Torleth doesn't want your junk ..."));
            CopyItem(oItem, oPC, TRUE);
            DestroyObject(oItem);
        }
        else
        {
            int nPrice = GetLocalInt(OBJECT_SELF, "PRICE");
            if (GetGold(oPC) >= nPrice)
            {
                TakeGoldFromCreature(nPrice, oPC, TRUE);
                AssignCommand(oPC, PlaySound("it_coins"));
            }
            else
            {
                AssignCommand(oPC, PlaySound("gui_error"));
                AssignCommand(oPC, SpeakString("... I don't have enough gold to shop here ..."));
                CopyItem(oItem, OBJECT_SELF, TRUE);
                DestroyObject(oItem);
            }
        }
    }
}
