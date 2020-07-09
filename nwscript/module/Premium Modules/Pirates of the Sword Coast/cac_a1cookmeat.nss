//::///////////////////////////////////////////////
//:: cac_a1cookmeat
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gather all the meat in the players inventory
    destroy it and replace it with cooked meat.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oMeat = GetFirstItemInInventory(oPC);
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_COOKEDMEAT");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");
    int iMeatCounter = 0;

    while(GetIsObjectValid(oMeat) == TRUE)
    {
        if (GetTag(oMeat) == "a1_rawmeat")
        {
            iMeatCounter++;
            DestroyObject(oMeat);
        }
        oMeat = GetNextItemInInventory(oPC);
    }

    while (iMeatCounter > 0)
    {
        CreateItemOnObject("a1_cookedmeat", oPC);
        iMeatCounter--;

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_COOKEDMEAT", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
}
