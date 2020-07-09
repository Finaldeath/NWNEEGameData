//::///////////////////////////////////////////////
//:: dla_areaonroad
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    OnEnter script of area "On the Road"
    Rolls the clock forward to 6am for the sunrise.
*/
//:://////////////////////////////////////////////
//:: Created By: Ben W-Husey
//:: Created On: January, 2006
//:://////////////////////////////////////////////

#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    int nOnce = GetLocalInt(OBJECT_SELF,"nFired");
    if (GetIsDefPC(oPC) && nOnce<1)
    {
    int nAdjust = 30-GetTimeHour();
    if (GetTimeHour()<6) SetTime(6,1,1,1);
    else  SetTime(GetTimeHour()+nAdjust,1,1,1);
    SetLocalInt(OBJECT_SELF,"nFired",1);
    }
}
