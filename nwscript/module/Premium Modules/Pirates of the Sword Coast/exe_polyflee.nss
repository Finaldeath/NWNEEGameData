//::///////////////////////////////////////////////
//:: exe_polyflee
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will cause the owner to fly away
    and come back to a safe lcoation later.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////
#include "inc_polyflee"

void main()
{
    object oEntering = GetEnteringObject();
    object oFirstPC = GetFirstPC();
    object oOwner = GetAreaOfEffectCreator();

    string sResRef = GetResRef(oOwner);
    effect eDisapear = EffectDisappear();
    int iDoOnce = GetLocalInt(OBJECT_SELF, "exe_polyflee");

    //SendMessageToPC(GetFirstPC(), "POLY AOE FIRED!");

    if ((GetIsEnemy(oFirstPC, oEntering) == TRUE) && (iDoOnce == FALSE))
    {
        //SendMessageToPC(GetFirstPC(), "POLY FLEE!");
        SetLocalInt(OBJECT_SELF, "exe_polyflee", TRUE);
        PolyFlee(oOwner);
    }
}
