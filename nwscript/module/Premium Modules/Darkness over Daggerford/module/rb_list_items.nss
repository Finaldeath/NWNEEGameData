//Inventory Owner, Inventory Item, Equipped?, Droppable?

void PrintCSVRecord(object oName, object oItem, int nEquipped)
{
    string droppable = "N";
    string rec = "";

    if(GetObjectType(oName) == OBJECT_TYPE_PLACEABLE ||
       GetDroppableFlag(oItem))
    {
        droppable = "Y";
    }

    rec = GetName(oName) + "," + GetName(oItem) + "," +
          IntToString(GetGoldPieceValue(oItem)) + "," +
          (nEquipped ? "Y" : "N") + "," + droppable;

    PrintString(rec);
}

void PrintCSVGoldRecord(object oName, int nGold)
{
    string rec = "";

    rec = GetName(oName) + "," + "Gold Coins" + "," +
          IntToString(nGold) + "," + "N" + "," + "Y";

    PrintString(rec);
}

void main()
{
    int nGold;
    int nItemCount;
    int nSlot;
    int nTotal;

    object oArea = GetArea(GetPCSpeaker());
    object oObject = GetFirstObjectInArea(oArea);

    PrintString("Inventory items in Area " + GetName(oArea));
    //PrintString("----------------------------------------");

    while(GetIsObjectValid(oObject))
    {
         nItemCount = 0;
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
                   PrintCSVRecord(oObject, oItem, 0);
                   if((GetObjectType(oObject) == OBJECT_TYPE_CREATURE &&
                      GetDroppableFlag(oItem)) ||
                      GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
                   {
                       nTotal += GetGoldPieceValue(oItem);
                   }
               }

               oItem = GetNextItemInInventory(oObject);
             }
             for (nSlot=0; nSlot<NUM_INVENTORY_SLOTS; nSlot++)
             {
                 oItem=GetItemInSlot(nSlot, oObject);
                 if(oItem != OBJECT_INVALID)
                 {
                    nItemCount++;
                    SetIdentified(oItem, TRUE);
                    PrintCSVRecord(oObject, oItem, 1);
                    if(GetDroppableFlag(oItem))
                    {
                        //PrintString("Equipped Item = " + GetName(oItem) +
                        //            ", value = " + IntToString(GetGoldPieceValue(oItem)));
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
                     PrintCSVGoldRecord(oObject, nGold);
                     nTotal += nGold;
                    // PrintString("Has " + IntToString(nGold) + " gold pieces");
                 }
             }

             //No items in inventory, but record details for area info
             if(nItemCount == 0)
             {
                 PrintString(GetName(oObject) + "," + "None" + "," +
                             IntToString(0) + "," + "N" + "," + "N");
             }

             //PrintString("----------------------");
         }
         oObject = GetNextObjectInArea(oArea);
    }
    PrintString("Total value for area = " + IntToString(nTotal));
    PrintString("---------------------------");
    FloatingTextStringOnCreature("Listed all items", GetFirstPC());
}
