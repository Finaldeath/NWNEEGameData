//B W-Husey
//October 2005
// Generic container script for armour racks and such.

#include "cu_magicspecific"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetTreasureType("Armour",OBJECT_SELF,100,1);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);}
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable();
    }
