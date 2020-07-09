// October 2005
// B W-Husey
// Generates Store contents, plus chance of new stock each day

#include "CU_TREASURE"
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
            GetMagic("Potions",OBJECT_SELF,10);
            iNumb ++;
            }
            iNumb = 0;
    //======================From cu_magicspecific
    GetTreasureType("Jewelry",OBJECT_SELF,100,1,2);
    GetTreasureType("Jewelry",OBJECT_SELF,20,2,1);
    GetTreasureType("Misc",OBJECT_SELF,80,1,1);
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
    /*
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
    */
        if (nNumber<100){  //set the upper limit you want in the store in case it gets ridiculously crowded.
        GetTreasure("Misc", OBJECT_SELF, 100);  //generate new items for today's stock
        GetTreasureType("Jewelry",OBJECT_SELF,15,1,2);
        GetTreasureType("Jewelry",OBJECT_SELF,10,2,1);
        GetTreasureType("Misc",OBJECT_SELF,30,1,1);
        GetMagic("Potions",OBJECT_SELF,10);
        }
    }//end of stocking on new days
} //end of nDay if
SetLocalInt( OBJECT_SELF,"StoreDay",nDay);
}
