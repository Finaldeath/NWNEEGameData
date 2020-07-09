//B W-Husey
//October 2005
// Generic container script for weapon racks and such

#include "CU_TREASURE"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetTreasure("Weapon",OBJECT_SELF,100);
    GetTreasure("Weapon",OBJECT_SELF,100);
    GetTreasure("Weapon",OBJECT_SELF,80);
    GetTreasure("Weapon",OBJECT_SELF,60);
    GetTreasure("Weapon",OBJECT_SELF,40);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);}
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable();
    }
