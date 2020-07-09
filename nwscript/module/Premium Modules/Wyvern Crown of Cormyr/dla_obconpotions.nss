//October 2005
//B W-Husey
//Creates miscellaneous treasure in container. Gold and gems.
// Search dependent lucky find of minor treasure.

#include "CU_MAGIC"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetMagic("Potions",OBJECT_SELF,100);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
