//::///////////////////////////////////////////////
//:: ten_a3_cutbridge
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Initiate the cutscene on the bridge to the
    Imberlant temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    object oModule = GetModule();

    int iDoOnce = GetLocalInt(oModule, "ten_a3_cutbridge");

    if ((GetIsPCNotDM(oPC) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "ten_a3_cutbridge", TRUE);
        cs_StartCutscene_Poly("cut_a3_bridge", "", 0.0f, FALSE, FALSE, 10, oArea);
    }
}
