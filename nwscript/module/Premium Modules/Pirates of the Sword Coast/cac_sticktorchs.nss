//::///////////////////////////////////////////////
//:: cac_sticktorchs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Destroy A Stick in the PC Speakers inventory
    and replace it with a make-shift torch
    object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    object oIchor = GetItemPossessedBy(oPC, "a1_ichor");
    int iDoOnce = GetLocalInt(GetModule(), "CRAFT_A1_TORCH");
    int iCounter = GetLocalInt(GetModule(), "CRAFT_A1_COUNTER");

    if (GetIsObjectValid(oStick) == TRUE)
    {
        DestroyObject(oStick);
        CreateItemOnObject("a1_torch", oPC);

        if (iDoOnce == FALSE)
        {
            ExecuteScript("exe_a1_surviv40", oPC);

            SetLocalInt(GetModule(), "CRAFT_A1_TORCH", TRUE);
            SetLocalInt(GetModule(), "CRAFT_A1_COUNTER", (iCounter + 1));
        }
    }

    DestroyObject(oIchor);
}
