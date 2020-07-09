//::///////////////////////////////////////////////
//:: PotSC - StoreOpen Booty Items
//:: sop_booty_items.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Add booty list items to the store according
     to variable on the store object.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 6, 2005
//:://////////////////////////////////////////////
#include "inc_storesystem"
#include "inc_genbooks"
#include "inc_genscrolls"

void main()
{
    int iGenerics = GetLocalInt(OBJECT_SELF, "iBOOTY_GENERIC");
    int iUniques = GetLocalInt(OBJECT_SELF, "iBOOTY_UNIQUE");
    int iBooks = GetLocalInt(OBJECT_SELF, "iBOOTY_BOOKS");
    int iScrolls = GetLocalInt(OBJECT_SELF, "iBOOTY_SCROLLS");
    int iGenericCounter = 0;
    int iUniqueCounter = 0;
    int bDoOnce = GetLocalInt(OBJECT_SELF, "bDoOnce");

    if (bDoOnce == FALSE)
    {
        //Loop through the booty list and generate generics...
        while (iGenericCounter < iGenerics)
        {
            //Create the booty item.
            CreateBootyOnObject(OBJECT_SELF, BOOTY_GENERIC);

            //Increment the counter.
            iGenericCounter++;
        }
        //Loop through the booty list and generate uniques...
        while (iUniqueCounter < iUniques)
        {
            //Create the booty item.
            CreateBootyOnObject(OBJECT_SELF, BOOTY_UNIQUE);

            //Increment the counter.
            iUniqueCounter++;
        }

        //Generate a random number of books, with iBooks being the maximum...
        CreateBooksOnObject(OBJECT_SELF, iBooks);

        //Generate a random number of scrolls, with iScrolls being the maximum...
        CreateScrollsOnObject(OBJECT_SELF, iScrolls);

        //Flag the DoOnce.
        SetLocalInt(OBJECT_SELF, "bDoOnce", TRUE);
    }
}
