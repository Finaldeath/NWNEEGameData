//::///////////////////////////////////////////////
//:: con_a1_cvntrc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Is the PC in the Jelly Caves without a torch?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oCave = GetArea(oPC);

    object oTorchS = GetItemPossessedBy(oPC, "a1_torch");
    object oTorchL = GetItemPossessedBy(oPC, "a1_torch_long");

    int iResult = FALSE;

    // Does a stick exist in the PC's inventory?
    if ((GetIsObjectValid(oTorchS) == FALSE)  && (GetIsObjectValid(oTorchL) == FALSE)
        && (GetTag(oCave) == "a1_ochrejellycave"))
    {
        iResult = TRUE;
    }

    return iResult;
}
