// destroy this object on close if it's empty
// -Brian Watson

void main()
{
    object oItem = GetFirstItemInInventory();

    if (!GetIsObjectValid(oItem))
    {
        DestroyObject(OBJECT_SELF);
    }
}
