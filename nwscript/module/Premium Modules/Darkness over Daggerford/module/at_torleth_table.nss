// open the inventory panel for torleth's junk table
// .. this works by spawning a placeable at the player's feet
// .. and populating it with items from a nearby hidden container
// .. (magic items are only copied if the player passed a skill check)

int IsMagic(object oItem)
{
    itemproperty nProp = GetFirstItemProperty(oItem);
    return (GetIsItemPropertyValid(nProp));
}

void MoveInventory(object oSource, object oDest, int nAll)
{
    object o = GetFirstItemInInventory(oSource);
    while (GetIsObjectValid(o))
    {
        if (nAll || !IsMagic(o))
        {
            CopyItem(o, oDest, TRUE);
            DestroyObject(o);
        }
        o = GetNextItemInInventory(oSource);
    }
}

void main()
{
    object oPC = GetPCSpeaker();
    int nPrice = GetLocalInt(OBJECT_SELF, "PRICE");
    if (GetGold(oPC) >= nPrice)
    {
        string sTag = "pl_torleth_" + IntToString(nPrice);
        object oTable = GetNearestObjectByTag(sTag, OBJECT_SELF);
        if (GetIsObjectValid(oTable))
        {
            int nAll = GetLocalInt(OBJECT_SELF, "HF_ARG"); // true if player searched
            object oInv = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_torleth", GetLocation(oPC));
            SetLocalInt(oInv, "PRICE", nPrice);
            SetLocalObject(oInv, "SOURCE", oTable);
            MoveInventory(oTable, oInv, nAll);
            DelayCommand(0.25, AssignCommand(oPC, ActionInteractObject(oInv)));
        }
    }
    else
    {
        AssignCommand(oPC, PlaySound("gui_error"));
        AssignCommand(oPC, ActionSpeakString("... I don't have enough gold to shop here ..."));
    }
}
