// destroy this object on close if it's empty

void main()
{
    object oItem = GetFirstItemInInventory();
    if (!GetIsObjectValid(oItem))
    {
        DestroyObject(OBJECT_SELF);
    }
}
