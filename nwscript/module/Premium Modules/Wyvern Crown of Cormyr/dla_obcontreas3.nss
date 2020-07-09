//October 2005
//B W-Husey
//Creates miscellaneous treasure in container. Gold and gems. Lots of it.

#include "CU_FUNCTIONS"
#include "CU_TREASURE"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
//==========This section places treasure in the container
    GetTreasure("Gold100",OBJECT_SELF,100,250+d6()*100);  //1-100+350-850 gold
    GetTreasure("Gem",OBJECT_SELF,85);  //25% chance of gems
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
