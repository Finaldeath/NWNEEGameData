//::///////////////////////////////////////////////
//:: aen_a3_scrtntrnc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start VFX Bubble.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////
#include "inc_safepoint"
#include "inc_bubbles"

void main()
{
    object oPC = GetEnteringObject();
    object oGarm, oNisar;
    int iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_seabottom");

    if (GetIsPC(oPC) == TRUE)
    {
        ExploreAreaForPlayer(OBJECT_SELF, oPC);
        UpdateSafePoint();

        DelayCommand(1.0f, CreateBubbles(oPC));
        oGarm = GetObjectByTag("a1_hench_garm");
        if (GetMaster(oGarm) == oPC)
        {
            DelayCommand(1.0f, CreateBubbles(oGarm));
        }

        oNisar = GetObjectByTag("a2_hench_nisar");
        if (GetMaster(oGarm) == oPC)
        {
            DelayCommand(1.0f, CreateBubbles(oNisar));
        }
    }
}
