//::///////////////////////////////////////////////
//:: aex_a3_shgnpssg
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a protection script to ensure all
    puzzle related effects are being removed
    if the player exits the puzzle area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_a3_rgbpzzl"

void main()
{
    object oPC = GetExitingObject();

    // If the exiting object is a PC
    if (GetIsPC(oPC) == TRUE)
    {
        // clear all puzzle effects
        ClearSourceEffect(oPC);
    }
}
