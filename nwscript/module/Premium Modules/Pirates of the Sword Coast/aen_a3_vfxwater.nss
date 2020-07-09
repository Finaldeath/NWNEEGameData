//::///////////////////////////////////////////////
//:: aen_a3_vfxwater
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Area enter script to fire the inital cutscene
    and create the tile magic water.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "inc_global"
#include "inc_balance"
#include "inc_safepoint"

void main()
{
    object oEntering = GetEnteringObject();
    object oOldArea = GetObjectByTag("a3_tuts_shgnpssge");
    object oArea = OBJECT_SELF;
    int iCounter, iDoOnce;

    cs_AreaOnEnter_Poly(oEntering);

    iDoOnce = GetLocalInt(OBJECT_SELF, "aen_a3_vfxwater");

    if ((iDoOnce == FALSE) && (GetIsPCNotDM(oEntering) == TRUE))
    {
        SetLocalInt(OBJECT_SELF, "aen_a3_vfxwater", TRUE);

        UpdateSafePoint(oOldArea);
        ReCalcGlobalDif();

        object oRealNisar = GetObjectByTag("a2_hench_nisar");
        object oRealGarm = GetObjectByTag("a1_hench_garm");

        if (GetMaster(oRealNisar) == OBJECT_INVALID)
        {
            HireHenchman(oEntering, oRealNisar);
            AssignCommand(oRealNisar, JumpToObject(oEntering));
        }
        if (GetMaster(oRealGarm) == OBJECT_INVALID)
        {
            HireHenchman(oEntering, oRealGarm);
            AssignCommand(oRealGarm, JumpToObject(oEntering));
        }

        cs_PreCutsceneFade(CS_FADE_TYPE_BLACK, FADE_SPEED_MEDIUM, oArea);
        cs_StartCutscene_Poly("cut_a3_tasina", "", 3.0f, FALSE, FALSE, 10, oArea);

    }
}
