//January 2006
//B W-Husey
//Creates miscellaneous treasure in container.
// Ammo.  Usually level 1

#include "x2_inc_compon"
#include "CU_MAGICSPECIFIC"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1)
    {
    object oPC = GetLastOpenedBy();
//==========This section places treasure in the container
    GetTreasureType("Ammo", OBJECT_SELF, 100, 1);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
