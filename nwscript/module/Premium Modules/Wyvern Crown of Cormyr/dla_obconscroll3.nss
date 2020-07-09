//October 2005
//B W-Husey
//Container contains Higher level scrolls.


#include "cu_Magic"
#include "x2_inc_compon"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1){
    GetMagic("Scrolls12",OBJECT_SELF,30);  //
    GetMagic("Scrolls34",OBJECT_SELF,30);  //
    GetMagic("Scrolls56",OBJECT_SELF,100);  //
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
