// November 2005
// B W-Husey
// Generates Store contents, plus chance of new stock each day.
// This is Six Coffers store - Expensive, but can have the best.

#include "CU_TREASURE"
#include "CU_MAGIC"
#include "CU_MAGICSPECIFIC"
#include "CU_MAGICVARIABLE"

void main()
{
int nDay = GetCalendarDay();         //Store today
// If not done this routine today, do it now
if (GetLocalInt(OBJECT_SELF,"StoreDay") != nDay)
{
    if (GetLocalInt(OBJECT_SELF,"StoreDone") == 0) // the first time the store gets its contents
    {
    int counter=d3()+1;   //this is used to generate a number of each basic type
    int iNumb=0;
    //======================From libraries
    while (iNumb<counter*2)
            {
            GetTreasure("Misc");
            GetTreasure("Armour");
            GetTreasure("Weapon");
            GetMagic("Major",OBJECT_SELF,50);
            GetMagic("Potions",OBJECT_SELF,100);
            GetMagic("Scrolls12",OBJECT_SELF,50);
            iNumb ++;
            }
            iNumb = 0;

            GetMagic("Weapon2", OBJECT_SELF, 100);
            GetMagic("Armour2", OBJECT_SELF, 100);
            GetMagic("Weapon1", OBJECT_SELF, 100);
            GetMagic("Armour1", OBJECT_SELF, 100);
            GetMagic("Scrolls34",OBJECT_SELF,100);
            GetMagic("Scrolls56",OBJECT_SELF,100);

    //======================From cu_magicspecific

    GetTreasureType("Jewelry",OBJECT_SELF,100,1,3);
    GetTreasureType("Jewelry",OBJECT_SELF,100,2,2);
    GetTreasureType("Jewelry",OBJECT_SELF,100,3,1);
    GetTreasureType("Clothing",OBJECT_SELF,100,2,1);
    GetTreasureType("Clothing",OBJECT_SELF,100,1,1);
    GetTreasureType("Clothing",OBJECT_SELF,100,3,1);
    GetTreasureType("Clothing",OBJECT_SELF,100,4,1);
    GetTreasureType("Misc",OBJECT_SELF,100,1,1);
    GetTreasureType("Misc",OBJECT_SELF,100,2,1);
    GetTreasureType("Misc",OBJECT_SELF,100,3,1);
    GetTreasureType("Wizardry",OBJECT_SELF,50,1,1);
    GetTreasureType("Wizardry",OBJECT_SELF,50,2,1);
    GetTreasureType("Wizardry",OBJECT_SELF,50,3,1);
    GetTreasureType("Ammo",OBJECT_SELF,100,1,3);
    GetTreasureType("Ammo",OBJECT_SELF,100,2,1);
    GetTreasureType("Weapon",OBJECT_SELF,100,1,2);
    GetTreasureType("Weapon",OBJECT_SELF,100,2,1);
    GetTreasureType("Weapon",OBJECT_SELF,100,3,1);
    GetTreasureType("Weapon",OBJECT_SELF,100,4,1);
    GetTreasureType("Armour",OBJECT_SELF,100,1,1);
    GetTreasureType("Armour",OBJECT_SELF,50,2,1);
    GetTreasureType("Armour",OBJECT_SELF,50,3,1);

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

        if (nNumber<200){  //set the upper limit you want in the store in case it gets ridiculously crowded.
        GetTreasureType("Jewelry",OBJECT_SELF,7,1,1);  //generate new items for today's stock
        GetTreasureType("Jewelry",OBJECT_SELF,4,2,1);
        GetTreasureType("Jewelry",OBJECT_SELF,2,3,1);
        GetTreasureType("Weapon",OBJECT_SELF,7,1,1);
        GetTreasureType("Weapon",OBJECT_SELF,5,2,1);
        GetTreasureType("Weapon",OBJECT_SELF,2,3,1);
        GetTreasureType("Weapon",OBJECT_SELF,2,4,1);
        GetTreasureType("Armour",OBJECT_SELF,10,1,1);
        GetTreasureType("Armour",OBJECT_SELF,10,d3(),1);
        GetTreasureType("Clothing",OBJECT_SELF,8,1,1);
        GetTreasureType("Clothing",OBJECT_SELF,5,2,1);
        GetTreasureType("Clothing",OBJECT_SELF,8,3,1);
        GetTreasureType("Clothing",OBJECT_SELF,8,4,1);
        GetTreasureType("Misc",OBJECT_SELF,8,1,1);
        GetTreasureType("Misc",OBJECT_SELF,5,2,1);
        GetTreasureType("Misc",OBJECT_SELF,3,3,1);
        GetTreasureType("Wizardry",OBJECT_SELF,2,1,1);
        GetTreasureType("Wizardry",OBJECT_SELF,1,2,1);
        GetTreasureType("Wizardry",OBJECT_SELF,1,3,1);
        GetTreasureType("Ammo",OBJECT_SELF,20,1,1);
        GetTreasureType("Ammo",OBJECT_SELF,10,2,1);
        GetTreasureType("Ammo",OBJECT_SELF,10,3,1);
        GetTreasure("Potions",OBJECT_SELF,15);
        }
    }//end of stocking on new days
} //end of nDay if
SetLocalInt( OBJECT_SELF,"StoreDay",nDay);
}
