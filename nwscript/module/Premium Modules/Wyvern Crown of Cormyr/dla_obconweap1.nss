//B W-Husey
//October 2005
// Generic container script for weapon racks and such. Slightly magic items.

#include "cu_magic"
#include "cu_magicspecific"
#include "cu_magicvariable"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetTreasureType("Weapon",OBJECT_SELF,80);
    GetVariable("Weapon",OBJECT_SELF,100,0,0,1);
    GetVariable("Weapon",OBJECT_SELF,30,0,0,1);
    GetVariable("Weapon",OBJECT_SELF,50,0,0,d2());
    GetMagic("Weapon1",OBJECT_SELF,30);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);}
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable();
    }
