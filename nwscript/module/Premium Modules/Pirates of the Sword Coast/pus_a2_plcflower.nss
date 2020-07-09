//::///////////////////////////////////////////////
//:: pus_a2_plcflower
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has picked som flowers.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    object oSelf = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oSelf, "pus_a2_plcflower");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "pus_a2_plcflower", TRUE);

        CreateItemOnObject("a2_flowers", oPC);
        DestroyObject(oSelf, 1.0f);
    }
}
