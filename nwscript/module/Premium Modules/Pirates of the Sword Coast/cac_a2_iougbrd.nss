//::///////////////////////////////////////////////
//:: cac_a2_iougbrd
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does the PC have the Grog Beards IOU.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_bootysystem"

void main()
{
    object oPC = GetPCSpeaker();
    object oIOU = GetItemPossessedBy(oPC, "trs_u_sys_iou003");

    // Does a IOU for the executioner exist in the PC's inventory?
    if (GetIsObjectValid(oIOU) == TRUE)
    {
        DestroyObject(oIOU);
        CreateBootyOnObject(oPC, BOOTY_UNIQUE);
    }
}
