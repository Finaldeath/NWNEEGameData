//::///////////////////////////////////////////////
//:: con_a1_stcksichr
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have a Stick object in their
    inventory and some ichor?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    object oStick = GetItemPossessedBy(oPC, "a1_stick");
    object oIchor = GetItemPossessedBy(oPC, "a1_ichor");

    int iResult = FALSE;

    if ((GetIsObjectValid(oStick) == TRUE)
      && (GetIsObjectValid(oIchor) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
