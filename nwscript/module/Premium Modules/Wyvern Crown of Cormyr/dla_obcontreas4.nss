//October 2005
//B W-Husey
//Creates miscellaneous treasure in container. Gold and gems. Chance of major random item.

#include "CU_FUNCTIONS"
#include "CU_TREASURE"
#include "CU_MAGIC"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
//==========This section places treasure in the container
    GetTreasure("Gold100",OBJECT_SELF,100,100);  //1-200 gold
    GetTreasure("Gem",OBJECT_SELF,25);  //25% chance of gems
    GetMagic("Major",OBJECT_SELF,100);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
