//::///////////////////////////////////////////////
//:: cac_a1_crftsrrwl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a superior set of arrows
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_arrow_s";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oFeather = GetItemPossessedBy(oPC, "a1_feather");
    object oStickL = GetItemPossessedBy(oPC, "a1_stick_long");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_ARROWS");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if ((GetIsObjectValid(oFeather) == TRUE)
      && (GetIsObjectValid(oStickL) == TRUE))
    {
        DestroyObject(oFeather);
        DestroyObject(oStickL);

        CreateItemOnObject(sResRef, oPC, 15);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_ARROWS", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
    else
    {
        SendMessageToPC(oPC, sMSGFailed);
    }
}
