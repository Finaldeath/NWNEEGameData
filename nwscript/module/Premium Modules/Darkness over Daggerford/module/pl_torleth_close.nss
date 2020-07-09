// player has closed the torleth's table
// .. copy items back to the real table

void DeleteInventory(object oContainer)
{
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oContainer);
    }
}

void main()
{
    // copy any remaining items from here back source table
    object oSource = GetLocalObject(OBJECT_SELF, "SOURCE");
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oItem))
    {
        CopyItem(oItem, oSource, TRUE);
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    // delete the contents from here
    DeleteInventory(OBJECT_SELF);
    DestroyObject(OBJECT_SELF);
}
