/*
    GN_C_LOOTBAG.NSS
    gaoneng erick               may 6, 2006

    All inventory items sans armour on the creature executing this script will
    get transferred to a newly created lootbag nearby.

    This is to facilitate looting of henchmen inventory when they die.
*/

// PATCH 1 Version History
//::mm/dd/yyyy | MODIFIED BY           | DESCRIPTION
//::===========|=======================|========================================
//::10/11/2006 | Deva B. Winblood      | Fix for #2137 duplicate items in bags
//             |                       | and bags not being copied as well.

void main()
{
    object self = OBJECT_SELF;
    object area = GetArea(self);
    vector pos = GetPosition(self) + 1.2*AngleToVector(GetFacing(self) + IntToFloat(Random(180) - 90)); // generate a random loc that is 1.2 meter away
    object lootbag = CreateObject(OBJECT_TYPE_PLACEABLE, "gn_p_lootbag", Location(area, pos, 0.0)); // create the lootbag placeable
    SetName(lootbag, GetName(self) + "'s Lootbag"); // Add creature name to name of lootbag

    object item = GetFirstItemInInventory(self);
    object content;
    while (GetIsObjectValid(item)) // start copying items over
    {
        if (GetHasInventory(item)) // if item is a container, e.g. magic bag, then we need to clear its content first
        {
            content = GetFirstItemInInventory(item);
            while (GetIsObjectValid(content))
            {
                if (!GetLocalInt(content,"bCopied")) CopyItem(content, lootbag, TRUE);
                SetLocalInt(content,"bCopied",TRUE);
                DestroyObject(content);
                content = GetNextItemInInventory(item);
            }
            CopyItem(item, lootbag,TRUE);
            DestroyObject(item);
        }
        else
        {
          if (!GetLocalInt(item,"bCopied")) CopyItem(item, lootbag, TRUE);
          SetLocalInt(item,"bCopied",TRUE);
          DestroyObject(item);
        }
        item = GetNextItemInInventory(self);
    }
    int i;
    for (i = 0; i < 14; i++) // remove all equipped item except for armor and creature items
    {
        item = GetItemInSlot(i, self);
        if (i != 1 && GetIsObjectValid(item))
        {
            CopyItem(item, lootbag, TRUE);
            DestroyObject(item);
        }
    }
    i = GetGold(self);
    if (i)
    {
        CreateItemOnObject("nw_it_gold001", lootbag, i);
        TakeGoldFromCreature(i, self, TRUE);
    }
}
