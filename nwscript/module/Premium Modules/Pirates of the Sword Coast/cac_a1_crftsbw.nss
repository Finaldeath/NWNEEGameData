//::///////////////////////////////////////////////
//:: cac_a1_crftsbw
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Create a superior short bow
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
const string sResRef = "a1_bow_s";
const string sMSGFailed = "You do not have the proper components to create such an item.";

void main()
{
    object oPC = GetPCSpeaker();
    object oCatgut = GetItemPossessedBy(oPC, "a1_catgut");
    object oStickL = GetItemPossessedBy(oPC, "a1_stick_long");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_SHORTBOW");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if ((GetIsObjectValid(oCatgut) == TRUE)
      && (GetIsObjectValid(oStickL) == TRUE))
    {
        DestroyObject(oCatgut);
        DestroyObject(oStickL);

        CreateItemOnObject(sResRef, oPC, 10);

        if (iDoOnce == FALSE)
        {
            SetLocalInt(GetModule(), "CRAFT_A1_SHORTBOW", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }
    else
    {
        SendMessageToPC(oPC, sMSGFailed);
    }
}
