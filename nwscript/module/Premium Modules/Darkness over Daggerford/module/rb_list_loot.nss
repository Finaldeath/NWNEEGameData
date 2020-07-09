#include "rb_treasure_inc"

string GetLootClasses(int iLootMask)
{
    int i = 0;
    int nTranslatedClass;

    string sClasses = "";

    //For each PC class, convert it to its binary mask equivalent and check if
    //it is contained in the supplied iLootMask
    for(i = 0; i < 11; i++)
    {
        nTranslatedClass = TranslateLootClass(i);
        if(GetLootState(nTranslatedClass, iLootMask))
        {
            sClasses = sClasses + "Y";
        }
        else
        {
            sClasses = sClasses + "N";
        }
        if(i < 10)
            sClasses = sClasses + ",";
    }

    return sClasses;
}

//Written as : Area, Inventory Owner, Inventory Item, Value, Class List
void PrintCSVRecord(string sArea, object oInv, object oItem,
                    string sLootMask = "Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y")
{
    string droppable = "N";
    string rec = "";

    if(GetObjectType(oInv) == OBJECT_TYPE_PLACEABLE ||
       GetDroppableFlag(oItem))
    {
        droppable = "Y";
    }

    rec = sArea + "," + GetName(oInv) + "," + GetName(oItem) + "," +
          IntToString(GetGoldPieceValue(oItem)) + "," + sLootMask;

    PrintString(rec);
}

//Written as : Area, Inventory Owner, Inventory Item, Value, Class List
void PrintCSVGoldRecord(string sArea, object oInv, int nGold,
                        string sLootMask = "Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y")
{
    string rec = "";

    rec = sArea + "," + GetName(oInv) + "," + "Gold Coins" + "," +
          IntToString(nGold) + "," + sLootMask;

    PrintString(rec);
}

//We don't want to count creature items set to droppable on spawn twice so
//check if the item is going to be logged as part of class item analysis
int IsClassItem(object oOwner, object oItem)
{
    int i = 1;
    int iFound = 0;

    string sLootClass = "RB_LOOTCLASS_" + IntToString(i);
    string sLoot = "RB_LOOT_" + IntToString(i);
    string sLootItem = GetLocalString(oOwner, sLoot);

    while(sLootItem != "")
    {
        sLootItem = GetLocalString(oOwner, "RB_LOOT_" + IntToString(i));
        if(sLootItem != "")
        {
            if(GetTag(oItem) == sLootItem)
            {
                iFound = 1;
                break;
            }
        }
        else
        {
            //PrintString("No item found on object for variable " + sLoot);
        }
        i++;
        sLoot = "RB_LOOT_" + IntToString(i);
        sLootItem = GetLocalString(oOwner, sLoot);
    }

    return iFound;
}

void main()
{
    int nClassTotal;
    int nGold;
    int nItemCount;
    int nSlot;
    int nTotal;

    object oArea = GetArea(GetPCSpeaker());
    object oItem;
    object oObject = GetFirstObjectInArea(oArea);

    string sAllClasses = "Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y";
    string sArea = GetName(oArea);

    PrintString("Inventory items in Area " + sArea);
    //PrintString("----------------------------------------");

    while(GetIsObjectValid(oObject))
    {
        nItemCount = 0;
        if(GetObjectType(oObject) == OBJECT_TYPE_ITEM)
        {
            oItem = GetObjectByTag(GetTag(oObject));
            SetIdentified(oItem, TRUE);
            nTotal += GetGoldPieceValue(oItem);
            PrintCSVRecord(sArea, oObject, oItem);
        }
        else
        if(GetHasInventory(oObject) && !GetIsPC(oObject) &&
           GetAssociateType(oObject) == ASSOCIATE_TYPE_NONE &&
           GetObjectType(oObject) != OBJECT_TYPE_STORE)
        {
            //PrintString("Object is " + GetName(oObject));
            object oItem = GetFirstItemInInventory(oObject);
            while (GetIsObjectValid(oItem) == TRUE)
            {
                if(GetName(oItem) != "Gold Piece")
                {
                    nItemCount++;
                    SetIdentified(oItem, TRUE);
                    // PrintString("Item = " + GetName(oItem) +
                    //             ", value = " + IntToString(GetGoldPieceValue(oItem)));
                    if(GetObjectType(oObject) == OBJECT_TYPE_CREATURE &&
                       GetDroppableFlag(oItem) && !IsClassItem(oObject, oItem))
                    {
                        PrintCSVRecord(sArea, oObject, oItem);
                    }
                    else
                    if(GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
                    {
                        PrintCSVRecord(sArea, oObject, oItem);
                    }

                    if((GetObjectType(oObject) == OBJECT_TYPE_CREATURE &&
                        GetDroppableFlag(oItem) &&
                        !IsClassItem(oObject, oItem)) ||
                        GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
                    {
                        nTotal += GetGoldPieceValue(oItem);
                    }
                }

                oItem = GetNextItemInInventory(oObject);
             }
             //Ignore creature inventory items
             for(nSlot = INVENTORY_SLOT_HEAD; nSlot<INVENTORY_SLOT_CWEAPON_L; nSlot++)
             {
                 oItem=GetItemInSlot(nSlot, oObject);
                 if(oItem != OBJECT_INVALID)
                 {
                    nItemCount++;
                    SetIdentified(oItem, TRUE);

                    if(GetDroppableFlag(oItem) && !IsClassItem(oObject, oItem))
                    {
                        //PrintString("Equipped Item = " + GetName(oItem) +
                        //            ", value = " + IntToString(GetGoldPieceValue(oItem)));
                        PrintCSVRecord(sArea, oObject, oItem);
                        nTotal += GetGoldPieceValue(oItem);
                    }
                    else
                    {
                        //PrintString("Non droppable item - " + GetName(oItem));
                    }
                 }
             }

             //Determine any gold in inventory
             if(GetObjectType(oObject) == OBJECT_TYPE_CREATURE ||
                GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
             {
                 nGold = GetGold(oObject);
                 if(nGold > 0)
                 {
                     nItemCount++;
                     PrintCSVGoldRecord(sArea, oObject, nGold);
                     nTotal += nGold;
                    // PrintString("Has " + IntToString(nGold) + " gold pieces");
                 }
             }

             //Determine any class-specific items in inventory
            int i = 1;

            string sClasses = "";
            string sLootClass = "RB_LOOTCLASS_" + IntToString(i);
            string sLoot = "RB_LOOT_" + IntToString(i);
            string sLootItem = "";

            int iLootMask = GetLocalInt(oObject, sLootClass);

            //Create each item and record which classes it will be generated for
            while(iLootMask != 0)
            {
                sLootItem = GetLocalString(oObject, "RB_LOOT_" + IntToString(i));
                if(sLootItem != "")
                {
                    nItemCount++;
                    if(GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
                    {
                        oItem = CreateItemOnObject(sLootItem, oObject);
                    }
                    else
                    {
                        oItem = GetItemPossessedBy(oObject, sLootItem);
                        if(oItem == OBJECT_INVALID)
                        {
                            oItem = CreateItemOnObject(sLootItem, oObject);
                        }
                    }
                    //PrintString("oItem = " + sLootItem + " - " + GetName(oItem));
                    SetIdentified(oItem, TRUE);
                    nClassTotal += GetGoldPieceValue(oItem);
                }
                else
                {
                    PrintString("No item found on object for variable " + sLootItem);
                }

                sClasses = GetLootClasses(iLootMask);
                PrintCSVRecord(sArea, oObject, oItem, sClasses);
                i++;
                sLootClass = "RB_LOOTCLASS_" + IntToString(i);
                iLootMask = GetLocalInt(oObject, sLootClass);
            }

            //No items in inventory, but record details for area info (could be chest with script)
            if(nItemCount == 0 && GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
            {
                PrintString(sArea + "," + GetName(oObject) + "," +
                            "None" + "," + IntToString(0) + "," +
                            sAllClasses);
            }

            //PrintString("----------------------");
         }
         oObject = GetNextObjectInArea(oArea);
    }
    PrintString("Total value for area = " + IntToString(nTotal));
    PrintString("Total class value for area = " + IntToString(nClassTotal));
    PrintString("---------------------------");
    FloatingTextStringOnCreature("Listed all items", GetFirstPC());
}
