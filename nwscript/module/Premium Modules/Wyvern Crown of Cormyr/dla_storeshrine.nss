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

if (GetLocalInt(OBJECT_SELF,"StoreDay") == nDay) return;
// If not done this routine today, do it now
if (GetLocalInt(OBJECT_SELF,"StoreDay") != nDay)
{
    if (GetLocalInt(OBJECT_SELF,"StoreDone") == 0) // the first time the store gets its contents
    {
    //This store carries:
    // minor jewelry, weaponry (mostly non-magic), some armour (minor), potions & scrolls.
    int counter=d4()+1;   //this is used to generate a number of each basic type
    int iNumb=0;
    //======================From cu_treasure
    while (iNumb<counter*2)
            {
            GetTreasure("Weapon", OBJECT_SELF, 100);
            iNumb ++;
            }
            iNumb = 0;
    while (iNumb<counter)
            {
            GetTreasure("Armour", OBJECT_SELF, 100);
            iNumb ++;
            }
            iNumb = 0;
    //======================From cu_magic
    counter=d3()+2;   //this is used to generate a number of each basic type
    while (iNumb<counter*2)
            {
            GetMagic("Potions", OBJECT_SELF, 100);
            GetMagic("Scrolls12", OBJECT_SELF, 100);
            GetMagic("Scrolls34", OBJECT_SELF, 100);
            GetMagic("Scrolls56", OBJECT_SELF, 100);
            iNumb ++;
            }
            iNumb = 0;
    GetMagic("Weapon1", OBJECT_SELF, 100);
    GetMagic("Weapon1", OBJECT_SELF, 70);
    GetMagic("Weapon2", OBJECT_SELF, 20);
    GetMagic("Armour1", OBJECT_SELF, 70);
    GetMagic("Armour2", OBJECT_SELF, 10);
    //======================From cu_magicvariable
    GetVariable("Weapon",OBJECT_SELF,50,0,0,1);
    GetVariable("Weapon",OBJECT_SELF,30,0,0,2);
    GetVariable("Weapon",OBJECT_SELF,15,0,0,3);
    GetVariable("Armour",OBJECT_SELF,80,0,0,1);
    GetVariable("Armour",OBJECT_SELF,30,0,0,d4());
    //======================From cu_magicspecific
    GetTreasureType("Jewelry",OBJECT_SELF,100,1,3);
    GetTreasureType("Jewelry",OBJECT_SELF,100,2,3);
    GetTreasureType("Jewelry",OBJECT_SELF,80,3,1);
    GetTreasureType("Weapon",OBJECT_SELF,100,1,1);
    GetTreasureType("Weapon",OBJECT_SELF,100,2,1);
    GetTreasureType("Weapon",OBJECT_SELF,50,3,1);
    GetTreasureType("Weapon",OBJECT_SELF,10,4,1);

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
        if (nNumber<150){  //set the upper limit you want in the store in case it gets ridiculously crowded.
        GetTreasureType("Jewelry",OBJECT_SELF,10,1,1);  //generate new items for today's stock
        GetTreasureType("Jewelry",OBJECT_SELF,6,2,1);
        GetTreasureType("Jewelry",OBJECT_SELF,5,3,1);
        GetTreasureType("Weapon",OBJECT_SELF,8,2,1);
        GetTreasureType("Weapon",OBJECT_SELF,5,2,1);
        GetTreasureType("Weapon",OBJECT_SELF,2,2,1);
        GetTreasureType("Weapon",OBJECT_SELF,1,2,1);
//        GetVariable("Weapon",OBJECT_SELF,20,0,0,d6());
        GetMagic("Weapon1", OBJECT_SELF, 30);
        GetMagic("Potions", OBJECT_SELF, 20);
        GetMagic("Scrolls12", OBJECT_SELF, 20);
        GetMagic("Scrolls34", OBJECT_SELF, 10);
        GetMagic("Scrolls56", OBJECT_SELF, 10);
        }
    }//end of stocking on new days
} //end of nDay if
SetLocalInt( OBJECT_SELF,"StoreDay",nDay);
}
