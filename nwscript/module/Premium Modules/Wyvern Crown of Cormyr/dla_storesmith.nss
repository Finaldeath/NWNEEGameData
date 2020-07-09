// October 2005
// B W-Husey
// Generates Store contents, plus chance of new stock each day.
// This store is not meant to be a major source of magic.

#include "CU_MAGIC"
#include "CU_MAGICVARIABLE"
#include "CU_MAGICSPECIFIC"

void main()
{
int nDay = GetCalendarDay();         //Store today
// If not done this routine today, do it now
if (GetLocalInt(OBJECT_SELF,"StoreDay") != nDay)
{
    if (GetLocalInt(OBJECT_SELF,"StoreDone") == 0) // the first time the store gets its contents
    {
    int counter=d3()+2;   //this is used to generate a number of each basic type
    int iNumb=0;
    //======================From libraries
    while (iNumb<counter)
            {
            GetMagic("Weapon1", OBJECT_SELF, 30);
            GetMagic("Weapon2", OBJECT_SELF, 10);
            GetMagic("Armour1", OBJECT_SELF, 30);
            GetMagic("Armour2", OBJECT_SELF, 10);
            GetVariable("Weapon",OBJECT_SELF,20,0,0,1);
            GetVariable("Weapon",OBJECT_SELF,20,0,0,2);
            GetVariable("Weapon",OBJECT_SELF,15,0,0,3);
            GetVariable("Armour",OBJECT_SELF,20,0,0,1);
            GetVariable("Armour",OBJECT_SELF,5,0,0,d4());
            iNumb ++;
            }
            iNumb = 0;
    //======================From cu_magicspecific
    GetTreasureType("Jewelry",OBJECT_SELF,100,1,5);
    GetTreasureType("Weapon",OBJECT_SELF,100,1,2);
//    GetTreasureType("Weapon",OBJECT_SELF,100,2,d2());
//    GetTreasureType("Weapon",OBJECT_SELF,50,3,3);
    GetTreasureType("Armour",OBJECT_SELF,100,1,1);
    GetTreasureType("Armour",OBJECT_SELF,50,d3(),1);
    }//end of first stocking if
    else  //chance of new stock each day
    {

       object oNumber =GetFirstItemInInventory(OBJECT_SELF);
       int nNumber = 1;
      while (GetIsObjectValid(oNumber) == TRUE)          //Count the items in store
      {
          oNumber =GetNextItemInInventory(OBJECT_SELF);
          nNumber += 1;
      }

       // This section removes stock from the store - DO NOT USE ON STORES WITH ESSENTIAL ITEMS IN THEM
       // like resurrect scrolls or restorations for example.
        object oItem;
        int nDestroy = Random(nNumber)+1;    //destroy a random numbered item
        int nCounter = 0;
          while (nCounter<nDestroy)                    // find the item
          {
            oItem =GetNextItemInInventory(OBJECT_SELF);
            nCounter += 1;
          }
        DestroyObject(oItem);              // destroy it

        if (nNumber<150){  //set the upper limit you want in the store in case it gets ridiculously crowded.
        GetTreasureType("Jewelry",OBJECT_SELF,5,1,1);  //generate new items for today's stock
        GetTreasureType("Jewelry",OBJECT_SELF,3,2,1);
        GetTreasureType("Jewelry",OBJECT_SELF,2,3,1);
        GetTreasureType("Weapon",OBJECT_SELF,7,1,1);
        GetTreasureType("Weapon",OBJECT_SELF,5,2,1);
        GetTreasureType("Weapon",OBJECT_SELF,2,3,1);
        GetTreasureType("Weapon",OBJECT_SELF,1,4,1);
//        GetVariable("Weapon",OBJECT_SELF,50,0,0,2);
        GetVariable("Weapon",OBJECT_SELF,5,0,0,d6());
        GetMagic("Weapon1", OBJECT_SELF, 5);
        GetMagic("Weapon2", OBJECT_SELF, 10);
        GetMagic("Armour1", OBJECT_SELF, 8);
        GetMagic("Armour2", OBJECT_SELF, 10);
        GetTreasureType("Armour",OBJECT_SELF,10,1,1);
        GetTreasureType("Armour",OBJECT_SELF,5,d3(),1);
        }
    }//end of stocking on new days
} //end of nDay if
SetLocalInt( OBJECT_SELF,"StoreDay",nDay);
}
