//::///////////////////////////////////////////////
//:: cac_a1_crftblt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a standard set of bullets
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_bullet";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oStone = GetItemPossessedBy(oPC, "a1_stone");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_BULLETS");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if (GetIsObjectValid(oStone) == TRUE)
    {
        DestroyObject(oStone);
        CreateItemOnObject(sResRef, oPC, 15);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_BULLETS", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
    else
    {
        SendMessageToPC(oPC, sMSGFailed);
    }
}
