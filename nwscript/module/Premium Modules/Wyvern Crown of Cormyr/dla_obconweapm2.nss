//October 2005
//B W-Husey
//Creates miscellaneous weapon in container.

#include "x2_inc_compon"
#include "CU_MAGICSPECIFIC"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
//==========This section places treasure in the container
    GetTreasureType("Weapon",OBJECT_SELF,100,2);  //'lvl 2' magic weapon
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
