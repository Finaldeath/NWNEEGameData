//::///////////////////////////////////////////////
//:: cac_a1_crftml
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a standard Maul
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_maul";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oLeather = GetItemPossessedBy(oPC, "a1_leather");
    object oStone = GetItemPossessedBy(oPC, "a1_stone");
    object oStickS = GetItemPossessedBy(oPC, "a1_stick");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_MAUL");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if ((GetIsObjectValid(oLeather) == TRUE)
      && (GetIsObjectValid(oStone) == TRUE)
      && (GetIsObjectValid(oStickS) == TRUE))
    {
        DestroyObject(oLeather);
        DestroyObject(oStone);
        DestroyObject(oStickS);

        CreateItemOnObject(sResRef, oPC);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_MAUL", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
    else
    {
        SendMessageToPC(oPC, sMSGFailed);
    }
}
