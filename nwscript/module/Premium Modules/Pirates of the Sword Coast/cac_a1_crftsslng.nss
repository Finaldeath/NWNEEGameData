//::///////////////////////////////////////////////
//:: cac_a1_crftsslng
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a superior sling
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_sling_s";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oLeather = GetItemPossessedBy(oPC, "a1_leather");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_SLING");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if (GetIsObjectValid(oLeather) == TRUE)
    {
        DestroyObject(oLeather);
        CreateItemOnObject(sResRef, oPC);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_SLING", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
    else
    {
        SendMessageToPC(oPC, sMSGFailed);
    }
}
