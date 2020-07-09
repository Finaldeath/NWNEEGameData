//::///////////////////////////////////////////////
//:: con_a1_stckbichr
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

    object oStickS = GetItemPossessedBy(oPC, "a1_stick");
    object oStickL = GetItemPossessedBy(oPC, "a1_stick_long");
    object oIchor = GetItemPossessedBy(oPC, "a1_ichor");

    int iResult = FALSE;

    if (((GetIsObjectValid(oStickL) == TRUE)
      ||(GetIsObjectValid(oStickS) == TRUE))
      && (GetIsObjectValid(oIchor) == TRUE))
    {
        iResult = TRUE;
    }

    return iResult;
}
