/*
    DLA_AREAXCLEANUP.nss
    gaoneng erick
    july 27, 2006

    called from area's OnExit
    search area for leftover bodybags and destroy them
*/
#include "cu_functions"

// destroy all items in target's inventory
void dla_ClearInventory(object target);

void main()
{
    // check if exiting object is pc
    object pc = GetExitingObject();
    if (!GetIsDefPC(pc)) return;

    object area = OBJECT_SELF;
    object lootbag = GetFirstObjectInArea(area);
    while (GetIsObjectValid(lootbag))
    {
        // check if object is a BodyBag or a dead hostile creature
        if ((GetTag(lootbag) == "BodyBag") ||
            (GetObjectType(lootbag) == OBJECT_TYPE_CREATURE &&
             GetIsDead(lootbag) &&
             GetIsEnemy(pc, lootbag)))
        {
            dla_ClearInventory(lootbag);
            DestroyObject(lootbag);
        }
        lootbag = GetNextObjectInArea(area);
    }
}

void dla_ClearInventory(object target)
{
    object item, subitem;
    item = GetFirstItemInInventory(target);
    while (GetIsObjectValid(item))
    {
        if (GetHasInventory(item)) // check if item is container
        {
            subitem = GetFirstItemInInventory(item);
            while (GetIsObjectValid(subitem))
            {
                DestroyObject(subitem);
                subitem = GetNextItemInInventory(item);
            }
        }
        DestroyObject(item);
        item = GetNextItemInInventory(target);
    }
}
