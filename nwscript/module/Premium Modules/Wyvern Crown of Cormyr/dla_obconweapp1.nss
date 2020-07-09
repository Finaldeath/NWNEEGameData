//B W-Husey
//October 2005
// Generic container script for weapon racks and such. Slightly magic items.

#include "cu_magic"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetMagic("Weapon1",OBJECT_SELF,100);
    SetLocalInt(OBJECT_SELF,"nEmptied",1);}
    }
