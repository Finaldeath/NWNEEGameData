// October 2005
// B W-Husey
// Generates Store contents.

#include "CU_TREASURE"
#include "CU_MAGIC"
#include "CU_MAGICVARIABLE"
#include "CU_MAGICSPECIFIC"

void main()
{
    //int nDay = GetCalendarDay();         //Store today
    if (GetLocalInt(OBJECT_SELF,"StoreDone") == 0) // the first time the store gets its contents
    {
    //This store carries:
    // A few miscellaneous items and chance of minor jewelry
    //======================From cu_treasure
    int counter=d3()+2;   //this is used to generate a number of each basic type
    int iNumb;
    while (iNumb<counter*2)
            {
            GetTreasure("Misc", OBJECT_SELF, 100);
            iNumb ++;
            }
            iNumb = 0;
    while (iNumb<counter)
            {
            GetTreasure("Minor", OBJECT_SELF, 80);
            iNumb ++;
            }
            iNumb = 0;
    //======================From cu_magicspecific
    GetTreasureType("Jewelry",OBJECT_SELF,100,1,2);
    GetTreasureType("Jewelry",OBJECT_SELF,20,2,d3());
    GetTreasureType("Misc",OBJECT_SELF,80,1,1);
    GetTreasureType("Ammo",OBJECT_SELF,20,1,1);
    GetTreasureType("Clothing",OBJECT_SELF,50,d2(),d2());
    GetTreasureType("Misc",OBJECT_SELF,30,1,d3());
    GetTreasureType("Wizardry",OBJECT_SELF,20,1,1);
    }//end of first stocking if
    SetLocalInt( OBJECT_SELF,"StoreDone",1);
}
