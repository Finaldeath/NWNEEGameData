//::///////////////////////////////////////////////
//:: act_cal_noring
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The PC refuses Calibast's ring
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: Nov 2003
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetFirstPC();
    SetLocalInt(oPC,"OS_CAL_ROMANCE",90);
}
