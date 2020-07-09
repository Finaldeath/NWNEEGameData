#include "inc_id1_debug"
#include "inc_id1_items"

void main()
{
    object oItem = GetLocalObject(OBJECT_SELF, "oItem");
    string sName = GetName(oItem);
    string sTag = GetTag(oItem);

    DebugMessage("");
    DebugMessage("Naming bas item " + sName + " with tag " + sTag);
    SetItemName(oItem);

    DestroyObject(OBJECT_SELF);
}
