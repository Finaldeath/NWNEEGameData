//::///////////////////////////////////////////////
//:: cac_a1_crftrrws
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a standard set of arrows
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_arrow";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oFeather = GetItemPossessedBy(oPC, "a1_feather");
    object oStickS = GetItemPossessedBy(oPC, "a1_stick");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_ARROWS");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if ((GetIsObjectValid(oFeather) == TRUE)
      && (GetIsObjectValid(oStickS) == TRUE))
    {
        DestroyObject(oFeather);
        DestroyObject(oStickS);

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
