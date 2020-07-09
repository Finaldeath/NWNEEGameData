//October 2005
//B W-Husey
//Creates miscellaneous treasure in container.
// Can be jewelry, wizardry, misc or clothing.  Usually level 2
// Gold plus chance of gems.

#include "CU_FUNCTIONS"
#include "x2_inc_compon"
#include "CU_MAGICSPECIFIC"
#include "CU_Treasure"

void main()
{
int nEmptied;
if (GetLocalInt(OBJECT_SELF,"nEmptied")<1)
    {
    object oPC = GetLastOpenedBy();
//==========This section places treasure in the container
    int nRand = Random(20);
    if (nRand<9) GetTreasureType("Jewelry", OBJECT_SELF, 100, 2);
    else if (nRand<13)  GetTreasureType("Clothing", OBJECT_SELF, 100, 2);
    else if (nRand<18)  GetTreasureType("Misc", OBJECT_SELF, 100, 2);
    else if (nRand<20)  GetTreasureType("Wizardry", OBJECT_SELF, 100, 2);

        //**************Debug lines***********
       /* if (nRand<9)SendMessageToPC(GetFirstPC(),"Type: Jewelry");
        else if (nRand<13) SendMessageToPC(GetFirstPC(),"Type: Clothing");
        else if (nRand<18)SendMessageToPC(GetFirstPC(),"Type: Misc");
        else if (nRand<20)SendMessageToPC(GetFirstPC(),"Type: Wizardry");
         */
    GetTreasure("Gold10",OBJECT_SELF,100,d6()*10);  //1-10+10-60 gold
    GetTreasure("Gem",OBJECT_SELF,15);  //15% chance of gems
    SetLocalInt(OBJECT_SELF,"nEmptied",1);   // Container has been raided
    }
    if (GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE) craft_drop_placeable(); //Can be broken for crafting item
}
