// October 2005
// B W-Husey
// Generates Store contents (once only)

#include "CU_TREASURE"
#include "CU_MAGIC"
#include "CU_MAGICVARIABLE"
#include "CU_MAGICSPECIFIC"

void main()
{
    int nDay = GetCalendarDay();         //Store today
    if (GetLocalInt(OBJECT_SELF,"StoreDone") == 0) // the first time the store gets its contents
    {
    //This store carries:
    // A few miscellaneous items, chance of minor jewelry, potions, scrolls, books, wizardry, clothing
    //======================From cu_treasure
    int counter=d3()+2;   //this is used to generate a number of each basic type
    int iNumb;
    while (iNumb<counter)
            {
            GetTreasure("Misc", OBJECT_SELF, 100);
            iNumb ++;
            }
            iNumb = 0;
    while (iNumb<counter)
            {
            GetTreasure("Minor", OBJECT_SELF, 80);
            GetMagic("Scrolls1");
            GetMagic("Scrolls12");
            GetMagic("Scrolls34");
            GetMagic("Scrolls56");
            iNumb ++;
            }
            iNumb = 0;
    //======================From cu_magicspecific
    GetTreasureType("Jewelry",OBJECT_SELF,100,1,2);
    GetTreasureType("Jewelry",OBJECT_SELF,100,d2()+1,d2());
    GetTreasureType("Misc",OBJECT_SELF,100,1,d3());
    GetTreasureType("Misc",OBJECT_SELF,100,2,1);
    GetTreasureType("Clothing",OBJECT_SELF,100,d2(),d2());
    GetTreasureType("Clothing",OBJECT_SELF,100,d2(),d2());
    GetTreasureType("Misc",OBJECT_SELF,50,d3(),1);
    GetTreasureType("Wizardry",OBJECT_SELF,100,1,1);
    GetTreasureType("Wizardry",OBJECT_SELF,100,2,1);
    GetVariable("Weapon",OBJECT_SELF,100,0,0,1);
    GetVariable("Weapon",OBJECT_SELF,100,0,0,d3());
    GetMagic("Potions");
    GetMagic("Potions");
    }//end of first stocking if
    SetLocalInt( OBJECT_SELF,"StoreDone",nDay);
}
